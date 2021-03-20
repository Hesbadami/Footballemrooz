# **Footballemrooz**: *Today's Soccer Matches*

An automated server-side Telegram bot, which gathers data on all soccer matches daily, and creates a stylized image containing info on today's matches (e.g. kick-off time and broadcasters).

----------
Prerequisites
-------------
- `Python 3.6` 
- PostgreSQL: [How to Install PostgreSQL and phpPgAdmin on Ubuntu 20.04](https://www.howtoforge.com/tutorial/ubuntu-postgresql-installation/)
- Install necessary packages using `pipenv install`. Instructions for installing and using pipenv is provided [here](https://realpython.com/pipenv-guide/#pipenv-introduction). Also have a look at [their github](https://github.com/pypa/pipenv) if you are interested. 

Gathering matches using the main program (Soccertoday.py)
-------
```bash
python Soccertoday.py
```
The result is saved (by default) in `results/<date>.html` (e.g. `2021-03-18.html`). You can specify wether if you also want a `png` image created as an argument,  similarly the image is also saved in `results/<date>.png`. The image creation is supported by `Selenium` and Chromium's chromedriver. Do not use if you don't or can't have chromedriver with chromium-browser (e.g. on windows). (Note that regular chrome browser does not work, chromium is essential)

##### Tips:
- Use `--telegram` argument to also attach a [Telegram Bot](https://core.telegram.org/bots). You need to pass your api token and chat ID into configs.
- If you wish only for html results and don't want `png` image to be created. Use the `--noimage` argument and give another try.
- Use the `--config` argument, to go through configuration wizard again. Alternatively, you can manually edit the `config.json` file.
- The Wav2Lip model without GAN usually needs more experimenting with the above two to get the most ideal results, and sometimes, can give you a better result as well.

Preparing the database
----------
Our program uses a PostgreSQL database. See [here](https://www.howtoforge.com/tutorial/ubuntu-postgresql-installation/) for installing PostgreSQL along with phppgadmin administration tool on Ubuntu.
##### Creating database after installation
```bash
sudo -i -u postgres psql
```

```psql
CREATE DATABASE footballemrooz WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
```
Additional setups like creating tables are done automatically in the program. (Stored in `dbtables.sql`)

##### Database structure
```
PostgreSQL
├── footballemrooz
|		├── Schemas
|		│		├── Public (default)
|		│		│	  	├── Tables
|		│		│	  	│		├── links
|		│		│	 	 	│		├── teams
|		│		│	  	│		├── competitions
|		│		│		  │		├── posts
|		│		│		  │		├── matches
```
