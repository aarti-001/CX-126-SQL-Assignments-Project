--Assignment 3 (University DataBase Management System) 

--Inorder  to create this system Perform the following task:- 
--Task 1:- 
--1.Create University Database give any University name you want 
--2. Under this University Create four tables and each table should have following three Column named as:- 
--A. College_Table 
--College_ID(PK) 
--College_Name 
--College_Area 
--B. Department_Table 
--Dept_ID(PK) 
--Dept_Name 
--Dept_Facility 
--C. Professor_Table 
--Professor_ID(PK) 
--Professor_Name 
--Professor_Subject 
--D. Student_Table 
--Student_ID(PK) 
--Student_Name 
--Student_Stream 

Create Table  College_Table (College_ID int, College_Name varchar(max), College_Area varchar(max))
select * from College_Table
Create Table  Department_Table (Dept_ID int,Dept_Name varchar(max),Dept_Facility varchar(max))
select * from Department_Table
Create Table Professor_Table (Professor_ID int,Professor_Name varchar(max), Professor_Subject varchar(max))
select * from Professor_Table
Create Table Student_Table (Student_ID int, Student_Name varchar(max), Student_Stream varchar(max))
select * from Student_Table

--3. Apply foreign key on Department key from College_table 
ALTER TABLE Department_Table
ADD College_ID INT; ALTER TABLE Department_Table, ADD CONSTRAINT FK_Department_College FOREIGN KEY (College_ID) REFERENCES College_Table (College_ID);

--4. Apply foreign Key on Student_Table from Professor_Table 
ALTER TABLE Student_Table
ADD CONSTRAINT FK_Student_Professor
FOREIGN KEY (Professor_ID)
REFERENCES Professor_Table (Professor_ID);

--5. Insert atleast 10 Records in each table 
INSERT INTO College_Table (College_ID, College_Name, College_Area) VALUES
(1, 'Engineering College', 'North Campus'),
(2, 'Medical College', 'South Campus'),
(3, 'Management College', 'East Campus'),
(4, 'Science College', 'West Campus'),
(5, 'Law College', 'Central Campus'),
(6, 'Arts College', 'North Campus'),
(7, 'Commerce College', 'South Campus'),
(8, 'IT College', 'East Campus'),
(9, 'Pharmacy College', 'West Campus'),
(10,'Architecture College', 'Central Campus');

INSERT INTO Department_Table (Dept_ID, Dept_Name, Dept_Facility, College_ID) VALUES
(101, 'Computer Science', 'Advanced Labs', 1),
(102, 'Mechanical', 'Workshop', 1),
(103, 'Medicine', 'Hospital', 2),
(104, 'Surgery', 'Operation Theatre', 2),
(105, 'MBA', 'Case Study Rooms', 3),
(106, 'Finance', 'Trading Lab', 3),
(107, 'Physics', 'Research Lab', 4),
(108, 'Chemistry', 'Chemical Lab', 4),
(109, 'Criminal Law', 'Moot Court', 5),
(110, 'Fine Arts', 'Art Studio', 6);

INSERT INTO Professor_Table (Professor_ID, Professor_Name, Professor_Subject) VALUES
(201, 'Dr. Alan Smith', 'Computer Science'),
(202, 'Dr. Robert Brown', 'Mechanical'),
(203, 'Dr. Susan White', 'Medicine'),
(204, 'Dr. James Green', 'Surgery'),
(205, 'Dr. Emily Clark', 'Management'),
(206, 'Dr. David Lewis', 'Finance'),
(207, 'Dr. Sarah Hall', 'Physics'),
(208, 'Dr. Michael Young', 'Chemistry'),
(209, 'Dr. Laura King', 'Law'),
(210, 'Dr. Kevin Scott', 'Fine Arts');


INSERT INTO Student_Table (Student_ID, Student_Name, Student_Stream) VALUES
(301, 'Amit Sharma', 'Computer Science'),
(302, 'Neha Verma', 'Mechanical'),
(303, 'Rahul Mehta', 'Medicine'),
(304, 'Pooja Singh', 'Surgery'),
(305, 'Karan Patel', 'MBA'),
(306, 'Sneha Iyer', 'Finance'),
(307, 'Rohit Gupta', 'Physics'),
(308, 'Anjali Nair', 'Chemistry'),
(309, 'Vikram Rao', 'Law'),
(310, 'Meera Joshi', 'Fine Arts');


--Task 2:- 
--1. Give the information of College_ID and College_name from College_Table 
SELECT College_ID, College_Name
FROM College_Table;

--2. Show  Top 5 rows from Student table.
SELECT TOP 5 *
FROM Student_Table;

--3. What is the name of  professor  whose ID  is 5 
SELECT Professor_Name
FROM Professor_Table
WHERE Professor_ID = 5;

--4. Convert the name of the Professor into Upper case  
SELECT Professor_ID,
       UPPER(Professor_Name) AS Professor_Name_Upper
FROM Professor_Table;

--5. Show me the names of those students whose name is start with a 
SELECT Student_Name
FROM Student_Table
WHERE Student_Name LIKE 'A%';

--6. Give the name of those colleges whose end with a 
SELECT Student_Name
FROM Student_Table
WHERE Student_Name LIKE '%A';


--7.  Add one Salary Column in Professor_Table 
ALTER TABLE Professor_Table
ADD Salary DECIMAL(10,2);
select * from Professor_Table
UPDATE Professor_Table
SET Salary = 75000
WHERE Professor_ID = 201

--8. Add one Contact Column in Student_table 
ALTER TABLE Student_Table
ADD Salary int;

--9. Find the total Salary of Professor  
Select SUM(Salary) 'Total Salary' from Professor_Table

--10. Change datatype of any one column of any one Table
ALTER TABLE Student_Table
ALTER COLUMN Student_Name VARCHAR(150);

--Task 3:- 

--1. Show first 5 records from Students table and Professor table Combine 
not done
SELECT 
    s.Student_ID,
    s.Student_Name,
    p.Professor_Name
FROM Student_Table s
JOIN Professor_Table p
  ON s.Professor_ID = p.Professor_ID
ORDER BY s.Student_ID
LIMIT 5

--2. Apply Inner join on all 4 tables together(Syntax  is mandatory) 
not done
SELECT College_Table.College_ID,College_Table.College_Name,
    d.Dept_ID,
    d.Dept_Name,
    p.Professor_ID,
    p.Professor_Name,
    s.Student_ID,
    s.Student_Name,
    s.Student_Stream
FROM College_Table c
INNER JOIN Department_Table d
    ON c.College_ID = d.College_ID
INNER JOIN Professor_Table p
    ON p.Professor_Subject = d.Dept_Name
INNER JOIN Student_Table s
    ON s.Professor_ID = p.Professor_ID;


--3. Show Some null values from Department table and Professor table. 
-- Department NULL values
SELECT Dept_ID, Dept_Name, Dept_Facility
FROM Department_Table
WHERE Dept_Facility IS NULL;

-- Professor NULL values
SELECT Professor_ID, Professor_Name, Professor_Subject
FROM Professor_Table
WHERE Professor_Subject IS NULL;

--4. Create a View from College Table  and give those records whose college name starts with C 
CREATE VIEW College_C_View AS
SELECT College_ID, College_Name, College_Area
FROM College_Table
WHERE College_Name LIKE 'C%';
Select * from College_Table


--5. Create Stored Procedure  of Professor table whatever customer ID will be given by user it should show whole records of it.CREATE PROCEDURE Get_Professor_Details
CREATE PROCEDURE Get_Professor_Details_Safe
    @Professor_ID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Professor_Table WHERE Professor_ID = @Professor_ID)
        SELECT * FROM Professor_Table WHERE Professor_ID = @Professor_ID;
    ELSE
        PRINT 'Professor ID not found';
END;

--6. Rename the College_Table to College_Tables_Data .
EXEC sp_rename 'College_Table', 'College_Tables_Data';

