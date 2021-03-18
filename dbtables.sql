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
  "post_message_id" int NOT NULL,
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
INSERT INTO competitions VALUES (14, 'PRL3', 'images/PRL3.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (15, 'HAC', 'images/HAC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (16, 'LAL', 'images/LAL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (17, 'LEC', 'images/LEC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (18, 'LI1', 'images/LI1.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (19, 'UNL', 'images/UNL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (20, 'UEL', 'images/UEL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (21, 'UCL', 'images/UCL.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (22, 'SUC', 'images/SUC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (23, 'TDC', 'images/TDC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (24, 'USC', 'images/USC.png') ON CONFLICT (competition_acronym) DO NOTHING;
INSERT INTO competitions VALUES (25, 'WOC', 'images/WOC.png') ON CONFLICT (competition_acronym) DO NOTHING;

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
INSERT INTO teams VALUES (5, 'Uzbekistan', 'ازبکستان', 'images/Uzbekistan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (6, 'Borussia Dortmund', 'بروسیا دورتموند', 'images/Borussia Dortmund.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (7, 'Everton', 'اورتون', 'images/Everton.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (8, 'Atletico Madrid', 'اتلتیکو مادرید', 'images/Atletico Madrid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (9, 'Levante', 'لوانته', 'images/Levante.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (10, 'Al Nassr', 'النصر', 'images/Al Nassr.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (11, 'Manchester United', 'منچستر یونایتد', 'images/Manchester United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (12, 'Spartak Moscow', 'اسپارتاک مسکو', 'images/Spartak Moscow.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (13, 'Milan', 'میلان', 'images/Milan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (14, 'Bayern Munich', 'بایرن مونیخ', 'images/Bayern Munich.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (15, 'Leeds United', 'لیدز یونایتد', 'images/Leeds United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (16, 'Porto', 'پورتو', 'images/Porto.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (17, 'Aston Villa', 'آستون ویلا', 'images/Aston Villa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (18, 'Udinese', 'اودینزه', 'images/Udinese.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (19, 'Juventus', 'یوونتوس', 'images/Juventus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (20, 'Portugal', 'پرتغال', 'images/Portugal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (21, 'Germany', 'آلمان', 'images/Germany.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (22, 'Netherlands', 'هلند', 'images/Netherlands.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (23, 'Belgium', 'بلژیک', 'images/Belgium.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (24, 'PSG', 'پاریسن ژرمن', 'images/PSG.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (25, 'Barcelona', 'بارسلونا', 'images/Barcelona.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (26, 'England', 'انگلستان', 'images/England.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (27, 'France', 'فرانسه', 'images/France.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (28, 'Iran', 'ایران', 'images/Iran.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (29, 'Cagliari', 'کالیاری', 'images/Cagliari.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (30, 'Crystal Palace', 'کریستال پالاس', 'images/Crystal Palace.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (31, 'Sheffield United', 'شفلید یونایتد', 'images/Sheffield United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (32, 'Internazionale', 'اینتر', 'images/Internazionale.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (33, 'Freiburg', 'فرایبورگ', 'images/Freiburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (34, 'Brighton & Hove Albion', 'برایتون', 'images/Brighton & Hove Albion.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (35, 'Villarreal', 'ویارئال', 'images/Villarreal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (36, 'Real Madrid', 'رئال مادرید', 'images/Real Madrid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (37, 'Persepolis', 'پرسپولیس', 'images/Persepolis.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (38, 'Tottenham Hotspur', 'تاتنهام', 'images/Tottenham Hotspur.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (39, 'Zenit', 'زنیت', 'images/Zenit.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (40, 'Spezia', 'اسپتزیا', 'images/Spezia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (41, 'Hertha BSC', 'هرتابرلین', 'images/Hertha BSC.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (42, 'Manchester City', 'منچسترسیتی', 'images/Manchester City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (43, 'Marítimo', 'ماریتیمو', 'images/Marítimo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (44, 'Liverpool', 'لیورپول', 'images/Liverpool.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (45, 'Roma', 'رم', 'images/Roma.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (46, 'Napoli', 'ناپولی', 'images/Napoli.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (47, 'Spain', 'اسپانیا', 'images/Spain.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (48, 'Turkey', 'ترکیه', 'images/Turkey.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (49, 'Mexico', 'مکزیک', 'images/Mexico.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (50, 'Côte d''Ivoire', 'ساحل عاج', 'images/Côte d''Ivoire.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (51, 'Angers SCO', 'آنژیه', 'images/Angers SCO.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (52, 'Sevilla', 'سویا', 'images/Sevilla.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (53, 'Wales', 'ولز', 'images/Wales.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (54, 'Ukraine', 'اوکراین', 'images/Ukraine.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (55, 'New Zealand', 'نیوزلند', 'images/New Zealand.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (56, 'Hong Kong', 'هنگ‌کنگ', 'images/Hong Kong.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (57, 'Argentina', 'آرژانتین', 'images/Argentina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (58, 'Brazil', 'برزیل', 'images/Brazil.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (59, 'Bosnia-Herzegovina', 'بوسنی و هرزگوین', 'images/Bosnia-Herzegovina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (60, 'Cambodia', 'کامبوج', 'images/Cambodia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (61, 'Mali', 'مالی', 'images/Mali.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (62, 'Bolivia', 'بولیوی', 'images/Bolivia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (63, 'Croatia', 'کرواسی', 'images/Croatia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (64, 'Peru', 'پرو', 'images/Peru.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (65, 'Iceland', 'ایسلند', 'images/Iceland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (66, 'Italy', 'ایتالیا', 'images/Italy.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (67, 'Düren Merzenich', 'اف سی دورن', 'images/Düren Merzenich.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (68, 'Nîmes', 'نیمس', 'images/Nîmes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (69, 'Newcastle United', 'نیوکاسل', 'images/Newcastle United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (70, 'Crotone', 'کروتونه', 'images/Crotone.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (71, 'Hoffenheim', 'هوفنهایم', 'images/Hoffenheim.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (72, 'Arminia Bielefeld', 'آرمینیا بیلفلد', 'images/Arminia Bielefeld.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (73, 'Getafe', 'ختافه', 'images/Getafe.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (74, 'Celta Vigo', 'سلتاویگو', 'images/Celta Vigo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (75, 'Sporting CP', 'اسپورتینگ', 'images/Sporting CP.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (76, 'Ecuador', 'اکوادور', 'images/Ecuador.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (77, 'Switzerland', 'سوئیس', 'images/Switzerland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (78, 'Sweden', 'سوئد', 'images/Sweden.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (79, 'Denmark', 'دانمارک', 'images/Denmark.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (80, 'Southampton', 'ساوتهمپتون', 'images/Southampton.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (81, 'Sochi', 'سوچی', 'images/Sochi.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (82, 'West Ham United', 'وستهام', 'images/West Ham United.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (83, 'Benevento', 'بنونتو', 'images/Benevento.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (84, 'Cádiz', 'کادیز', 'images/Cádiz.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (85, 'Dynamo Kyiv', 'دیناموکیف', 'images/Dynamo Kyiv.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (86, 'Ferencvaros', 'فرانس واروش', 'images/Ferencvaros.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (87, 'Club Brugge', 'کلاب بروخه', 'images/Club Brugge.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (88, 'Ajax', 'آژاکس', 'images/Ajax.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (89, 'Borussia M''gladbach', 'مونشن گلادباخ', 'images/Borussia M''gladbach.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (90, 'Midtjylland', 'میتیلند', 'images/Midtjylland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (91, 'Shakhtar Donetsk', 'شاختار دونتسک', 'images/Shakhtar Donetsk.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (92, 'Rapid Wien', 'راپید وین', 'images/Rapid Wien.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (93, 'LASK', 'لاسک', 'images/LASK.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (94, 'AZ', 'آ زد آلکمار', 'images/AZ.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (95, 'Celtic', 'سلتیک', 'images/Celtic.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (96, 'Young Boys', 'یانگ بویز', 'images/Young Boys.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (97, 'Genoa', 'جنوآ', 'images/Genoa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (98, 'Sampdoria', 'سمپدوریا', 'images/Sampdoria.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (99, 'Schalke 04', 'شالکه 04', 'images/Schalke 04.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (100, 'Eintracht Frankfurt', 'آنتراخت فرانکفورت', 'images/Eintracht Frankfurt.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (101, 'Real Betis', 'رئال بتیس', 'images/Real Betis.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (102, 'Dijon', 'دیژون', 'images/Dijon.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (103, 'Gil Vicente', 'گیل ویسنته', 'images/Gil Vicente.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (104, 'Rubin Kazan', 'روبین کازان', 'images/Rubin Kazan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (105, 'Leicester City', 'لسترسیتی', 'images/Leicester City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (106, 'Hellas Verona', 'ورونا', 'images/Hellas Verona.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (107, 'Burnley', 'برنلی', 'images/Burnley.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (108, 'West Bromwich Albion', 'وست برومویچ', 'images/West Bromwich Albion.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (109, 'Khimki', 'کیمکی', 'images/Khimki.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (110, 'Köln', 'کلن', 'images/Köln.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (111, 'Osasuna', 'اوساسونا', 'images/Osasuna.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (112, 'Lokomotiv Moscow', 'لوکوموتیو مسکو', 'images/Lokomotiv Moscow.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (113, 'Krasnodar', 'کراسنودار', 'images/Krasnodar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (114, 'Istanbul Basaksehir', 'باشاکشهیر', 'images/Istanbul Basaksehir.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (115, 'Antwerp', 'آنتورپ', 'images/Antwerp.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (116, 'Olympique Marseille', 'المپیک مارسی', 'images/Olympique Marseille.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (117, 'Real Sociedad', 'رئال سوسیداد', 'images/Real Sociedad.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (118, 'Deportivo Alavés', 'آلاوز', 'images/Deportivo Alavés.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (119, 'Nantes', 'نانت', 'images/Nantes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (120, 'Paços de Ferreira', 'پاکوس ده فریرا', 'images/Paços de Ferreira.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (121, 'Esteghlal', 'استقلال', 'images/Esteghlal.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (122, 'Saipa', 'سایپا', 'images/Saipa.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (123, 'Huesca', 'هوئسکا', 'images/Huesca.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (124, 'Parma', 'پارما', 'images/Parma.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (125, 'Sassuolo', 'ساسولو', 'images/Sassuolo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (126, 'Fiorentina', 'فیورنتینا', 'images/Fiorentina.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (127, 'Sparta Praha', 'اسپارتا پراگ', 'images/Sparta Praha.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (128, 'Salzburg', 'سالزبورگ', 'images/Salzburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (129, 'Olympiakos Piraeus', 'المپیاکس', 'images/Olympiakos Piraeus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (130, 'RB Leipzig', 'لایپزیش', 'images/RB Leipzig.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (131, 'Dundalk', 'دوندالک', 'images/Dundalk.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (132, 'CSKA Sofia', 'زسکا سوفیا', 'images/CSKA Sofia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (133, 'Tractor', 'تراکتورسازی', 'images/Tractor.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (134, 'Mes Rafsanjan', 'مس رفسنجان', 'images/Mes Rafsanjan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (135, 'Bologna', 'بولونیا', 'images/Bologna.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (136, 'Ludogorets', 'لودوگورتس', 'images/Ludogorets.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (137, 'Rijeka', 'ریکا', 'images/Rijeka.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (138, 'Valencia', 'والنسیا', 'images/Valencia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (139, 'Foolad', 'فولاد', 'images/Foolad.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (140, 'Portimonense', 'پورتیمونس', 'images/Portimonense.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (141, 'CFR Cluj', 'سی اف آر کلاژ', 'images/CFR Cluj.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (143, 'Molde', 'مولد', 'images/Molde.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (144, 'Lille', 'لیل', 'images/Lille.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (142, 'Rennes', 'رن', 'images/Rennes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (146, 'Sanat Naft', 'صنعت نفت', 'images/Sanat Naft.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (147, 'Naft Masjed Soleyman', 'نفت مسجد سلیمان', 'images/Naft Masjed Soleyman.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (148, 'Paraguay', 'پاراگوئه', 'images/Paraguay.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (149, 'Venezuela', 'ونزوئلا', 'images/Venezuela.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (150, 'Machine Sazi', 'ماشین سازی', 'images/Machine Sazi.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (151, 'Andorra', 'آندورا', 'images/Andorra.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (152, 'Czech Republic', 'جمهوری چک', 'images/Czech Repng') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (153, 'Estonia', 'استونی', 'images/Estonia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (154, 'Poland', 'لهستان', 'images/Poland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (155, 'Republic of Ireland', 'ایرلند', 'images/Republic of Ireland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (156, 'Finland', 'فنلاند', 'images/Finland.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (157, 'Bahrain', 'بحرین', 'images/Bahrain.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (158, 'Monaco', 'موناکو', 'images/Monaco.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (159, 'Iraq', 'عراق', 'images/Iraq.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (160, 'Shahr Khodrou', 'شهر خودرو', 'images/Shahr Khodrou.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (161, 'Paykan', 'پیکان', 'images/Paykan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (162, 'Uruguay', 'اوروگوئه', 'images/Uruguay.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (163, 'Stuttgart', 'اشتوتگارت', 'images/Stuttgart.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (164, 'Nassaji Mazandaran', 'نساجی', 'images/Nassaji Mazandaran.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (165, 'Torino', 'تورنیو', 'images/Torino.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (166, 'Werder Bremen', 'وردر برمن', 'images/Werder Bremen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (167, 'Wolverhampton Wanderers', 'ولورهمپتون', 'images/Wolverhampton Wanderers.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (168, 'Bordeaux', 'بوردو', 'images/Bordeaux.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (169, 'Zob Ahan', 'ذوب آهن', 'images/Zob Ahan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (170, 'Fulham', 'فولام', 'images/Fulham.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (171, 'Real Valladolid', 'وایادولید', 'images/Real Valladolid.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (172, 'Union Berlin', 'یونیون برلین', 'images/Union Berlin.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (173, 'Montpellier', 'مونپولیه', 'images/Montpellier.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (174, 'Elche', 'الچه', 'images/Elche.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (175, 'Bayer Leverkusen', 'بایر لورکوزن', 'images/Bayer Leverkusen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (176, 'Stoke City', 'استوک سیتی', 'images/Stoke City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (177, 'Cardassar', 'کارداسار', 'images/Cardassar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (178, 'Granada', 'گرانادا', 'images/Granada.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (179, 'Wolfsburg', 'ولفسبورگ', 'images/Wolfsburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (180, 'Eintracht Braunschweig', 'براونشویگ', 'images/Eintracht Braunschweig.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (181, 'Olympique Lyonnais', 'المپیک لیون', 'images/Olympique Lyonnais.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (182, 'Lorient', 'لورین', 'images/Lorient.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (183, 'Eibar', 'ایبار', 'images/Eibar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (184, 'Strasbourg', 'استراسبورگ', 'images/Strasbourg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (185, 'Benfica', 'بنفیکا', 'images/Benfica.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (186, 'Athletic Club', 'اتلتیک بیلبائو', 'images/Athletic Club.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (187, 'Vitoria Guimaraes', 'ویتوریا گیمارش', 'images/Vitoria Guimaraes.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (188, 'Gol Gohar', 'گل گهر', 'images/Gol Gohar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (189, 'Mainz 05', 'ماینتس ۰۵', 'images/Mainz 05.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (190, 'Moreirense', 'موریرنز', 'images/Moreirense.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (191, 'Aluminium Arak', 'آلومینیوم اراک', 'images/Aluminium Arak.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (192, 'Sepahan', 'سپاهان', 'images/Sepahan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (193, 'Brentford', 'برنتفورد', 'images/Brentford.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (194, 'Cornellà', 'کورنلا', 'images/Cornellà.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (195, 'Saint-Etienne', 'سنت اتین', 'images/Saint-Etienne.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (196, 'Watford', 'واتفورد', 'images/Watford.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (197, 'Brest', 'برست', 'images/Brest.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (198, 'Birmingham City', 'بیرمنگام', 'images/Birmingham City.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (199, 'Morecambe', 'مورکم', 'images/Morecambe.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (200, 'Marine', 'مارین', 'images/Marine.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (201, 'Newport County', 'نیوپورت کانتی', 'images/Newport County.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (202, 'Empoli', 'امپولی', 'images/Empoli.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (203, 'Holstein Kiel', 'هولشتاين كيل', 'images/Holstein Kiel.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (204, 'Augsburg', 'آگسبورگ', 'images/Augsburg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (205, 'Alcoyano', 'آلکویانو', 'images/Alcoyano.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (206, 'Blackpool', 'بلک‌پول', 'images/Blackpool.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (207, 'Cheltenham Town', 'چلتنهام تاون', 'images/Cheltenham Town.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (208, 'Shakhtyor', 'شاختیور', 'images/Shakhtyor.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (209, 'Luton Town', 'لوتون تاون', 'images/Luton Town.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (210, 'Wycombe Wanderers', 'وایکام واندررز', 'images/Wycombe Wanderers.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (211, 'Rayo Vallecano', 'رایووایکانو', 'images/Rayo Vallecano.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (212, 'SPAL', 'اسپال', 'images/SPAL.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (213, 'Paderborn', 'پادربورن', 'images/Paderborn.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (214, 'Arsenal Tula', 'آرسنال تولا', 'images/Arsenal Tula.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (215, 'Wolfsberger AC', 'ولفسبرگر', 'images/Wolfsberger AC.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (216, 'Rostov', 'روستوف', 'images/Rostov.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (217, 'Dinamo Zagreb', 'دینامو زاگرب', 'images/Dinamo Zagreb.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (218, 'Barnsley', 'بارنزلی', 'images/Barnsley.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (219, 'Crvena Zvezda', 'ستارهٔ سرخ بلگراد', 'images/Crvena Zvezda.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (220, 'Sporting Braga', 'براگا', 'images/Sporting Braga.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (221, 'Caen', 'کان', 'images/Caen.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (222, 'Mes Novin Kerman', 'مس نوین کرمان', 'images/Mes Novin Kerman.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (223, 'Al Rayyan', 'الریان', 'images/Al Rayyan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (224, 'Al Shorta', 'الشرطه', 'images/Al Shorta.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (225, 'Serbia', 'صربيا', 'images/Serbia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (226, 'Luxembourg', 'لوکزامبورگ', 'images/Luxembourg.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (227, 'Georgia', 'گرجستان', 'images/Georgia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (228, 'Kazakhstan', 'قزاقستان', 'images/Kazakhstan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (229, 'Hungary', 'هنغاريا', 'images/Hungary.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (230, 'Colombia', 'کلمبیا', 'images/Colombia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (231, 'Romania', 'رومانی', 'images/Romania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (232, 'Albania', 'آلبانی', 'images/Albania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (233, 'Gibraltar', 'جبل الطارق', 'images/Gibraltar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (234, 'CSKA Moscow', 'سيسكا موسكو', 'images/CSKA Moscow.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (235, 'Bulgaria', 'بلغارستان', 'images/Bulgaria.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (236, 'Lithuania', 'لیتوانی', 'images/Lithuania.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (237, 'Tigres UANL', 'تیگرس', 'images/Tigres UANL.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (238, 'Nice', 'نیس', 'images/Nice.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (239, 'Al Ahli', 'الاهلی', 'images/Al Ahli.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (240, 'Oman', 'عمان', 'images/Oman.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (241, 'Azerbaijan', 'آذربایجان', 'images/Azerbaijan.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (242, 'Qatar', 'قطر', 'images/Qatar.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (243, 'Greece', 'یونان', 'images/Greece.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (244, 'Kosovo', 'کوزوو', 'images/Kosovo.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (245, 'Chile', 'شیلی', 'images/Chile.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (246, 'North Macedonia', 'مقدونیه شمالی', 'images/North Macedonia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (247, 'Korea Republic', 'کره جنوبی', 'images/Korea Repng') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (248, 'San Marino', 'سان مارينو', 'images/San Marino.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (249, 'Austria', 'اتریش', 'images/Austria.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (250, 'Belarus', 'بلاروس', 'images/Belarus.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (251, 'Russia', 'روسیه', 'images/Russia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (252, 'Latvia', 'لتونی', 'images/Latvia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (253, 'Ararat-Armenia', 'آرارات ارمنستان', 'images/Ararat-Armenia.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (254, 'Noah', 'نوح', 'images/Noah.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (255, 'Akhmat Grozny', 'احمد گروزنی', 'images/Akhmat Grozny.png') ON CONFLICT (team_name) DO NOTHING;
INSERT INTO teams VALUES (256, 'Northern Ireland', 'ایرلند شمالی', 'images/Northern Ireland.png') ON CONFLICT (team_name) DO NOTHING;

SELECT pg_catalog.setval('links_link_id_seq', (SELECT MAX(link_id) FROM links), true);
SELECT pg_catalog.setval('competitions_competition_id_seq', (SELECT MAX(competition_id) FROM competitions), true);
SELECT pg_catalog.setval('teams_team_id_seq', (SELECT MAX(team_id) FROM teams), true);
SELECT pg_catalog.setval('matches_match_id_seq', (SELECT MAX(match_id) FROM matches), true);
SELECT pg_catalog.setval('posts_post_id_seq', (SELECT MAX(post_id) FROM posts), true);
