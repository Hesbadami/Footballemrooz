import psycopg2, json

with open('config.json', 'r') as f:
		_config = json.load(f)

class DBHelper:
	def __init__(self, dbname="footballemrooz"):
		self.dbname = dbname
		self.con = psycopg2.connect(
			database = dbname,
			user = _config['PostgreSQL_USERNAME'],
			password = _config['PostgreSQL_PASSWORD'],
			host = _config['PostgreSQL_HOST'],
			port = _config['PostgreSQL_PORT']
		)
		self.cur = self.con.cursor()
		
	def setup(self):
		with open('dbtables.sql', 'r') as stmt:
			stmt = stmt.read()
		
		self.cur.execute(stmt)
		self.con.commit()

	def add_team(self, columns, values, replace=None):
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO teams ({columns}) VALUES %s ON CONFLICT (team_name) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		self.cur.execute(stmt, args)
		self.con.commit()
		
	def add_competition(self, columns, values, replace=None):
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO competitions ({columns}) VALUES %s ON CONFLICT (competition_acronym) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		self.cur.execute(stmt, args)
		self.con.commit()
	
	def delete_team(self, name):
		stmt = "DELETE FROM teams WHERE team_name = %s;"
		args = (name, )
		
		self.cur.execute(stmt, args)
		self.con.commit()
		
	def delete_competition(self, name):
		stmt = "DELETE FROM competitions WHERE competition_name = %s;"
		args = (name, )
		
		self.cur.execute(stmt, args)
		self.con.commit()
		
	def add_post(self, columns, values, replace=None):
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO posts ({columns}) VALUES %s ON CONFLICT (post_date) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		self.cur.execute(stmt, args)
		self.con.commit()
	
	def add_match(self, columns, values, replace=None):
		check = f"SELECT EXISTS (SELECT match_id FROM matches WHERE ({columns}) = %s);"
		
		stmt = f"INSERT INTO matches ({columns}) VALUES %s;"
		args = (values, )
		
		self.cur.execute(check, args)
		
		if (self.cur.fetchall()[0][0]):
			raise ValueError('Match already exists, use "update_match()" instead')
		
		self.cur.execute(stmt, args)
		self.con.commit()
		
	def update_match(self, replace, condition):
		s = {
			'replace':'',
			'condition':''
		}
		
		for i in replace:
			s['replace'] += i + '= %s, '
		s['replace'] = s['replace'].strip(', ')
		
		for i in condition:
			s['condition'] += i + '= %s AND '
		s['condition'] = s['condition'].strip('AND ')
		
		args = tuple(replace.values()) + tuple(condition.values())
		stmt = f"UPDATE matches SET {s['replace']} WHERE {s['condition']};"
		
		self.cur.execute(stmt, args)
		self.con.commit()
	
	def get_item(self, column, table, condition=None, returnBool=False):
		s = ''

		if condition:
			for i in condition:
				s += i + '= %s AND '
			s = s.strip('AND ')
			
			condition = tuple(condition.values())
		
		stmt = f"SELECT {column} FROM {table} {bool(not condition)*'; -- '}WHERE {s}"
		
		if returnBool:
			stmt = f"SELECT EXISTS ({stmt});"
		
		self.cur.execute(stmt, condition)
		return self.cur.fetchall()
