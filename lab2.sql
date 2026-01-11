--Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
 
--10	Harsh Parmar	harsh@univ.edu	9876543219	CSE	2005-09-18	2023
--11	Om Patel	om@univ.edu	9876543220	IT	2002-08-22	2022
   CREATE OR ALTER PROCEDURE PR_INSERT_STUDENT
   @SID INT,
   @NAME  VARCHAR(100),
   @EMAIL VARCHAR(50),
   @PHONE VARCHAR(15),
   @DEPARTMENT VARCHAR(15),
   @DOB DATE,
   @ENROLLMENTYEAR INT
   AS
   BEGIN  
     INSERT INTO STUDENT (StudentId,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear) VALUES (@SID,@NAME,@EMAIL,@PHONE,@DEPARTMENT,@DOB,@ENROLLMENTYEAR)
   END
   select * from STUDENT
   EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu','9876543219','CSE','2005-09-18',2023
    EXEC PR_INSERT_STUDENT 11,'Om Patel','om@univ.edu','9876543220','IT','2002-08-22',2022

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	Credits	Dept	Semester
--CS330	Computer Networks	4	CSE	5
--EC120	Electronic Circuits	03	ECE	2
  CREATE OR ALTER PROCEDURE PR_INSERT_COURSE
   @COURSEID VARCHAR(10),
   @CourseNAME  VARCHAR(100),
   @CREDITS int,
   @DEPT VARCHAR(15), 
   @SEMESTER INT
   AS
   BEGIN  
   INSERT INTO COURSE (CourseId,CourseName,CourseCredits,CourseDepartment,CourseSemester)
   VALUES (@COURSEID,@CourseNAME,@CREDITS,@DEPT,@SEMESTER)
   END
   SELECT * FROM COURSE

      EXEC PR_INSERT_COURSE  'CS330','Computer Networks',4,'CSE',5
       EXEC PR_INSERT_COURSE  'EC120','Electronic Circuits',3,'ECE',2

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
      CREATE OR ALTER PROCEDURE PR_UPDATE_STUDENT
      @EMAIL VARCHAR(10),
      @PHONE VARCHAR(15),
      @STUID INT
      AS
      BEGIN 
      UPDATE STUDENT
      SET StuEmail=@EMAIL , StuPhone=@PHONE
      WHERE  StudentId=@STUID
      END
      EXEC PR_UPDATE_STUDENT 'rajpatel@univ.edu','9875432131',1 

         SELECT * FROM STUDENT

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
            CREATE OR ALTER PROCEDURE PR_DELETE_STUDENT
              AS
              BEGIN 
              SELECT * FROM STUDENT
               WHERE  StuName='OM PATEL'
              END
--5.  SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
          CREATE OR ALTER PROCEDURE PR_SELECT_STUDENT_BY_ID
          @STUID INT
          AS
          BEGIN
                  SELECT * FROM
                  STUDENT
                  WHERE StudentId=@STUID
          END

          EXEC PR_SELECT_STUDENT_BY_ID 2


--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
          CREATE OR ALTER PROCEDURE PR_SELECT_STUDENT_ENROLLMENT
          AS 
          BEGIN
           SELECT TOP 5 StuName,Studentid,StuEnrollmentYear
           FROM STUDENT
           ORDER BY StuEnrollmentYear
           END
           EXEC PR_SELECT_STUDENT_ENROLLMENT

              CREATE OR ALTER PROCEDURE PR_SELECT_STUDENT_ENROLLMENT
              @N INT
              AS 
           BEGIN
               SELECT TOP (@N) *
               FROM STUDENT
               ORDER BY StuEnrollmentYear
           END
           EXEC PR_SELECT_STUDENT_ENROLLMENT 3

--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.
        CREATE OR ALTER PROCEDURE PR_FACULTYCOUNT
        AS 
        BEGIN
             SELECT COUNT(*),FacultyDesignation
            FROM FACULTY
            GROUP BY FacultyDesignation
        END
        EXEC PR_FACULTYCOUNT
        select * from FACULTY
--8.	Create a stored procedure that takes department name as input and returns all students in that department.
       CREATE OR ALTER PROCEDURE PR_INPUT_DEPT
       @DEPT VARCHAR(50)
       AS
       BEGIN
           SELECT * FROM STUDENT
           WHERE StuDepartment=@DEPT

        END
        EXEC PR_INPUT_DEPT 'CSE'
--Part – C 
           SELECT * FROM COURSE

--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
         CREATE OR ALTER PROCEDURE PR_DEPT_CREDIT
         AS
         BEGIN
             SELECT CourseDepartment,MAX(CourseCredits)  AS MAXIMUM,
                    MIN(CourseCredits)  AS MINIMUM,
                    AVG(CourseCredits)  AS AVERAGE
                    FROM COURSE
                    GROUP BY CourseDepartment
         END
         EXEC PR_DEPT_CREDIT
         

         SELECT * FROM Enrollment
--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
       CREATE OR ALTER PROCEDURE PR_STUDENTID_GRADE
       @STUID INT
       AS 
       BEGIN
         SELECT * FROM
         STUDENT
         JOIN Enrollment
         ON STUDENT.StudentId=Enrollment.StudentId
         WHERE STUDENT.StudentId=@STUID
       END
       EXEC  PR_STUDENTID_GRADE 5
