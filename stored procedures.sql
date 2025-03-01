create database employee;
use employee;
CREATE TABLE Worker (
  Worker_Id INT,
  FirstName CHAR(25),
  LastName CHAR(25),
  Salary INT,
  JoiningDate DATETIME,
  Department CHAR(25)
);
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES
(1, 'John', 'Doe', 50000, '2020-01-01', 'HR'),
(2, 'Jane', 'Doe', 60000, '2020-02-02', 'Marketing'),
(3, 'Bob', 'Smith', 70000, '2020-03-03', 'Sales'),
(4, 'Alice', 'Johnson', 80000, '2020-04-04', 'IT'),
(5, 'Mike', 'Williams', 90000, '2020-05-05', 'Finance'),
(6, 'Emily', 'Davis', 100000, '2020-06-06', 'HR'),
(7, 'David', 'Miller', 110000, '2020-07-07', 'Marketing'),
(8, 'Sarah', 'Wilson', 120000, '2020-08-08', 'Sales'),
(9, 'Kevin', 'Moore', 130000, '2020-09-09', 'IT'),
(10, 'Lisa', 'Taylor', 140000, '2020-10-10', 'Finance');
DELIMITER //
CREATE PROCEDURE sp_add_worker(
  IN p_Worker_Id INT,
  IN p_FirstName CHAR(25),
  IN p_LastName CHAR(25),
  IN p_Salary INT,
  IN p_JoiningDate DATETIME,
  IN p_Department CHAR(25)
)
BEGIN
  INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
  VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END //
DELIMITER ;

-- Procedure call
CALL sp_add_worker(11, 'New', 'Worker', 150000, '2022-01-01', 'HR');
DELIMITER //
CREATE PROCEDURE sp_get_salary(
  IN p_Worker_Id INT,
  OUT p_Salary INT
)
BEGIN
  SELECT Salary INTO p_Salary
  FROM Worker
  WHERE Worker_Id = p_Worker_Id;
END //
DELIMITER ;

-- Procedure call
CALL sp_get_salary(2, @p_Salary);
SELECT @p_Salary;
DELIMITER //
CREATE PROCEDURE sp_update_department(
  IN p_Worker_Id INT,
  IN p_Department CHAR(25)
)
BEGIN
  UPDATE Worker
  SET Department = p_Department
  WHERE Worker_Id = p_Worker_Id;
END //
DELIMITER ;
SET SQL_SAFE_UPDATES = 0;

-- Procedure call
CALL sp_update_department(1, 'Marketing');

DELIMITER //
CREATE PROCEDURE sp_get_worker_count(
  IN p_Department CHAR(25),
  OUT p_workerCount INT
)
BEGIN
  SELECT COUNT(*) INTO p_workerCount
  FROM Worker
  WHERE Department = p_Department;
END //
DELIMITER ;

-- Procedure call
CALL sp_get_worker_count('marketing', @p_workerCount);
SELECT @p_workerCount;
DELIMITER //
CREATE PROCEDURE sp_get_avg_salary(
  IN p_Department CHAR(25),
  OUT p_avgSalary DECIMAL(10, 2)
)
BEGIN
  SELECT AVG(Salary) INTO p_avgSalary
  FROM Worker
  WHERE Department = p_Department;
END //
DELIMITER ;

-- Procedure call
CALL sp_get_avg_salary('HR', @p_avgSalary);
SELECT @p_avgSalary;
select * from worker;
drop database employee;