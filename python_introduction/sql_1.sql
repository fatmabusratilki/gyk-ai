-- SQL => Structer Query Language

-- DDL - DML
-- Data Definition Language
-- Data Manipulation Language

-- Ekleme
INSERT INTO categories VALUES(100,'Deneme','Açıklama') 

INSERT INTO categories(category_name, category_id) VALUES ('Deneme 2', 101)
--
-- Silme
Delete from categories where category_id=101
--
-- Güncelleme
update categories set category_name = 'Güncellendi' where category_id = 100
--
-- Sorgulama 
-- select [alanlar] from [tablo]
-- * => ALL
select category_name, category_id from categories
select * from categories

select * from categories where category_id=5
select * from categories where category_id=5 or category_id=4
select * from categories where category_id=5 and category_id=4

select * from categories where description='Soft drinks, coffees, teas, beers, and ales'

-- LIKE [KALIP] - %
select * from categories where description like '%a%' -- içinde a geçen

select * from categories where description like 'S%' -- S ile başlayan

select * from categories where description not like 'S%' -- S ile başlamayan

-- _ => 1 adet ne olduğu önemsiz karakteri temsil eder
select * from categories where description like '____s%' -- 5. harfi s olan


select * from orders where freight > 30

-- Aggregate Functions
select * from order_details

select sum(quantity) from order_details

select sum((unit_price*quantity)-discount) from order_details

select count(*) from orders 

select * from products 

select max(unit_price) from products
select min(unit_price) from products

-- Gelen veri setini limitlemek
-- Postgresql (limit, offset, fetch next) 
select * from products
limit 10 

-- offset x (x kadar veriyi atla)
-- Sayfalama mantığında çokca kullanılır.
-- En iyi 5 çalışanımı bul
select * from products
limit 10 offset 20 -- verileri 20.den başlat 20.den itibaren 10 adet al


-- En pahalı ilk 5 ürün
-- order by küçükten büyüğe sıralama yapar. Tam tersi için sonuna  -DESC keyword ü eklenir.
-- ASC => küçükten büyüğe a-z (Default)
select * from products
order by unit_price DESC
limit 5

select order_id, (unit_price * quantity) from order_details
order by (unit_price * quantity) desc

-- Alias = Takma Ad
-- Bir sütuna (as)
select sum(unit_price * quantity) as "Toplam Cüro" from order_details
-- Bir tabloya verilebilir. (Direkt yanına yazabiliyoruz)
select order_details.unit_price from order_details
select od.unit_price from order_details od

-- Group By, having, joins

-- Group BY
select supplier_id count(*), sum(unit_price) from products
group by supplier_id

select supplier_id
from products
group by supplier_id

select customer_id, count(*) from orders
group by customer_id

select customer_id, employee_id, count(*) from orders
group by customer_id, employee_id

select * from orders where customer_id='BONAP' and employee_id=8

select * from orders where customer_id='QUICK' and employee_id=2

-- Kaç Farklı ülkeden kaç çalışanım var?
select city, count(*) from employees
group by city


select country, count(*) from employees
group by country

select * from employees where country='USA'


-- Group By - Where ?
-- Group by kullanılan yerde where değil "HAVING" kullanılmalı
-- 100'den fazla satış yapmış elemanların satış sayısı fazladan aza sıralanmıştır.
select employee_id, count(*) from orders
group by employee_id
having count(*)>100
order by count(*) desc


-- JOİNLER
-- İlişkili olduğum tablo ile veri setini o tablodaki denk gelen veriyle doldurmak.

select o.order_id, e.last_name, e.first_name from orders o 
inner join employees e
on o.employee_id = e.employee_id

select * from customers c
left join orders o
on c.customer_id = o.customer_id

select * from employees e
left join orders o 
on e.employee_id = o.employee_id
where order_id< 10300


select * from employees e
full outer join orders o 
on e.employee_id = o.employee_id

select * from orders o
inner join employees e
on o.employee_id = e.employee_id
inner join employee_territories et
on e. employee_id = et.employee_id
inner join territories t
on et.territory_id = t.territory_id
join customers c
on c.customer_id = o.customer_id


-- En çok sipariş veren kullanıcıyı bulunuz
-- Paylaşılacal dosyadaki soruları sql ile cevaplayınız.
-- İç içe sorgular ve DISTINCT yapısını araştıralım.

Select min(unit_price) from products -- sql ile bir hesaplama sonucu elde edilebilir.

-- Sıralama yöntemiyle 
select *from products 
order by unit_price
limit 1

-- iç içe sorgu
select * from products
where unit_price = (
	select min(unit_price) from products
)


-- Hız ve maliyet açısından bakıldığında sıralama yöntemi daha hızlı çalışabilir. Veriye göre maliyet oranları değişebilir.
-- Burada önemli nokta, aynı fiyatta 5 farklı ürün olabilir. min fonksiyonu en düşük olanların hepsini getirir. Ancak limit 1 de yalnızca bir tanesi gelir.
-- Limit aynı fiyata sahip ürünlerden getirdiği ürünü sql in kullandığı sıralama yöntemine göre seçiyor. 


-- her çalışanın kaç sipariş aldığını listeleyin 
select e.employee_id, e.first_name, e.last_name, count(*) from employees e
left join orders o 
on e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by Count(*) DESC
-- group by fonk eklediğim değerler gruplama işlemini bozmamalı.

-- Her kategoride kaç ürün bulunduğunu hesaplayın
select c.category_id, c.category_name, count(*) from categories c
left join products p on c.category_id = p.category_id
group by c.category_id, c.category_name


-- 97- Ortalama sipariş değerini geçen siparişleri listeleyin
select o.order_id, sum(od.quantity * od.unit_price) from orders o
inner join order_details od
on o.order_id = od.order_id
group by o.order_id
having sum(od.quantity * od.unit_price) > (
	select avg(TotalOrder) from (
	select sum(od.unit_price * od.quantity) as TotalOrder 
	from order_details od
	group by od.order_id
	)
)

select avg(unit_price * quantity) from order_details -- Her bir ürün kalemin ortalaması 

-- Siparişin ortalaması
select avg(TotalOrder) from (
	select sum(od.unit_price * od.quantity) as TotalOrder 
	from order_details od
	group by od.order_id
)

-- 99- En çok satış yapılan ayları bulunuz. 
select extract(month from order_date) as OrderMonth, 
extract(year from order_date) as OrderYear,
count(*) from orders
group by OrderMonth, OrderYear
order by count(*) DESC

--  76 ürünlerin fiyatlarını ortalama fiyatla karşılaştırarak yüzdelik farkını bulun 
select product_id, product_name, unit_price, ROUND((((unit_price - avg_price) / avg_price) * 100):: NUMERIC, 2) as percantage
from
(
select p.product_id, p.product_name, p.unit_price, (select avg(unit_price) from products) as avg_price
from products p
)
order by percantage

-- Silmek istediğimiz bir veri diğer tablolarda da pk-fk şeklinde ilişkiliyse silme işlemini nasıl yapmamız gerekiyor?
-- on delete behavior: İlişkisel olan tablolarda silme işleminde nasıl davranılacak? 
-- On Delete Behavior => Araştır
-- Sorularda Cascade kullanılabilir


-- DISTINCT
select distinct(city) from customers

-- 2 ways to use
select distinct(title) from employees
select distinct title from employees
























