-- DROP TABLE IF EXISTS orders;
-- CREATE TABLE orders (
-- 	orderid int4 NOT NULL,
-- 	orderdate date NULL,
-- 	orderstatus varchar(1) NULL,
-- 	orderpriority varchar(15) NULL,
-- 	clerk varchar(15) NULL,
-- 	CONSTRAINT orders_pk PRIMARY KEY (orderid)
-- );



-- Insert data from public to Data Vault
 

 INSERT INTO core.h_orders  (
     order_id )
	select orderid
	FROM public.orders 	


INSERT INTO core.s_orders  (
     orderdate, orderstatus, orderpriority, clerk )
	select orderdate, orderstatus, orderpriority, clerk
	FROM public.orders 
	
	



-- DROP TABLE IF EXISTS products;
-- CREATE TABLE products (
-- 	productid int4 NOT NULL,
-- 	productname varchar(55) NULL,
-- 	producttype varchar(25) NULL,
-- 	productsize int4 NULL,
-- 	retailprice numeric(15,2) NULL,
-- 	CONSTRAINT products_pk PRIMARY KEY (productid)
-- );



-- Insert data from public to Data Vault


 INSERT INTO core.h_products  (
     productid )
	select productid 
	FROM public.products

 INSERT INTO  core.s_products ( productname, producttype, productsize, retailprice)
	select productname, producttype, productsize, retailprice
	FROM public.products 	
	
	
	




-- Insert data from public to Data Vault
 INSERT INTO core.l_orders_products  (
     h_order_rk, h_product_rk )
	select  orderid, productid
	FROM public.orderdetails
	
	

-- Insert data from public to Data Vault
INSERT INTO core.l_s_orders_products  (
     UnitPrice, Quantity, Discount )
	select unitprice, quantity, discount
	FROM public.orderdetails
 



	
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


-- Insert data from public to Data Vault
 

 INSERT INTO core.h_suppliers  (
     supplierid )
	select supplierid 
	FROM public.suppliers



INSERT INTO core.s_suppliers  (
    suppliername,
	address,
	phone,
	balance,
	descr)
	select 
		suppliername,
		address,
		phone,
		balance,
		descr
	FROM public.suppliers

select * from core.s_suppliers;





-- Insert data from public to Data Vault
 INSERT INTO core.l_suppliers_products  (
 	h_supplier_rk,
	h_product_rk)
	select  productid,
		supplierid
	FROM public.productsuppl
	


-- Insert data from public to Data Vault
INSERT INTO core.l_s_suppliers_products  (
	qty,
	suplycost,
	descr
     )
	select 
	qty,
	supplycost,
	descr
	FROM public.productsuppl
