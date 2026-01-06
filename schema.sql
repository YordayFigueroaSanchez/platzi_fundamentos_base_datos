CREATE TABLE IF NOT EXISTS clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    total FLOAT,
    status enum('open', 'paid', 'lost') NOT NULL DEFAULT 'open',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
        on delete cascade
        on update cascade
);

show tables;

CREATE TABLE IF NOT EXISTS bill_products (
    bill_product_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
        on delete cascade
        on update cascade,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
        on delete cascade
        on update cascade
);

insert into clients (name, email, phone_number) values ('John Doe', 'john.doe@example.com', '123456789');
insert into products (name, slug, description) values ('Product 1', 'product-1', 'Description 1');
insert into bills (client_id, total, status) values (1, 100, 'open');
insert into bill_products (bill_id, product_id, quantity) values (1, 1, 1);

select * from clients;
select * from products;
select * from bills;
select * from bill_products;

drop table bill_products;
drop table bills;

CREATE TABLE IF NOT EXISTS bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    total FLOAT,
    status enum('open', 'paid', 'lost') NOT NULL DEFAULT 'open',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS bill_products (
    bill_product_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

show tables;

insert into clients (name, email, phone_number) values ('John Doe', 'john.doe@example.com', '123456789');
insert into products (name, slug, description) values ('Product 1', 'product-1', 'Description 1');
insert into bills (client_id, total, status) values (1, 100, 'open');
insert into bill_products (bill_id, product_id, quantity) values (1, 1, 1);

select * from clients;
select * from products;
select * from bills;
select * from bill_products;

-- Modificación de tablas MySQL con ALTER TABLE
Create table tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    qty INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

show tables;

describe tests;

alter table tests add column price float;
describe tests;
alter table tests drop column price;
describe tests;
alter table tests add column price float;
describe tests;
alter table tests modify column price decimal(10,3) not null;
describe tests;

alter table tests rename column price to prices;
describe tests;

alter table tests rename to testss;
describe testss;

insert into products (name, slug) values ('botella 100', 'botella-100');
select * from products p ;

insert into products (name, slug) values 
('pluma azul', 'pluma-azul'),
('pluma roja', 'pluma-roja');
select * from products p ;

-- error por duplicado
insert ignore into products (name, slug) values ('pluma azul', 'pluma-azul');

show warnings;

insert ignore into products (name, slug) values ('pluma azul', 'pluma-azul')
on duplicate key update description = 'por duplicado...';

-- agregar la columna price del tipo float a la tabla products
alter table products add column price float;

-- actualizar la columna price usando un update por medio de rand()*10
update products set price = rand()*10;

-- borrar tabla products
DROP TABLE products;

-- crear la tabla products
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10,2),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

select * from products p ;

-- borrar las tablas
DROP TABLE products;
DROP TABLE bills;
DROP TABLE bill_products;
DROP TABLE clients;

-- crear la tabla clients
create table if not exists clients (
  client_id integer primary key auto_increment,
  name varchar(100) not null,
  email varchar(100) not null unique,
  phone_number varchar(15),
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

-- crear la tabla products
create table if not exists products (
  `product_id` integer unsigned primary key auto_increment,
  name varchar(100) not null,
  sku varchar(20) not null,
  slug varchar(200) not null unique,
  description text,
  price float not null default 0,
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

-- crear la tabla bills
create table if not exists bills (
  bill_id integer unsigned primary key auto_increment,
  client_id integer not null,
  total float,
  status enum('open', 'paid', 'lost') not null default 'open',
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

-- crear la tabla bill_products
create table if not exists bill_products (
  bill_product_id integer unsigned primary key auto_increment,
  bill_id integer unsigned not null,
  product_id integer unsigned not null,
  quantity integer not null default 1,
  price float not null,
  discount integer not null default 0,
  date_added datetime,
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

-- select
select name from clients c where c.name like '%Gibson%';

select name, price from products p where p.price between 500 and 700;

select * from bill_products bp where bp.discount > 0;

select * from bill_products bp where bp.date_added < '2024-06-06';

select * from bill_products bp where bp.date_added between '2024-01-06' and '2024-04-06 12:00:00';

-- update
select * from clients c limit 10;

update clients 
set phone_number = '+529999' 
where client_id = 4
;

update clients 
set phone_number = null 
where client_id = 4
;

select * from products p ;

-- agregar una columna stock de tipo int con valor 0 por default
alter table products add column stock int default 0;

-- agregar valores a la columna stock
update products p set stock = ROUND(100 * RAND());

-- descontar el stock de un producto desde sql
update products p set stock = stock - 3 where p.product_id = 1;

-- delete
alter table clients add column active tinyint not null default 1 after phone_number;
desc clients;

-- borrado suave
select * from clients c limit 10;

update clients c set active = 0 where c.client_id = 3;

-- borrado fuerte
delete FROM clients 
where false;

delete from clients where client_id = 2;

-- select
select now();
select database();
desc products;
select p.product_id ,p.name ,p.sku,p.stock from products p where p.price < 100;
select p.product_id ,p.name ,p.sku,p.stock from products p where p.price between 50 and 70;
select p.product_id ,p.name ,p.sku,p.stock, p.stock*p.price as total 
from products p where p.price between 50 and 70;
select p.product_id ,p.name ,p.sku,p.stock, p.stock*p.price as total 
from products p where p.price between 50 and 70
order by total desc;

-- Funciones agregadoras y agrupación de datos con MySQL
select COUNT(*) from products p where p.price < 100;
select SUM(stock) from products;
select avg(price) from products;
select sum(price*stock) from products;
desc clients;
select email from clients c ;
-- if en el select
select email, if(email like '%@gmail.com',1,0)  from clients c ;
select 
	email, 
	if(email like '%@gmail.com',1,0) as gmail,
	if(email like '%@hotmail.com',1,0) as hotmail
from clients c ;
-- uso de case
select 
	email, 
	case
		when email like '%@gmail.com' then 'gmail'
		when email like '%@hotmail.com' then 'hotmail'
		else 'otro'
	end as proveedor
from clients c ;
-- agrupar
select 
	case
		when email like '%@gmail.com' then 'gmail'
		when email like '%@hotmail.com' then 'hotmail'
		else 'otro'
	end as proveedor,
	COUNT(*) as total
from clients c 
group by proveedor;
-- agrupar y ordenar
select 
	case
		when email like '%@gmail.com' then 'gmail'
		when email like '%@hotmail.com' then 'hotmail'
		else 'otro'
	end as proveedor,
	COUNT(*) as total
from clients c 
group by proveedor
order by total desc;
-- agrupar y ordenar
select 
	case
		when email like '%@gmail.com' then 'gmail'
		when email like '%@hotmail.com' then 'hotmail'
		when email like '%@kuhic.net' then 'kuhic'
		when email like '%@mann.com' then 'mann'
		when email like '%@olson.org' then 'olson'
		when email like '%@yahoo.com' then 'yahoo'
		else 'otro'
	end as proveedor,
	COUNT(*) as total
from clients c 
where c.name like 'a%'
group by proveedor
order by total desc;

-- Como llenar tablas usando INSERT INTO SELECT en MySQL
desc products;
CREATE TABLE investment (
    investment_id int unsigned primary key auto_increment,
    product_id int unsigned not null,
    investment int unsigned not null
);
DROP TABLE investment;
CREATE TABLE investments (
    investment_id integer unsigned primary key auto_increment,
    product_id integer unsigned not null,
    investment integer not null default 0
);

-- llenar la tbala con info de otra tabla
select p.product_id , p.price * p.stock 
from products p 
;
insert into investments(product_id, investment)  
select p.product_id , p.price * p.stock 
from products p 
;
select * from investments i 
;

-- Cómo usar Left Join para conectar tablas relacionales
select * from investments i 
left join products p on i.product_id = p.product_id 
limit 1 
;
select * from investments i 
left join products p on i.product_id = p.product_id 
limit 1 
;
select p.product_id as pid, p.name ,i.investment 
from investments i 
left join products p on i.product_id = p.product_id 
order by i.investment desc
limit 1 
;