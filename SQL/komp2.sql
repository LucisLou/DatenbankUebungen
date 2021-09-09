select employee_id, last_name, job_id, hire_date STARTDATE from employees;

select distinct job_id from employees;

select last_name, salary from employees where salary > 12000;

select last_name, department_id from employees where employee_id = '176';

select last_name, job_id, hire_date from employees order by hire_date;

select last_name, department_id from employees where department_id = 20 order by last_name;

select last_name Employee, salary Salary, commission_pct*100 Commission from employees where commission_pct*100 = 20;

--

select job_id, sum(salary) salaries from employees group by job_id order by salaries desc;

select round(avg(salary), 2) "Average Salary" from EMPLOYEES;

select first_name, last_name, department_name from employees, departments where employees.department_id = departments.department_id;
select first_name, last_name, (select department_name from departments where employees.department_id = departments.department_id) "Department Name" from employees;


select department_name, POSTAL_CODE, CITY, STATE_PROVINCE, STREET_ADDRESS from departments, locations where departments.LOCATION_ID = locations.location_id;

select department_name,
       (select postal_code from locations where departments.location_id = locations.location_id) "Postal Code",
       (select city from locations where departments.location_id = locations.location_id) City,
       (select state_province from locations where departments.location_id = locations.location_id) "State Province",
       (select street_address from locations where departments.location_id = locations.location_id) "Street Address"
from departments;

select (select listagg(department_name, ', ') from departments where locations.location_id = departments.location_id) "Department Name",
       postal_code,
       city,
       state_province,
       street_address
from locations;



select department_name, POSTAL_CODE, CITY, STATE_PROVINCE, STREET_ADDRESS, country_name from departments, locations, countries where departments.LOCATION_ID = locations.location_id and locations.country_id = COUNTRIES.COUNTRY_ID;
select department_name,
       (select country_name from countries where locations.country_id = countries.country_id and locations.location_id in (select location_id from departments where locations.location_id = departments.location_id)) Country,
       (select postal_code from locations where departments.location_id = locations.location_id) "Postal Code",
       (select city from locations where departments.location_id = locations.location_id) City,
       (select state_province from locations where departments.location_id = locations.location_id) "State Province",
       (select street_address from locations where departments.location_id = locations.location_id) "Street Address"
from departments, locations;

select (select listagg(department_name, ', ') from departments where locations.location_id = departments.location_id) as "department name",
       postal_code,
       city,
       state_province,
       street_address,
       (select country_id from countries where locations.country_id = countries.country_id) Country
from locations;

select first_name || ' ' || last_name as Manager, department_name, POSTAL_CODE, CITY, STATE_PROVINCE, STREET_ADDRESS, country_name
from employees, departments, locations, countries
where departments.LOCATION_ID = locations.location_id
and locations.country_id = COUNTRIES.COUNTRY_ID
and employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
and job_id like '%MAN';


select level, first_name || ' ' || last_name as Name, job_title as Job, salary, department_name from employees, departments, jobs
where employees.department_id = departments.department_id
and employees.job_id = jobs.job_id
connect by prior employees.employee_id = employees.manager_id start with employees.MANAGER_ID is null order by level;

