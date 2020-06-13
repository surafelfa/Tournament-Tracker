/* HOW TO MODIFY A NAME*/
CREATE DATABASE sample_1
ALTER DATABASE  sample_1
MODIFY		    name=sample_3 

/* SELECT STATEMENT*/
SELECT s_name + '\t\t\t\t\t' +  Email 
AS     [Student Name and Email ] 
FROM   Student_table 

/*ALTERING A TABLE AND ADDING A COLUMN*/
ALTER TABLE advisor_table
ADD         Aemail VARCHAR(100)

ALTER TABLE advisor_table
DROP COLUMN Aemail

/*HOW TO CHANGE THE DATA TYPE OF A COLUMN*/
ALTER TABLE  Student_table
ALTER COLUMN s_name varchar(30)

--DEFAULT CONSTRAINT
ALTER TABLE		employee
ADD CONSTRAINT	def_age
DEFAULT			18 
FOR			 E_age

--UNIQUE CONSTRAINT
ALTER TABLE    employee
ADD CONSTRAINT unique_name
UNIQUE        (E_name)

--CHECK CONTRAINT
ALTER TABLE    employee
ADD CONSTRAINT  check_age
CHECK          (E_age>=18 and E_age<50)
CHECK		   (E_name in('abebe','bekele')) or NOT IN
--FOREIGN KEY CONSTRAINT
FOREIGN KEY (cid) REFERENCES customer(cid) ON UPDATE CASCADE);
ALTER TABLE People
ADD CONSTRAINT order_s
FOREIGN KEY (ord) REFERENCES orders(oId)

--DISTINCT RENAME THE COLUMN AS DISTINCT SALARY
SELECT DISTINCT * 
FROM			person
SELECT DISTINCT p_age 
AS				[distinct salay] 
FROM			person

-- UPDATING 
UPDATE person
SET    p_age=23, p_salary=5000,p_address='bole'
WHERE  p_id= 4
UPDATE person 
SET    p_age= p_age+1
UPDATE person 
SET    p_salary += 500
WHERE  p_address='bole'

--DELETING
DELETE FROM person
WHERE	    p_id= 4 

--BETWEEN
SELECT  * 
FROM    customer 
WHERE   cname  BETWEEN 'a' AND 'j'

--LIKE
SELECT  * 
FROM    customer 
WHERE   cname LIKE  '_____'

SELECT  * 
FROM    customer 
WHERE   cname LIKE '_l__z%'

SELECT  * 
FROM    customer 
WHERE   cname LIKE  '[a-j]%'
SELECT  * 
FROM    customer 
WHERE   cage  LIKE '[^4-6]%'

--IN
SELECT   * 
FROM     customer 
WHERE    cage  NOT IN (30,31,44,50)

--LEFT,RIGHT,FULL
SELECT  customer.cname,item.item
FROM    customer 
FULL    JOIN item 
ON      customer.itm=item.Iid

--UNION
SELECT  cname AS "All names"
FROM    customer
UNION   ALL
SELECT  item FROM item

--SQL VIEW
CREATE VIEW "OVER 25" AS 
SELECT * FROM employee
WHERE eage>25
SELECT * FROM "OVER 25"
--The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries,
--and common table expressions, unless TOP, OFFSET or FOR XML is also specified.

--AGGREGATE FUNCTION
SELECT * FROM employee
WHERE  ESALARY>(SELECT AVG(ESALARY) FROM employee)

--TOP
--RETURNS THE TOP N ROWA OR THE LAST N ROWS
SELECT TOP 2 *
FROM employee
ORDER BY eid DESC

-- GROUP BY
SELECT ename,SUM(esalary)
FROM employee
GROUP BY ename

SELECT  eaddress "ADDRESS",SUM(esalary)  "TOTAL SUM"
FROM employee
WHERE eage BETWEEN 20 AND 60
GROUP BY eaddress
HAVING SUM(esalary) BETWEEN 2500 AND 7000
ORDER BY SUM(ESALARY) DESC

--USE SET FOR KNOWN VALUES 
DECLARE @m MONEY
SET @m=(SELECT sum(p_salary) FROM person)
PRINT 'total salary ' + CAST(@m AS VARCHAR(20))

--USE SELECT WHEN ASSIGNEMENT OPPERATION IS NEEDED
DECLARE @mun VARCHAR 20)
SELECT @mun= sum(p_salary) FROM Person
PRINT 'total salary = '+CHAR (10)+CHAR(13)+'--------'+CHAR(10) +@mun

--Table Data Type
DECLARE @MyTableVar table
(
FN varchar(50)
, LN varchar(50)
)
INSERT @MyTableVar (FN, LN)
SELECT FirstName , FatherName
FROM Student
--HOW TO PRINT ALL NAMES
DECLARE @y VARCHAR(max)=''
SELECT @y=@y+'  '+p_name FROM  person
PRINT @y

--HOW TO DO MULTIPLICATON
DECLARE @L INT =20,  @W INT=70 
DECLARE @A INT =(@L* @W)/2
PRINT @A 

--CONTROL FLOW STATEMENTS
--BEGIN SIGNIFIES START OF A BLOCK 
DECLARE @input INT =2
IF @input<1 OR @input >10
	PRINT 'BAD INPUT'
ELSE IF @input<5
	BEGIN
		PRINT 'LESS THAN FIVE'
		IF @input<3
			PRINT 'LESS THAN THREE'
	END
ELSE
	PRINT 'GREATER THAN OR EQUAL TO FIVE'

--HOW TO USE CAST IN SELECT STATEMENT
SELECT @employee=@employee+'Full Name :- '+f_name+'  '+l_name+' |   '+'OldSalary:-'
+CAST(salary AS VARCHAR)+' New Salary :- '+CAST((salary-500)AS VARCHAR)+CHAR(10)
FROM Accounting

--EXISTS
IF( EXISTS (SELECT * FROM Accounting WHERE Accounting.s_id=7))
	PRINT'EXISTS'

--NULL
DECLARE @X INT
SELECT @X= s_id FROM Accounting WHERE Accounting.s_id=7
IF(@X IS NULL)
	INSERT INTO Accounting VALUES(7,'Wondosen','Tessema','03/08/2007',3600)
	
--SIMPLE CASE EXPRESSION
DECLARE @x int = 20
PRINT
	CASE @x % 2
		WHEN 0 THEN 'EVEN number'
		WHEN 1 THEN 'ODD number'
	END
--SEARCHED CASE
SELECT f_name  "Full Name", salary,
	CASE
		WHEN salary<2900 THEN 'low'
		WHEN salary>=2900 THEN 'high' 
	END AS 'Salary Satus'
FROM Accounting

--WHILE
DECLARE @even int=0
WHILE(@even<=100)
	BEGIN
	SET @even+=1
	IF(@even%2=0)
		PRINT @even
	IF(@even=50)
		break
	END

--PROCEDURE AND USING CASE WITH PRINT STATEMENT
CREATE PROCEDURE [Above salary]
@salary MONEY
AS
BEGIN
	DECLARE @QUAN INT
	SELECT @QUAN=COUNT(employee.eid)
	FROM employee
	WHERE employee.salary>@salary
	PRINT ''+
	CASE 
		WHEN @QUAN<3 THEN 'FEW'
		ELSE 'A LOT'
	END
END
SP_HELPTEXT [Above salary]

--CURSORS 
--#POINTER DATA TYPE
--#THEY ARE SLOW
--#YOU ARE ALLOWED TO USE THEM INSIDE PROCUDER,FUNCTION
--DECLARE com CURSOR LOCAL SCROLL  FOR  CAN BE DECLARED AS THIS
DECLARE exampleCusor CURSOR LOCAL SCROLL  --FORWARD_ONLY , STATIC| FAST_FORWARD| DYNAMIC|KEYSET 
FOR 
SELECT * FROM Person
OPEN exampleCusor
--FETCH ABSOLUTE 4 FROM exampleCusor   RELATIVE 6
--FETCH FIRST FROM exampleCusor
--FETCH NEXT FROM com INTO @name,@IQ
FETCH LAST FROM exampleCusor
WHILE (@@FETCH_STATUS=0)
FETCH PRIOR FROM exampleCusor
--FETCH RELATIVE 2 FROM exampleCusor
CLOSE exampleCusor
DEALLOCATE exampleCusor

--SCALAR USER DEFINE DATA TYPE
CREATE FUNCTION [ADD](@NO1 INT , @NO2 INT)
RETURNS INT
AS
BEGIN
	DECLARE @SUM INT 
	SET @SUM = @NO1+@NO2
	RETURN @SUM
END

--Inline Table-Valued UDF 
CREATE FUNCTION SearchByNameFun(@CR VARCHAR(MAX))
RETURNS TABLE
--WITH ENCRYPTION,SCHEMABINDING [WE CAN USE THIS AFTER RETURNS TABLE]
RETURN
(
	SELECT*
	FROM Person 
	WHERE name LIKE '%'+@CR+'%'
)
--Multi-Statement Table-Valued UDF
CREATE FUNCTION GetEmpData (@depID INT)
RETURNS @empList TABLE
(
EmployeeID int primary key NOT NULL
, EmpName varchar(100) NOT NULL
, Department varchar(100) NOT NULL
)
AS
BEGIN
	INSERT @empList
	SELECT E.EmpID, E.FirstName + ' ' + E.LastName, D.DepName
	FROM Employee E JOIN Department D ON E.DepID = D.DepID
	WHERE D.DepID = @depID
	RETURN
END
--DML TRIGGER
CREATE TRIGGER [PER UPDATE]
ON PERSON
AFTER UPDATE
AS
BEGIN
	IF @@ROWCOUNT=0
		RAISERROR('THERE WAS AN ERROR',16,1) 
		
	ELSE 
		PRINT 'YOU JUST HAVE UPDATED!'
		
END

--DDL TRIGGER
CREATE TRIGGER [NO TABLE]
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'NO TABLE CREATION'
	ROLLBACK TRAN
END

-- HOW TO DISBALE TRIGGERS
DISABLE TRIGGER [NO TABLE] ON DATABASE
DISABLE TRIGGER [ADIM CHECK] ON PERSON

-- BAKCUP AND RECOVERY
SELECT  recovery_model_desc --to the kind of recovery model that the database use
FROM	sys.databases
WHERE	name='lab4'

--use master when you backup files
ALTER DATABASE LAB4 SET RECOVERY FULL --bulk_logged
BACKUP DATABASE LAB4 TO DISK ='F:\FOLDERNAME\LAB4.BAK' WITH FORMAT -- WILL OVERWRITE
BACKUP DATABASE LAB4 TO DISK ='F:\FOLDERNAME\LAB4.BAK' WITH DIFFERENTIAL
BACKUP LOG LAB4 TO DISK ='F:\FOLDERNAME\LAB4.BAK' 
--RESTORING DATABASE
RESTORE DATABASE LAB4 FROM DISK ='F:\FOLDERNAME\LAB4.BAK' WITH NORECOVERY
RESTORE DATABASE LAB4 FROM DISK ='F:\FOLDERNAME\LAB4.BAK' WITH RECOVERY

--BACKINGUP TAIL LOG
BACKUP LOG LAB4 TO DISK ='F:\FOLDERNAME\LAB4.BAK' WITH NORECOVERY -- WITH STANDBY
RESTORE LOG LAB4 FROM DISK ='F:\FOLDERNAME\LAB4.BAK' WITH NORECOVERY, STOPAT='DEC 15 2019 3:12 PM'
RESTORE DATABASE LAB4 WITH RECOVERY -- WILL BRING THE DB TO ONLINE 

--HOW TO CREATE A LOGIN
CREATE LOGIN myLogin
WITH PASSWORD='XXXX' MUST_CHANGE
,DEFAULT_DATABASE = LAB4
,CHECK_EXPIRATION=ON
,CHECK_POLICY=ON

--HOW TO MAP USERS
CREATE USER SURAFEL FOR LOGIN myLogin
ALTER USER SURAFEL WITH NAME =[SURAFEL FANTU]

--HOW TO CREATE ROLE
CREATE ROLE newROLE;
EXEC sp_addrolemember 'newRole' , 'SURAFEL FANTU'

--GRANTING PERMISSION
GRANT SELECT (FirstName) ON Employee
TO newRole
GRANT INSERT ON Orders
TO [SURAFEL FANTU]
WITH GRANT OPTION

--DENING PERMISSION
DENY DELETE, UPDATE ON Customers TO testUser CASCADE

--REVOKING PERMISSION
REVOKE/* GRANT OPTION FOR*/ REFERENCES (EmployeeID) ON tblEmployee
FROM testUser CASCADE

--INDEX
CREATE UNIQUE CLUSTERED INDEX IX_Employee 
ON Employee (OrganizationLevel, OrganizationNode)
WITH (DROP_EXISTING = ON, FILLFACTOR = 80);

--HOW TO DISABLE
ALTER INDEX ALL ON PERSON.ID DISABLE
--HOW TO REBUILD AN EXISTING INDEX
ALTER INDEX IX_Employee ON Employee
REBUILD WITH (FILLFACTOR = 80);

--ANOTHER WAY OF REBUILDING AN INDEX USING DDCC
USE myDB;
GO
DBCC DBREINDEX ('Employee', PK_Employee_BusinessEntityID,80);
GO

/*
Reorganize index is an online operation
Users can still utilize the index during the operation
REORGANIZE works only on the leaf level of your index
Non-leaf levels of the index go untouched.*/
ALTER INDEX ALL
ON TransactionHistory
REORGANIZE

--DATABASE OPTIONS
ALTER Database DBName
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER Database DBName
SET MULTI_USER WITH NO_WAIT

--AUTO_ SHRINK
ALTER DATABASE databaseName
SET AUTO_SHRINK ON 

--HOW TO CHANGE DATABASE STATE
--TO CHANGE THE STATE OF A DATABASE SET THE DATABASE TO SINGLE_USER
--USE MASTER
GO
ALTER DATABASE databaseName
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE databaseName
SET READ_ONLY
GO
ALTER DATABASE databaseName
SET MULTI_USER 
/*properties, SUCH AS 
Collation, IsAutoShrink, IsAutoClose,Recovery,Restoring,Recovering,
UserAccess(Single_user,MultiUser,Restricted_user),
Status(online, offline, restoring,recovering,suspecting,Emergence)
#Suspect(mean the data base did not recover. it is called recovery pending )
#Emergence(means read_only state)*/
--RETRIEVING THE STATUS OF THE AUTO_SHRINK OPTION
SELECT DATABASEPROPERTYEX('myDB', 'IsAutoShrink');
/*
Help on DBCC commands
List the commands
DBCC HELP ('?’);
Get a description of a particular command
DBCC HELP (CHECKDB);
*/
DBCC HELP (CHECKDB);

--Reclaims space from dropped variable-length columns in tables
DBCC CLEANTABLE (myDB , 'myTable', 0)
WITH NO_INFOMSGS;

--shrinking database using ddcc
DBCC SHRINKDATABASE (UserDB, 10);--10 percent free space in the database.

--DBCC SHRINKDATABASE (myDB, TRUNCATEONLY);??????????///
/*Shrink the size of a data file named DataFile1
in the UserDB user database to 7 MB.*/
USE UserDB;
DBCC SHRINKFILE (DataFile1, 7);

/*#################
DATA TYPE
ROWVERSION 8byte one per table 
SQL_VARIANT can have a maximum length of 8016 bytes. more than one is allowed
SYSNAME used to store object name,functionally the same as nvarchar(128) , can not be null,names assigned to it must be quoted.
*/

--HOW TO CREATE USER DEFINED DATA TYPE
CREATE TYPE StudCode
FROM CHAR(6) NOT NULL

--HOW TO ADD USER DEFINED DATATYPE IN THE MODEL DATABASE
sp_addtype Typename ,system_data_type, 'NOT NULL'
sp_droptype 'typeName'

--HOW TO CREATE A RULE
CREATE RULE range_rule
AS
@range>= $1000 AND @range <$20000;

--Binds a rule to a column or to an alias data type
sp_bindrule 'rule' , 'object_name' , ['futureonly_flag' ]--When futureonly is specified, no existing columns of type ssn are affected

-- HOW TO CREATE A DEFAULT AND BIND IT
CREATE DEFAULT phonedflt AS 'unknown';
sp_bindefault 'phonedflt', 'PersonPhone.PhoneNumber';

--User-defined Table Type - Example
CREATE TYPE dbo.MyName AS TABLE
(fName varchar(20), LName varchar(20) );
GO
CREATE PROCEDURE dbo.GetFullNames
@nm dbo.MyName READONLY
AS
BEGIN
SELECT fName + ' ' + LName FROM @nm;
END
DECLARE @mm dbo.MyName
INSERT @mm (fName, LName)	VALUES('Hailu ', 'Getachew')
EXEC dbo.GetFullNames @mm

--ERROR HADLING 
SELECT @ErrorVar = @@ERROR, @RowCountVar = @@ROWCOUNT
 RAISERROR('Invalid Operation', 18, 1 )
sp_addmessage @msgnum = 50005,
@severity = 10,
@msgtext = 'Invalid Operation'
sp_dropmessage 50005

--Try … Catch - Example
/*CATCH block only when an error condition that has an error level of 11–19 occurs
Errors trapped by a catch block are not returned to the calling application*/
DECLARE @ErrorNo int, @Severity tinyint, @State smallint, @LineNo int, @Message nvarchar(4000);
BEGIN TRY
	-- Try and create the table
	CREATE TABLE Employee(Col1 int PRIMARY KEY);
END TRY
BEGIN CATCH
	SELECT @ErrorNo = ERROR_NUMBER(), @Severity = ERROR_SEVERITY(),
	@State = ERROR_STATE(), @LineNo = ERROR_LINE (),@Message = ERROR_MESSAGE();
	SELECT @ErrorNo , @Severity, @State, @LineNo, @Message
	IF @ErrorNo = 2714 -- Object exists error
		SELECT 'WARNING: Skipping CREATE as table already exists';
	ELSE --error not recognized
		RAISERROR(@Message, 16, 1 );
END CATCH
/*Different categories of Windows Functions
 Aggregate Functions: AVG, SUM, COUNT, MIN, MAX, etc.
 Ranking Functions: RANK, DENSE_RANK, ROW_NUMBER
 Analytic Functions: LEAD, LAG, etc.
*/
SELECT ROW_NUMBER() OVER ( PARTITION BY DepID ORDER BY Salary ) AS [Row Number],FName,Lname,DepID,Salary
FROM Employee
OVER (ORDER BY Salary ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW ) AS Average

--CTE - Example
WITH cte_DepEmployees(depId, EmpCount)
AS (
SELECT DepID , COUNT(*) EmpCount
FROM Employee
GROUP BY DepID
)
SELECT employeeName, EmpCount
FROM cte_DepEmployees

--USE THE CACHED PLAN
SELECT usecounts,cacheobjtype,objtype,st.text
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) AS st


/*
Using the Management Studio
 Create a Maintenance Plan that backs up all user databases
1. Management > Maintenance Plan
2. New Maintenance Plan
3. Toolbox – Drag the “Backup Database Task”
4. DB Click on the “Backup Database Task” box and configure
5. General TAB
5. General TAB
	 Select databases
	 To Disk
6. Destination
	 Set the destination
	 Subfolders for each database
7. Options
	 Encryption
	 Expiry
	 Verify backup integrity
8. Save ALL
	 The Maintenance Plan can be executed manually from
	 SQL Server Agent
	 Maintenance Plans
	 The Maintenance Plan can also be scheduled to runautomatically
*/
/*
Policy Based Management (cont.)
 How exactly these Policies (rules) are enforced is set by
rules — treatment options include:
 On Demand: Only check for violations of policy when an
administrator has specifically requested the policy audit.
 Scheduled: Run an audit of policy violations according to some
schedule
 On Change: Prevent: This proactively prevents the policy
violation from being allowed.
 On Change – Log: This notes the violation, but simply logs it
 Want to enforce that all stored procedures begin with “sp”
 Steps to create the policy
 Management > Policy Management
 New CONDITION
	 Name: spNameCondition
	 Field: @name
	 Operator: =
	 Value: ‘sp_%’
 New Policy
	 Name: spNamePolicy
	 Check condition: spNameCondition
	 Against Target: Every Stored Preocedure
	 Evaluate Mode: On demand

*/
/*Jobs and Tasks are created using SQL Server Agent
service
Creating Jobs - Example
	 SQL Server Agent > Jobs > New Job > Name the job
	 Steps > New
	 Step Name , Type , Command
	 Repeat and add steps to the job
	 Set On Success / On Failure options
	 Setup schedule
	 Add Alert, Notifications, etc.
Help on Jobs and Scheduling
	 dbo.sysjobactivity - shows the current information of the
	jobs
	 dbo.sysjobhistory - shows the execution result of the
	jobs.
	 dbo.sysjobs - shows the information of the jobs
	 dbo.sysjobsshedules - shows the job schedule
	information like the next run date and time of the jobs.
	 dbo.sysjobsteps - shows the job steps
	 dbo.sysjobsteplogs - let you see the logs of the steps
	configured to display the output in a table
	*/
/*
GLOBAL Variables - Examples
 @@ERROR
	Returns the error number for the last Transact-SQL statement executed
 @@IDENTITY
	Returns the last-inserted identity value
 @@ROWCOUNT
	Returns the number of rows affected by the last statement
 @@SERVERNAME
	Returns the name of the local server that is running SQL Server
 @@VERSION
	Returns system and build information for the current installation of SQL Server
*/
----------------------------------------------------------
--More Topics	###########################
--Application Role	############################
--Granting permission on a VIEW	##################
--Database Tuning	############################
--Execution Plan	######################
-----------------------------------------------------------