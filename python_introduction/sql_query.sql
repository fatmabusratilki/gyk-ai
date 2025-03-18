-- Tüm müşterileri listeleyin.
select * from customers

-- Tüm çalışanların adlarını ve soyadlarını listeleyin.
select first_name, last_name from employees

-- Şehirleri tekrarsız (DISTINCT) olarak getirin.
select distinct city from customers

-- Şirket ismi "Around the Horn" olan müşterinin bilgilerini getirin.
select * from customers where company_name='Around the Horn'

-- 10’dan fazla stoğu olan ürünleri listeleyin.
select * from products where units_in_stock > 10

-- Ürün ismi "Chai" olan ürünün fiyatını bulun.
select unit_price from products where product_name = 'Chai'

-- Çalışanların tam adını (FirstName + LastName) "Full Name" olarak listeleyin.
select concat(first_name, ' ', last_name) as "Full Name" from employees

-- En pahalı ürünü getirin.
select * from products 
order by unit_price desc 
limit 1

-- En pahalı 5 ürünü listeleyin.
select * from products 
order by unit_price desc 
limit 5

-- Çalışanların doğum tarihlerini yıl bazında sıralayın.
SELECT * FROM employees 
ORDER BY birth_date

select * from employees
order by extract (year from birth_date) asc

-- İsmi "Maria" olan çalışanları listeleyin.
select * from employees 
where first_name = 'Maria'

-- Adresinde "Street" geçen müşterileri bulun.
select * from customers
where address like '%Street%'

-- Fiyatı 20 ile 50 arasında olan ürünleri listeleyin.
select * from products
where unit_price between 20 and 50

-- "London" şehrinde bulunan müşterileri bulun.
select * from customers
where city='London'

-- "L" harfiyle başlayan ürünleri listeleyin.
select * from products 
where product_name like 'L%'

-- 1997 yılında işe alınan çalışanları listeleyin.
select * from employees 
where extract(year from hire_date)= '1997'

-- Ürün ismi içinde "cheese" geçenleri bulun.
SELECT * FROM products WHERE product_name LIKE '%cheese%'

-- 1996 yılında sipariş veren müşterileri bulun.
select c.customer_id, o.order_id, o.order_date from customers c
inner join orders o
on c.customer_id = o.customer_id
where extract(year from o.order_date) = '1996' 

-- İsmi "E" harfi ile biten çalışanları listeleyin.
select * from employees
where first_name like '%e'

-- Müşterilerin faks numarası olmayanları listeleyin.
select * from customers
where fax is null

-- Ürünleri fiyatlarına göre artan şekilde sıralayın.
select * from products
order by unit_price asc

-- Çalışanları soyadına göre azalan sıralayın.
select * from employees
order by last_name desc

-- Çalışanları en eski işe alınandan en yeniye sıralayın.
select * from employees
order by hire_date asc

-- Siparişleri sipariş tarihine göre sıralayın.
select * from orders
order by order_date 

-- En fazla sipariş veren müşterileri sıralayın.
SELECT c.*, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC

-- Ürünleri stok miktarına göre sıralayın.
select * from products
order by units_in_stock 

-- En son alınan siparişin detaylarını getirin.
SELECT od.*
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_date = (SELECT MAX(order_date) FROM orders)
LIMIT 1

-- En ucuz 3 ürünü listeleyin.
select * 
from products
order by unit_price 
limit 3

-- Çalışanları yaşlarına göre sıralayın. (Yaşları büyükten küçüğe)
select * 
from employees
order by birth_date

-- Ürünleri kategoriye göre sıralayın.
select p.product_name, c.category_name 
from products p
left join categories c
on p.category_id = c.category_id
order by c.category_name

-- Müşterilerin yaptığı siparişleri listeleyin. 
select o.order_id, c.customer_id, c.contact_name 
from orders o
inner join customers c
on o.customer_id = c.customer_id

-- Çalışanların gerçekleştirdiği siparişleri listeleyin.
select o.*
from orders o
inner join employees e
on o.employee_id = e.employee_id

-- "USA" ülkesindeki müşterilerin siparişlerini getirin.
select o.*
from customers c
right join orders o
on c.customer_id = o.customer_id
where c.country = 'USA'

-- En fazla sipariş veren müşteriyi bulun.
SELECT c.*, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC
limit 1

-- Her siparişin hangi çalışana ait olduğunu getirin.
select o.order_id, e.employee_id, e.first_name, e.last_name
from orders o
inner join employees e
on o.employee_id = e.employee_id

-- Hangi tedarikçinin hangi ürünü sağladığını listeleyin.
select p.product_name, s.company_name
from suppliers s
inner join products p
on s.supplier_id = p.supplier_id

-- Çalışanların bağlı olduğu yöneticileri bulun.

-- Çalışanların yaşını hesaplayın.
SELECT first_name, last_name, birth_date, 
        AGE(birth_date) AS age
FROM employees;

-- Her çalışanın kaç sipariş aldığını listeleyin.
select e.employee_id, e.first_name, e.last_name, count(o.order_id) as total_orders
from employees e
inner join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name

-- Her kategoride kaç ürün bulunduğunu hesaplayın.
select c.category_name,p.category_id, count(p.category_id) as product_count
from products p
inner join categories c
on c.category_id = p.category_id
group by c.category_name, p.category_id

-- Her kategorideki ortalama ürün fiyatlarını listeleyin.
select category_id, avg(unit_price) as avg_price
from products 
group by category_id

-- Çalışanların toplam kaç sipariş işlediğini hesaplayın.
select employee_id, count(*) as order_sum
from orders
group by employee_id

-- En fazla sipariş alan ilk 5 müşteriyi listeleyin.
select customer_id, count(*) as order_sum
from orders
group by customer_id
order by order_sum desc
limit 5

-- Ortalama fiyatı 30’dan fazla olan kategorileri listeleyin.
select category_id, avg(unit_price) as avg_price
from products 
group by category_id
having avg(unit_price) > 30

-- 10’dan fazla sipariş veren müşterileri listeleyin.
select customer_id, count(customer_id) as order_sum
from orders
group by customer_id
having count(customer_id) > 10

-- Ülkeye göre müşteri sayısını listeleyin.
select country, count(customer_id) 
from customers
group by country

-- Ürünleri tedarikçiye göre gruplayın.
select  supplier_id, count(product_id) as product_sum
from products
group by supplier_id

-- 100’den fazla siparişi olan çalışanları listeleyin.
select employee_id, count(*) as order_sum
from orders
group by employee_id
having count(employee_id) > 100

-- Ortalama sipariş miktarı 10’dan fazla olan siparişleri listeleyin. 
SELECT order_id, AVG(quantity) AS avg_order_quantity
FROM order_details
GROUP BY order_id
HAVING AVG(quantity) > 10

-- Çalışan bazında toplam satış miktarlarını hesaplayın.
SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity * od.unit_price) AS total_sales
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC

-- En pahalı ürünün fiyatını döndürün.
select max(unit_price) 
from products

-- En yüksek fiyatlı ürünün bilgilerini getirin.
select * from products 
order by unit_price 
limit 1

-- En az sipariş alan ürünü listeleyin.
SELECT p.product_id, p.product_name, COUNT(od.order_id) AS order_count
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY order_count ASC
LIMIT 1

-- 1997 yılında en fazla sipariş veren müşteriyi getirin.
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 1;

-- En fazla sipariş alan çalışanı bulun.
select employee_id, count(*) as order_sum
from orders
group by employee_id
order by order_sum desc
limit 1

-- En fazla satış yapan çalışanın ismini bulun.
SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity * od.unit_price) AS total_sales
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_sales DESC
limit 1

-- En çok sipariş alan müşteriyi listeleyin.
select customer_id, count(customer_id) as order_sum
from orders
group by customer_id
order by order_sum desc
limit 1

-- Ortalama fiyatın üzerindeki ürünleri bulun.
select * 
from products
where unit_price > (select avg(unit_price) from products)

-- Ortalama sipariş tutarını hesaplayın.
SELECT AVG(unit_price * quantity * (1 - discount)) AS avg_order_amount
FROM order_details;

-- En pahalı ürünün tedarikçisinin bilgilerini getirin.
select s.* 
from suppliers s
right join products p
on p.supplier_id = s.supplier_id
where p.unit_price = (
	select max(unit_price)
	from products
)

-- Yeni bir müşteri ekleyin.
insert into customers values('some customer', 'Some Company')

select * from customers

-- Yeni bir ürün ekleyin.
insert into products(product_id,product_name, discontinued) values (78,'new products', 0)
select * from products

-- "Berlin" şehrinde bulunan müşterilerin şehir adını "New Berlin" olarak güncelleyin.
update customers set city = 'New Berlin' where city='Berlin'

-- "Beverages" kategorisindeki ürünlerin fiyatlarını %10 artırın.
SELECT * FROM products 
WHERE category_id = (SELECT category_id FROM categories WHERE category_name = 'Beverages');

update products 
set unit_price = unit_price + (unit_price * 0.10)
where category_id = (select category_id from categories where category_name = 'Beverages')

-- 50’den az stoğu olan ürünlerin stoğunu 100 olarak güncelleyin.
select * from products 
where units_in_stock < 50

update products 
set units_in_stock = 100
where units_in_stock < 50

-- En pahalı ürünü silin.
Delete from products  
where unit_price = (select max(unit_price) from products) 
 
-- 1996'dan önce işe alınan çalışanları silin.
DELETE FROM employees 
WHERE extract(year from hire_date) < ‘1996’

-- Şirketi olmayan müşterileri silin.
DELETE FROM customers 
WHERE company_name IS NULL 

-- En az sipariş veren müşteriyi silin.
DELETE FROM customers 
WHERE customer_id = ( 
SELECT customer_id 
FROM orders 
GROUP BY customer_id 
ORDER BY COUNT (order_id) ASC 
LIMIT 1 
)

-- En az stoğu olan ürünü silin.
Delete from products 
Where unit_price = (select min(units_in_stock) from products) 


-- Her kategorideki en pahalı ürünü bulun.
SELECT category_id, product_name, unit_price
FROM products p1
WHERE unit_price = (
    SELECT MAX(unit_price)
    FROM products p2
    WHERE p1.category_id = p2.category_id
)

-- En çok sipariş edilen ürünü bulun.
select product_id, sum(quantity) as total_quantity
from order_details
group by product_id
order by total_quantity desc
limit 1

-- Çalışanların sipariş ortalamasını hesaplayın.
SELECT employee_id, AVG(order_count) AS avg_orders
FROM (
    SELECT employee_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY employee_id
) AS order_stats

-- Müşterilerin sipariş miktarlarını yüzde bazında gösterin.
SELECT customer_id, COUNT(order_id) AS total_orders, (COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders)) AS percentage
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC

-- Müşterilerin sipariş miktarlarını yüzde bazında gösterin.
SELECT customer_id, COUNT(order_id) AS total_orders, (COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders)) AS percentage
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC

-- Ürünlerin fiyatlarını ortalama fiyatla karşılaştırarak yüzdelik farkını bulun.
SELECT product_name, unit_price, (unit_price - (SELECT AVG(unit_price) FROM products)) / (SELECT AVG(unit_price) FROM products) * 100 AS percentage_difference
FROM products

-- Çalışanların her yıl kaç sipariş aldığını hesaplayın.
SELECT employee_id, EXTRACT(YEAR FROM order_date) AS order_year, COUNT(*) AS total_orders
FROM orders
GROUP BY employee_id, order_year
ORDER BY employee_id, order_year

-- Müşterileri sipariş sayısına göre 'Düşük', 'Orta', 'Yüksek' olarak etiketleyin.
SELECT customer_id, COUNT(order_id) AS total_orders,
       CASE
           WHEN COUNT(order_id) < 10 THEN 'Düşük'
           WHEN COUNT(order_id) BETWEEN 10 AND 20 THEN 'Orta'
           ELSE 'Yüksek'
       END AS order_category
FROM orders
GROUP BY customer_id

-- En yüksek ciro yapan ilk 3 tedarikçiyi bulun.
SELECT s.supplier_id, s.company_name, SUM(od.unit_price * od.quantity) AS total_revenue
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
JOIN order_details od ON p.product_id = od.product_id
GROUP BY s.supplier_id, s.company_name
ORDER BY total_revenue DESC
LIMIT 3

-- En az 3 sipariş veren müşterileri listeleyin.
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 3

----Sipariş veren müşterileri ve sipariş sayılarını gösterin.
select customer_id, count(order_id) as total_orders
from orders
group by customer_id

--En çok sipariş verilen ürünleri ve sipariş sayılarını listeleyin.
select product_id, count(order_id) as total_orders
from order_details
group by product_id
order by total_orders desc

--En yüksek toplam satış yapan çalışanları gösterin.
select o.employee_id, sum(od.quantity * od.unit_price) as total_sales
from orders o
inner join order_details od on o.order_id = od.order_id
group by o.employee_id
order by total_sales desc


--En fazla sipariş veren müşterinin bilgilerini getirin.
select c.*
from customers c
inner join (
    select customer_id
    from orders
    group by customer_id
    order by count(order_id) desc
    limit 1
) as top_customer 
on c.customer_id = top_customer.customer_id



--Her siparişte sipariş verilen ürünleri listeleyin.
select o.order_id, p.product_name, od.quantity
from order_details od
inner join orders o on od.order_id = o.order_id
inner join products p on od.product_id = p.product_id
order by o.order_id

--Müşterinin yaptığı siparişlerde hangi çalışanın ilgilendiğini gösterin.
select o.order_id, c.contact_name, e.first_name
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join employees e on o.employee_id = e.employee_id
order by c.contact_name, o.order_id

--Çalışanların sattığı toplam ürün miktarını getirin.
select e.employee_id, e.first_name, sum(od.quantity) as total_sold_quantity
from orders o
inner join employees e on o.employee_id = e.employee_id
inner join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name
order by total_sold_quantity desc

--Siparişlerde en çok kullanılan nakliye şirketlerini listeleyin.
select s.company_name as shipper_name, count(o.order_id) as total_shipments
from orders o
inner join shippers s on o.ship_via = s.shipper_id
group by s.company_name
order by total_shipments desc


--Çalışanların kaç farklı müşteriyle çalıştığını listeleyin.
select e.employee_id, e.first_name, count(distinct o.customer_id) as unique_customers
from orders o
inner join employees e on o.employee_id = e.employee_id
group by e.employee_id, e.first_name
order by unique_customers desc

--En çok sipariş verilen kategorileri listeleyin.
select c.category_name, count(od.order_id) as total_orders
from order_details od
inner join products p on od.product_id = p.product_id
inner join categories c on p.category_id = c.category_id
group by c.category_name
order by total_orders desc

-- Müşterilerden en çok sipariş alan tedarikçileri bulun. 
SELECT s.supplier_id, s.company_name AS supplier_name,  
COUNT(od.order_id) AS total_orders FROM suppliers s  
JOIN products p ON s.supplier_id = p.supplier_id  
JOIN order_details od ON p.product_id = od.product_id  
GROUP BY s.supplier_id, s.company_name ORDER BY total_orders DESC

-- Müşteri bazında toplam sipariş tutarlarını listeleyin. 
SELECT c.customer_id, c.contact_name, c.company_name,  
SUM(od.unit_price * od.quantity) AS total_order_value FROM customers c  
JOIN orders o ON c.customer_id = o.customer_id  
JOIN order_details od ON o.order_id = od.order_id  
GROUP BY c.customer_id, c.contact_name, c.company_name  
ORDER BY total_order_value DESC

-- Çalışan bazında ortalama sipariş tutarlarını listeleyin. 
SELECT  o.employee_id, e.last_name || ', ' || e.first_name AS employee_name, AVG(od.unit_price * od.quantity) AS avg_order_value 
FROM orders o 
JOIN employees e ON o.employee_id = e.employee_id 
JOIN order_details od ON o.order_id = od.order_id 
GROUP BY o.employee_id, employee_name 
ORDER BY avg_order_value DESC

-- En uzun sürede teslim edilen siparişi getirin. 
SELECT  o.order_id, o.customer_id, c.contact_name, o.order_date, o.shipped_date, (o.shipped_date - o.order_date) AS delivery_time 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
WHERE o.shipped_date IS NOT NULL 
ORDER BY delivery_time DESC 
LIMIT 1

-- En hızlı teslim edilen siparişi getirin. 
SELECT  o.order_id, o.customer_id, c.contact_name, o.order_date, o.shipped_date, (o.shipped_date - o.order_date) AS delivery_time 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
WHERE o.shipped_date IS NOT NULL 
ORDER BY delivery_time ASC 
LIMIT 1

-- 1000 dolardan fazla sipariş veren müşterileri bulun. 
SELECT c.customer_id, c.contact_name, c.country,  
SUM(od.unit_price * od.quantity) AS total_spent FROM customers c  
JOIN orders o ON c.customer_id = o.customer_id  
JOIN order_details od ON o.order_id = od.order_id  
GROUP BY c.customer_id, c.contact_name, c.country  
HAVING SUM(od.unit_price * od.quantity) > 1000  
ORDER BY total_spent DESC

-- Ortalama sipariş değerini geçen siparişleri listeleyin. 
SELECT  o.order_id, o.customer_id, c.contact_name, SUM(od.unit_price * od.quantity) AS order_total 
FROM orders o 
JOIN order_details od ON o.order_id = od.order_id 
JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY o.order_id, o.customer_id, c.contact_name 
HAVING SUM(od.unit_price * od.quantity) > ( 
    SELECT AVG(order_total) 
    FROM ( 
        SELECT  o2.order_id, SUM(od2.unit_price * od2.quantity) AS order_total 
        FROM orders o2 
        JOIN order_details od2 ON o2.order_id = od2.order_id 
        GROUP BY o2.order_id 
    ) AS order_totals 
) 
ORDER BY order_total DESC

-- Ülkeye göre en çok sipariş veren müşterileri bulun. 
 
WITH customer_orders AS ( 
    SELECT c.country, c.customer_id, c.contact_name, COUNT(o.order_id) AS total_orders 
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.country, c.customer_id, c.contact_name 
), 
max_orders AS ( 
SELECT country, MAX(total_orders) AS max_total_orders 
FROM customer_orders 
GROUP BY country 
) 
SELECT co.country, co.customer_id, co.contact_name, co.total_orders 
FROM customer_orders co 
JOIN max_orders mo ON co.country = mo.country  
AND co.total_orders = mo.max_total_orders 
ORDER BY co.country, co.total_orders DESC

-- En çok satış yapılan ayları bulun. 
SELECT EXTRACT(MONTH FROM o.order_date) AS sale_month,  
SUM(od.unit_price * od.quantity) AS total_sales  
FROM orders o JOIN order_details od ON o.order_id = od.order_id  
GROUP BY sale_month HAVING SUM(od.unit_price * od.quantity) = ( SELECT MAX(monthly_total) 
FROM ( SELECT SUM(od.unit_price * od.quantity) AS monthly_total  
FROM orders o JOIN order_details od ON o.order_id = od.order_id  
GROUP BY EXTRACT(MONTH FROM o.order_date) ) AS monthly_sales )

-- Çalışanların toplam sattığı ürün miktarını listeleyin. 
SELECT o.employee_id, SUM(od.quantity) AS total_products_sold FROM orders o JOIN 
order_details od ON o.order_id = od.order_id GROUP BY o.employee_id




