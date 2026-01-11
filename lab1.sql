INSERT INTO COURSE (CourseID,CourseName,CourseCredits,CourseDepartment,CourseSemester)
VALUES
('CS101','Programming Fundamentals',4,'CSE',1),
('CS201','Data Structures',4,'CSE',3),
('CS301','Database Management Systems',4,'CSE',5),
('IT101','Web Technologies',3,'IT',1),
('IT201','Software Engineering',4,'IT',3),
('EC101','Digital Electronics',3,'ECE',1),
('EC201','Microprocessors',4,'ECE',3),
('ME101','Engineering Mechanics',4,'MECH',1),
('CS202','Operating Systems',4,'CSE',4),
('CS302','Artificial Intelligence',3,'CSE',6);
select * from COURSE

INSERT INTO FACULTY (FacultyID,FacultyName,FacultyEmail,FacultyDepartment,FacultyDesignation,FacultyJoiningDate)
VALUES
(101,'Dr. Sheth','Sheth@univ.edu','CSE','Professor','2010-07-15'),
(102,'Prof. Gupta','gupta@univ.edu','IT','Associate Prof','2012-08-20'),
(103,'Dr. Patel','patel@univ.edu','CSE','Assistant Prof','2015-06-10'),
(104,'Dr. Singh','singh@univ.edu','ECE','Professor','2008-03-25'),
(105,'Prof. Reddy','reddy@univ.edu','IT','Assistant Prof','2018-01-15'),
(106,'Dr. Iyer','iyer@univ.edu','MECH','Associate Prof','2013-09-05'),
(107,'Prof. Nair','nair@univ.edu','CSE','Assistant Prof','2019-07-20');

select * from faculty

INSERT INTO ENROLLMENT (StudentID,CourseID,EnrollmentDate,Grade,EnrollmentStatus)
VALUES
(1,'CS101','2021-07-01','A','Completed'),
(1,'CS201','2022-01-05','B+','Completed'),
(1,'CS301','2023-07-01',NULL,'Active'),
(2,'IT101','2020-07-01','A','Completed'),
(2,'IT201','2021-07-01','A-','Completed'),
(3,'CS101','2021-07-01','B','Completed'),
(3,'CS201','2022-01-05','A','Completed'),
(4,'EC101','2022-07-01','B+','Completed'),
(5,'IT101','2021-07-01','A','Completed'),
(6,'CS201','2021-01-05','A','Completed'),
(1,'CS302','2023-07-01',NULL,'Active'),
(2,'IT201','2022-01-05',NULL,'Dropped');

select * from Enrollment

INSERT INTO COURSE_ASSIGNMENT (CourseID,FacultyID,Semester,Year,ClassRoom)
VALUES
('CS101',103,1,2024,'A-301'),
('CS201',101,3,2024,'B-205'),
('CS301',101,5,2024,'A-401'),
('IT101',102,1,2024,'C-102'),
('IT201',105,3,2024,'C-205'),
('EC101',104,1,2024,'D-101'),
('EC201',104,3,2024,'D-203'),
('ME101',106,1,2024,'E-101'),
('CS202',107,4,2024,'A-305'),
('CS302',101,6,2024,'B-401');

select * from student

--Part – A 
--1.	Retrieve all unique departments from the STUDENT table.
          select distinct StuDepartment
          from STUDENT
--2.	Insert a new student record into the STUDENT table.
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
         Insert Into STUDENT Values
        (9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
        UPDATE STUDENT
        SET StuEmail='raj.p@univ.edu'
        WHERE StuName='Raj Patel'
--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
         ALTER TABLE STUDENT
          ADD CGPA DECIMAL(3,2)
--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
        SELECT CourseName
        from COURSE
        WHERE CourseName LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
         SELECT StuName
        from STUDENT
        WHERE StuName LIKE '%shah%'
--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
         SELECT UPPER(FacultyName)
        from FACULTY
 --8.	Find all faculty who joined after 2015. (FACULTY table)
         SELECT *
        from FACULTY
        where YEAR( FacultyJoiningDate)>'2015'
--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
          SELECT SQRT(CourseCredits)
        from COURSE
        where CourseName='Database Management Systems' 
        select * from course
--10.	Find the Current Date using SQL Server in-built function.
         SELECT GETDATE() as CurrentDateTime     
--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
          select top 3 StuName,StuEnrollmentYear 
          from STUDENT
          order by  StuEnrollmentYear DESC 

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
        SELECT *
       from Enrollment   
        WHERE  YEAR(EnrollmentDate)='2022' 
           
--13.	Find the number of courses offered by each department. (COURSE table)
          SELECT  COUNT(CourseName) as course_name, CourseDepartment 
          from COURSE
          group by CourseDepartment
--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
       SELECT *
       from Enrollment
       join COURSE
       on COURSE.CourseId=Enrollment.CourseId
      GROUP BY COURSE.CourseId
 --15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
        SELECT StuName,EnrollmentStatus
       from STUDENT
        join Enrollment
       on STUDENT.StudentId=Enrollment.StudentId
     
--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
        SELECT StuName,CourseName
       from STUDENT
        join Enrollment
       on STUDENT.StudentId=Enrollment.StudentId
       join COURSE
       on COURSE.CourseId=Enrollment.CourseId

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name.
---(STUDENT, COURSE, ENROLLMENT,  table)
         CREATE VIEW  ActiveEnrollments
          AS 
          SELECT StuName,CourseName
       from STUDENT
        join Enrollment
       on STUDENT.StudentId=Enrollment.StudentId
       join COURSE
       on COURSE.CourseId=Enrollment.CourseId
       WHERE Enrollment.EnrollmentStatus = 'Active';

       SELECT VIEW  ActiveEnrollments
--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
        SELECT StuName
        FROM STUDENT
        WHERE StudentID NOT IN (
        SELECT Enrollment.StudentID
      FROM Enrollment);

--19.	Display course name having second highest credit. (COURSE table)
                SELECT TOP 1 CourseCredits
        FROM (
        SELECT TOP 2 CourseCredits
        FROM COURSE
        ORDER BY CourseCredits DESC
        ) AS T
         ORDER BY CourseCredits;


                              
    
    select   CourseCredits,CourseName 
        from COURSE
        WHERE CourseCredits=(select Max(CourseCredits)
                             from  COURSE
                              where CourseCredits<(select Max(CourseCredits)
                             from   COURSE 
                             where CourseCredits<(select Max(CourseCredits)
                             from   COURSE )))
 
--Part – B 
--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
             SELECT count(e.Studentid) AS TotalStudent,
             c.CourseID,c.CourseName
             FROM COURSE c
             left OUTER join Enrollment e
             on c.CourseId=e.CourseId
             GROUP BY c.CourseId,c.CourseName
         

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)
      SELECT 
    EnrollmentStatus,
    COUNT(*) AS TotalEnrollments
    FROM ENROLLMENT
    GROUP BY EnrollmentStatus
   HAVING COUNT(*) > 2;
     
--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)
    SELECT 
    c.CourseID,
    c.CourseName,
    c.CourseCredits
  FROM COURSE c
   JOIN COURSE_ASSIGNMENT ca 
    ON c.CourseID = ca.CourseID
     JOIN FACULTY f 
    ON ca.FacultyID = f.FacultyID
  WHERE f.FacultyName = 'Dr. Sheth'
  ORDER BY c.CourseCredits;

--Part – C 
--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)
SELECT 
    s.StudentID,
    s.StuName,
    COUNT(e.CourseID) AS TotalCourses
FROM STUDENT s
JOIN ENROLLMENT e
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.StuName
HAVING COUNT(e.CourseID) > 3;

--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)
SELECT StuName
FROM STUDENT
WHERE StudentID IN (
        SELECT StudentID
        FROM ENROLLMENT
        WHERE CourseID = 'CS101'
    )
AND StudentID IN (
        SELECT StudentID
        FROM ENROLLMENT
        WHERE CourseID = 'CS201'
    );

--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)
  SELECT 
    FacultyDepartment AS Department,
    COUNT(*) AS FacultyCount,
    AVG(DATEDIFF(YEAR, FacultyJoiningDate, GETDATE())) AS AvgExperienceYears
FROM FACULTY
GROUP BY FacultyDepartment;



