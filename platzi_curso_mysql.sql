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

-- Generación de Slugs SEO-Friendly en MySQL
select name, slug from products p;

-- Contruir el slug
select name,lower(replace(name, ' ', '-')) as slug_generated, slug from products p;

-- usando expresiones regulares
select name,
    lower(regexp_replace(
        regexp_replace(
	        name, 
	        '[[^a-z]|[:space:]]', 
	        '-'
    	), 
        '[:space:]', 
        '-'
    )) as slug_generated,
    slug
from products p;

-- agregar columna en la tabla products con el nombre slug_generated que sea el slug generado en modo stored
ALTER TABLE products add column slug_generated varchar(200) as (
    lower(regexp_replace(
        regexp_replace(
	        name, 
	        '[[^a-z]|[:space:]]', 
	        '-'
    	), 
        '[:space:]', 
        '-'
    ))
) stored;
-- select all de products
select * from products p;
-- desc products
desc products;

-- select all de products
select * from products p where product_id = 1;

-- actualizar el nombre de un producto
update products p set name = 'New Pro;duct' where product_id = 1;

-- Creación y Uso de Vistas en Bases de Datos MySQL
-- seleccionar el price y el discount de un bill_product
select price, discount from bill_products bp;

-- crea una nueva columna total en la tabla bill_products del tipo virtual 
ALTER TABLE bill_products add column total float as (price * quantity * (1 - discount/100)) virtual;
-- desc bill_products
desc bill_products;
-- select all de bill_products
select bp.bill_id, bp.total from bill_products bp;

-- vista
select 
    date(bp.date_added) as date,
    count(bp.bill_id),
    sum(bp.quantity),
    avg(bp.discount),
    max(bp.discount),
    max(bp.total),
    ROUND(sum(bp.total)) as total
from bill_products bp
group by 1
order by 1;

-- crear una vista
create view ventas_diarias_view as (
    select 
        date(bp.date_added) as fecha,
        count(bp.bill_id) cantidad,
        sum(bp.quantity) cantidad_total,
        avg(bp.discount) descuento_promedio,
        max(bp.discount) descuento_maximo,
        max(bp.total) total_maximo,
        ROUND(sum(bp.total)) as total
    from bill_products bp
    group by 1
    order by 1
)
;

SELECT * from ventas_diarias_view;

SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1;

CREATE TABLE ventas_diarias_m (
    fecha date not null unique,
    cantidad integer,
    total integer
);

INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1;

select * from ventas_diarias_m;

-- las entradas en bill_products que son de un `ar`
select * 
from bill_products bp 
where bp.bill_id in (
    select bill_id 
    from bills b 
    where b.client_id in (
        select client_id 
        from clients c 
        where c.country = 'ar'
    )
);

-- variante usando left join
select * 
from bill_products bp 
left join bills b on bp.bill_id = b.bill_id 
left join clients c on b.client_id = c.client_id 
where c.country = 'ar';

-- agregar una columna en la tabla clients con el nombre bill_count que sea el conteo de bills
ALTER TABLE clients 
    add column bill_count int
;

-- llenar la columna bill_count
update clients c set bill_count = (select count(*) from bills b where b.client_id = c.client_id);   

select * 
from clients c
where c.bill_count > 0
;

-- Creación y Uso de Triggers en MySQL para Actualizar Vistas Materializadas
desc ventas_diarias_m;

select * from ventas_diarias_m;
-- dia en analisis 
select * from ventas_diarias_m where fecha = '2024-03-13';
-- buscar en bill_products
select * from bill_products bp where date(bp.date_added) = '2024-03-13';
-- agregar registro
INSERT INTO bill_products (bill_id,product_id, date_added, price)
VALUES (3000, 10, '2024-03-13 12:12:12', 34.1);

-- actualizar la tabla ventas_diarias_m
INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1;

-- mejora en la query para actualizar la tabla ventas_diarias_m
INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1
ON DUPLICATE KEY UPDATE
    cantidad = (select count(*) from bill_products bp where date(bp.date_added) = ventas_diarias_m.fecha),
    total = (select sum(total) from bill_products bp where date(bp.date_added) = ventas_diarias_m.fecha);

-- dia en analisis 
select * from ventas_diarias_m where fecha = '2024-03-13';

-- Agregar Trigger
-- Cambiar el delimitador

delimiter ;
select * from ventas_diarias_m where fecha = '2024-03-13' ;

-- Agregar Trigger
CREATE TRIGGER mat_view_ventas_diarias_m
AFTER INSERT ON bill_products
FOR EACH ROW
BEGIN
    INSERT INTO ventas_diarias_m (fecha, cantidad, total)
    VALUES (
        date(new.date_added),
        (select count(*) from bill_products where date(date_added) = date(new.date_added)),
        (select sum(total) from bill_products where date(date_added) = date(new.date_added))
    )
    ON DUPLICATE KEY UPDATE
        cantidad = values(cantidad),
        total = values(total);
END$$
-- Restaurar el delimitador
;
select delimiter;
delimiter ;|
-- Consultar para un dia en particular
select * from ventas_diarias_m where fecha = '2024-03-13';
-- Agregar registro para probar el trigger
INSERT INTO bill_products (bill_id,product_id, date_added, price)
VALUES (3001, 11, '2024-03-13 12:12:12', 34.1);
-- Consultar para un dia en particular
select * from ventas_diarias_m where fecha = '2024-03-13';

select 1|

delimiter ;

select 1;

-- Consultar para un dia en particular
select * from ventas_diarias_m where fecha = '2024-03-13';
-- Agregar registro para probar el trigger
INSERT INTO bill_products (bill_id,product_id, date_added, price)
VALUES (3002, 14, '2024-03-13 12:12:12', 34.1);
-- Consultar para un dia en particular
select * from ventas_diarias_m where fecha = '2024-03-13';

