# platzi_fundamentos_base_datos
platzi_fundamentos_base_datos

# Qué es SQL y cuándo usarlo en lugar de Excel
Para aprender SQL desde cero, les recomiendo tres portales muy útiles y fáciles de usar. El primero es SQLBolt, ideal para comenzar porque te enseña paso a paso y te deja practicar en el navegador. Luego está Mode, que tiene un tutorial muy visual donde puedes escribir consultas y ver resultados al instante. Y por último, Kaggle, donde puedes aprender con ejercicios basados en datos reales y obtener certificados. Los tres son gratuitos y perfectos si estás empezando.

# Docker
[docker](docker)

# Tabla de clientes
[clientes_create.sql](clientes_create.sql)

# Normalización y relaciones en bases de datos de tiendas
# Creación visual de esquemas de bases de datos con DBML
# Tipos de tablas en bases de datos relacionales: catálogo, operación, registro y archivo
# Modificación de tablas MySQL con ALTER TABLE
# Inserción de datos y manejo de claves duplicadas en MySQL
# Creación de tablas MySQL realistas con campos únicos y timestamps
[query/product.sql](query/product.sql)
# Filtrado de datos con WHERE en SQL
## nuevo schema
[class_17/schema_b68ce7b9-9a62-461a-9983-18cf0c11344e.zip](class_17/schema_b68ce7b9-9a62-461a-9983-18cf0c11344e.zip)
## data para llenar la base
[class_17/data_e467ad8a-a59e-4c14-bb20-dd48a7ee766b.zip](class_17/data_e467ad8a-a59e-4c14-bb20-dd48a7ee766b.zip)

# Comando UPDATE: modificar registros en tablas SQL
# Borrado lógico y físico de datos en SQL

# Uso del comando SELECT para consultas básicas en SQL
```
SELECT [columnas, variables, operacion, funciones]
FROM [tablas]
WHERE [condiciones]
ORDER BY [columnas]
HAVING [condiciones]
ORDER BY [columnas]
LIMIT [A] [B]
```

# Funciones agregadoras y agrupación de datos con MySQL

## Funciones agregadoras
- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

## Agrupación de datos
- GROUP BY
- HAVING

## IF en el SELECT
- IF()

## Uso de CASE
CASE
    WHEN [condicion] THEN [resultado]
    ELSE [resultado]
END

# Cómo llenar tablas usando INSERT INTO SELECT en MySQL
## Crear tabla 
```
CREATE TABLE investment (
    investment_id integer unsigned primary key auto_increment,
    product_id integer unsigned not null default 0,
    investment interger not null deaful 0
);
```

## Llenar tabla
```
INSERT INTO investments (product_id, investment) 
SELECT product_id, investment FROM products;
```

# Cómo usar Left Join para conectar tablas relacionales
SELECT [columnas]
FROM [tablas]
LEFT JOIN [tablas] ON [condiciones]
WHERE [condiciones]

# Consultas complejas con múltiples tablas usando LEFT JOIN en MySQL

# Backup de la base desdpues de terminado el curso
[backup/dump-platzi_fundamentos_base_datos-202601061329.zip](backup/dump-platzi_fundamentos_base_datos-202601061329.zip)

# Examen
ok

# Curso de SQL y MySQL
## Curso Avanzado de MySQL: Vistas, Triggers y Columnas Generadas
[Curso Avanzado de MySQL: Vistas, Triggers y Columnas Generadas](https://platzi.com/cursos/sql-mysql/diseno-y-optimizacion-avanzada-de-bases-de-datos-c/)
### schema
[docs_curso_2/schema.sql](docs_curso_2/schema.sql)
### data
[docs_curso_2/clients.sql](docs_curso_2/clients.sql)
[docs_curso_2/products.sql](docs_curso_2/products.sql)
[docs_curso_2/bills.sql](docs_curso_2/bills.sql)
[docs_curso_2/bill_products.sql](docs_curso_2/bill_products.sql)

## Buenas prácticas avanzadas en MySQL: optimización y superqueries

## Columnas Generadas en MySQL: Automatización de Operaciones
```sql
CREATE TABLE example (
    example_id integer unsigned primary key auto_increment,
    quantity int not null default 1,
    price float not null,
    total float as (quantity * price)
)
```
|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|example_id|int unsigned|NO|PRI||auto_increment|
|quantity|int|NO||1||
|price|float|NO||||
|total|float|YES|||VIRTUAL GENERATED|

La columna `total` es una columna generada, es decir, no se almacena en la base de datos, sino que se calcula en tiempo real.

### Agregar columna en modo stored
```sql
ALTER TABLE example add column total_stored float as (quantity * price) stored;
```

|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|example_id|int unsigned|NO|PRI||auto_increment|
|quantity|int|NO||1||
|price|float|NO||||
|total|float|YES|||VIRTUAL GENERATED|
|total_stored|float|YES|||STORED GENERATED|

La diferencia entre `VIRTUAL` y `STORED` es que `VIRTUAL` almacena el resultado de la operación en la base de datos, mientras que `STORED` almacena el resultado de la operación en la base de datos.

### Agregar columna en modo virtual
```sql
ALTER TABLE products add column description_length int as (length(description)) virtual;
```
### descripcion de la tabla products
|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|product_id|int unsigned|NO|PRI||auto_increment|
|sku|varchar(20)|NO|UNI|||
|name|varchar(100)|NO||||
|slug|varchar(200)|NO|UNI|||
|description|text|YES||||
|price|float|NO||0||
|created_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED|
|updated_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED on update CURRENT_TIMESTAMP|
|description_length|int|YES|||VIRTUAL GENERATED|

## Generación de Slugs SEO-Friendly en MySQL
```sql
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
```

|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|product_id|int unsigned|NO|PRI||auto_increment|
|sku|varchar(20)|NO|UNI|||
|name|varchar(100)|NO||||
|slug|varchar(200)|NO|UNI|||
|description|text|YES||||
|price|float|NO||0||
|created_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED|
|updated_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED on update CURRENT_TIMESTAMP|
|description_length|int|YES|||VIRTUAL GENERATED|
|slug_generated|varchar(200)|YES|||STORED GENERATED|

Si se actualiza el nombre de un producto, el slug_generated se actualiza automaticamente.

## Creación y Uso de Vistas en Bases de Datos MySQL

### agregar columna total a bill_products
```sql
ALTER TABLE bill_products add column total float as (price * quantity * (1 - discount/100)) virtual;
```

### desc bill_products
|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|bill_product_id|int unsigned|NO|PRI||auto_increment|
|bill_id|int unsigned|NO||||
|product_id|int unsigned|NO||||
|date_added|datetime|YES||||
|quantity|int|YES||1||
|price|float|NO||||
|discount|int|NO||0||
|created_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED|
|updated_at|timestamp|NO||CURRENT_TIMESTAMP|DEFAULT_GENERATED on update CURRENT_TIMESTAMP|
|total|float|YES|||VIRTUAL GENERATED|

## Creación de Vistas Materializadas en MySQL
### Crear tabla materializada ooo
```sql
CREATE TABLE ventas_diarias_m (
    fecha date not null unique,
    cantidad integer,
    total integer
);
```

### Insertar en la tabla `ventas_diarias_m`
```sql
INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1;
```

## Creación y Uso de Triggers en MySQL para Actualizar Vistas Materializadas
```sql
desc ventas_diarias_m;
```
|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|fecha|date|NO|PRI|||
|cantidad|int|YES||||
|total|int|YES||||

### Como actualizar la tabla `ventas_diarias_m` cuando salta key duplicate
#### dia en analisis 
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|2|39551|

#### Agregar registro para el dia `2024-03-14` en bill_products
```sql
INSERT INTO bill_products (bill_id,product_id, date_added, price)
VALUES (3000, 10, '2024-03-14 12:12:12', 34.1);
```


#### Error al insertar en la tabla `ventas_diarias_m`
```sql
INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1;
```

#### Mejora en la query para actualizar la tabla `ventas_diarias_m`
```sql
INSERT INTO ventas_diarias_m (fecha, cantidad, total)
SELECT 
    date(bp.date_added),
    count(bp.bill_product_id),
    sum(bp.total)
FROM bill_products bp
GROUP BY 1
ON DUPLICATE KEY UPDATE
    cantidad = (select count(*) from bill_products bp where bp.date_added = ventas_diarias_m.fecha),
    total = (select sum(total) from bill_products bp where bp.date_added = ventas_diarias_m.fecha);
```
### Crear trigger after insert en bill_products

### Para agregar el trigger
Se tiene que cambiar el delimitador que por defaul es `;`
```sql
delimiter |
```
Despues de agregado el trigger se cambia el delimitador de vuelta a `;`.
```sql
delimiter ;
```
Se hace el foreach para que el trigger se ejecute por cada registro insertado. Para cubrir los insert que llegan con mas de un registro para insertar.
```sql
insert table_name(id, name)
values (1,'name1'),(2,'name2'),(3,'name3');
```

### Trigger after insert en bill_products
Se ejecuta lo relacionado con el trigger directo desde la base de datos.
[trigger_after_insert.sql](trigger_after_insert.sql)
```sql
use platzi_curso_mysql;
```
Cambiar el delimitador a `|` para que el trigger se ejecute correctamente.
```sql
DELIMITER |
```
Crear el trigger
```sql
CREATE TRIGGER matview_insert
AFTER INSERT ON bill_products
FOR EACH ROW
BEGIN
    INSERT INTO ventas_diarias_m (fecha, cantidad, total)
    VALUES (
        DATE(NEW.date_added),
        (SELECT COUNT(*) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added)),
        (SELECT SUM(total) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added))
    )
    ON DUPLICATE KEY UPDATE
    cantidad = VALUES(cantidad),
    total = VALUES(total);
END
|
```
Cambiar el delimitador de vuelta a `;`.
```sql
DELIMITER ;
```
### Test del trigger
Consultar para un dia en particular
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|4|39620|

Agregar registro para probar el trigger
```sql
INSERT INTO bill_products (bill_id,product_id, date_added, price)
VALUES (3002, 14, '2024-03-13 12:12:12', 34.1);
```
Consultar para un dia en particular
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|5|39654|

## Creación de Vistas Materializadas en MySQL con Triggers (after delete)
[trigger_after_delete.sql](trigger_after_delete.sql)
### Test del trigger
Consultar para un dia en particular
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|5|39654|

Eliminar registro para probar el trigger
```sql
DELETE FROM bill_products WHERE bill_id = 3002;
```
Consultar para un dia en particular
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|3|39585|

## Creación de Vistas Materializadas en MySQL con Triggers (after update)
[trigger_after_update.sql](trigger_after_update.sql)
Agregar el trigger desde el motor de basa de datos.
- Buscar registro en `bill_products`
```sql
select * from bill_products bp where bp.bill_product_id = 410;
```
|bill_product_id|bill_id|product_id|date_added|quantity|price|discount|created_at|updated_at|total|
|---------------|-------|----------|----------|--------|-----|--------|----------|----------|-----|
|410|18|1590|2024-03-13 19:36:38|6|1129.98|10|2026-01-06 15:05:20|2026-01-06 15:05:20|6101.89|

- Fechas en analisis
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|3|39585|

```sql
select * from ventas_diarias_m where fecha = '2024-03-16';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-16|3|69578|

- Actualizar precio
```sql
UPDATE platzi_curso_mysql.bill_products
	SET price=3030.0
	WHERE bill_product_id=410;
```

```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|3|49846|

- Actualizar fecha
```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|3|49846|

Se actualiza la fecha al dia `2024-03-16`.

```sql
select * from ventas_diarias_m where fecha = '2024-03-13';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-13|2|33484|


```sql
UPDATE bill_products
	SET date_added='2024-03-16 19:36:38'
	WHERE bill_product_id=410;
```

```sql
select * from ventas_diarias_m where fecha = '2024-03-16';
```
|fecha|cantidad|total|
|-----|--------|-----|
|2024-03-16|4|85940|

## Llaves e índices en bases de datos MySQL
### Llaves
llave primaria
llave unica
llave de relacion foranea
### Indices
el indice ocupa espacio en el disco duro

#### Crear indice
```sql
CREATE INDEX idx_clients_name ON clients(name);
```

#### Eliminar indice
```sql
DROP INDEX idx_clients_name ON clients;
```

#### Mostrar indices
```sql
SHOW INDEXES FROM clients;
```

## Manipulación de Columnas JSON en MySQL: Creación y Modificación
### Crear columna JSON
```sql
ALTER TABLE products ADD COLUMN datajson JSON;
```
### Actualizar datos JSON de un producto
```sql
UPDATE products
SET datajson = '{"age": 30, "city": "New York"}'
WHERE product_id = 100;
```
### Remplazar un valor en el JSON
```sql
UPDATE products
SET datajson = JSON_REPLACE(datajson, '$.age', 31)
WHERE product_id = 100;
```

### Remover un valor en el JSON
```sql
UPDATE products
SET datajson = JSON_REMOVE(datajson, '$.age')
WHERE product_id = 100;
```

### Agregar un valor en el JSON
```sql
UPDATE products
SET datajson = JSON_SET(datajson, '$.color', 'red')
WHERE product_id = 100;
```

## Búsqueda y Manipulación de Datos JSON en MySQL
### Agregar datos JSON
```sql
UPDATE products
SET datajson = '{"brand": "Apple", "hdsize": "128GB", "color": "red"}'
WHERE rand() < 0.1;
```

### Seleccionar datos JSON de un producto
```sql
SELECT * 
FROM products 
WHERE JSON_EXTRACT(datajson, '$.brand') = 'Apple';
```

### Guardar un JSON dentro de JSON
```sql
UPDATE products
SET datajson = '{"age": 30, "city": "New York", "address": {"street": "Main St", "zip": "12345"}}'
WHERE product_id = 100;
```

#### Seleccionar datos JSON de un producto
```sql
select datajson from products where product_id = 100;
```
```sql
select datajson->'$.address'  from products p where p.product_id = 100;
```
**Tomar la data sin los delimitadores de cadena**
```sql
select datajson->>'$.address.zip'  from products p where p.product_id = 100;
```
