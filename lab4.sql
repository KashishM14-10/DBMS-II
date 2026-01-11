----Part-A
----1.
----Write a scalar function to print "Welcome to DBMS Lab".
         CREATE OR ALTER FUNCTION FN_WELCOME()
         RETURNS VARCHAR(50)
         AS
         BEGIN
           RETURN 'Welcome to DBMS Lab'
           END
         SELECT dbo.FN_WELCOME()
         
     
----2.
----Write a scalar function to calculate simple interest.
       CREATE OR ALTER FUNCTION FN_SI
       (@P FLOAT,
       @R FLOAT,
       @T FLOAT)
       RETURNS FLOAT
         AS BEGIN
              DECLARE @SI FLOAT
              SET @SI=(@P*@R*@T)/100;
              RETURN @SI
         END;

         SELECT dbo.FN_SI(500,2,3)




----3.
----Function to Get Difference in Days Between Two Given Dates
      CREATE OR ALTER FUNCTION FN_DAY
      (@D1 DATE,
       @D2 DATE)
       RETURNS INT
       AS
       BEGIN
                     
           RETURN  DATEDIFF(DAY,@D1,@D2)
       END

         SELECT dbo.FN_DAY('2005-1-1','2005-1-31')

----4.
----Write a scalar function which returns the sum of Credits for two given CourseIDs.
          CREATE OR ALTER FUNCTION FN_SUM
          (@CID1 VARCHAR(10),
          @CID2 VARCHAR(10))
          RETURNS INT
          AS
          BEGIN
             DECLARE @SUM INT =0
             SELECT SUM(CourseCredits)
             FROM COURSE
             WHERE CourseId IN (@CID1,@CID2)
             RETURN @SUM
       END
                SELECT dbo.FN_SUM('CS101','C201')

----5.
----Write a function to check whether the given number is ODD or EVEN.
       CREATE OR ALTER FUNCTION FN_ODD_EVEN
       (@N INT)
       RETURNS VARCHAR(50)
       AS BEGIN
             DECLARE @MSG VARCHAR(50)
             IF @N%2=0
             SET @MSG='EVEN'
             ELSE
             SET @MSG ='ODD'
             RETURN @MSG
        END
                SELECT dbo.FN_ODD_EVEN(5)

----6.
----Write a function to print number from 1 to N. (Using while loop)
 CREATE OR ALTER FUNCTION FN_1TON
       (@N INT)
       RETURNS VARCHAR(50)
       AS BEGIN
             DECLARE @MSG VARCHAR(50),@COUNT INT
             SET @MSG=''
             SET @COUNT=1
              WHILE (@COUNT<=@N)
               BEGIN
                SET @MSG=@MSG+' '+CAST(@COUNT AS varchar)
                SET @COUNT=@COUNT+1
                END
                
             RETURN @MSG
        END
        SELECT dbo.FN_1TON(5)
----7.
----Write a scalar function to calculate factorial of total credits for a given CourseID.
CREATE OR ALTER FUNCTION FN_FACTORIAL
(
    @CID VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @CREDIT INT,
            @FACT INT,
            @I INT;

    SET @FACT = 1;
    SET @I = 1;

    SELECT @CREDIT = CourseCredits
    FROM COURSE
    WHERE CourseId = @CID;

    WHILE (@I <= @CREDIT)
    BEGIN
        SET @FACT = @FACT * @I;
        SET @I = @I + 1;
    END

    RETURN @FACT;
END;


        SELECT dbo.FN_FACTORIAL('CS101')
          
----8.
----Write a scalar function to check whether a given EnrollmentYear is in the past,
     --current or future (Case statement)
     CREATE OR ALTER FUNCTION FN_ENROLLMENTYEAR(@YEAR INT)
     RETURNS VARCHAR(50)
     AS
     BEGIN
         RETURN CASE
             WHEN @YEAR<YEAR(GETDATE()) THEN 'PAST'
              WHEN @YEAR>YEAR(GETDATE()) THEN 'FURURE'
              ELSE 'PRESENT'
              END
               END
              

        SELECT dbo.FN_ENROLLMENTYEAR(2025)

----9.
----Write a table-valued function that returns details of students whose names start with a given letter.
       CREATE OR ALTER FUNCTION FN_NAME(
         @LETTER CHAR(1))
         RETURNS TABLE
         AS
          RETURN(SELECT * FROM STUDENT
          WHERE StuName LIKE @LETTER +'%')

          SELECT * FROM dbo.FN_NAME('p')


----10.
----Write a table-valued function that returns unique department names from the STUDENT table
       CREATE OR ALTER FUNCTION fn_dept()
          RETURNS TABLE
         AS
          RETURN(SELECT DISTINCT StuDepartment  FROM STUDENT)

           SELECT * FROM dbo.fn_dept()

--Part-B
--11.
--Write a scalar function that calculates age in years given a DateOfBirth.
           CREATE OR ALTER FUNCTION FN_AGE
           (
           @DOB DATE)
           RETURNS INT
           AS BEGIN
              RETURN  DATEDIFF(YEAR,@DOB,GETDATE())
              END
           SELECT  dbo.FN_AGE('2006-10-15')

--12.
--Write a scalar function to check whether given number is palindrome or not.
     CREATE OR ALTER FUNCTION FN_PALINDROME
           (
           @N INT)
           RETURNS VARCHAR(50)
           AS BEGIN
            DECLARE @REV INT
            SET @REV=REVERSE(@N)
            IF (@REV=@N)
                RETURN 'PALINDROME'
            RETURN 'NOT PALINDROME'
END
SELECT dbo.FN_PALINDROME(121)

               END
           SELECT  dbo.FN_AGE('2006-10-15')
--13.
--Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department.@
   CREATE OR ALTER FUNCTION FN_CREDITSUM()
   RETURNS INT
   AS
   BEGIN
       DECLARE @CREDIT INT
       SELECT @CREDIT=SUM(CourseCredits)
       FROM COURSE
       WHERE CourseDepartment='CSE'
       RETURN @CREDIT
       END
           SELECT  dbo.FN_CREDITSUM()

--14.
--Write a table-valued function that returns all courses taught by faculty with a specific designation.
CREATE FUNCTION FN_COURSES_BY_DESIGNATION
(
    @Designation VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        C.CourseID,
        C.CourseName,
        F.FacultyName,
        F.FacultyDesignation
    FROM FACULTY F
    JOIN COURSE_ASSIGNMENT CA
        ON F.FacultyID = CA.FacultyID
    JOIN COURSE C
        ON CA.CourseID = C.CourseID
    WHERE F.FacultyDesignation = @Designation
);

SELECT * FROM dbo.FN_COURSES_BY_DESIGNATION('Assistant Prof')

--Part - C
--15.
--Write a scalar function that accepts StudentID and returns their total enrolled credits 
--(sum of credits from all active enrollments).
CREATE FUNCTION FN_ACTIVE
(
    @StudentID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCredits INT;

    SELECT @TotalCredits = SUM(C.CourseCredits)
    FROM ENROLLMENT E
    JOIN COURSE C
        ON E.CourseID = C.CourseID
    WHERE E.StudentID = @StudentID
      AND E.EnrollmentStatus = 'Active';

    RETURN @TotalCredits
END;
select dbo.FN_ACTIVE(1)
--16.
--Write a scalar function that accepts two dates (joining date range) and returns the 
--count of faculty who joined in that period.

CREATE FUNCTION FN_FACULTY_COUNT
(
    @StartDate DATE,
    @EndDate   DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @FacultyCount INT;

    SELECT @FacultyCount = COUNT(*)
    FROM FACULTY
    WHERE FacultyJoiningDate BETWEEN @StartDate AND @EndDate;

    RETURN @FacultyCount;
END;
SELECT dbo.FN_FACULTY_COUNT(
    CAST('2008-10-15' AS DATE),
    CAST('2015-6-10' AS DATE)
);
