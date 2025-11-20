--1
select o.ORDER_ID, 
		(oi.QUANTITY * oi.UNIT_PRICE) as sumValue, 
		ISNULL(SHIP_ADDRESS, 'допълнително запитване'),
		e.FNAME + ' ' + e.LNAME as employeeNames,
		c.FNAME + ' ' + c.LNAME as customerNames
		from orders as o
join ORDER_ITEMS as oi on oi.ORDER_ID = o.ORDER_ID
join EMPLOYEES as e on o.EMPLOYEE_ID = e.EMPLOYEE_ID
join CUSTOMERS as c on o.CUSTOMER_ID = c.CUSTOMER_ID
where (oi.QUANTITY * oi.UNIT_PRICE) > 500000
order by o.ORDER_ID desc

--2
create or alter view EmployeeOrdersCount
as
select e.FNAME, e.LNAME, count(o.ORDER_ID) as ordersCount from EMPLOYEES as e
join ORDERS as o on o.EMPLOYEE_ID = e.EMPLOYEE_ID
group by e.EMPLOYEE_ID, e.FNAME, e.LNAME
having count(o.ORDER_ID) > 5

select * from EmployeeOrdersCount
order by ordersCount desc
