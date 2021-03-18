import json, requests, pytz, wget

with open('config.json', 'r') as f:
		_config = json.load(f)
		
class Telegram:
	def __init__(self, chat_id="@footballemrooz"):
		self.chat_id = chat_id
		self.api = "https://api.telegram.org/bot{}/".format(_config['Telegram_TOKEN'])
	
	def send_photo(self, photo):
		url = self.api + "sendPhoto"
		params = {'chat_id': self.chat_id}
		files = {'photo': open(photo,'rb')}
		response = requests.post(url, params=params, files=files)
		response = json.loads(response.content.decode('utf8'))
		return response['result']['message_id']

	def send_message(self, text):
		url = self.api + "sendMessage"
		params = {
			'chat_id': self.chat_id,
			'text': text
		}
		requests.post(url, params=params)
		
	def edit_photo(self, message_id, photo):
		url = self.api + "editMessageMedia"
		media = json.dumps({
			'type': 'photo',
			'media': 'attach://photo'
		})
		params = {
			'chat_id': self.chat_id,
			'message_id': message_id,
			'media': media
		}
		files = {'photo': open(photo,'rb')}
		requests.post(url, params=params, files=files)

	def get_file(self, file_id, save_loc):
		url = self.api + "getFile"
		params = {'file_id': file_id}
		response = requests.post(url, params=params)
		path = json.loads(response.content.decode('utf8'))["result"]["file_path"]
		path = "https://api.telegram.org/file/bot{}/".format(_config['Telegram_TOKEN']) + path
		wget.download(path, save_loc)

	def send_action(self, action): #https://core.telegram.org/bots/api#sendchataction
		url = self.api + "sendChatAction"
		params = {
			'chat_id': self.chat_id,
			'action': action 
		}
		requests.post(url, params=params)
