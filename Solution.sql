CREATE TABLE Employee
(
    Emp_Id  NUMBER(1000) NOT NULL PRIMARY KEY,
    Name CHAR(40),
    Department CHAR(60),
    Grade NUMBER(100),
    Salary NUMBER(1000000),
    Gender CHAR(1)
)

CREATE TABLE Student
(
    Student_Id  NUMBER(1000) NOT NULL,
    Class_Teacher_Employee_Id NUMBER(1000) NOT NULL,
    Subject1 CHAR(2),
    Subject2 CHAR(2),
    Subject3 CHAR(2),
    PRIMARY KEY(Student_Id),
    FOREIGN KEY (Class_Teacher_Employee_Id) REFERENCES Employee(Emp_Id)
)


INSERT INTO Employee VALUES (1,'Robert','Computer Science',100,100000,'M');
INSERT INTO Employee VALUES (2,'Ram','Information Technology',101,134000,'M');
INSERT INTO Employee VALUES (3,'Alex','Computer Science',200,123456,'M');
INSERT INTO Employee VALUES (4,'Radha','Information Technology',201,23456,'F');
INSERT INTO Employee VALUES (5,'Santhi','Civil',300,234567,'F');
INSERT INTO Employee VALUES (6,'Madavi','BioTech',301,234567,'F');

INSERT INTO Student VALUES (1,1,'P','P','F');
INSERT INTO Student VALUES (2,1,'P','F','P');
INSERT INTO Student VALUES (3,2,'P','P','P');
INSERT INTO Student VALUES (4,3,'F','F','F');
INSERT INTO Student VALUES (5,4,'P','P','P');
INSERT INTO Student VALUES (6,5,'P','P','F');
INSERT INTO Student VALUES (7,4,'P','P','P');
INSERT INTO Student VALUES (8,5,'P','P','P');
INSERT INTO Student VALUES (9,4,'P','P','P');
INSERT INTO Student VALUES (10,3,'F','F','F');

/*Write a query to fetch Employee name whose grade greater than 200.*/

SELECT E.Name
FROM Employee E
WHERE E.Grade > 200 

/*Write a query to fetch the department name where only male staff available.*/

SELECT E.department
FROM Employee E
WHERE E.Gender = 'M'

/*Write a query to fetch the second highest salaried employer.*/

select *from Employee 
group by Salary 
order by  Salary desc limit 1,1;

/*Write a query to fetch the employ details who did not assigned with any students.*/

SELECT * FROM Employee E
WHERE
 NOT EXISTS (SELECT * FROM Student S WHERE S.Class_Teacher_Employee_Id = E.Emp_Id)

/*Write a query to fetch the student who passed in all three subjects.*/

SELECT S.Student_Id FROM Student S
WHERE (
    S.Subject1 = 'P' AND
    S.Subject2 = 'P' AND
    S.Subject3 = 'P'
)

/*Write a query to fetch the top employee details where all of his students passed in the subjects.*/

SELECT E.Emp_Id,E.Name,E.Department, E.Grade,E.Salary,E.Gender FROM(
  SELECT Class_Teacher_Employee_Id,COunt(*) AS Freq FROM (
    	SELECT S.Class_Teacher_Employee_Id FROM Student S
			WHERE (
   				S.Subject1 = 'P' AND
    			S.Subject2 = 'P' AND
    			S.Subject3 = 'P'
			) 
  		) 
  	GROUP BY Class_Teacher_Employee_Id ORDER BY COUNT(*) DESC LIMIT 1
	) N, Employee E
    WHERE N.Class_Teacher_Employee_Id = E.emp_id