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
