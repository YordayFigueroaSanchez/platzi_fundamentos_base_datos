-- platzi curso mysql
select COUNT(*) from clients c ;
select COUNT(*) from products p ;
select COUNT(*) from bills b ;
select COUNT(*) from bill_products bp ;

-- Buenas prácticas avanzadas en MySQL: optimización y superqueries 
alter table clients add column gender enum('m', 'f', 'ns') default 'ns' not null;
alter table clients add column country varchar(2) default 'mx' not null;
select * from clients c ;

-- asignar el gender f en clients por un rand() < 0.51
update clients c set gender = 'f' where rand() < 0.51;
update clients c set gender = 'm' where gender = 'ns';

-- agrupar por gender y country
select gender, country, count(*) 
from clients c 
group by gender, country;

-- asignar el pais co por un rand() < 0.2
update clients c set country = 'co' where rand() < 0.2;
update clients c set country = 'ar' where rand() < 0.2;
update clients c set country = 'us' where rand() < 0.2;
update clients c set country = 'br' where rand() < 0.2;

-- agrupar usando rand
select gender, country, count(*) 
from clients c 
group by gender, 2
order by rand();

-- contar la cantidad de clientes
select count(*) from clients c;
select sum(1) from clients c;

-- suma la cantidad de mx
select sum(
    if(
        country = 'mx',
        1,
        0
    ) as cantidad
    ) from clients c;

-- matrix de gender por countries
select gender, 
sum(if(country = 'mx',1,0)) as mx,
sum(if(country = 'ar',1,0)) as ar,
sum(if(country = 'us',1,0)) as us,
sum(if(country = 'br',1,0)) as br
from clients c 
group by gender;

-- Columnas Generadas en MySQL: Automatización de Operaciones
CREATE TABLE example (
    example_id integer unsigned primary key auto_increment,
    quantity int not null default 1,
    price float not null,
    total float as (quantity * price)
);

desc example;
-- insertar datos
insert into example (quantity, price) values (1, 10.44),(2, 20.83),(3, 30.55),(4, 40.77),(5, 50.28);
-- select all de exmples
select * from example;
-- agregar columna total_stored
ALTER TABLE example add column total_stored float as (quantity * price) stored;
-- descripcion de la tabla example
desc example;

-- agregar una columna en la tabla products con el nombre description_length que sea el tamaño de la descripcion en modo virtual
ALTER TABLE products add column description_length int as (length(description)) virtual;
-- select all de products
select * from products p;
-- desc products
desc products;


