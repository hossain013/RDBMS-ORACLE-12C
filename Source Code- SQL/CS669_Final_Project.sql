/*
Delower Hossain
Term Project FINA Iteration-5, CS669
Boston University
*/

/*
DROP TABLE Store;
DROP TABLE Customer;
DROP TABLE Vendor;
DROP TABLE Category;
DROP TABLE Product;
DROP TABLE Department;
DROP TABLE Employee;
DROP TABLE Invoice_line;
DROP TABLE Online_Invoice;
DROP TABLE Physical_Invoice;
DROP TABLE Address;
DROP TABLE Project_Manager;
DROP TABLE Programmer;
DROP TABLE Accountant;
DROP TABLE PriceChange_History;
*/



CREATE TABLE Store( 
store_id DECIMAL(12) PRIMARY KEY,
store_name VARCHAR(64) NOT NULL
--store_postalCode VARCHAR(12)NOT NULL,
--store_street VARCHAR(64),
--store_state VARCHAR (64), 
--Store_Country VARCHAR (64) NOT NULL
);


CREATE TABLE Customer(
Cus_Id DECIMAL (12) PRIMARY KEY,
cus_fname VARCHAR (64) NOT NULL,
cus_lname VARCHAR (64) NOT NULL,
email VARCHAR (255), NULL,
contact_no VARCHAR (64)
--cus_street VARCHAR (64) NULL,
--cus_postalcode VARCHAR (64) NOT NULL,
--cus_City VARCHAR (64) NOT NULL,
--cus_state VARCHAR (64) NOT NULL,
--cus_country VARCHAR (64) NOT NULL
);

CREATE TABLE Vendor(
ven_code DECIMAL (12) NOT NULL PRIMARY KEY,
ven_name VARCHAR (64) NOT NULL,
ven_phone VARCHAR (64) NULL,
ven_country VARCHAR (64) NOT NULL
);
CREATE TABLE Category(
category_id DECIMAL (12) PRIMARY KEY,
category_name VARCHAR (64) NOT NULL,
category_desc VARCHAR (256) NULL
);

CREATE TABLE Product(
product_id DECIMAL (12) PRIMARY KEY,
product_name VARCHAR (64) NOT NULL,
product_on_hand DECIMAL (16) NOT NULL,
product_price DECIMAL(8, 2),
category_id DECIMAL (12),
ven_code DECIMAL(12),
product_code VARCHAR (35),
FOREIGN KEY (category_id) REFERENCES Category(category_id),
FOREIGN KEY (ven_code) REFERENCES Vendor(ven_code)
);

CREATE TABLE Department(
dept_id DECIMAL (8) PRIMARY KEY,
dept_name VARCHAR(25) NOT NULL,
manager_id DECIMAL (12) NULL,
FOREIGN KEY (manager_id) REFERENCES Employee (Emp_id)
);

CREATE TABLE Employee(
emp_id DECIMAL (12) PRIMARY KEY,
emp_fname VARCHAR (35) NOT NULL,
emp_lname VARCHAR (35) NOT NULL,
emp_phone VARCHAR (25) NULL,
emp_hireDate DATE  NULL,
dept_id DECIMAL(8),
store_id DECIMAL(10) NULL,
FOREIGN KEY (store_id) REFERENCES Store(store_id),
FOREIGN KEY (dept_id) REFERENCES Department (dept_id)
);

ALTER TABLE Department -- Addig New Column/attribute for department table
ADD Manager_Id DECIMAL(12);

CREATE TABLE Invoice(
Inv_number DECIMAL (12) PRIMARY KEY,
inv_total DECIMAL(8, 2) NULL,
inv_date DATE NOT NULL,
cus_id DECIMAL(12),
emp_id DECIMAL (12),
store_id DECIMAL(12),
FOREIGN KEY (cus_id) REFERENCES Customer(cus_id),
FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

CREATE TABLE Invoice_Line(
Inv_line_number DECIMAL (16),
inv_number DECIMAL (16) NOT NULL,
product_id DECIMAL (12), 
line_price DECIMAL(8,2) NOT NULL,
line_unit DECIMAL(6, 2),
PRIMARY KEY (Inv_line_number, inv_number),
FOREIGN KEY(inv_number) REFERENCES Invoice(inv_number),
FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Online_Invoice(
Inv_number DECIMAL (12) PRIMARY KEY,
Inv_url VARCHAR (1024) NULL,
FOREIGN KEY (Inv_number) REFERENCES Invoice(Inv_number)
);

CREATE TABLE Physical_Invoice(
Inv_number DECIMAL (12) PRIMARY KEY,
address_id DECIMAL (12) NULL,
FOREIGN KEY (Inv_number) REFERENCES Invoice(Inv_number)
);

CREATE TABLE Address(
address_id DECIMAL (12) PRIMARY KEY NOT NULL,
Street VARCHAR (30),
postal_code VARCHAR (15),
city VARCHAR (20),
state VARCHAR (25),
country VARCHAR (25) NOT NULL
);


CREATE TABLE Project_manager(
emp_id DECIMAL(12) PRIMARY KEY NOT NULL,
PMP_License VARCHAR (84), 
p_admin_no DECIMAL (25),
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id)
);

CREATE TABLE Programmer(
emp_id DECIMAL(12) PRIMARY KEY NOT NULL,
ocp_License VARCHAR (84), 
DBA_Certificate_no VARCHAR (35),
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id)
);

CREATE TABLE Accountant(
emp_id DECIMAL(12) PRIMARY KEY NOT NULL,
cpa_License VARCHAR (84), 
cfa_Certification VARCHAR (35),
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id)
);

--Price Change History Table 
CREATE TABLE PriceChange_History (
Price_Chg_ID DECIMAL(12) NOT NULL PRIMARY KEY,
OldPrice DECIMAL(8,2) NOT NULL,
NewPrice DECIMAL(8,2) NOT NULL,
Product_ID DECIMAL(12) NOT NULL,
Change_Date DATE NOT NULL
);

ALTER TABLE Physical_Invoice
ADD CONSTRAINT PhysicalInvoice_address_fk
FOREIGN KEY(address_id)
REFERENCES address(address_id);

ALTER TABLE PriceChange_History
ADD CONSTRAINT PriceChange_History_Product_fk
FOREIGN KEY(Product_id)
REFERENCES Product(Product_id);

ALTER TABLE Department
ADD CONSTRAINT Department_Employee_fk
FOREIGN KEY(manager_id)
REFERENCES Employee(emp_id);



---Foreign Key Indexing 
CREATE INDEX Invoice_CusID_Idx
ON Invoice(Cus_id);

CREATE INDEX Invoice_StoreID_Idx
ON Invoice(Store_id);

CREATE INDEX Invoice_Emp_Idx
ON Invoice(Emp_id);

CREATE INDEX InvoiceLine_InvNumber_Idx
ON Invoice_Line(Inv_Number);

CREATE INDEX InvoiceLine_ProductId_Idx
ON Invoice_Line(Product_id);

CREATE INDEX PhysicalInvoice_AddressID_Idx
ON Physical_Invoice(address_id);


-- UNIQUE INDEX 
CREATE UNIQUE INDEX EmployeePhoneIdx
ON Employee(emp_phone);

CREATE UNIQUE INDEX ProgrammerOcpLicIndx
ON Programmer(Ocp_License);


---Query Drived Index 
CREATE INDEX vendor_idx
  ON vendor (Ven_name, ven_country);

--Single table Query 
/*
SELECT Product.product_id, Product.product_name
FROM Product
WHERE Product.product_price = ‘ $$$ ’ ;
*/

--AS PER ABOVE QUERY WE CREATE NON UNIQUE INDEX FOR price column
CREATE INDEX Product_price_idx
  ON Product (Product_name, Product_price);
  

-------------------


--Data Insertion into STORE Table

INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(101, 'Orchid Fashion New York', '55902', '512','NY','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(102, 'Orchid Fashion MN', '55903', '513','MN','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(103, 'Orchid Fashion ILLINOIS', '55904', '514','IL','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(104, 'Orchid Fashion Massachusetts', '55905', '515','MA','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(105, 'Orchid Fashion TEXAS', '55906', '516','TX','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(106, 'Orchid Fashion Washington DC', '55907', '517','DC','USA');
INSERT INTO Store(store_id, store_name, store_postalCode, store_street, store_state,
Store_Country)
VALUES(107, 'Orchid Fashion Ontario', '655902', '666','ON','CANADA');

SELECT * FROM STORE;

----Data Insertion Table VENDOR
DELETE FROM VENDOR;
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(501, 'Macy', '525.303.8888', 'USA');
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(502, 'GAP', '525.303.8889', 'USA');
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(503, 'Tommy Hilfiger', '525.303.8890', 'USA');
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(504, 'JCPanny', '525.303.8891', 'USA');
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(505, 'Target', '525.303.8892', 'USA');
INSERT INTO Vendor(ven_code, ven_name, ven_phone, ven_Country)
VALUES(506, 'ARMANI', '225.303.8893', 'ITALI');

SELECT * FROM VENDOR;

----Data Insertion Table CATEGORY
INSERT INTO Category(category_id, category_name, category_desc)
VALUES(101, 'Mens', 'This category belongs to all mens apparel');
INSERT INTO Category(category_id, category_name, category_desc)
VALUES(102, 'Womens', 'This section related to all women clothing');
INSERT INTO Category(category_id, category_name, category_desc)
VALUES(103, 'Kids', 'This kids department');
INSERT INTO Category(category_id, category_name, category_desc)
VALUES(104, 'Ladies', 'Section belongs to teen ladies');

SELECT * FROM CATEGORY;

----Data Insertion Table Customer
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(301, 'Alfreds', 'Futterkiste','xyz0@gmail.com','515.123.4560');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(302, 'Susan', 'Bru','xyz1@gmail.com','515.123.4561');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(303, 'Ana', 'Trujillo','xyz2@gmail.com','515.123.4562');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(304, 'Antonio ', 'Moreno ','xyz3@gmail.com','515.123.4563');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(305, 'Yang', 'Wang','xyz4@gmail.com','515.123.4564');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(306, 'Berglunds', 'snabbköp','xyz5@gmail.com','515.123.4565');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(307, 'Blauer', 'Delikatessen','xyz6@gmail.com','615.123.4566');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(308, 'Janine', 'Labrune','xyz7@gmail.com','915.123.4567');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(309, 'Roland', 'Mendel','xyz8@gmail.com','615.123.4567');
INSERT INTO Customer(cus_id, cus_fname, cus_lname, email, contact_no)
VALUES(310, 'Jessica', 'Meldova','xyz9@gmail.com','615.123.4568');



----Data Insertion  Address Table
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(1,  '512','55902', 'Amsterdam', 'NY','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(2,  '513','55903', 'Rochester', 'MN','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(3,  '514','55904', 'Chicago', 'IL','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(4,  '515','55905', 'Boston', 'MA','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(5,  '516','55906', 'Dallas', 'TX','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(6,  '517','55907', 'Alexandria', 'DC','USA');
INSERT INTO address(address_id, street, postal_Code, city, state, Country)
VALUES(7,  '6518','ON-655907', 'Toronto', 'ONTARIO','CANADA');

----Data Insertion  Department Table
INSERT INTO Department(Dept_id, Dept_name, manager_id)
VALUES(401,  'Administrator', null);
INSERT INTO Department(Dept_id, Dept_name, manager_id)
VALUES(402,  'Human Resources', null);
INSERT INTO Department(Dept_id, Dept_name, manager_id)
VALUES(403,  'Sales', null);
INSERT INTO Department(Dept_id, Dept_name, manager_id)
VALUES(404,  'Execcutive', null);
INSERT INTO Department(Dept_id, Dept_name, manager_id)
VALUES(405,  'Finance And Payroll', null);


----Data Insertion  Employee Table
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(1,  'Jeffrey','Anderson', '507.319.3452','17-03-2003',401,null,null);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(2,  'Josh','Bone', '507.319.3453','02-04-2003',402,null,1);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(3,  'Michale','Fine', '507.319.3454','30-04-2003', 403, null, 1);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(4,  'Oliver','Thomas', '507.319.3455','30-05-2003', 404, null, 1);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(5,  'Jack','Conner', '507.319.3456','18-05-2003', 405, null, 1);

---Subtype/Child Employee who has exceptional attributes 
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(1,  'Jeffrey','Anderson', '507.319.3452','17-03-2003',401,null,null);


--Store number 101 employees
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(6,  'Harry','Callum', '507.319.3461','15-04-2003',402,101,2);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(7,  'Kal','Jacob', '507.319.3458','30-04-2003', 403, 101, 3);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(8,  'Jessica','Ray', '507.319.3459','30-05-2003', 404, 101, 4);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(9,  'Susan','Bru', '507.319.3466','28-05-2003', 405, 101, 5);

--Store number 102 employees record Insertion
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(10,  'Andrew','Murphy', '607.319.3461','20-05-2004',402,102,2);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(11,  'Olivia','Samantha', '607.319.3462','25-05-2004',402,102,2);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(12,  'Amelia','Margaret', '607.319.3463','15-05-2003',403,102,3);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(13,  'William','Damian', '607.319.3465','17-05-2004',404,102,4);

--Store number 107 employees record Insertion
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(14,  'James','Charlie', '907.319.3461','20-05-2005',402,107,2);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(15,  'Oscar','Rhys', '907.319.3462','28-06-2005',402,107,3);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(16,  'George','Reece', '907.319.3463','21-06-2005',403,107,4);
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(18,  'Julia','Reece', '907.319.3464','21-06-2006',403,107,4);

---Subtype/Child Employee who has exceptional attributes 
INSERT INTO employee(emp_id, emp_fname, emp_lname,emp_phone,emp_hiredate, 
dept_id, store_id, manager_id)
VALUES(17,  'Taylor','Smith', '707.319.3452','17-03-2006',null,null,null);

---Employee SubTypes: Project_Manager, Programmer, and Accountant Table data Insertion
INSERT INTO Project_manager(emp_id, pmp_license, p_admin_no) 
VALUES(17, 'PMP-999.25.555', '321654');
INSERT INTO Programmer(emp_id, OCP_license, dba_certificate_no) 
VALUES(17, 'OCP-55525', 'DBA-321654');
INSERT INTO Accountant(emp_id, CPA_license, CFA_certification) 
VALUES(5, 'CPA-55525', 'CFA-321654');

--Online_Invoice row insertion 
INSERT INTO Online_Invoice(inv_number, inv_url) 
VALUES(109, 'https://www.orchidfashion.com/invoice/109');
INSERT INTO Online_Invoice(inv_number, inv_url) 
VALUES(110, 'https://www.orchidfashion.com/invoice/110');
INSERT INTO Online_Invoice(inv_number, inv_url) 
VALUES(111, 'https://www.orchidfashion.com/invoice/111');

--Physical Invoice rows inserting 
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(102, '1');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(103, '1');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(113, '1');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(112, '1');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(104, '2');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(105, '2');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(114, '2');
INSERT INTO Physical_Invoice(inv_number, address_id) 
VALUES(111, '7');

SELECT * FROM Employee;


--1st Store Procedure Product Table data insertion 
CREATE SEQUENCE p_id_seq;

CREATE OR REPLACE PROCEDURE ADD_PRODUCT(
    p_name IN VARCHAR, -- The item's description
    p_onhand IN DECIMAL,
    p_price IN DECIMAL, -- The item's price
    p_category_id IN DECIMAL,
    p_ven_code IN DECIMAL)
IS
    v_product_code VARCHAR(4); --Declare a variable to hold an item_code value.
BEGIN
    --Calculate the item_code value and put it into the variable.
    v_product_code := SUBSTR(p_name, 1, 1) || ROUND(DBMS_RANDOM.VALUE(0,999), 0);
    --Insert a row with the combined values of the parameters and the variable.
    INSERT INTO PRODUCT (product_id, product_name, product_on_hand, product_price, 
    category_id, 
    ven_code, product_code)
    VALUES( p_id_seq.NEXTVAL, p_name, p_onhand,p_price, p_category_id, p_ven_code, 
    v_product_code);
END;
BEGIN
  ADD_PRODUCT('Long Sleeve Classical T-Shirt', 50, 21.50,101,502);
END;
/
BEGIN
  ADD_PRODUCT('Oxford Shirt', 65, 25,101,502);
END;
/
BEGIN
  ADD_PRODUCT('Ladies Skinny Jeans',300, 34.99,104,501);
END;
/
BEGIN
  ADD_PRODUCT('Winter jacket',25, 175,102,503);
END;
/

BEGIN
  ADD_PRODUCT('Pullover Sweater',75, 20.99,101,504);
END;
/

BEGIN
  ADD_PRODUCT('Graphic Long Sleeve',84, 18,103,505);
END;
/

BEGIN
  ADD_PRODUCT('Disney Mouse Hoddie Fleece',800, 45,103,506);
END;
/
BEGIN
  ADD_PRODUCT('Straight Denim',750, 35,101,506);
END;
/

BEGIN
  ADD_PRODUCT('Ruffle Print Wrap Dress',200, 48,101,502);
END;
/
SELECT * FROM Product;


--2nd Store Procedure 
CREATE SEQUENCE INV_NUM_seq
      START WITH 101
      INCREMENT BY 1
      CACHE 10000;

CREATE OR REPLACE PROCEDURE ADD_INVOICE(
            p_cus_id IN DECIMAL, 
            p_emp_id IN DECIMAL, 
            p_store_id IN DECIMAL) 
IS
BEGIN
    INSERT INTO INVOICE(inv_number,inv_date, cus_id, emp_id, store_id)
    VALUES(INV_NUM_seq.nextval, SYSDATE(), p_cus_id, p_emp_id, p_store_id);
END;
/
BEGIN
  ADD_INVOICE( 303, 12,102);
END;
/


--3nd Store Procedure 
CREATE SEQUENCE INVL_id_seq;

CREATE OR REPLACE PROCEDURE ADD_INVOICE_LINE(
            p_code IN VARCHAR, -- The code of the item.
            p_inv_number IN DECIMAL, -- The ID of the order for the line item.
            p_line_unit IN DECIMAL) -- The quantity of the item.
IS
    v_product_id DECIMAL(12); --Declare a variable to hold the ID of the product code.
    v_line_price DECIMAL(12,2); --Declare a variable to calculate line price.
BEGIN
        --Get the item_id based upon the item_code, as well as the line total.
        SELECT product_id, product_price * p_line_unit
        INTO v_product_id, v_line_price FROM product
        WHERE product_code = p_code;
        --Insert the new line item.
        INSERT INTO INVOICE_LINE(inv_line_number,inv_number, product_id,line_price, line_unit)
        VALUES(INVL_id_seq.nextval, p_inv_number, v_product_id, v_line_price, p_line_unit);
END;
/
BEGIN
  ADD_INVOICE_LINE('P295', 105, 2);
END;
/

--Creating a Trigger for Price change history table
CREATE OR REPLACE TRIGGER PriceChgHisTrigger
BEFORE UPDATE OF Product_Price ON Product
FOR EACH ROW
BEGIN
INSERT INTO PriceChange_History(Price_Chg_ID, OldPrice, NewPrice, Product_ID, 
Change_Date)
      VALUES(NVL((SELECT MAX(Price_Chg_ID)+1 FROM Pricechange_history), 1),
                :OLD.product_Price,
                :NEW.product_Price,
                :New.Product_ID,
                trunc(sysdate));
END;
/
SELECT * FROM Product
WHERE product_id=5;

UPDATE Product
SET product_price = 145
WHERE product_id = 5;

SELECT * FROM PriceChange_History;
SELECT * FROM Product;

--Organization-Driven Queries

--USE CASE 1: COUNT LIST OF PRODUCT AVAILABLE 
SELECT  Count(*) AS Total_PRODUCT
FROM Product;

--USE CASE 2:LIST OF ALL EMPLOYEE WHO HAS JOINED PRIOR 2014
SELECT emp_lname, emp_hiredate, dept_id
from employee
where emp_hiredate<'1-12-2004';

--USE CASE 3: COMPUTE TOTAL REVENUE FOR THE STORE
SELECT SUM(LINE_PRICE) AS TOTAL_SALE
FROM INVOICE_LINE;



-- USE CASE 4: LIST OF ALL PRODUCT ORGANIZED FROM MIN PRICE 
SELECT PRODUCT_ID, PRODUCT_CODE, PRODUCT_NAME, MIN(PRODUCT_PRICE) AS MIN_PRODUCT_PRICE
FROM PRODUCT
GROUP BY PRODUCT_ID, PRODUCT_CODE, PRODUCT_NAME
ORDER BY MIN(PRODUCT_PRICE);

--USE CASE 5: LIST OF ALL CUSTOMERS WHO HAVE CONDUCTED TRANSACTION/ SHOW INVOICE NO
SELECT  Customer.Cus_lname, Invoice.Inv_Date, Invoice.Inv_number
FROM Invoice
INNER JOIN Customer ON Invoice.Cus_id=Customer.Cus_id
ORDER BY inv_number;

--USE CASE 6: SHOW EACH PRODUCT NAME AND THEIR CATEGORY DESC ORDER
SELECT  product_name, category_name
FROM product
JOIN category ON product.CATEGORY_ID=category.CATEGORY_id
GROUP BY PRODUCT_NAME, category_name
ORDER BY category_name DESC;

--USE CASE 7: UNCORRELATED SUBQUERIES
SELECT Product_name, product_price
FROM product 
WHERE PRODUCT_PRICE> (SELECT AVG(product_price)
from product);


                









