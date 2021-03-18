import time, concurrent.futures, json, requests, pytz
import datetime
import pandas as pd
from bs4 import BeautifulSoup

from dbhelper import DBHelper
db = DBHelper()
db.setup()

def localize_timezone(timestamp):
	old_timezone = pytz.timezone('CET')
	new_timezone = pytz.timezone('Asia/Tehran')
	return old_timezone.localize(timestamp).astimezone(new_timezone)

class Scrap:
	def __init__(self):
		self.header = {
			'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36 OPR/74.0.3911.203',
			"Cache-Control": "no-cache",
			"Pragma": "no-cache"
		}

	def scrap_club(self, club_url):
		club = pd.DataFrame(columns = ['Date', 'Competition', 'Outcome', 'Home team', 'Score/Time'])
		response = requests.get(club_url, headers = self.header)
		club = pd.concat([club, pd.read_html(response.text)[0].drop(['Away team', 'Unnamed: 6'], axis=1)])
		return club
		
	def scrap_competition(self, comp):
		competition = pd.DataFrame(columns = ['Date', 'Competition', 'Home team', 'Score/Time', 'Away team'])
		url = comp[1]
		for _ in range(2):
			url = 'https://int.soccerway.com'+requests.get(url, headers=self.header, allow_redirects=False).headers['location']
		if 'final-stages' in url:
			response = pd.read_html(requests.get(url, headers = self.header).text)
			if len(response) > (
				(int(comp[2][1])-int(comp[2][0]))+1
			):
				for s in response[:-((int(comp[2][1])-int(comp[2][0]))+1)]:
					df = s.drop(s.columns[4:], axis= 1)
					df = df[df['Day'].apply(lambda x: 'Aggr.' not in x)].reset_index(drop=True)
					df = pd.concat ([
						df['Day'].iloc[range(0,len(df),2)].reset_index(drop=True).rename('Date'),
						df.drop(range(0,len(df),2)).reset_index(drop=True)
					], axis=1).drop('Day',axis=1)[0:]
					df['Competition'] = comp[0]
					competition = pd.concat([competition, df])
				competition.reset_index(drop = True, inplace = True)
		return competition

	def raw(self):
		start = time.perf_counter()
		matches = pd.DataFrame(columns = ['Date', 'Competition', 'Outcome', 'Home team', 'Score/Time'])
		clubs = [q[0] for q in db.get_item('(link_url)', 'links', {'link_type': 'CLUB'})]
		competitions = [i[0].strip('()').split(',') for i in db.get_item(
			'(link_name, link_url, link_stages)',
			'links',
			{'link_type': 'COMPETITION'}
		)]
		with concurrent.futures.ThreadPoolExecutor() as executor:
			club_results = executor.map(self.scrap_club, clubs)
		for result in club_results:
			matches = pd.concat([matches, result])
		matches.rename(columns={
			'Outcome':'Home team',
			'Home team':'Score/Time',
			'Score/Time':'Away team'
		}, inplace=True)
		with concurrent.futures.ThreadPoolExecutor() as executor:
			comp_results = executor.map(self.scrap_competition, competitions)	
		for result in comp_results:
			matches = pd.concat([matches, result])
		matches = matches[matches['Date']!='Live']
		matches.drop_duplicates(keep='first', inplace=True)
		matches.reset_index(drop=True, inplace=True)
		finish = time.perf_counter()
		print (f'Finished in {round(finish-start,2)} second(s)')
		return matches
		
	def today(self):
		tz = pytz.timezone('Asia/Tehran')
		matches = self.raw()
		matches['Date'] = matches['Date'].apply(lambda x: pd.to_datetime(x).date())
		matches = matches[
			(matches['Date']==datetime.datetime.now(tz).date()) |
			(matches['Date']==(datetime.datetime.now(tz)+datetime.timedelta(days=1)).date())
		].sort_values('Date')
		matches.drop_duplicates(keep='first', inplace=True)
		matches.reset_index(drop=True, inplace=True)
		return matches
		
	def clean(self, matches):
		matches = matches[matches['Score/Time'].apply(lambda x: ":" in x)]
		matches['Date'] = matches['Date'].apply(str) +' '+ matches['Score/Time'].apply(lambda x: x.replace(' ', ''))
		matches.drop('Score/Time', axis=1, inplace=True)
		matches['Date'] = matches['Date'].apply(lambda x: localize_timezone(pd.to_datetime(x)))
		matches.drop_duplicates(keep='first', inplace=True)
		matches.reset_index(drop=True, inplace=True)
		return matches
	
	def scrap_channels(self):
		response = requests.get('https://www.varzesh3.com')
		soup = BeautifulSoup(response.content, "html5lib").find(id="widget28")
		soup = soup.find(class_="full-width").get_text().split('\n')
		tvbox = list(filter(None, [a.strip() for a in soup]))
		
		channels = {}
		
		for i in range(0,len(tvbox)):
			line = tvbox[i]
			
			if '-' in line:
				teams = line.split('-')
				
				try:
					if "سه" in tvbox[i+3]:
						channele = "se"
						
						channels[teams[0].strip()]=channele
						channels[teams[1].strip()]=channele
					
					if "ورزش" in tvbox[i+3]:
						channele = "varzesh"
						
						channels[teams[0].strip()]=channele
						channels[teams[1].strip()]=channele

				except:
					print ('Box out of range for', tvbox[i])
					
		return channels
	
	def channel(self, df):
		channels = self.scrap_channels()
		
		df['Channel'] = 'none'
		for index, row in df.iterrows():
			for team in [
				db.get_item('(team_name_fa)', 'teams', {'team_name': row['Home team']})[0][0],
				db.get_item('(team_name_fa)', 'teams', {'team_name': row['Away team']})[0][0]
			]:
				if team in channels:
					df.loc[index, 'Channel'] = channels[team]
		return df
