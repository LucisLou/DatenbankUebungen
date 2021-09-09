insert into players (PLAYERNO, NAME, INITIALS, YEAR_OF_BIRTH, SEX, YEAR_JOINED, STREET, HOUSENO, POSTCODE, TOWN, PHONENO, LEAGUENO) VALUES (3, 'Lindwurm', 'L', 1993, 'F', 2011, 'Vixen Road', 3, '6392LK', 'Plymouth', '010-548769', null);
commit;

update players set sex = 'W' where sex = 'F';

update penalties set amount =  amount * 1.2 where amount > (select avg(amount) from penalties);

update players set street = (select street from players where playerno = 6),
                   houseno = (select houseno from players where playerno = 6),
                   postcode = (select postcode from players where playerno = 6),
                   town = (select town from players where playerno = 6)
where playerno = 95;

delete from penalties where playerno = 44 and extract(year from pen_date) = 1980;

delete from penalties where playerno in (select playerno from matches where teamno = 2);

--

-- select sal from emp e, (select deptno,avg(sal) avg_sal from emp group by
--deptno) e1
--where e.deptno=e1.deptno and e.sal < (e1.avg_sal/100*80);

select empno,deptno, sal from emp a where sal < (select avg(sal)*0.8 from emp where a.deptno = deptno);

--select deptno, round(avg(sal)*0.8, 2) from emp group by deptno;

savepoint beforeupdate;

rollback to savepoint beforeupdate;

update emp
set sal = (select avg(sal)*0.8 from emp a where a.deptno = emp.deptno)
where sal < (select avg(sal)*0.8 from emp b where b.deptno = emp.deptno);

delete from emp where extract(year from current_date) - extract(year from hiredate) > 35;

savepoint sequenceTable;

rollback to savepoint sequenceTable;

create sequence goby10
start with 50
increment by 10
minvalue 50
maxvalue 100
nocycle;

insert into dept values(goby10.nextval, 'HTL', 'LEONDING');

commit;







