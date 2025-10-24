use TRADE_READY
go

select CITY, COUNT(DEPARTMENT_ID) as 'Department Count' from DEPARTMENTS
group by CITY

select * from EMPLOYEES
where DEPARTMENT_ID is null and  EMAIL like 'k%'

select j.JOB_TITLE, COUNT(e.EMPLOYEE_ID) as 'Employee Count' from JOBS as j
join EMPLOYEES as e on e.JOB_ID = j.JOB_ID
group by j.JOB_TITLE
having COUNT(e.EMPLOYEE_ID) between 1 and 5
order by COUNT(e.EMPLOYEE_ID) asc