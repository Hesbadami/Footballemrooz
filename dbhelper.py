import psycopg2, json

with open('config.json', 'r') as f:
		_config = json.load(f)

class DBHelper:
	def __init__(self, dbname="footballemrooz"):
		self.dbname = dbname
	
	def dbconnect(self):
		con = psycopg2.connect(
			database = self.dbname,
			user = _config['PostgreSQL_USERNAME'],
			password = _config['PostgreSQL_PASSWORD'],
			host = _config['PostgreSQL_HOST'],
			port = _config['PostgreSQL_PORT']
		)
		return con
		
	def setup(self):
		con = self.dbconnect()
		cur = con.cursor()
		
		with open('dbtables.sql', 'r') as stmt:
			stmt = stmt.read()
		
		cur.execute(stmt)
		
		con.commit()
		con.close()
		
	def add_team(self, columns, values, replace=None):
		con = self.dbconnect()
		cur = con.cursor()
		
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO teams ({columns}) VALUES %s ON CONFLICT (team_name) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
		
	def add_competition(self, columns, values, replace=None):
		con = self.dbconnect()
		cur = con.cursor()
		
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO competitions ({columns}) VALUES %s ON CONFLICT (competition_acronym) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
	
	def delete_team(self, name):
		con = self.dbconnect()
		cur = con.cursor()
		
		stmt = "DELETE FROM teams WHERE team_name = %s;"
		args = (name, )
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
		
	def delete_competition(self, name):
		con = self.dbconnect()
		cur = con.cursor()
		
		stmt = "DELETE FROM competitions WHERE competition_name = %s;"
		args = (name, )
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
		
	def add_post(self, columns, values, replace=None):
		con = self.dbconnect()
		cur = con.cursor()
		
		t = ''
		
		args = (values, )
		
		if replace:	
			for i in replace:
				t += i + '= %s, '
			t = t.strip(', ')
			
			args += tuple(replace.values())
		
		stmt = f"INSERT INTO posts ({columns}) VALUES %s ON CONFLICT (post_date) DO {bool(not replace)*'NOTHING; -- '}UPDATE SET {t};"
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
		
	def add_match(self, columns, values, replace=None):
		con = self.dbconnect()
		cur = con.cursor()
		
		check = f"SELECT EXISTS (SELECT match_id FROM matches WHERE ({columns}) = %s);"
		
		stmt = f"INSERT INTO matches ({columns}) VALUES %s;"
		args = (values, )
		
		cur.execute(check, args)
		
		if (self.cur.fetchall()[0][0]):
			raise ValueError('Match already exists, use "update_match()" instead')
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
		
	def update_match(self, replace, condition):
		con = self.dbconnect()
		cur = con.cursor()
		
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
		
		cur.execute(stmt, args)
		
		con.commit()
		con.close()
	
	def get_item(self, column, table, condition=None, returnBool=False):
		con = self.dbconnect()
		cur = con.cursor()
		
		s = ''

		if condition:
			for i in condition:
				s += i + '= %s AND '
			s = s.strip('AND ')
			
			condition = tuple(condition.values())
		
		stmt = f"SELECT {column} FROM {table} {bool(not condition)*'; -- '}WHERE {s}"
		
		if returnBool:
			stmt = f"SELECT EXISTS ({stmt});"
		
		cur.execute(stmt, condition)
		return cur.fetchall()
		
		con.commit()
		con.close()
