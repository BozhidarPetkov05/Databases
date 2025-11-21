begin tran
set xact_abort on
	update customers
	set lname = 'Монтгомъри', address = 'гр. Чепеларе, ул. ЗДРАВЕЦ 11'
	where customer_id = 103

	insert into orders
	values(908, GETDATE(), 103, 169, 'гр. Чепеларе, ул. ЗДРАВЕЦ 11')

	update orders
	set employee_id = 169
	where customer_id = 103

	select 103 as cust_id, 169 as emp_id, (select min(order_date) from orders where customer_id = 103) as custFirstOrder, (select min(order_date) from orders where employee_id = 169) as empFirstOrder

	save tran SaveTran

	delete from customers
	where customer_id not in (select customer_id from orders)

	update employees set manager_id = 169
	where employee_id not in (select employee_id from orders)

	rollback transaction SaveTran

	commit tran
	

