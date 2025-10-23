---------------------------------------------------------------
-----------------------TRADECOMPANY ---------------------------
---------------------------------------------------------------

--Демо: Въведи по един запис във всяка от таблиците.

--Демо: Промяна на заплатата на служител с даден идентификатор.

--Демо: Поръчката е анулирана -  изтрий реда и от таб. ORDERS.

/*Задача 3-1. 
    Да се изтрият всички редове от всички таблици в базата от
     данни, след което да се въведат данните чрез командите 
	 от inserts_mssql.sql файла. */

/*Задача 3-2. 
    Да се увеличи количеството с 2 броя 
	и да се намали единичната цена с 5% 
	на продукт с идентификатор 2254
	в поръчка с идентификатор 2354. */

	select * from ORDER_ITEMS
	where PRODUCT_ID = 2254 AND ORDER_ID = 2354

	update ORDER_ITEMS
	set QUANTITY = QUANTITY + 2
	where PRODUCT_ID = 2254 AND ORDER_ID = 2354
	
	update ORDER_ITEMS
	set UNIT_PRICE = UNIT_PRICE - UNIT_PRICE * 0.05
	where PRODUCT_ID = 2254 AND ORDER_ID = 2354

 
/*Задача 3-3.
    Да се изтрие служител с идентификатор 183.*/
	
	delete from EMPLOYEES
	where EMPLOYEE_ID = 183


/* Пример 4-1. 
    Да се изведат имената, датите на назначаване и заплатите 
	на всички служители. */

	select FNAME, LNAME, HIRE_DATE, SALARY from EMPLOYEES

 
/*Пример 4-2. 
    Да се изведат всички данни за продуктите, 
	с цена по-голяма от 2000. 
	Резултатът нека бъде подреден по цена на 
	продукт възходящо.	*/

	select * from PRODUCTS
	where PRICE > 2000
	order by PRICE asc
 
/*Пример 4-3.
    Да се изведе броя на всички служители.*/

	select COUNT(EMPLOYEE_ID) as Emp_Count from EMPLOYEES

/*Пример 4-4.  
    Да се изведе броя служители, групирани по отдела, 
	в който работят.*/

	select DEPARTMENT_ID, COUNT(EMPLOYEE_ID) as Emp_Count from EMPLOYEES
	group by DEPARTMENT_ID

---------------------------------------------------------------
/*Задача. Да се изведат общата сума на заплатите и 
	броя служители в отдел 60.*/

	select SUM(SALARY) as Total_Salary, COUNT(EMPLOYEE_ID) as Employee_Count from EMPLOYEES
	where DEPARTMENT_ID = 60
 
/*Задача.
    За всички поръчки да се изведат идентификатор на 
	поръчка и обща стойност на
    поръчката. Резултатът да е подреден по стойност на 
	поръчката в низходящ ред.*/

	select ORDER_ID, (UNIT_PRICE * QUANTITY) as Total from ORDER_ITEMS
	order by Total desc
 
---------------------------------------------------------------
----АГРЕГАТНИ ФУНКЦИИ; КЛАУЗИ: GROUP BY, HAVING, ORDER BY------
---------------------------------------------------------------

--#1 
--Изведете общото количество, в което продуктите 
--са били поръчани. Сортирай резултатния набор 
--спрямо общо количество във възходящ ред.

	select ORDER_ID, COUNT(PRODUCT_ID) as Products_Count from ORDER_ITEMS
	group by ORDER_ID
	order by Products_Count asc

--#2 
--Изведете от кои идентификатори на държави колко 
--на брой клиенти на фирмата има. Сортирайте спрямо броя 
--на клиентите в низходящ ред.

	select COUNTRY_ID, COUNT(CUSTOMER_ID) as Customer_Count from CUSTOMERS
	group by COUNTRY_ID
	order by Customer_Count desc

--#3 
--Изведете броя поръчки, които е изпълнил всеки служител.
--В резултата да участват само служители, изпълнили 
--повече от 5 поръчки. 

	select EMPLOYEE_ID ,COUNT(ORDER_ID) as Order_Count from ORDERS
	group by EMPLOYEE_ID
	having COUNT(ORDER_ID) > 5

--#4 
--Изведете длъжностите със средна работна заплата над 10000.
--Сортирайте по средната работна заплата в низходящ ред.

	select CAST(AVG(Salary) as Numeric(8,2)) as Avg_Salary, JOB_ID from EMPLOYEES
	group by JOB_ID
	order by Avg_Salary desc


--#5 
--Изведете колко служители са назначени на определен 
--идентификатор на длъжност. Но в резултат да излязат тези 
--длъжности, на които са назначени повече от 5 служителя.
--Сортирайте по броя работещи на съответната длъжност 
--възходящо.

	select JOB_ID, COUNT(EMPLOYEE_ID) as Employee_Count from EMPLOYEES
	group by JOB_ID
	having COUNT(EMPLOYEE_ID) > 5
	order by Employee_Count asc

