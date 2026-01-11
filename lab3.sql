--	Part – A 
--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
         CREATE OR ALTER PROCEDURE PR_DATE_FACULTY
         @DATE DATE
         AS
         BEGIN 
            SELECT * FROM FACULTY
            WHERE FacultyJoiningDate=@DATE
         END
         EXEC PR_DATE_FACULTY '2010-7-15'
            SELECT * FROM FACULTY
--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
           CREATE OR ALTER PROCEDURE PR_ENROOMENT
           @SID INT =NULL,
           @CID VARCHAR(10) =NULL
           AS 
           BEGIN
              SELECT *
              FROM Enrollment
              WHERE StudentId=@SID OR CourseId=@cid
          END
          EXEC PR_ENROOMENT 2
            EXEC PR_ENROOMENT @CID="IT101"

          GO
--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
             CREATE OR ALTER PROCEDURE PR_COURSE
             @MIN INT,
             @MAX INT
             AS
             BEGIN
                 SELECT * FROM COURSE
                 WHERE CourseCredits BETWEEN @MIN AND @MAX
            END
            EXEC PR_COURSE 2,5

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
         CREATE OR ALTER PROCEDURE PR_COURSENAME
         @CNAME VARCHAR(100)
         AS
         BEGIN
               SELECT StuName,CourseName FROM STUDENT
              JOIN Enrollment
               ON STUDENT.StudentId=Enrollment.StudentId
               JOIN COURSE
               ON COURSE.CourseId=Enrollment.CourseId
               WHERE CourseName=@CNAME
        END
        EXEC PR_COURSENAME 'Data Structures'



--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
      CREATE OR ALTER PROCEDURE PR_FACULTYNAME
      @FNAME VARCHAR(10)
      AS
        BEGIN
          SELECT * FROM COURSE_Assignment
         LEFT OUTER JOIN FACULTY
           ON FACULTY.FacultyID=COURSE_Assignment.FacultyId
           WHERE FacultyName=@FNAME
       END
       EXEC PR_FACULTYNAME "Dr. Patel"



--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
          CREATE OR ALTER PROCEDURE  PR_SEMESTERR
            @SEM INT ,
            @YEAR INT
            AS 
            BEGIN
             SELECT FacultyName,Course_Assignment.ClassRoom FROM COURSE_Assignment
           JOIN FACULTY
           ON FACULTY.FacultyID=COURSE_Assignment.FacultyId
           WHERE Semester=@SEM AND Year=@YEAR
       END
       EXEC PR_SEMESTERR 1,2024
 
----Part – B 
--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
       CREATE OR ALTER PROCEDURE PR_LETTER
       @LETTER char(1)
       AS
         BEGIN
         SELECT * FROM Enrollment
         WHERE  EnrollmentStatus like @LETTER+'%'
         END
      EXEC PR_LETTER "A"
--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
       CREATE OR ALTER PROCEDURE PR_depname
       @SNAME VARCHAR(10) =NULL,
       @DPNAME VARCHAR(10) =NULL
       AS
       BEGIN
         SELECT * FROM STUDENT
         WHERE StuName=@SNAME OR StuDepartment =@DPNAME
           
     END
     EXEC PR_depname  "Priya Shah","CSE"

--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
       CREATE OR ALTER PROCEDURE PR_ENROLLMENT
       @CID VARCHAR(20),
       @COUNT INT OUT
       AS
        BEGIN
         SELECT  @COUNT=COUNT(*)
          FROM Enrollment 
          WHERE CourseId=@CID
          GROUP BY EnrollmentStatus
       END
          DECLARE @COUNT_COUNT INT
          EXEC PR_ENROLLMENT "CS101",@COUNT=@COUNT_COUNT OUT
          SELECT @COUNT_COUNT
--Part – C 
--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
        CREATE OR ALTER PROCEDURE PR_CORSEASSIGN
       @YEAR INT 
        AS
        BEGIN
          SELECT FacultyName,ClassRoom FROM COURSE_Assignment
           JOIN FACULTY
           ON FACULTY.FacultyID=COURSE_Assignment.FacultyId
           WHERE Year=@YEAR
           END 

  EXEC PR_CORSEASSIGN "2024"
--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
CREATE OR ALTER PROCEDURE PR_CORSEASSIGN
       @FROMDATE  DATE  ,
       @TODATE DATE 
       AS
        BEGIN
          SELECT  EnrollmentId,EnrollmentDate,EnrollmentStatus,StuEnrollmentYear FROM Enrollment
           JOIN STUDENT
           ON  STUDENT.StudentId=Enrollment.StudentId
           JOIN COURSE
           ON COURSE.CourseId=Enrollment.CourseId
           WHERE EnrollmentDate BETWEEN @FROMDATE AND @TODATE
           END 

  EXEC PR_CORSEASSIGN "2021-1-5" ,"2021-7-1"
--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
   CREATE OR ALTER PROCEDURE PR_FACULTY
   @FID INT
   AS
     BEGIN
     SELECT  SUM(CourseCredits) FROM FACULTY
       JOIN COURSE_Assignment
       ON COURSE_Assignment.FacultyId=FACULTY.FacultyID
       JOIN COURSE
       ON COURSE.CourseId=COURSE_Assignment.CourseId
   END
       EXEC PR_FACULTY 101

