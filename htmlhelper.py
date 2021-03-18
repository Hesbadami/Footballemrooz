from persiantools import digits
from persiantools.jdatetime import JalaliDate
from dbhelper import DBHelper
import datetime, pytz
import pandas as pd
db = DBHelper()
db.setup()

def date_to_jalali(time):
	persian = {
	'Farvardin': 'فروردین',
	'Ordibehesht': 'اردیبهشت',
	'Khordad': 'خرداد',
	'Tir': 'تیر',
	'Mordad': 'مرداد',
	'Shahrivar': 'شهریور',
	'Mehr': 'مهر',
	'Aban': 'آبان',
	'Azar': 'آذر',
	'Dey': 'دی',
	'Bahman': 'بهمن',
	'Esfand': 'اسفند',
	'Shanbeh': 'شنبه',
	'Yekshanbeh': 'یکشنبه',
	'Doshanbeh': 'دوشنبه',
	'Seshanbeh': 'سه‌شنبه',
	'Chaharshanbeh': 'چهارشنبه',
	'Panjshanbeh': 'پنجشنبه',
	'Jomeh': 'جمعه'
	}
	time = persian[JalaliDate(time).strftime('%A')] + ' - ' + str(JalaliDate(time).strftime('%d')) + ' ' + persian[JalaliDate(time).strftime('%B')] + ' '+ JalaliDate(time).strftime('%Y')
	time = digits.en_to_fa(time)
	return time

class Html():
	def __init__(self, date):
		self.date = date
		self.row = '            <tr>\n              <td>\n                <div class="right-row-cells">\n#score/time\n                  <div class="matchs">\n                    <div class="match-row persian">\n                      <img src="../images/#Home.png" alt="#Home" />\n                      <h5>#home_fa</h5>\n                    </div>\n                    <div class="match-row persian">\n                      <img src="../images/#Away.png" alt="#Away" />\n                      <h5>#away_fa</h5>\n                    </div>\n                  </div>\n                  <div class="league">\n                    <img\n                      src="../images/#comp.png"\n                      alt="#comp"\n                    />\n                  </div>\n                </div>\n              </td>\n              <td>\n                <div class="channel">\n                  <img src="../images/#channel.jpg" alt="TV channel" />\n                </div>\n              </td>\n            </tr>'
		self.scorediv = '                  <div class="persian score">                    <div class="#homeoutcome">#homescore</div>\n                    <div class="#awayoutcome">#awayscore</div>\n                  </div>'
		self.timediv = '                  <div class="time persian">#time</div>'
		self.rows = []
		self.placeholder = '            <tr>\n              <td>\n                <div class="right-row-cells">\n                  <div class="time2 persian">۱۲:۳۰</div>\n                  <div class="matchs">\n                    <div class="match-row persian">\n                      <img src="../images/noneteam.png" alt="noneteam" />\n                      <h5></h5>\n                    </div>\n                    <div class="match-row persian">\n                      <img src="../images/noneteam.png" alt="noneteam" />\n                      <h5></h5>\n                    </div>\n                  </div>\n                  <div class="league">\n                    <img\n                      src="../images/none.png"\n                      alt="none"\n                    />\n                  </div>\n                </div>\n              </td>\n              <td>\n                <div class="channel">\n                  <img src="../images/none.jpg" alt="TV channel" />\n                </div>\n              </td>\n            </tr>'
		self.daybreak = '          </tbody>\n        </table>\n      </div>\n    </div>\n    \n\t<div class="day">\n      <div class="date persian">{}</div>\n      <div class="table-container">\n        <table class="table table-bordered my-Tabl">\n          <thead></thead>\n          <tbody>'
		
	def add_row(self, scoretime, comp, home, away, channel='none' ,isscore=False):
		values = {
			'#comp':comp,
			'#Home':home,
			'#Away':away,
			'#home_fa': db.get_item('(team_name_fa)', 'teams', {'team_name': home})[0][0],
			'#away_fa':	db.get_item('(team_name_fa)', 'teams', {'team_name': away})[0][0],
			'#channel': channel
		}
		row = self.row
		if isscore:
			scores = scoretime.split(' - ')
			outcome = {}
			score = {}
			winner = scores.index(max(scores))
			looser = scores.index(min(scores))
			outcome[winner] = 'winner'
			outcome[looser] = 'looser'
			score[winner] = digits.en_to_fa(max(scores))
			score[looser] = digits.en_to_fa(min(scores))
			if max(scores) == min(scores):
				outcome[0] = 'tie'
				outcome[1] = 'tie'
				score[0] = digits.en_to_fa(max(scores))
				score[1] = digits.en_to_fa(min(scores))
			values['#homeoutcome'] = outcome[0]
			values['#homescore'] = score[0]
			values['#awayoutcome'] = outcome[1]
			values['#awayscore'] = score[1]
			row = row.replace('#score/time', self.scorediv)
		if not isscore:
			values['#time'] = scoretime
			row = row.replace('#score/time', self.timediv)
		for value in values:
			row = row.replace(value, values[value])
		self.rows.append(row)
		
	def create_post(self, df):
		df = df.sort_values('Date')
		e = False
		daybreaked = False
		R = ''
		for index, match in df.iterrows():
			if match['Date'].date() == self.date:
				e = True
				print('hi1')
				try:
					print('hi2')
					if match['Result']:
						print('hi3')
						R = '_Result'
						self.add_row(
							match['Result'],
							match['Competition'],
							match['Home team'],
							match['Away team'],
							match['Channel'],
							isscore=True
						)
				
				except:
					self.add_row(
						digits.en_to_fa(match['Date'].strftime('%H:%M')),
						match['Competition'],
						match['Home team'],
						match['Away team'],
						match['Channel']
					)
			elif (match['Date'] - datetime.timedelta(days=1)).date() == self.date:
				if not e:
					self.rows.append(self.placeholder)
					e = True
				if not daybreaked:
					self.rows.append(self.daybreak.format(date_to_jalali(match['Date'])))
					daybreaked = True
					
				try:
					if match['Result']:
						R = '_Result'
						self.add_row(
							match['Result'],
							match['Competition'],
							match['Home team'],
							match['Away team'],
							match['Channel'],
							isscore=True
						)
				
				except Exception as e:
					print(e)
					self.add_row(
						digits.en_to_fa(match['Date'].strftime('%H:%M')),
						match['Competition'],
						match['Home team'],
						match['Away team'],
						match['Channel']
					)
		
		while len(self.rows) < 9:
			self.rows.append(self.placeholder)
		hashrow = ''
		for r in self.rows:
			hashrow += r
		with open ('results/.raw.htm', 'rt') as f:
			raw = f.read()
		raw = raw.replace('#date', date_to_jalali(pd.to_datetime(self.date)))
		raw = raw.replace('#row', hashrow)
		with open (f'results/{self.date}{R}.html', 'wt') as f:
			f.write(raw)
		print (f'Successfully generated {self.date}{R}.html')
