select last_name,salary,commission_pct,salary+(salary*commission_pct) SALARYTOTAL from employees where job_id = 'SA_MAN';

-- Exercise 3, 1-7

select playerno, name from players where year_of_birth >1960;

select playerno, name, town from players where sex = 'F' and town != 'Stratford';

select count(playerno) JoinedBetween1970And1980 from players where year_joined between 1970 and 1980;

select playerno, name, year_of_birth YearOfBirth from players 
    where 
    (mod(year_of_birth,4) = 0 and mod(year_of_birth,100) != 0)
    or
    (mod(year_of_birth,4) = 0 and mod(year_of_birth,100) = 0 and mod(year_of_birth,400) = 0);
    
select count(amount) AmountOfPenalties from penalties where amount between 50 and 100;

select playerno,name from players 
    where 
    town != 'Stratford' 
    and 
    town != 'Douglas';
    
select playerno, name from players where name like '%is%';

select * from players where leagueno is null;

-- Exercise 3, 9-21

select * from emp where sal < comm;

select * from emp where deptno = 30 and sal >= 1500;

select * from emp where job = 'MANAGER' and deptno != 30;

select * from emp where deptno = 10 and job != 'MANAGER' and job != 'CLERK';

select * from emp where sal between 1200 and 1300;

select * from emp where ename like 'ALL__';

select empno, ename, job, 
    case 
    when comm is null 
    then sal 
    else (sal+comm) 
    end salary
from emp;

select * from emp where comm > (sal/4);

select round(avg(sal)) AverageSalary from emp;
-- rounded agv() for better output

select * from emp where comm is not null and comm != 0;

select count(distinct job) DistinctJobsDept30 from emp where deptno = 30;

select count(ename) NumberOfEmpDept30 from emp where deptno = 30;

select * from emp where hiredate between '04-01-81' and '15-04-81';

-- Exercise 4, 1-6

select teamno from teams where playerno != 27;

select playerno, name, initials from players where players.playerno in (select playerno from matches where won >= 1);
-- outputs playerno, name, and initials from the table players where playerno from players is identical to playerno from matches where won >= 1

select playerno, name from players where players.playerno in (select playerno from penalties where paymentno is not null);
-- outputs payerno and name from players where playerno from players is identical to playerno from penalties where paymentno is not null

select playerno, name from players where players.playerno in (select playerno from penalties where amount > 50);

select playerno, name from players where year_of_birth in (select year_of_birth from players where name = 'Parmenter' and initials = 'R') and (name != 'Parmenter' and initials != 'R');

select playerno, name from players where town = 'Stratford' and year_of_birth in (select min(year_of_birth) from players);
-- outputs playerno and name from players in Stratford and year_of_birth is identical to the minimum of year_of_birth from players, i.e. the oldest player from Stratford

-- Exercise 4, 7-12

select * from dept where dept.deptno not in (select deptno from emp); 

select * from emp where job in (select job from emp where ename = 'JONES');

select * from emp where sal > (select max(sal) from emp where deptno = 30);

select * from emp where deptno = 10 and job not in (select job from emp where deptno = 30);

select empno, ename, job, sal from emp where sal = (select max(sal) from emp);

-- Exercise 5, 1-11

select count(*) NoOfNewPlayers, year_joined from players group by year_joined order by year_joined;
-- number of new players per year

select playerno, count(*) NoOfPenalties, round(avg(amount)) AverageAmount from penalties group by playerno order by playerno;
-- number and average amount of penalties per player

select count(*) NoOfPenaltiesBefore1983 from penalties where pen_date < '1.1.1983';
-- number of penalties for the years before 1983

select town TownWith4ORMorePlayers from players group by town having count(*) >= 4;
-- in which cities live more than 4 players

select playerno from penalties group by playerno having sum(amount) >= 150;
-- PLAYERNO of those players whose penalty total is over 150

select name, initials from players where playerno in (select playerno from penalties group by playerno having count(*) > 1);
-- output NAME and INITIALS of those players who received more than one penalty

select extract(year from pen_date) YearWith2Penalties from penalties group by extract(year from pen_date) having count(*) = 2;
-- in which years there were exactly 2 penalties

select name, initials from players where playerno in (select playerno from penalties where amount > 40 group by playerno having count(*) >= 2);
-- NAME and INITIALS of the players who received 2 or more penalties over $40

select name, initials from players where playerno in (select playerno from penalties where amount in (select max(amount) from penalties));
-- NAME and INITIALS of the player with the highest penalty amount

select extract(year from pen_date) YearWithMostPenalties, count(*) AmountOfPenalties from penalties group by extract(year from pen_date) order by count(*) desc fetch first 1 row only;
-- in which year there were the most penalties and how many were there
-- "order by count(*) desc fetch first 1 row only" is used to order the amount of penalties per year in a descending order and since with this order the first row has the most penalties only the 1st row is selected.

select playerno, teamno, (won - lost) as "Won - Lost" from matches order by (won - lost);
-- PLAYERNO, TEAMNO, WON - LOST sorted by the the last.

-- Exercise 5, 12-19

select * from emp where deptno = 30 order by sal desc;

select * from emp order by job, sal;

select * from emp order by hiredate desc, ename;

select * from emp where job = 'SALESMAN' order by comm/sal desc;

select deptno, round(avg(sal)) from emp group by deptno;

select round(avg(sal)*14) as "Annual average salary", job as "Job with more than 2 personnel" from emp group by job having count(*) > 2;

select deptno from emp where job = 'CLERK' group by deptno having count(*) >= 2;
-- output all department numbers with at least 2 office workers

select round(avg(sal)), avg(comm) from emp where deptno = 30;

-- Exercise 6, 1-5

select players.name, players.initials, matches.won from players, matches where players.playerno = matches.playerno;

select players.name, penalties.pen_date, penalties.amount from players, penalties where players.playerno = penalties.playerno;

select teams.teamno, players.name from teams, players where players.playerno = teams.playerno;

select players.name, matches.won, matches.lost from players, matches where matches.won > matches.lost and players.playerno = matches.playerno;

select p1.name, p1.playerno, amount FROM players p1 LEFT JOIN (SELECT playerno, sum(amount) AS amount FROM penalties group BY playerno) p2 ON p1.playerno = p2.playerno order by amount;

-- Exercise 6, 6-9

select loc from dept where deptno in (select deptno from emp where ename = 'ALLEN');

select * from emp e where e.sal > (select sal from emp where empno = e.mgr);
-- select all from emp defined as e where the salary from table defined as e is higher than sal from emp where empno is the same as mgr from table defined as e

select * from emp where job in (select job from emp where deptno in (select deptno from dept where loc = 'CHICAGO'));

-- Exercise 7, 1-4

select name "Players played in both Team 1 and 2" from players where playerno in (select playerno from matches where teamno = 1) and playerno in (select playerno from matches where teamno = 2);

select name "Players without penalties in 1980", initials from players where playerno not in (select playerno from penalties where extract(year from pen_date) = 1980);

select * from players where playerno in (select playerno from penalties where amount > 80);

select * from players where exists (select * from penalties where players.playerno = penalties.playerno and amount > 80);

-- Exercise 7, 5-8

select * from emp a where sal > (select avg(sal) from emp where a.deptno = deptno) order by deptno;

select deptno "Depatments with at least one employee" from emp d where exists (select * from emp where d.deptno = deptno) group by deptno;

select deptno "Departments with at least one employee earning over 1000" from emp d where exists (select * from emp where d.deptno = deptno and sal > 1000) group by deptno;

select deptno "Departments with each employee earning over 1000" from emp d where exists (select * from emp where d.deptno = deptno) and (select min(sal) from emp where d.deptno = deptno) > 1000 group by deptno;

commit;

-- Exercise 8

select level, lpad(' ',2*level) || sub as part from parts connect by prior sub = super start with sub = 'P3';
select level, lpad(' ',2*level) || sub as part from parts connect by prior sub = super start with sub = 'P9';

select level, lpad(' ', 3*level) || sub as part from parts where sub = 'P12' connect by prior sub = super start with sub = 'P1';
-- at which hierarchy level is P12 used in P1

select level, lpad(' ', 3*level) || ename as "Employee under Jones" from emp where ename != 'JONES' connect by prior empno = mgr start with ename = 'JONES';

select level, lpad(' ', 6*level) || ename as "Superiors of Smith" from emp connect by empno = prior mgr start with ename = 'SMITH' order by level desc;

select level, lpad(' ', 10*level) || round(avg(sal), 2) as "Average salary per hiarchy level" from emp connect by prior empno = mgr start with ename = 'KING' group by level order by level;

commit;

-- Exercise 6, 1-5 with joins

select name, initials, won from players, matches where players.playerno = matches.playerno;

select name, pen_date, amount from players, penalties where players.playerno = penalties.playerno order by amount desc;

select teamno, name as "Captain" from players, teams where players.playerno = teams.playerno;

select name, won, lost from players, matches where players.playerno = matches.playerno and matches.won > matches.lost;

select player.playerno, player.name, amount from players player left join (select playerno, sum(amount) as amount from penalties group by playerno) penalty on player.playerno = penalty.playerno order by amount; 

-- Exercise 6, 6-9 with joins

select loc from dept, emp where dept.deptno = emp.deptno and emp.ename = 'ALLEN';

select e.ename "Employee", e.sal "Employee Salary", m.ename "Supervisor name", m.sal "Supervisor Salary" from emp e, emp m where m.empno = e.mgr and e.sal > m.sal;

select count(extract(year from hiredate)) "Amount of new hirees",extract(year from hiredate) "Year" from emp group by extract(year from hiredate) order by extract(year from hiredate);

select * from emp a where a.job in (select b.job from emp b, dept where b.deptno = dept.deptno and loc = 'CHICAGO');

-- Exercise 7, 1-4 with joins

select name from players, matches a, matches b where players.playerno = a.playerno and players.playerno = b.playerno and a.teamno = 1 and b.teamno = 2;

select name, initials from players inner join penalties using (playerno);

select * from players left join penalties using (playerno) where amount > 80;