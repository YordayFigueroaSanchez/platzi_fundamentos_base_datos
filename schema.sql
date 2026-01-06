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