


-- DROP TABLE IF EXISTS orders;
-- CREATE TABLE orders (
-- 	orderid int4 NOT NULL,
-- 	orderdate date NULL,
-- 	orderstatus varchar(1) NULL,
-- 	orderpriority varchar(15) NULL,
-- 	clerk varchar(15) NULL,
-- 	CONSTRAINT orders_pk PRIMARY KEY (orderid)
-- );

create table core.s_orders (
    h_order_rk int,
    orderdate date NULL,
	orderstatus varchar(1) NULL,
	orderpriority varchar(15) NULL,
	clerk varchar(15) NULL,
    source_system string,
    valid_from_dttm datetime,
    valid_to_dttm datetime,
    processed_dttm datetime,
	CONSTRAINT orders_fk_1 FOREIGN KEY (h_order_rk) REFERENCES public.core.h_orders(h_order_rk)
	);

create table core.h_orders (
    h_order_rk SERIAL PRIMARY KEY,
    order_id int,
    source_system string,
    processed_dttm datetime,
    UNIQUE(order_bk)
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
    h_product_rk int,
    productname varchar(55) NULL,
	producttype varchar(25) NULL,
	productsize int4 NULL,
	retailprice numeric(15,2) NULL,
    source_system string,
    valid_from_dttm datetime,
    valid_to_dttm datetime,
    processed_dttm datetime,
	CONSTRAINT products_fk_1 FOREIGN KEY (h_product_rk) REFERENCES public.core.h_products(h_product_rk)
	);

create table core.h_products (
    h_product_rk SERIAL PRIMARY KEY,
    productid int,
    source_system string,
    processed_dttm datetime,
    UNIQUE(product_rk)
);

-- Links 

create table core.l_orders_products (
    l_order_product_rk SERIAL PRIMARY KEY,
	h_order_rk int,
    h_product_rk int,
    source_system string,
    processed_dttm datetime,
    UNIQUE(order_product_rk)
);

-- Links and Satilits

create table core.l_s_orders_products (
    l_order_product_rk SERIAL PRIMARY KEY,
	UnitPrice numeric(15,2),
    Quantity numeric(15,2),
	Discount numeric(15,2),
    source_system string,
    processed_dttm datetime,
    UNIQUE(order_product_rk)
);



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
    h_supplier_rk int,
	suppliername varchar(25) NULL,
	address varchar(40) NULL,
	phone varchar(15) NULL,
	balance numeric(15,2) NULL,
	descr varchar(101) NULL,
    source_system string,
    valid_from_dttm datetime,
    valid_to_dttm datetime,
    processed_dttm datetime,
	CONSTRAINT suppliers_fk_1 FOREIGN KEY (h_supplier_rk) REFERENCES public.core.h_suppliers(h_supplier_rk)
	);

create table core.h_suppliers (
    h_supplier_rk SERIAL PRIMARY KEY,
    supplierid int4 NOT NULL,
    source_system string,
    processed_dttm datetime,
    UNIQUE(product_rk)
);

-- Links 

create table core.l_suppliers_products (
    l_supplier_product_rk SERIAL PRIMARY KEY,
	h_supplier_rk int,
    h_product_rk int,
    source_system string,
    processed_dttm datetime,
    UNIQUE(order_product_rk)
);

-- Links and Satilits

create table core.l_s_suppliers_products (
    l_supplier_product_rk SERIAL PRIMARY KEY,
	Qty int,
	SuplyCost numeric(15,2),
	Descr varchar(199),
    source_system string,
    processed_dttm datetime,
    UNIQUE(supplier_product_rk)
);
