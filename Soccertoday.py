import pandas as pd
import json, os, requests, schedule, pytz, datetime, threading, time, argparse
from getpass import getpass

os.chdir(os.path.dirname(os.path.abspath(__file__)))

parser = argparse.ArgumentParser(description='Main code to gathers data on all soccer matches for today')

parser.add_argument('--telegram', default=False, action='store_true',
					help='Use if you want to attach a telegram bot and chat', required=False)
					
parser.add_argument('--noimage', default=False, action='store_true',
					help='If True, then produce only html result (e.g. if you cant have chromium driver', required=False)

parser.add_argument('--config', default=False, action='store_true',
					help='Use this to reconfigure config.json', required=False)

args = parser.parse_args()

if args.telegram and args.noimage:
	raise ValueError("You can only post images to telegram.")

### CONFIGURATION
pd.options.mode.chained_assignment = None  # default='warn'

if (not os.path.isfile('config.json')) or args.config:
	_config = {
		'PostgreSQL_HOST': input('database server host or socket directory (default: "localhost"): '),
		'PostgreSQL_PORT': input('database server port (default: "5432"): '),
		'PostgreSQL_USERNAME': input('database user name: '),
		'PostgreSQL_PASSWORD': getpass(f'Password for user: '),
	}
	
	if args.telegram:
		_config['Telegram_TOKEN'] = input('telegram bot api token: ')
		_config['Telegram_CHAT'] = input('telegram main chat ID (e.g. @footballemrooz): ')
		_config['Telegram_LOG'] = input('telegram chat ID for logs (e.g. 69411445): ')
	
	with open('config.json', 'w') as f:
		json.dump(_config, f)

args = parser.parse_args()


with open('config.json', 'r') as f:
	_config = json.load(f)
	
	if args.telegram and ('Telegram' not in str(_config)):
		_config['Telegram_TOKEN'] = input('telegram bot api token: ')
		_config['Telegram_CHAT'] = input('telegram main chat ID (e.g. @footballemrooz): ')
		_config['Telegram_LOG'] = input('telegram chat ID for logs (e.g. 69411445): ')
		
		with open('config.json', 'w') as c:
			json.dump(_config, c)
	

from dbhelper import DBHelper
from scraper import Scrap
from htmlhelper import Html

db = DBHelper()
db.setup()

if args.telegram:
	from telegram import Telegram
	
	tg = Telegram(_config['Telegram_CHAT'])
	log = Telegram(_config['Telegram_LOG'])

sc = Scrap()

now = pd.to_datetime(datetime.datetime.now(pytz.timezone('Asia/Tehran')))
post = Html(now.date())

def warning():
	r = sc.raw()
	d = db.get_item('team_id','teams',{'team_name':'Barcelona'},returnBool=True)[0][0]
	BadTeam = pd.DataFrame(columns=['Team','Days'])
	for index, row in r.iterrows():
		for b in [
			row['Home team'], row['Away team']
		]:
			if (not db.get_item('team_id','teams',{'team_name':b}, returnBool=True)[0][0]):
				dr = (pd.to_datetime(row['Date']).date() - now.date()).days
				if (0 <= dr <= 10):
					BadTeam = BadTeam.append({'Team':b, 'Days':dr}, ignore_index=True)
					
		if (not db.get_item('competition_id','competitions',{'competition_acronym':row['Competition']}, returnBool=True)[0][0]):
			dr = (pd.to_datetime(row['Date']).date() - now.date()).days
			if (0 <= dr <= 10):
				BadTeam = BadTeam.append({'Team':row['Competition'], 'Days':dr}, ignore_index=True)
					
	if not BadTeam.empty:
		BadTeam.sort_values('Days', inplace=True, ignore_index=True)
		BadTeam.drop_duplicates(subset=['Team'], inplace=True, ignore_index=True)
		print('Warning! \n', BadTeam)
		
		if args.telegram: log.send_message('Warning! '+str(BadTeam))

if not args.noimage:
	from PIL import Image
	from selenium import webdriver
	from selenium.webdriver.chrome.options import Options
	
	def create_png(date):
		chrome_options= Options()
		
		chrome_options.add_argument("--headless")
		chrome_options.add_argument("--no-sandbox")
		
		driver=webdriver.Chrome(options=chrome_options)
		driver.get('file:///'+os.path.abspath(f"results/{date}.html"))
		
		original_size = driver.get_window_size()
		required_width = driver.execute_script('return document.body.parentNode.scrollWidth')
		required_height = driver.execute_script('return document.body.parentNode.scrollHeight')
		
		driver.set_window_size(required_width, required_height)
		
		driver.find_element_by_tag_name('body').screenshot(f"results/{date}.png")
		
		driver.set_window_size(original_size['width'], original_size['height'])
		driver.close()
		
		def crop_image(img, img_limit):
			img_width, img_height = img.size
			crop_dim = (img_limit, 0, img_width, img_height)
			cropped_img = img.crop(crop_dim)
			return cropped_img
			
		img_limit = 325
		
		img = Image.open(f"results/{date}.png")
		img = crop_image(img, img_limit)
		
		img.save(f"results/{date}.png")
		print (f'Successfully generated {date}.png')
	
def sub_result_update(match_id, link_url, link_type):
	if not (bool(db.get_item('match_result','matches',{'match_id':match_id})[0][0])):
		
		if link_type == 'CLUB':
			df = sc.scrap_club(link_url)
			
			match_date = pd.to_datetime(
				db.get_item('match_datetime','matches',{'match_id':match_id})[0][0]
			).date()
			
			if match_date == pd.to_datetime(df.loc[4, 'Date']).date():
				db.update_match({'match_result':df.loc[4, 'Home team']}, {'match_id':match_id})
				
				if args.telegram: tg.send_action('typing')
	
				post_id = db.get_item('MAX(post_id)','posts')[0][0]
				post_message_id = db.get_item('post_message_id','posts',{'post_id':post_id})[0][0]
				
				matches = pd.DataFrame(
					db.get_item('*', 'matches', {'match_post_id': post_id}),
				)
				
				for index, row in matches.iterrows():
					
					matches.loc[index, 2] = db.get_item('team_name','teams',{'team_id':row[2]})[0][0]
					matches.loc[index, 3] =	db.get_item('team_name','teams',{'team_id':row[3]})[0][0]
					matches.loc[index, 4] = db.get_item(
						'competition_acronym',
						'competitions',
						{'competition_id':row[4]}
					)[0][0]
					matches.loc[index, 5] = pd.to_datetime(row[5])

				matches.drop([0,1], axis=1, inplace=True)
				matches.rename(columns={
					2:'Home team',
					3:'Away team',
					4:'Competition',
					5:'Date',
					6:'Result',
					7:'Channel'
				}, inplace=True)
					
				post.create_post(matches)
				
				if args.telegram: tg.send_action('upload_photo')
				
				if not args.noimage: create_png(f'{now.date()}_Result')
				
				if args.telegram: tg.edit_photo(post_message_id, f'results/{now.date()}_Result.png')
				
				return schedule.CancelJob
			
		elif link_type == 'COMPETITION':
			competition =  db.get_item(
				'(link_name, link_url, link_stages)',
				'links',
				{'link_url': link_url}
			)[0][0].strip('()').split(',')
			
			df = sc.scrap_competition(competition)
			
			match_date = pd.to_datetime(
				db.get_item('match_datetime','matches',{'match_id':match_id})[0][0]
			).date()
			match_home = db.get_item('team_name','teams',{
				'team_id':db.get_item('match_home','matches',{'match_id':match_id})[0][0]
			})[0][0]
			match_away = db.get_item('team_name','teams',{
				'team_id':db.get_item('match_away','matches',{'match_id':match_id})[0][0]
			})[0][0]

			df = df[
				(df['Date'].apply(lambda d: pd.to_datetime(d).date()) == match_date) &
				(df['Home team'] == match_home) &
				(df['Away team'] == match_away)
			]
			if not df.empty:
				if '-' in df.iloc[0, 3]:
					db.update_match({'match_result':df.iloc[0, 3]}, {'match_id':match_id})
					
					if args.telegram: tg.send_action('typing')
		
					post_id = db.get_item('MAX(post_id)','posts')[0][0]
					if args.telegram: post_message_id = db.get_item('post_message_id','posts',{'post_id':post_id})[0][0]
					
					matches = pd.DataFrame(
						db.get_item('*', 'matches', {'match_post_id': post_id}),
					)
					
					for index, row in matches.iterrows():
						
						matches.loc[index, 2] = db.get_item('team_name','teams',{'team_id':row[2]})[0][0]
						matches.loc[index, 3] =	db.get_item('team_name','teams',{'team_id':row[3]})[0][0]
						matches.loc[index, 4] = db.get_item(
							'competition_acronym',
							'competitions',
							{'competition_id':row[4]}
						)[0][0]
						matches.loc[index, 5] = pd.to_datetime(row[5])

					matches.drop([0,1], axis=1, inplace=True)
					matches.rename(columns={
						2:'Home team',
						3:'Away team',
						4:'Competition',
						5:'Date',
						6:'Result',
						7:'Channel'
					}, inplace=True)
						
					post.create_post(matches)
					
					if args.telegram: tg.send_action('upload_photo')
					
					if not args.noimage: create_png(f'{now.date()}_Result')
					
					if args.telegram: tg.edit_photo(post_message_id, f'results/{now.date()}_Result.png')
					
					return schedule.CancelJob

def channel_update():
	if args.telegram: tg.send_action('typing')
	
	post_id = db.get_item('MAX(post_id)','posts')[0][0]
	if args.telegram: post_message_id = db.get_item('post_message_id','posts',{'post_id':post_id})[0][0]
	
	if not (db.get_item('*', 'matches', {'match_post_id': post_id}, returnBool=True)[0][0]):
		raise RuntimeError('There are no matches today to check for channel')
	
	matches = pd.DataFrame(
		db.get_item('*', 'matches', {'match_post_id': post_id}),
	)
	
	channels = sc.scrap_channels()
	
	R = ''
	haschanged = False
	
	for index, row in matches.iterrows():
		for team in [
			db.get_item('team_name_fa', 'teams', {'team_id': row[2]})[0][0],
			db.get_item('team_name_fa', 'teams', {'team_id': row[3]})[0][0]
		]:
			if (team in channels) and (row[7] != channels[team]):
				haschanged = True
				matches.loc[index, 7] = channels[team]
			if row[6]:
				R = '_Result'
				matches['Result'] = matches[6]
		matches.loc[index, 2] = db.get_item('team_name','teams',{'team_id':row[2]})[0][0]
		matches.loc[index, 3] =	db.get_item('team_name','teams',{'team_id':row[3]})[0][0]
		matches.loc[index, 4] = db.get_item(
			'competition_acronym',
			'competitions',
			{'competition_id':row[4]}
		)[0][0]
		matches.loc[index, 5] = pd.to_datetime(row[5])
	
	if haschanged:
		matches.drop([0,1,6], axis=1, inplace=True)
		matches.rename(columns={
			2:'Home team',
			3:'Away team',
			4:'Competition',
			5:'Date',
			7:'Channel'
		}, inplace=True)
			
		post.create_post(matches)
		
		if args.telegram: tg.send_action('upload_photo')
		
		if not args.noimage: create_png(f'{now.date()}{R}')
		
		if args.telegram: tg.edit_photo(post_message_id, f'results/{now.date()}{R}.png')
	
def main():
	if args.telegram: tg.send_action('typing')
	
	today = sc.today()
	todayclean = sc.clean(today)
	todaymatches = sc.channel(
		todayclean[(
			(todayclean['Date'].apply(lambda d: d.date()) == now.date()) &
			(todayclean['Date'].apply(lambda d: d.hour) >= 9)
		) | (
			(todayclean['Date'].apply(lambda d: d.date()) == (now+datetime.timedelta(days=1)).date()) &
			(todayclean['Date'].apply(lambda d: d.hour) <= 9)
		)]
	)
	
	post.create_post(todaymatches)
	
	if args.telegram: tg.send_action('upload_photo')
	
	if not args.noimage: create_png(now.date())
	
	db.add_post(
		'post_date, post_html',
		(now.date(), f'results/{now.date()}.html')
		)
		
	if args.telegram: 
		message_id = tg.send_photo(f'results/{now.date()}.png')
		
		db.add_post(
			'post_date, post_html',
			(now.date(), f'results/{now.date()}.html'),
			replace={'post_message_id':message_id}
			)
		
		
	post_id = db.get_item('MAX(post_id)','posts')[0][0]
	
	for index, row in todaymatches.iterrows():
		try:
			db.add_match(
				'match_post_id, match_home, match_away, match_competition, match_datetime, match_channel',
				(
					post_id,
					db.get_item('(team_id)', 'teams', {'team_name': row['Home team']})[0][0],
					db.get_item('(team_id)', 'teams', {'team_name': row['Away team']})[0][0],
					db.get_item(
						'(competition_id)',
						'competitions',
						{'competition_acronym': row['Competition']}
					)[0][0],
					str(row['Date']),
					row['Channel']
				)
			)
		except Exception as e:
			print(e)
			if args.telegram: log.send_message(str(e))
	
	schedule_channel = schedule.Scheduler()
	
	def channel_check():
		cease_channel_check = threading.Event()
		
		class ChannelThread(threading.Thread):
			@classmethod
			def run(cls):
				while not cease_channel_check.is_set():
					schedule_channel.run_pending()
					time.sleep(5)
		
		check_thread = ChannelThread()
		check_thread.start()
		return cease_channel_check
	
	def wrapper():
		try:
			channel_update()
		except Exception as e:
			print(e)
			if args.telegram: log.send_message(str(e))
			ciese_checking_channel()
	
	if now.hour < 13:
		checkjob = schedule_channel.every(30).minutes.do(wrapper)
		
		stop_channel_check = channel_check()
		
		def ciese_checking_channel():
			stop_channel_check.set()
			schedule_channel.cancel_job(checkjob)
			schedule_channel.cancel_job(ciesejob)
			
		ciesejob = schedule_channel.every().day.at("13:00").do(ciese_checking_channel)

	post_id = db.get_item('MAX(post_id)','posts')[0][0]
	
	if (db.get_item('*', 'matches', {'match_post_id': post_id}, returnBool=True)[0][0]):
		matches = pd.DataFrame(
			db.get_item('*', 'matches', {'match_post_id': post_id}),
		)
		matches['Hour'] = matches[5].apply(lambda x: (pd.to_datetime(x) + datetime.timedelta(hours=2)).strftime('%H:%M'))
		
		schedule_subresult = schedule.Scheduler()
		
		schedule_result = schedule.Scheduler()
		
		def result_update(match_id, link_url, link_type):
			schedule_subresult.every(15).minutes.do(sub_result_update, match_id, link_url, link_type)
			
			return schedule.CancelJob
		
		for index, row in matches.iterrows():
			for team in [
				db.get_item('team_name', 'teams', {'team_id': row[2]})[0][0],
				db.get_item('team_name', 'teams', {'team_id': row[3]})[0][0],
				db.get_item('competition_acronym', 'competitions', {'competition_id':row[4]})[0][0]
			]:
				link_url = db.get_item('link_url', 'links', {'link_name':team})
				if link_url:
					link_type = db.get_item('link_type', 'links', {'link_name':team})[0][0]
					break
			
			schedule_result.every().day.at(str(row['Hour'])).do(result_update, row[0], link_url[0][0], link_type)
			
			def sub_result_check():
				
				class SubResultThread(threading.Thread):
					@classmethod
					def run(cls):
						while schedule_subresult.jobs:
							print ("Checking results")
							schedule_subresult.run_pending()
							time.sleep(30)
				
				check_thread = SubResultThread()
				check_thread.start()
			
			sub_result_check()
		
		def run_result_check():

			class ResultThread(threading.Thread):
				@classmethod
				def run(cls):
					while schedule_result.jobs:
						schedule_result.run_pending()
						time.sleep(900)

			result_thread = ResultThread()
			result_thread.start()
		
		run_result_check()

	warning()

if __name__ == '__main__':
	main()
