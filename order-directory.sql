Create Database if not exists `order-directory` ;
use `order-directory`;
CREATE TABLE IF NOT EXISTS supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50),
SUPP_PHONE varchar(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS customer(
CUS_ID INT NOT NULL,
CUS_NAME VARCHAR(20) NOT NULL,
CUS_PHONE VARCHAR(10) NOT NULL,
CUS_CITY varchar(30) NOT NULL,
CUS_GENDER CHAR,
PRIMARY KEY (CUS_ID));

CREATE TABLE IF NOT EXISTS category (
CAT_ID INT NOT NULL,
CAT_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY (CAT_ID)
);

CREATE TABLE IF NOT EXISTS product (
PRO_ID INT NOT NULL,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC VARCHAR(60),
CAT_ID INT NOT NULL,
PRIMARY KEY (PRO_ID),
FOREIGN KEY (CAT_ID) REFERENCES CATEGORY (CAT_ID)
);

CREATE TABLE IF NOT EXISTS supplier_pricing (
PRICING_ID INT NOT NULL,
PRO_ID INT NOT NULL,
SUPP_ID INT NOT NULL,
SUPP_PRICE INT DEFAULT 0,
PRIMARY KEY (PRICING_ID),
FOREIGN KEY (PRO_ID) REFERENCES PRODUCT (PRO_ID),
FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER(SUPP_ID)
);

CREATE TABLE IF NOT EXISTS `order` (
ORD_ID INT NOT NULL,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE,
CUS_ID INT NOT NULL,
PRICING_ID INT NOT NULL,
PRIMARY KEY (ORD_ID),
FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),
FOREIGN KEY (PRICING_ID) REFERENCES SUPPLIER_PRICING(PRICING_ID)
);

CREATE TABLE IF NOT EXISTS rating (
RAT_ID INT NOT NULL,
ORD_ID INT NOT NULL,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY (RAT_ID),
FOREIGN KEY (ORD_ID) REFERENCES `order`(ORD_ID)
);


INSERT INTO SUPPLIER (SUPP_ID , SUPP_NAME, SUPP_CITY, SUPP_PHONE ) 
VALUES (1,"Rajesh Retails","Delhi",1234567890), 
(2,"Appario Ltd.","Mumbai",2589631470),
(3,"Knome products","Banglore",9785462315),
(4,"Bansal Retails","Kochi",8975463285),
(5,"Mittal Ltd.","Lucknow",7898456532);

INSERT INTO CUSTOMER (CUS_ID, CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER )
VALUES(1,"AAKASH",'9999999999',"DELHI",'M'),
(2,"AMAN",'9785463215',"NOIDA",'M'),
(3,"NEHA",'9999999999',"MUMBAI",'F'),
(4,"MEGHA",'9994562399',"KOLKATA",'F'),
(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO CATEGORY (CAT_ID , CAT_NAME ) 
VALUES( 1,"BOOKS"),
(2,"GAMES"),
(3,"GROCERIES"),
(4,"ELECTRONICS"),
(5,"CLOTHES");

INSERT INTO PRODUCT (PRO_ID, PRO_NAME, PRO_DESC, CAT_ID)
VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2),
(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5),
(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
(4,"OATS","Highly Nutritious from Nestle",3),
(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1),
(6,"MILK","1L Toned MIlk",3),
(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4),
(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5),
(9,"Project IGI","compatible with windows 7 and above",2),
(10,"Hoodie","Black GUCCI for 13 yrs and above",5),
(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1),
(12,"Train Your Brain","By Shireen Stephen",1);

INSERT INTO SUPPLIER_PRICING (PRICING_ID, PRO_ID, SUPP_ID, SUPP_PRICE )
VALUES(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000),
(6,12,2,780),
(7,12,4,789),
(8,3,1,31000),
(9,1,5,1450),
(10,4,2,999),
(11,7,3,549),
(12,7,4,529),
(13,6,2,105),
(14,6,1,99),
(15,2,5,2999),
(16,5,2,2999);

INSERT INTO `ORDER` (ORD_ID, ORD_AMOUNT, ORD_DATE, CUS_ID, PRICING_ID) 
VALUES (101,1500,"2021-10-06",2,1),
(102,1000,"2021-10-12",3,5),
(103,30000,"2021-09-16",5,2),
(104,1500,"2021-10-05",1,1),
(105,3000,"2021-08-16",4,3),
(106,1450,"2021-08-18",1,9),
(107,789,"2021-09-01",3,7),
(108,780,"2021-09-07",5,6),
(109,3000,"2021-09-10",5,3),
(110,2500,"2021-09-10",2,4),
(111,1000,"2021-09-15",4,5),
(112,789,"2021-09-16",4,7),
(113,31000,"2021-09-16",1,8),
(114,1000,"2021-09-16",3,5),
(115,3000,"2021-09-16",5,3),
(116,99,"2021-09-17",2,14);

INSERT INTO RATING (RAT_ID, ORD_ID, RAT_RATSTARS) 
VALUES (1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);

select count(t2.cus_gender) as NoOfCustomers, t2.cus_gender from
(select t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name from
(select `order`.*, customer.cus_gender, customer.cus_name from `order` inner join customer where `order`.cus_id=customer.cus_id having
`order`.ord_amount>=3000)
as t1 group by t1.cus_id) as t2 group by t2.cus_gender;

select product.pro_name, `order`.* from `order`, supplier_pricing, product
where `order`.cus_id=2 and
`order`.pricing_id=supplier_pricing.pricing_id and supplier_pricing.pro_id=product.pro_id;

select supplier.* from supplier where supplier.supp_Id in
(select supp_id from supplier_pricing group by supp_id having
count(supp_id)>1) group by supplier.supp_id;

select category.*, min(t3.min_price) as Min_Price,t3.pro_name from category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join
(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id)
as t2 where t2.pro_id = product.pro_id)
as t3 where t3.cat_id = category.cat_id group by t3.cat_id;

SELECT product.PRO_ID, product.PRO_NAME FROM product INNER JOIN
(SELECT SP.* FROM supplier_pricing AS SP INNER JOIN 
(SELECT PRICING_ID, ORD_DATE FROM `order` where ORD_DATE>"2021-10-05") AS T1 ON T1.PRICING_ID=SP.PRICING_ID) 
AS T2 ON product.PRO_ID=T2.PRO_ID ;

select CUS_Name,CUS_Gender from customer where CUS_Name like 'A%' or CUS_Name like '%A';

call proc;

select * from supplier;
select * from customer;
select * from category;
select * from product;
select * from supplier_pricing;
select * from rating;
select * from `order`;