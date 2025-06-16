/*Q1. 1. Create a table called employees with the following structure?*/
create database test;
use test;
create table employees (
 emp_id int primary key ,
 emp_name Varchar(50) not null,
age int check (age>= 18),
email varchar (50) unique,
salary DECIMAL(10, 2) DEFAULT 30000.00);
select * from employees; 

/* Q2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.
Ans: 
Purpose of Constraints:
Data Accuracy:
Constraints ensure that the data stored in the database is correct and conforms to predefined rules.
Data Consistency:
They maintain consistency across the database by ensuring that relationships between tables are valid and that data adheres to specified formats.
Data Reliability:
By preventing invalid data from being entered, constraints contribute to the overall reliability and trustworthiness of the database.
Error Prevention:
They act as a safety net, catching errors early in the data entry process, preventing the propagation of incorrect information. 
Common Types of Constraints:
Primary Key:
Uniquely identifies each record in a table, ensuring no duplicate entries and preventing NULL values in the primary key column. 
Foreign Key:
Establishes relationships between tables, ensuring referential integrity by requiring that foreign key values match existing primary key values in the related table. 
Unique:
Enforces uniqueness for a column (or a set of columns), preventing duplicate values within that column. 
NOT NULL:
Ensures that a column cannot contain NULL values, forcing each row to have a value in that column. 
CHECK:
Allows defining a logical condition (e.g., a value must be greater than zero) that must be met for data to be inserted or updated. 
Default:
Assigns a default value to a column if no specific value is provided during insertion.  */

/*Q3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.

Ans:- The NOT NULL constraint is used to ensure that a column must always have a value. It prevents the insertion of NULL values into that column. This is important when:

The column represents essential data (e.g., usernames, emails, or timestamps).

You want to enforce data integrity, making sure incomplete or unknown data is not stored.

The column is used in calculations or joins, where NULL could lead to incorrect results.

Example:
If you're storing customer emails:

email VARCHAR(255) NOT NULL;
This ensures every record has a valid email address*/

/*Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.
Adding a Constraint
Syntax:


ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
Common Constraint Types:
PRIMARY KEY

FOREIGN KEY

UNIQUE

CHECK

NOT NULL (handled differently)

🔹 Example – Adding a UNIQUE Constraint

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);
This ensures that no two employees can have the same email address.

🔹 Example – Adding a FOREIGN KEY Constraint

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers(id);
This enforces referential integrity between orders and customers.

❌ Removing a Constraint
Syntax:


ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
⚠️ Note: Some database systems (like MySQL) may require you to know the system-generated constraint name or use a different syntax (e.g., DROP PRIMARY KEY).

🔹 Example – Dropping a UNIQUE Constraint

ALTER TABLE employees
DROP CONSTRAINT unique_email;
🔹 Removing a NOT NULL Constraint
To remove NOT NULL, you modify the column:



ALTER TABLE employees
MODIFY email VARCHAR(255);  -- In MySQL


ALTER TABLE employees
ALTER COLUMN email DROP NOT NULL;

Action	                   			SQL Command Example
Add constraint	            ALTER TABLE table_name ADD CONSTRAINT constraint_name TYPE (column);
Drop constraint         	ALTER TABLE table_name DROP CONSTRAINT constraint_name;
Remove NOT NULL	            ALTER TABLE table_name ALTER/MODIFY COLUMN column DROP NOT NULL;
*/


/*5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
Ans:
Constraints in SQL (e.g., PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK) are rules applied to table columns to ensure data integrity and validity.

🚫 Consequences of Violating Constraints
If you try to insert, update, or delete data in a way that violates any constraint:

❌ The operation fails.

🛑 The database throws an error.

✅ No partial or invalid data is saved.

🔄 Examples of Constraint Violations
1. Primary Key Violation
Trying to insert a duplicate value in a primary key column:


INSERT INTO students (id, name) VALUES (1, 'Alice');
-- Then again:
INSERT INTO students (id, name) VALUES (1, 'Bob');
Error (PostgreSQL):


ERROR: duplicate key value violates unique constraint "students_pkey"
DETAIL: Key (id)=(1) already exists.
2. NOT NULL Violation
Trying to insert NULL into a column that doesn’t allow it:


INSERT INTO employees (name, email) VALUES ('John', NULL);
Error (MySQL):


ERROR 1048 (23000): Column 'email' cannot be null
3. Foreign Key Violation
Inserting a value that doesn't exist in the referenced table:


-- Assuming there's no customer with id 99
INSERT INTO orders (order_id, customer_id) VALUES (101, 99);
Error (SQL Server):


The INSERT statement conflicted with the FOREIGN KEY constraint "fk_customer".
The conflict occurred in database "shop", table "customers", column 'id'.
4. CHECK Constraint Violation
Trying to insert a value that fails a custom rule:


-- Suppose age must be >= 18
INSERT INTO users (name, age) VALUES ('Tom', 15);
Error (Oracle):


ORA-02290: check constraint (USERS_AGE_CHECK) violated

*/

/*Q 6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00
*/
CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));

select *from products;

alter table products
modify product_id int primary key;
alter table products modify
price decimal(10,2) default 50.00;

/*Q7 You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
Ans:*/
select students.student_name , classes.class_name
from students inner join classes on students.class_id = classes.class_id;

/*Q8. Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN)*/

select orders.order_id, customers.customer_name, products.product_name from 
 ((orders left join customers on orders.customer_id = customers.customer_id)
 orders left join products on orders.order_id = products.order_id);
 
 /*Q25 Given the following tables:
 Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/
 
 select sum(sales.amount) , products.product_id
 from sales inner join products on sales.product_id = products.product_id;
 
 /*10. You are given three tables:
 Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.*/

select orders.order_id, customers.customer_name ,count(order_Details.quntity)
from ((orders inner join customers on orders.customer_id = customers.customer_id)
orders inner join order_Details on orders.order_id = order_Details.order_id);


