create table Products_Hist
(
	product_id int,
	old_price numeric(8,2),
	new_price numeric(8,2),
	changed_time datetime
)

create or alter trigger ProductsPriceTRG on Products
for update
as
begin
	insert into Products_Hist
	select d.product_id, d.price, i.price, getdate()
	from deleted as d join inserted as i on i.product_id = d.product_id
	where d.price != i.price
end

update products
set price += 1400
where product_id = 3350

select * from Products_Hist