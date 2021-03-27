CREATE TABLE IF NOT EXISTS "teams" (
  "team_id" SERIAL PRIMARY KEY NOT NULL,
  "team_name" text UNIQUE NOT NULL,
  "team_name_fa" text NOT NULL,
  "team_picture" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "competitions" (
  "competition_id" SERIAL PRIMARY KEY NOT NULL,
  "competition_acronym" text UNIQUE NOT NULL,
  "competition_picture" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "links" (
  "link_id" SERIAL PRIMARY KEY NOT NULL,
  "link_name" text UNIQUE NOT NULL,
  "link_url" text UNIQUE NOT NULL, -- COMPETITION types are automatically redirected to final stage
  "link_type" text NOT NULL, -- COMPETITION type is for important matches with unspecified teams
  "link_stages" int NOT NULL -- For COMPETITION type: (Eg. 23 := Finals and Semi-Finals from a total of 3 Stages)
);

CREATE TABLE IF NOT EXISTS "posts" (
  "post_id" SERIAL PRIMARY KEY NOT NULL,
  "post_message_id" int,
  "post_date" text UNIQUE NOT NULL,
  "post_html" text NOT NULL
);

CREATE TABLE IF NOT EXISTS "matches" (
  "match_id" SERIAL PRIMARY KEY NOT NULL,
  "match_post_id" int NOT NULL,
  "match_home" int NOT NULL,
  "match_away" int NOT NULL,
  "match_competition" int NOT NULL,
  "match_datetime" text NOT NULL,
  "match_result" text,
  "match_channel" text
);
ALTER TABLE "matches" DROP CONSTRAINT IF EXISTS matches_match_post_id_fkey; 
ALTER TABLE "matches" DROP CONSTRAINT IF EXISTS matches_match_home_fkey; 
ALTER TABLE "matches" DROP CONSTRAINT IF EXISTS matches_match_away_fkey; 
ALTER TABLE "matches" DROP CONSTRAINT IF EXISTS matches_match_competition_fkey; 
ALTER TABLE "matches" ADD FOREIGN KEY ("match_post_id") REFERENCES "posts" ("post_id");
ALTER TABLE "matches" ADD FOREIGN KEY ("match_home") REFERENCES "teams" ("team_id");
ALTER TABLE "matches" ADD FOREIGN KEY ("match_away") REFERENCES "teams" ("team_id");
ALTER TABLE "matches" ADD FOREIGN KEY ("match_competition") REFERENCES "competitions" ("competition_id");

INSERT INTO competitions VALUES (1, 'ACL', 'images/ACL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (2, 'BUN', 'images/BUN.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (3, 'PGP', 'images/PGP.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (4, 'PGL', 'images/PGL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (5, 'CDF', 'images/CDF.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (6, 'CDR', 'images/CDR.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (7, 'CLF', 'images/CLF.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (8, 'COI', 'images/COI.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (9, 'CUP', 'images/CUP.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (10, 'DFP', 'images/DFP.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (11, 'FAC', 'images/FAC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (12, 'FRI', 'images/FRI.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (13, 'SEA', 'images/SEA.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (14, 'PRL', 'images/PRL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (15, 'HAC', 'images/HAC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (16, 'LAL', 'images/LAL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (17, 'LEC', 'images/LEC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (18, 'LI1', 'images/LI1.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (19, 'UNL', 'images/UNL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (20, 'UEL', 'images/UEL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (21, 'UCL', 'images/UCL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (22, 'SUC', 'images/SUC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (23, 'TDC', 'images/TDC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (24, 'WQE', 'images/WQE.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (25, 'WQS', 'images/WQS.png') ON CONFLICT (competition_acronym) DO NOTHING;

INSERT INTO links VALUES (1, 'Manchester City', 'https://int.soccerway.com/teams/england/manchester-city-football-club/676/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (2, 'Liverpool', 'https://int.soccerway.com/teams/england/liverpool-fc/663/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (3, 'Arsenal', 'https://int.soccerway.com/teams/england/arsenal-fc/660/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (4, 'Tottenham Hotspur', 'https://int.soccerway.com/teams/england/tottenham-hotspur-football-club/675/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (5, 'Chelsea', 'https://int.soccerway.com/teams/england/chelsea-football-club/661/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (6, 'Manchester United', 'https://int.soccerway.com/teams/england/manchester-united-fc/662/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (7, 'Napoli', 'https://int.soccerway.com/teams/italy/ssc-napoli/1270/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (8, 'Internazionale', 'https://int.soccerway.com/teams/italy/fc-internazionale-milano/1244/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (9, 'Milan', 'https://int.soccerway.com/teams/italy/ac-milan/1240/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (10, 'Juventus', 'https://int.soccerway.com/teams/italy/juventus-fc/1242/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (11, 'Atalanta', 'https://int.soccerway.com/teams/italy/atalanta-bergamo/1255/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (12, 'Borussia Dortmund', 'https://int.soccerway.com/teams/germany/bv-borussia-09-dortmund/964/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (13, 'Bayern Munich', 'https://int.soccerway.com/teams/germany/fc-bayern-munchen/961/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (14, 'Real Madrid', 'https://int.soccerway.com/teams/spain/real-madrid-club-de-futbol/2016/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (15, 'Barcelona', 'https://int.soccerway.com/teams/spain/futbol-club-barcelona/2017/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (16, 'Atletico Madrid', 'https://int.soccerway.com/teams/spain/club-atletico-de-madrid/2020/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (17, 'Persepolis', 'https://int.soccerway.com/teams/iran/perspolis/1168/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (18, 'Esteghlal', 'https://int.soccerway.com/teams/iran/esteghlal/1164/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (19, 'Iran', 'https://int.soccerway.com/teams/iran/iran/1178/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (20, 'Portugal', 'https://int.soccerway.com/teams/portugal/portugal/1772/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (21, 'Spain', 'https://int.soccerway.com/teams/spain/spain/2137/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (22, 'France', 'https://int.soccerway.com/teams/france/france/944/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (23, 'Argentina', 'https://int.soccerway.com/teams/argentina/argentina/132/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (24, 'Germany', 'https://int.soccerway.com/teams/germany/germany/1037/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (25, 'Brazil', 'https://int.soccerway.com/teams/brazil/brazil/349/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (26, 'England', 'https://int.soccerway.com/teams/england/england/774/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (27, 'Belgium', 'https://int.soccerway.com/teams/belgium/belgium/281/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (28, 'Netherlands', 'https://int.soccerway.com/teams/netherlands/netherlands/1552/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (29, 'Italy', 'https://int.soccerway.com/teams/italy/italy/1318/', 'CLUB', 0) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (30, 'UCL', 'https://int.soccerway.com/international/europe/uefa-champions-league/', 'COMPETITION', 44) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (31, 'UEL', 'https://int.soccerway.com/international/europe/uefa-cup/', 'COMPETITION', 25) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (32, 'AAC', 'https://int.soccerway.com/international/asia/asian-cup/', 'COMPETITION', 44) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (33, 'EUC', 'https://int.soccerway.com/international/europe/european-championships/', 'COMPETITION', 44) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (34, 'UNL', 'https://int.soccerway.com/international/europe/uefa-nations-league/', 'COMPETITION', 23) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (35, 'WOC', 'https://int.soccerway.com/international/world/world-cup/', 'COMPETITION', 55) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (36, 'ACL', 'https://int.soccerway.com/international/asia/afc-champions-league/', 'COMPETITION', 24) ON CONFLICT (link_name) DO NOTHING;
INSERT INTO links VALUES (37, 'USC', 'https://us.soccerway.com/international/europe/uefa-super-cup/', 'COMPETITION', 11) ON CONFLICT (link_name) DO NOTHING;


INSERT INTO teams VALUES (1, 'Atalanta', 'آتالانتا', 'images/Atalanta.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (2, 'Chelsea', 'چلسی', 'images/Chelsea.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (3, 'Arsenal', 'آرسنال', 'images/Arsenal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (4, 'Lazio', 'لاتزیو', 'images/Lazio.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (5, 'Borussia Dortmund', 'بروسیا دورتموند', 'images/Borussia Dortmund.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (6, 'Everton', 'اورتون', 'images/Everton.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (7, 'Atletico Madrid', 'اتلتیکو مادرید', 'images/Atletico Madrid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (8, 'Levante', 'لوانته', 'images/Levante.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (9, 'Manchester United', 'منچستر یونایتد', 'images/Manchester United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (10, 'Milan', 'میلان', 'images/Milan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (11, 'Bayern Munich', 'بایرن مونیخ', 'images/Bayern Munich.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (12, 'Leeds United', 'لیدز یونایتد', 'images/Leeds United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (13, 'Porto', 'پورتو', 'images/Porto.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (14, 'Aston Villa', 'آستون ویلا', 'images/Aston Villa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (15, 'Udinese', 'اودینزه', 'images/Udinese.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (16, 'Juventus', 'یوونتوس', 'images/Juventus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (17, 'Portugal', 'پرتغال', 'images/Portugal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (18, 'Netherlands', 'هلند', 'images/Netherlands.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (19, 'PSG', 'پاریسن ژرمن', 'images/PSG.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (20, 'Barcelona', 'بارسلونا', 'images/Barcelona.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (21, 'France', 'فرانسه', 'images/France.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (22, 'Iran', 'ایران', 'images/Iran.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (23, 'Cagliari', 'کالیاری', 'images/Cagliari.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (24, 'Crystal Palace', 'کریستال پالاس', 'images/Crystal Palace.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (25, 'Sheffield United', 'شفلید یونایتد', 'images/Sheffield United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (26, 'Internazionale', 'اینتر', 'images/Internazionale.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (27, 'Freiburg', 'فرایبورگ', 'images/Freiburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (28, 'Brighton & Hove Albion', 'برایتون', 'images/Brighton & Hove Albion.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (29, 'Villarreal', 'ویارئال', 'images/Villarreal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (30, 'Real Madrid', 'رئال مادرید', 'images/Real Madrid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (31, 'Persepolis', 'پرسپولیس', 'images/Persepolis.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (32, 'Tottenham Hotspur', 'تاتنهام', 'images/Tottenham Hotspur.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (33, 'Zenit', 'زنیت', 'images/Zenit.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (34, 'Spezia', 'اسپتزیا', 'images/Spezia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (35, 'Hertha BSC', 'هرتابرلین', 'images/Hertha BSC.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (36, 'Manchester City', 'منچسترسیتی', 'images/Manchester City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (37, 'Liverpool', 'لیورپول', 'images/Liverpool.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (38, 'Roma', 'رم', 'images/Roma.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (39, 'Napoli', 'ناپولی', 'images/Napoli.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (40, 'Spain', 'اسپانیا', 'images/Spain.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (41, 'Côte d''Ivoire', 'ساحل عاج', 'images/Côte d''Ivoire.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (42, 'Angers SCO', 'آنژیه', 'images/Angers SCO.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (43, 'Sevilla', 'سویا', 'images/Sevilla.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (44, 'Bosnia-Herzegovina', 'بوسنی و هرزگوین', 'images/Bosnia-Herzegovina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (45, 'Cambodia', 'کامبوج', 'images/Cambodia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (46, 'Mali', 'مالی', 'images/Mali.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (47, 'Croatia', 'کرواسی', 'images/Croatia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (48, 'Iceland', 'ایسلند', 'images/Iceland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (49, 'Nîmes', 'نیمس', 'images/Nîmes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (50, 'Newcastle United', 'نیوکاسل', 'images/Newcastle United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (51, 'Crotone', 'کروتونه', 'images/Crotone.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (52, 'Hoffenheim', 'هوفنهایم', 'images/Hoffenheim.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (53, 'Arminia Bielefeld', 'آرمینیا بیلفلد', 'images/Arminia Bielefeld.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (54, 'Getafe', 'ختافه', 'images/Getafe.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (55, 'Celta Vigo', 'سلتاویگو', 'images/Celta Vigo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (56, 'Southampton', 'ساوتهمپتون', 'images/Southampton.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (57, 'West Ham United', 'وستهام', 'images/West Ham United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (58, 'Benevento', 'بنونتو', 'images/Benevento.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (59, 'Cádiz', 'کادیز', 'images/Cádiz.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (60, 'Borussia M''gladbach', 'مونشن گلادباخ', 'images/Borussia M''gladbach.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (61, 'Shakhtar Donetsk', 'شاختار دونتسک', 'images/Shakhtar Donetsk.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (62, 'Genoa', 'جنوآ', 'images/Genoa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (63, 'Sampdoria', 'سمپدوریا', 'images/Sampdoria.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (64, 'Schalke 04', 'شالکه 04', 'images/Schalke 04.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (65, 'Eintracht Frankfurt', 'آنتراخت فرانکفورت', 'images/Eintracht Frankfurt.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (66, 'Real Betis', 'رئال بتیس', 'images/Real Betis.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (67, 'Dijon', 'دیژون', 'images/Dijon.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (68, 'Rubin Kazan', 'روبین کازان', 'images/Rubin Kazan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (69, 'Leicester City', 'لسترسیتی', 'images/Leicester City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (70, 'Hellas Verona', 'ورونا', 'images/Hellas Verona.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (71, 'Burnley', 'برنلی', 'images/Burnley.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (72, 'West Bromwich Albion', 'وست برومویچ', 'images/West Bromwich Albion.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (73, 'Köln', 'کلن', 'images/Köln.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (74, 'Osasuna', 'اوساسونا', 'images/Osasuna.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (75, 'Krasnodar', 'کراسنودار', 'images/Krasnodar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (76, 'Olympique Marseille', 'المپیک مارسی', 'images/Olympique Marseille.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (77, 'Real Sociedad', 'رئال سوسیداد', 'images/Real Sociedad.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (78, 'Deportivo Alavés', 'آلاوز', 'images/Deportivo Alavés.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (79, 'Nantes', 'نانت', 'images/Nantes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (80, 'Esteghlal', 'استقلال', 'images/Esteghlal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (81, 'Saipa', 'سایپا', 'images/Saipa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (82, 'Huesca', 'هوئسکا', 'images/Huesca.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (83, 'Parma', 'پارما', 'images/Parma.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (84, 'Sassuolo', 'ساسولو', 'images/Sassuolo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (85, 'Fiorentina', 'فیورنتینا', 'images/Fiorentina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (86, 'Olympiakos Piraeus', 'المپیاکس', 'images/Olympiakos Piraeus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (87, 'RB Leipzig', 'لایپزیش', 'images/RB Leipzig.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (88, 'Tractor', 'تراکتورسازی', 'images/Tractor.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (89, 'Mes Rafsanjan', 'مس رفسنجان', 'images/Mes Rafsanjan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (90, 'Bologna', 'بولونیا', 'images/Bologna.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (91, 'Valencia', 'والنسیا', 'images/Valencia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (92, 'Foolad', 'فولاد', 'images/Foolad.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (93, 'Lille', 'لیل', 'images/Lille.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (94, 'Sanat Naft', 'صنعت نفت', 'images/Sanat Naft.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (95, 'Naft Masjed Soleyman', 'نفت مسجد سلیمان', 'images/Naft Masjed Soleyman.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (96, 'Machine Sazi', 'ماشین سازی', 'images/Machine Sazi.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (97, 'Czech Republic', 'جمهوری چک', 'images/Czech Republic.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (98, 'Bahrain', 'بحرین', 'images/Bahrain.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (99, 'Monaco', 'موناکو', 'images/Monaco.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (100, 'Iraq', 'عراق', 'images/Iraq.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (101, 'Shahr Khodrou', 'شهر خودرو', 'images/Shahr Khodrou.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (102, 'Paykan', 'پیکان', 'images/Paykan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (103, 'Stuttgart', 'اشتوتگارت', 'images/Stuttgart.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (104, 'Nassaji Mazandaran', 'نساجی', 'images/Nassaji Mazandaran.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (105, 'Torino', 'تورنیو', 'images/Torino.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (106, 'Werder Bremen', 'وردر برمن', 'images/Werder Bremen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (107, 'Wolverhampton Wanderers', 'ولورهمپتون', 'images/Wolverhampton Wanderers.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (108, 'Bordeaux', 'بوردو', 'images/Bordeaux.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (109, 'Zob Ahan', 'ذوب آهن', 'images/Zob Ahan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (110, 'Fulham', 'فولام', 'images/Fulham.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (111, 'Real Valladolid', 'وایادولید', 'images/Real Valladolid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (112, 'Union Berlin', 'یونیون برلین', 'images/Union Berlin.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (113, 'Montpellier', 'مونپولیه', 'images/Montpellier.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (114, 'Elche', 'الچه', 'images/Elche.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (115, 'Bayer Leverkusen', 'بایر لورکوزن', 'images/Bayer Leverkusen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (116, 'Stoke City', 'استوک سیتی', 'images/Stoke City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (117, 'Granada', 'گرانادا', 'images/Granada.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (118, 'Wolfsburg', 'ولفسبورگ', 'images/Wolfsburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (119, 'Eintracht Braunschweig', 'براونشویگ', 'images/Eintracht Braunschweig.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (120, 'Olympique Lyonnais', 'المپیک لیون', 'images/Olympique Lyonnais.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (121, 'Lorient', 'لورین', 'images/Lorient.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (122, 'Eibar', 'ایبار', 'images/Eibar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (123, 'Strasbourg', 'استراسبورگ', 'images/Strasbourg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (124, 'Benfica', 'بنفیکا', 'images/Benfica.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (125, 'Athletic Club', 'اتلتیک بیلبائو', 'images/Athletic Club.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (126, 'Gol Gohar', 'گل گهر', 'images/Gol Gohar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (127, 'Mainz 05', 'ماینتس ۰۵', 'images/Mainz 05.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (128, 'Aluminium Arak', 'آلومینیوم اراک', 'images/Aluminium Arak.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (129, 'Sepahan', 'سپاهان', 'images/Sepahan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (130, 'Brentford', 'برنتفورد', 'images/Brentford.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (131, 'Cornellà', 'کورنلا', 'images/Cornellà.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (132, 'Saint-Etienne', 'سنت اتین', 'images/Saint-Etienne.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (133, 'Watford', 'واتفورد', 'images/Watford.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (134, 'Brest', 'برست', 'images/Brest.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (135, 'Birmingham City', 'بیرمنگام', 'images/Birmingham City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (136, 'Morecambe', 'مورکم', 'images/Morecambe.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (137, 'Marine', 'مارین', 'images/Marine.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (138, 'Newport County', 'نیوپورت کانتی', 'images/Newport County.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (139, 'Empoli', 'امپولی', 'images/Empoli.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (140, 'Holstein Kiel', 'هولشتاين كيل', 'images/Holstein Kiel.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (141, 'Augsburg', 'آگسبورگ', 'images/Augsburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (142, 'Alcoyano', 'آلکویانو', 'images/Alcoyano.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (143, 'Blackpool', 'بلک‌پول', 'images/Blackpool.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (144, 'Cheltenham Town', 'چلتنهام تاون', 'images/Cheltenham Town.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (145, 'Shakhtyor', 'شاختیور', 'images/Shakhtyor.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (146, 'Luton Town', 'لوتون تاون', 'images/Luton Town.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (147, 'Wycombe Wanderers', 'وایکام واندررز', 'images/Wycombe Wanderers.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (148, 'Rayo Vallecano', 'رایووایکانو', 'images/Rayo Vallecano.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (149, 'SPAL', 'اسپال', 'images/SPAL.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (150, 'Paderborn', 'پادربورن', 'images/Paderborn.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (151, 'Arsenal Tula', 'آرسنال تولا', 'images/Arsenal Tula.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (152, 'Wolfsberger AC', 'ولفسبرگر', 'images/Wolfsberger AC.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (153, 'Rostov', 'روستوف', 'images/Rostov.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (154, 'Dinamo Zagreb', 'دینامو زاگرب', 'images/Dinamo Zagreb.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (155, 'Barnsley', 'بارنزلی', 'images/Barnsley.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (156, 'Crvena Zvezda', 'ستارهٔ سرخ بلگراد', 'images/Crvena Zvezda.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (157, 'Sporting Braga', 'براگا', 'images/Sporting Braga.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (158, 'Caen', 'کان', 'images/Caen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (159, 'Mes Novin Kerman', 'مس نوین کرمان', 'images/Mes Novin Kerman.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (160, 'Al Rayyan', 'الریان', 'images/Al Rayyan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (161, 'Al Shorta', 'الشرطه', 'images/Al Shorta.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (162, 'Serbia', 'صربستان', 'images/Serbia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (163, 'Luxembourg', 'لوکزامبورگ', 'images/Luxembourg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (164, 'Georgia', 'گرجستان', 'images/Georgia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (165, 'Kazakhstan', 'قزاقستان', 'images/Kazakhstan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (166, 'Nice', 'نیس', 'images/Nice.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (167, 'Korea Republic', 'کره جنوبی', 'images/Korea Republic.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (168, 'Akhmat Grozny', 'احمد گروزنی', 'images/Akhmat Grozny.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (169, 'Azerbaijan', 'آذربایجان', 'images/Azerbaijan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (170, 'Albania', 'آلبانی', 'images/Albania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (171, 'Argentina', 'آرژانتین', 'images/Argentina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (172, 'Belarus', 'بلاروس', 'images/Belarus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (173, 'Belgium', 'بلژیک', 'images/Belgium.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (174, 'Brazil', 'برزیل', 'images/Brazil.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (175, 'Bulgaria', 'بلغارستان', 'images/Bulgaria.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (176, 'Colombia', 'کلمبیا', 'images/Colombia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (177, 'England', 'انگلستان', 'images/England.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (178, 'Germany', 'آلمان', 'images/Germany.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (179, 'Gibraltar', 'جبل طارق', 'images/Gibraltar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (180, 'Greece', 'یونان', 'images/Greece.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (181, 'Italy', 'ایتالیا', 'images/Italy.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (182, 'Kosovo', 'کوزوو', 'images/Kosovo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (183, 'Latvia', 'لتونی', 'images/Latvia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (184, 'Lithuania', 'لیتوانی', 'images/Lithuania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (185, 'Northern Ireland', 'ایرلند شمالی', 'images/Northern Ireland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (186, 'Poland', 'لهستان', 'images/Poland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (187, 'Romania', 'رومانی', 'images/Romania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (188, 'San Marino', 'سن مارینو', 'images/San Marino.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (189, 'Turkey', 'ترکیه', 'images/Turkey.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (190, 'Turkeminstan', 'ترکمنستان', 'images/Turkmenistan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (191, 'Tuvalu', 'تووالو', 'images/Tuvalu.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (192, 'UAE', 'امارات', 'images/UAE.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (193, 'Uganda', 'اوگاندا', 'images/Uganda.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (194, 'Ukraine', 'اوکراین', 'images/Ukraine.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (195, 'United States', 'آمریکا', 'images/United States.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (196, 'Uruguay', 'اروگوئه', 'images/Uruguay.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (197, 'Uzbekistan', 'ازبکستان', 'images/Uzbekistan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (198, 'Vanuatu', 'وانواتو', 'images/Vanuatu.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (199, 'Venezuela', 'ونزوئلا', 'images/Venezuela.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (200, 'Vietnam', 'ویتنام', 'images/Vietnam.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (201, 'Wales', 'ولز', 'images/Wales.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (202, 'Yemen', 'یمن', 'images/Yemen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (203, 'Zambia', 'زامبیا', 'images/Zambia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (204, 'Zimbabwe', 'زیمبابوه', 'images/Zimbabwe.png') ON CONFLICT (team_name) DO NOTHING;

SELECT pg_catalog.setval('links_link_id_seq', (SELECT MAX(link_id) FROM links), true);
SELECT pg_catalog.setval('competitions_competition_id_seq', (SELECT MAX(competition_id) FROM competitions), true);
SELECT pg_catalog.setval('teams_team_id_seq', (SELECT MAX(team_id) FROM teams), true);
SELECT pg_catalog.setval('matches_match_id_seq', (SELECT MAX(match_id) FROM matches), true);
SELECT pg_catalog.setval('posts_post_id_seq', (SELECT MAX(post_id) FROM posts), true);
