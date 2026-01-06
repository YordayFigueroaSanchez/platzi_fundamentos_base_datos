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



