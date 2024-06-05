-- Retrieve the Team name , Start date of team , Home Kit and away kit of the team.
select  Tname As Team_Name,Tstart_date AS Start_Date,Thome_kit AS Home_Kit,Taway_kit as Away_Kit
from Team;

-- Retrieve the player name , player number  , player nationality , Player position and salary of the player whose Team_Tname is 'Man_city'.
select  Pname As Player_Name, pno AS Player_Number,Pnationalty AS Nationalty,Position ,Psalary As Salary
from player
where Team_Tname="Man_city";

-- Retrieve coach name and coach nationality of the coach Whose Cnathionalty is 'Egyption'.
select Cname AS Name, Cnathionalty AS Nathionalty
from Coach
where Cnathionalty = "Egyption";

-- Retrieve the Team Name , Prize Name of the Achivment Team who has Fa_cup and greater than 6 awards
Select Team_Tname as team_name , Aname as prize_name
from achivment_team 
where  Aname ="FA_cup" and Ano_Champion > 6;

-- Retrieve all details the Game who The result of all game ended 2 - 1
select * 
from Game
where Hscore=2 and Ascore=1; 

-- Retrieve the player name And Achievement_Player who has an achievement
select Apname , pname
from player , achinment_player
where Player_Pssn=Pssn;

-- Retrieve The Game number , Refrree name , player name who The player who received a one yellow card in the game
select Gno As game_number , Rname as Refree_name , pname as Player_name
from Game, refrree, player ,punish,player_has_game
where yellow_card=1 and Rssn=Refrree_Rssn and Gno=Game_Gno and Gno=Game_Gnob and Pssn=Player_Pssn and pssn=Player_Pssnb;

-- Retrieve The Player name , player position , Sgoal , assists and Number game  So That Zenhom Or Omar elqady made a goal or assist in a match 
select pname as 'player_name' , position , sgoal as goal , Sassist as assists , gno as game_week 
 from player , score , game
 where Pssn=Player_Pssn and Gno=Game_Gno
 and Pname IN('omar_elqady' , 'zenhom');
 
 -- Retrieve the stadium name, the Team Away, A Game number Whose stadium name is "old Trafford" and Awayscore is greater than Homescore.
 Select Sname AS Stadium , Taway As Team , Gno as game_week 
 from stadium,Game,stadium_game
 where Ascore > Hscore and Sname = "Old_trafford" and  Sname=Stadium_Sname and Game_Gno=Gno;
 
 -- Retrieve the player name ,  Prize Name of achinment_player , team name and coach_name So that Psalary of player between 25000 and 60000.
SELECT Pname AS Player_name , APname AS prize_name , Tname AS team_name , Cname AS coach_name
FROM player , achinment_player , team , coach
WHERE Player_Pssn=Pssn and Team_Tname=Tname and Cssn=coche_Cssn and Psalary between 25000 and 60000;

-- Retrieve the total number of Team name in the team whose The capcaity of stadium greater than 65000.
SELECT COUNT(Tname) AS number_of_Teams_in_league
FROM team , stadium
where capcaity > 65000 and Team_Tname=Tname;

-- Find The Sum of The Score goal for every Team.
Select sum(Sgoal) As Number_of_Goal,Tname As Team
From Score , team , Player
where Tname=Team_Tname and Player_Pssn=Pssn
group by Tname;

-- Retrieve The sum of assist of playe whose pssn is '404' and retrieve name of player
select sum(sassist) as num_assist , pname
from score , player
where Player_Pssn=pssn
and Pssn='404';

-- Retrieve The Team name and The Average of player Salary for each player Whose greater than 40000 and Descending Order
select avg(Psalary) as avg_salary , Tname
from player , team
WHERE Tname=Team_Tname
group by Tname
having avg_salary > 40000
order by avg_salary desc;

-- Retrieve name of refree and The Most sum of yellow card which the one refree give for players
select rname , sum(yellow_card) as total_yellowcard
from refrree join punish on rssn=refrree_rssnb
group by rname
ORDER BY total_yellowcard DESC
limit 1;

-- Retrive Player name , Player salary , Team name , player ssn whose player Score Goal.
select psalary , pname, team_Tname , Pssn
from player 
where pssn in 
(
select Player_Pssn 
from score
group by Player_Pssn
);

-- list the number of players have the same salary
select Psalary , count(*) as no_of_players
from player
GROUP BY psalary;

-- list the oldest club ever established with stadium , president and coach name
select tname as name , tstart_date as founded_date , sname as stadium , mname as president , cname as coach_name
from team join president on mssn = president_mssn
join coach on cssn = coche_Cssn 
join stadium on team_tname = tname
where tstart_date= 
(
select min(tstart_date)
from team) ;

-- list the name of players have same salary
select p1.pname , p1.psalary
from player p1 join player p2
on p1.psalary = p2.psalary and p1.pname <> p2.pname;

-- list the number of matches of players with team name and nationality
select pname as player, tname as team , Pnationalty as nationality , count(*) as no_of_games 
from player join player_has_game on pssn = player_pssn
join game on gno = game_gno
join team on Team_Tname = tname
group by pname;

-- Retrieve each name of player and his red card and yellow card (if exist)
Select pname ,yellow_card,red_card
From player RIGHT OUTER JOIN punish ON pssn =player_pssnb;