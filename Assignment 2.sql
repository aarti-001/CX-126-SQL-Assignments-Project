----Solve the Below Questions 

----Basics and Intermediate Questions  
---PART-1
---We have two table EmployeeDetails and Employee Salary Table  EXECUTE  the CREATE Query and Insert the Given records in the particular table in your  SQL  Editor.
Create Table EmployeeDetails (Empid int, FullName varchar(max), ManagerId INT, DateOfJoining DATE, City VARCHAR(max))

Create Table EmployeeSalary (Empid int, Project varchar(max),Salary DECIMAL(10, 2), Variable DECIMAL(10, 2)) 

 Select * from EmployeeSalary 

insert into EmployeeDetails values (101, 'Alice Johnson', 321, '2022-05-15', 'New York'),(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'),(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'),(104, 'David Williams', 876, '2019-11-05', 'Houston'),(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'),(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'),(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'),(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'),(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'),(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'),(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'),(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'),(113, 'Mia White', 876, '2019-06-03', 'Columbus'),(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'),(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'),(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'),(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'),(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'),(119, 'Steve Clark', 876, '2021-03-19', 'Washington'),(120, 'Tina Lewis', 321, '2019-08-31', 'Boston')
insert into EmployeeSalary values (101, 'P1', 7500, 500), (102, 'P2', 9200, 700),(103, 'P1', 6700, 600), (104, 'P3', 8300, 900),(105, 'P2', 7800, 800),(106, 'P3', 9100, 1000),(107, 'P1', 6200, 400), (108, 'P2', 8800, 750), (109, 'P3', 9500, 1100), (110, 'P1', 7200, 650),(111, 'P2', 8700, 850), (112, 'P3', 9300, 1200),(113, 'P1', 7900, 550),(114, 'P2', 6800, 450),(115, 'P3', 8400, 900),(116, 'P1', 7600, 500),(117, 'P2', 8900, 1000),(118, 'P3', 9200, 1100),(119, 'P1', 8100, 600),(120, 'P2', 8300, 750)

--Solve the Below Questions  
--Basics and Intermediate Questions  
--PART-1
---Q1)SQL Query to fetch records that are present in one table but not in another table.
Select EmployeeDetails.Empid, EmployeeDetails.FullName,EmployeeSalary .Project,EmployeeSalary.Salary from EmployeeDetails
left join EmployeeSalary
on EmployeeDetails.Empid =EmployeeSalary.Empid


---Q2)SQL query to fetch all the employees who are not working on any project.
Select EmployeeDetails.Empid, EmployeeDetails.FullName,EmployeeSalary .Project,EmployeeSalary.Salary, EmployeeSalary.Variable from EmployeeDetails
left join EmployeeSalary
on EmployeeDetails.Empid =EmployeeSalary.Empid

 
 ---Q3)SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020. 
 Select * from EmployeeDetails where YEAR() 2020

---Q4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
Select EmployeeDetails.Empid, EmployeeDetails.FullName,EmployeeSalary.Empid, EmployeeSalary.Salary from EmployeeDetails
inner join EmployeeSalary
on EmployeeDetails.EmpID =EmployeeSalary.Empid


---Q5)Write an SQL query to fetch a project-wise count of employees.
Select Project, Count(Project) 'Project wise count ' from EmployeeSalary
Group by Project

---Q6)Fetch employee names and salaries even if the salary value is not present for the employee.
Select EmployeeDetails.Empid, EmployeeDetails.FullName,EmployeeSalary .Project,EmployeeSalary.Salary from EmployeeDetails
left join EmployeeSalary
on EmployeeDetails.Empid =EmployeeSalary.Salary

---Q7)Write an SQL query to fetch all the Employees who are also managers.
SELECT DISTINCT EmployeeDetails.Empid, EmployeeDetails.FullName FROM EmployeeDetails eWHERE e.Empid IN (SELECT ManagerId FROM EmployeeDetails WHERE ManagerId IS NOT NULL);


----Q8)Write an SQL query to fetch duplicate records from EmployeeDetails. 

Select FullName, COUNT(FullName) 'Duplicate Records'from EmployeeDetails
Group by FullName Having COUNT(*) > 1

---Q9)Write an SQL query to fetch only odd rows from the table. 
SELECT *
FROM (
    SELECT 
        e.*,
        ROW_NUMBER() OVER (ORDER BY Empid) AS rn
    FROM EmployeeDetails e) t
WHERE rn % 2 = 1;

---Q10)Write a query to find the 3rd highest salary from a table without top or limit keyword. 
SELECT MAX(Salary) AS Third_Highest_Salary
FROM EmployeeSalary
WHERE Salary < (
    SELECT MAX(Salary)
    FROM EmployeeSalary
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EmployeeSalary));

----PART- 2 

--Ques.1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – „986‟. 
Select * from EmployeeDetails where ManagerId=986 

--Ques.2. Write an SQL query to fetch the different projects available from the EmployeeSalary table. 
Select Distinct Project from EmployeeSalary 

--Ques.3. Write an SQL query to fetch the count of employees working in project „P1‟. 
SELECT COUNT(*) AS noofproject
FROM EmployeeSalary
WHERE Project = 'P1'

--Ques.4. Write an SQL query to find the maximum, minimum, and average salary of the employees. 
Select AVG(Salary) 'Average Salary' from EmployeeSalary
Select Max(Salary) 'Max Salary' from EmployeeSalary
Select Min(Salary) 'Min Salary' from EmployeeSalary

--Ques.5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000. 
Select * from EmployeeSalary where Salary between 9000 and 15000

--Ques.6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321. 
Select * from EmployeeDetails where City='Toronto' and ManagerId=321

--Ques.7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321. 
Select * from EmployeeDetails where City='California' or ManagerId=321

--Ques.8. Write an SQL query to fetch all those employees who work on Projects other than P1. 
Select * from EmployeeSalary where Project not in ('P1')

--Ques.9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value. 
Select *,(Salary + Variable )'Toatl Salary' from EmployeeSalary

--Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.
Select * from EmployeeDetails where FullName like '%hn%'

--PART 3 
---1. Fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’:
SELECT Empid FROM EmployeeDetails
UNION
SELECT Empid FROM EmployeeSalary

 --2.Fetch common records between two tables:
 SELECT EmployeeDetails.Empid,EmployeeDetails.FullName,EmployeeDetails.ManagerId,EmployeeDetails.DateOfJoining,EmployeeDetails.City,EmployeeSalary.Project,EmployeeSalary.Salary, EmployeeSalary.Variable
FROM EmployeeDetails INNER JOIN EmployeeSalary ON EmployeeDetails.Empid = EmployeeSalary.Empid

---3.Fetch records that are present in one table but not in another table: 
SELECT EmployeeSalary.Empid,EmployeeDetails.FullName,EmployeeDetails.ManagerId,EmployeeDetails.DateOfJoining,EmployeeDetails.City
FROM EmployeeDetails LEFT JOIN EmployeeSalary ON EmployeeDetails.Empid = EmployeeSalary.Empid
WHERE EmployeeDetails.City is NULL

--4.Fetch the EmpIds that are present in both the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’: 
SELECT EmployeeDetails.Empid,EmployeeDetails.FullName,EmployeeDetails.ManagerId,EmployeeDetails.DateOfJoining,EmployeeDetails.City,EmployeeSalary.Project,EmployeeSalary.Salary, EmployeeSalary.Variable
FROM EmployeeDetails INNER JOIN EmployeeSalary ON EmployeeDetails.Empid = EmployeeSalary.Empid

--5.Fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary: 
SELECT EmployeeDetails.Empid,EmployeeDetails.FullName,EmployeeDetails.ManagerId,EmployeeDetails.DateOfJoining,EmployeeDetails.City
FROM EmployeeDetails LEFT JOIN EmployeeSalary ON EmployeeDetails.Empid = EmployeeSalary.Empid
WHERE EmployeeSalary.Empid is NULL

--6.Fetch the employee’s full names and replace the space: 
Use the REPLACE() function to substitute spaces with another character. 

--7. Fetch the position of a given character(s) in a field: 
SELECT 
    Empid,
    FullName,
    CHARINDEX('n', FullName) AS char_position
FROM EmployeeDetails;

--8. Display both the EmpId and ManagerId together: 
Select *, CONCAT(ManagerId,'-',Empid) 'Remark' from EmployeeDetails

--9. Fetch only the first name (string before space) from the FullName column: 
Select *, Len(FullName) 'Length', CHARINDEX(' ',FullName,1) '1stSpace',
Left(Fullname,CHARINDEX(' ',Fullname,1)-1) 'FirstName'
from EmployeeDetails

--10. Uppercase the name of the employee and lowercase the city values: 
Select UPPER(FullName) 'NameofEmployee' from EmployeeDetails
Select Lower(City) 'City' from EmployeeDetails

Select * from EmployeeSalary
Select * from EmployeeDetails

--PART 4 
--1. Find the count of the total occurrences of a particular character – ‘n’ in the FullName field: 
SELECT SUM(LENGTH(LOWER(FullName)), LENGTH(REPLACE(LOWER(FullName), 'n', ''))) AS total_n_count FROM EmployeeDetails;
SELECT Empid,FullName,(LENGTH(LOWER(FullName)) - LENGTH(REPLACE(LOWER(FullName),'n',''))) AS n_count FROM EmployeeDetails;


--2. Update the employee names by removing leading and trailing spaces: 
UPDATE EmployeeDetails SET FullName = TRIM(FullName)
Select * from EmployeeDetails

--3. Fetch all the employees who are not working on any project:
SELECT e.Empid, e.FullName
FROM EmployeeDetails e
LEFT JOIN EmployeeSalary s
  ON e.Empid = s.Empid
WHERE s.Empid IS NULL


--o Use a LEFT JOIN with a NULL check in the Project column.
SELECT EmployeeDetails.Empid,EmployeeDetails.FullName,EmployeeDetails.ManagerId,EmployeeDetails.DateOfJoining,EmployeeDetails.City
FROM EmployeeDetails LEFT JOIN EmployeeSalary ON EmployeeDetails.Empid = EmployeeSalary.Empid
WHERE EmployeeSalary.Project is NULL


--4. Fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000: 
Select * from EmployeeSalary where Salary between 5000 and 10000

--5. Find the current date-time: 
SELECT GETDATE();

--6. Fetch all Employee details from the EmployeeDetails table who joined in the Year 2020: 
SELECT *FROM EmployeeDetails WHERE YEAR(DateOfjoining) = 2020;

--7. Fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table: 
SELECT e.* FROM EmployeeDetails e INNER JOIN EmployeeSalary s ON e.Empid = s.Empid;

--8. Fetch the project-wise count of employees sorted by project’s count in descending order: 
SELECT Project, COUNT(Project) 'No. of Project' from EmployeeSalary group by Project order by COUNT(Project) DESC;

--9. Fetch employee names and salary records. Display the employee details even if the salary record is not present: 
SELECT e.Empid,e.FullName,s.Project,s.Salary,s.Variable FROM EmployeeDetails e LEFT JOIN EmployeeSalary s ON e.Empid = s.Empid;


--10. Write an SQL query to join 3 tables: 
SELECT e.Empid,e.FullName,
    e.ManagerId,
    s.Project,
    s.Salary
FROM EmployeeDetails e
LEFT JOIN EmployeeSalary s
    ON e.Empid = s.Empid
LEFT JOIN EmployeeDetails m
    ON e.ManagerId = m.ManagerId;

