-----------------------------------------------------------------------------------------
------------------------------------ JOIN -----------------------------------------------
--JOIN се използва за извличане на данни от две или повече таблици, като редовете им се
--комбинират чрез логическа връзка между таблиците, която може да бъде във FROM или WHERE.
--Обикновено тази връзка е първичен/външен ключ, но не задължително.

-----------------------------------------------------------------------------------------
-------------------------------------INNER JOIN или просто JOIN--------------------------
-----------------------------------------------------------------------------------------
--Извеждат редовете от две/повече таблици, които имат съвпадащи стойности в колоните,
--посочени в условието за сравнение.

--Пример 4-10. 
--	Да се изведат държавите и регионите, в които се намират.

    select * from countries as c
    join regions as r on r.REGION_ID = c.REGION_ID
	

--Пример 4-11.
--	Изведи имена на клиенти, имена на държавите от които са и имена на регионите на държавите.

    select FNAME, LNAME, ct.NAME as CountryName, r.NAME as RegionName from CUSTOMERS as c
    join COUNTRIES as ct on c.COUNTRY_ID = ct.COUNTRY_ID
    join regions as r on ct.REGION_ID = r.REGION_ID

-----------------------------------------------------------------------------------------
------------------------OUTER JOIN. Видове: LEFT/RIGHT/FULL------------------------------
-----------------------------------------------------------------------------------------
   
    -- Пример 4-12. 
    -- Да се изведат регионите и държавите, които се намират в тях. Резултатният
    -- набор да включва и регионите, в които няма въведени държави.

    select * from REGIONS as r
    left join COUNTRIES as c on r.REGION_ID = c.REGION_ID

    -- Пример 4-13. 
    -- Да се изведат държавите и регионите, в които се намират. 
    -- Резултатният набор да включва държавите, за които няма въведен регион.

    select * from REGIONS as r
    right join COUNTRIES as c on r.REGION_ID = c.REGION_ID

    -- Пример 4-14.
    -- Да се изведат държавите и регионите, в които се намират. 
    -- Резултатният набор да включва държавите, за които няма въведен регион и регионите, 
    -- за които няма въведени държави.

    select * from REGIONS as r
    full join COUNTRIES as c on r.REGION_ID = c.REGION_ID

    -------------------------------------------------------------------------------------

    --#1. 
    --Изведете наименуванията на длъжностите с минимална заплата над 5000. 
    --Сортирайте резултатния набор по мин. заплата низходящо.
	
    select min(salary) MIN_SALARY, JOB_TITLE
    from EMPLOYEES e join JOBS j 
    on j.JOB_ID = e.JOB_ID
    group by JOB_TITLE
    having min(salary) > 5000
    order by min(salary)  desc
 
    --#2. 
    --Изведете имената на служителите, наименованията на длъжностите им, 
    --и имената на отделите, в които работят.

    select FNAME, LNAME, JOB_TITLE, d.NAME from EMPLOYEES as e
    join JOBS as j on e.JOB_ID = j.JOB_ID
    join DEPARTMENTS as d on e.DEPARTMENT_ID = d.DEPARTMENT_ID

    --#3. 
    --Извeдете имената и броя поръчки, които са изпълнили служителите,
    --като резултатният набор да включва всички служители и тези, които все още 
    --не са изпълнявали поръчки. Сортирайте по броя на поръчките във възходящ ред.
	
    select fname, lname, count(order_id)  'броя на поръчките'
    from EMPLOYEES e left join ORDERS o 
    on e.EMPLOYEE_ID=o.EMPLOYEE_ID
    group by fname, lname, e.EMPLOYEE_ID
    order by 'броя на поръчките' asc


    --#4. 
    --Изведете имена, заплата и идентификатор на длъжност на служителите,
    --които работят в отдел 80 и не са обработвали поръчки до момента;

    select FNAME, LNAME, SALARY, JOB_ID from EMPLOYEES as e
    left join ORDERS as o on e.EMPLOYEE_ID = o.EMPLOYEE_ID
    where ORDER_ID is NULL AND DEPARTMENT_ID = 80

    --#5.
    --Изведете имената на отделите и съответния брой служители, които работят в тях.
    --Нека в резултатния набор да участват само отделите, които се намират в държави 
    --с идентификатор 'BG' или 'DE', като в отделите работят не по-малко от 7 служители.
    --Сортирайте резултатния набор по броя на служителите във възходящ ред.

    select d.NAME, COUNT(e.EMPLOYEE_ID) as EmpCount from DEPARTMENTS as d
    join EMPLOYEES as e on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    where d.COUNTRY_ID IN ('BG', 'DE')
    group by d.NAME
    having COUNT(e.EMPLOYEE_ID) >= 7
    order by COUNT(e.EMPLOYEE_ID)

    --#6.
    --Изведете идентификаторите на клиентите и общата стойност на поръчките им.
    --Нека участват само клиенти с обща стойност на поръчките над 900000 и под 1500000.

    select CUSTOMER_ID, sum(unit_price*quantity) as TotalSum
    from ORDERS o join ORDER_ITEMS oi 
    on o.ORDER_ID = oi.ORDER_ID
    group by CUSTOMER_ID
    having sum(unit_price*quantity) between 900000 and 1500000

    -------------------------------------------------------------------------------------
 
    -- Задача 4-8. 
    -- Извлечи идентификатори, дати на поръчките и имена на служители, които са ги обработили.

    select ORDER_ID, ORDER_DATE, e.FNAME, e.LNAME from ORDERS as o
    join EMPLOYEES as e on o.EMPLOYEE_ID = e.EMPLOYEE_ID
    
    -- Задача 4-9. 
    -- Да се изведат имената на всички клиенти и id на поръчките им. 
    -- В резултатния набор да участват и клиентите, които все още не са правили поръчки.
    -- Нека NULL бъде заменена с низа 'none'

    select FNAME, LNAME, ISNULL(CAST(ORDER_ID as varchar), 'none') as Order_Id from CUSTOMERS as c
    left join ORDERS as o on c.CUSTOMER_ID = o.CUSTOMER_ID

    -- Задача 4-11. 
    -- Да се изведат имената на всички клиенти, които са от държави в регион „Западна Европа“

    select FNAME, LNAME from CUSTOMERS as c
    join COUNTRIES as co on c.COUNTRY_ID = co.COUNTRY_ID
    join REGIONS as r on r.REGION_ID = co.REGION_ID
    where r.NAME = 'Западна Европа'

-----------------------------------------------------------------------------------------
------------------------------4.6.6. Други JOIN вариации---------------------------------
-----------------------------------------------------------------------------------------
 
    -- Пример 4-15. 
    -- Да се изведат държавите и регионите, в които се намират.
        --EQUI-JOIN /=/

        --всеки от разгледаните join-ове
 
    -- Пример 4-16.
    -- Да се изведат отделите, в които има назначени служители.
        --SEMI-JOIN /IN/EXISTS/

        
    select NAME from DEPARTMENTS
    where DEPARTMENT_ID IN (select DEPARTMENT_ID from EMPLOYEES)

    -- Пример 4-17.
    -- Да се изведат имената на клиентите, които все още не са правили поръчки.
        --ANTI-JOIN /NOT IN/NOT EXISTS/

    select FNAME, LNAME from CUSTOMERS
    where CUSTOMER_ID NOT IN (select CUSTOMER_ID from ORDERS)

    -- Пример 4-18. 
    -- Да се изведат комбинациите от всички региони и държави, сортирани по име на държава.
        --CROSS (CARTESIAN) JOIN

    select * from REGIONS, COUNTRIES

    select * from REGIONS cross join COUNTRIES
		      order by REGIONS.NAME