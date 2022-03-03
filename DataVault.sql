


-- DROP TABLE IF EXISTS orders;
-- CREATE TABLE orders (
-- 	orderid int4 NOT NULL,
-- 	orderdate date NULL,
-- 	orderstatus varchar(1) NULL,
-- 	orderpriority varchar(15) NULL,
-- 	clerk varchar(15) NULL,
-- 	CONSTRAINT orders_pk PRIMARY KEY (orderid)
-- );

drop table if EXISTS  core.s_orders ;
create table core.s_orders (
    h_order_rk SERIAL PRIMARY KEY,
    orderdate date NULL,
	orderstatus varchar(1) NULL,
	orderpriority varchar(15) NULL,
	clerk varchar(15) NULL,
    source_system varchar(15) NULL,
    valid_from_dttm time,
    valid_to_dttm time,
    processed_dttm timestamp default current_timestamp,
	CONSTRAINT orders_fk_1 FOREIGN KEY (h_order_rk) REFERENCES core.h_orders(h_order_rk)
	);


drop table if EXISTS  core.h_orders ;
create table core.h_orders (
    h_order_rk SERIAL PRIMARY KEY,
    order_id int,
    source_system varchar(15) NULL,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(h_order_rk)
);






-- DROP TABLE IF EXISTS products;
-- CREATE TABLE products (
-- 	productid int4 NOT NULL,
-- 	productname varchar(55) NULL,
-- 	producttype varchar(25) NULL,
-- 	productsize int4 NULL,
-- 	retailprice numeric(15,2) NULL,
-- 	CONSTRAINT products_pk PRIMARY KEY (productid)
-- );

create table core.s_products (
    h_product_rk SERIAL PRIMARY KEY,
    productname varchar(55) NULL,
	producttype varchar(25) NULL,
	productsize int4 NULL,
	retailprice numeric(15,2) NULL,
    source_system varchar(15) NULL,
    valid_from_dttm time,
    valid_to_dttm time,
    processed_dttm timestamp default current_timestamp,
	CONSTRAINT products_fk_1 FOREIGN KEY (h_product_rk) REFERENCES core.h_products(h_product_rk)
	);

create table core.h_products (
    h_product_rk SERIAL PRIMARY KEY,
    productid int,
    source_system varchar(15) NULL ,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(h_product_rk)
);




-- Links 
drop table if exists core.l_orders_products;
create table core.l_orders_products (
    l_order_product_rk SERIAL PRIMARY KEY,
	h_order_rk int,
    h_product_rk int,
    source_system varchar(15) NULL ,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(l_order_product_rk)
);


	
	
-- Links and Satilits

create table core.l_s_orders_products (
    l_order_product_rk SERIAL PRIMARY KEY,
	UnitPrice numeric(15,2),
    Quantity numeric(15,2),
	Discount numeric(15,2),
    source_system varchar(15) NULL ,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(l_order_product_rk),
    CONSTRAINT l_s_orders_products_fk_1 FOREIGN KEY (l_order_product_rk) REFERENCES core.l_s_orders_products(l_order_product_rk)
);


 



	
--------------------------------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS suppliers;
-- CREATE TABLE suppliers (
-- 	supplierid int4 NOT NULL,
-- 	suppliername varchar(25) NULL,
-- 	address varchar(40) NULL,
-- 	phone varchar(15) NULL,
-- 	balance numeric(15,2) NULL,
-- 	descr varchar(101) NULL,
-- 	CONSTRAINT supplier_pk PRIMARY KEY (supplierid)
-- );


create table core.s_suppliers (
    h_supplier_rk SERIAL PRIMARY KEY,
	suppliername varchar(25) NULL,
	address varchar(40) NULL,
	phone varchar(15) NULL,
	balance numeric(15,2) NULL,
	descr varchar(101) NULL,
    source_system varchar(15) NULL,
    valid_from_dttm time,
    valid_to_dttm time,
    processed_dttm timestamp default current_timestamp,
	CONSTRAINT s_suppliers_fk_1 FOREIGN KEY (h_supplier_rk) REFERENCES core.h_suppliers(h_supplier_rk)
	);

create table core.h_suppliers (
    h_supplier_rk SERIAL PRIMARY KEY,
    supplierid int4 NOT NULL,
    source_system varchar(15) NULL,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(h_supplier_rk)
);




-- Links 

create table core.l_suppliers_products (
    l_supplier_product_rk SERIAL PRIMARY KEY,
	h_supplier_rk int,
    h_product_rk int,
    source_system varchar(15) NULL ,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(l_supplier_product_rk)
);

	

-- Links and Satilits

create table core.l_s_suppliers_products (
    l_supplier_product_rk SERIAL PRIMARY KEY,
	Qty int,
	SuplyCost numeric(15,2),
	Descr varchar(199),
    source_system varchar(15) NULL ,
    processed_dttm timestamp default current_timestamp,
    UNIQUE(l_supplier_product_rk),
    CONSTRAINT l_s_suppliers_products_fk_1 FOREIGN KEY (l_supplier_product_rk) REFERENCES core.l_suppliers_products(l_supplier_product_rk)
);
	



