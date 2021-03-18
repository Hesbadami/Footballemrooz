# Footballemrooz

An automated server-side Telegram bot, which gathers data on all soccer matches daily, and posts a stylized image containing info on today's matches (e.g. kick-off time and broadcasters).

For now the project only produces result for Asia/Tehran timezone, and the results are in Persian. Although I plan on creating an easily customization version in future (Mainly supporting French and English language and time zones).

This projects uses postgresql database. My database was by default called "Footballemrooz". 
For producing images, chromium's chromedriver is used. keep in mind that the driver for normal chrome browser doesn't work. It has to be chromium!

Use pipenv to safely handle all dependancies.
