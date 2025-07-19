/* 1.Create a database named employee, then import data_science_team.csv proj_table.csv and
 emp_record_table.csv into the employee database from the given resources.
done
2.Create an ER diagram for the given employee database. */
use employee_management;
show tables;
select * from emp_record_table;
select * from data_science_team;
select * from proj_table;
desc emp_record_table;
/* 3.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and
 DEPARTMENT from the employee record table, and make a list of employees and details of their department. */
select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
from emp_record_table;
/* 4.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
 DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●less than two
●greater than four 
●between two and four
 */  
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
where (EMP_RATING<2 or EMP_RATING>4) or  (EMP_RATING>2 or EMP_RATING<4);
/* 5.Write a query to concatenate the FIRST_NAME and the LAST_NAME of
 employees in the Finance department from the employee table and then give
 the resultant column alias as NAME.
 */
select concat(FIRST_NAME, LAST_NAME) as NAME
from emp_record_table
where DEPT = ('Finance');

/* 6.Write a query to list only those employees who have someone reporting to them.
 Also, show the number of reporters (including the President). */
select manager_id,
count(emp_id) as no_of_reporters
from emp_record_table
group by manager_id
order by manager_id;

use employee_management;
/* 7.Write a query to list down all the employees from the healthcare 
and finance departments using union. Take data from the employee record table. */
SELECT first_name, last_name, dept
FROM emp_record_table
WHERE dept = 'HEALTHCARE'
UNION
SELECT first_name, last_name, dept
FROM emp_record_table
WHERE dept = 'FINANCE';


/* 8.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
Also include the respective employee rating along with the max emp rating for the department.*/

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE,DEPT, EMP_RATING, EMP_RATING as max_rating
from emp_record_table 
where (dept,emp_rating)
IN (SELECT dept, MAX(emp_rating) FROM emp_record_table GROUP By dept)
ORDER BY dept ASC;

-- 9.Write a query to calculate the minimum and the maximum salary of the employees in each role. 
-- Take data from the employee record table.

SELECT role, MIN(salary) AS minSalary, MAX(salary) AS maxSalary
FROM emp_record_table
GROUP BY role;

-- 10.Write a query to assign ranks to each employee based on their experience.
-- Take data from the employee record table.
SELECT  FIRST_NAME, LAST_NAME, EXP as experience,
dense_rank() over (order by exp desc)AS emp_rank
FROM emp_record_table ;
/*11.Write a query to create a view that displays employees in various countries
 whose salary is more than six thousand. Take data from the employee record table.
*/
create view emp_by_contries as
select COUNTRY, EMP_ID, FIRST_NAME, LAST_NAME,SALARY
from emp_record_table
where salary > 6000;
select * from emp_by_contries;
/*12.Write a nested query to find employees with experience of more than ten years.
 Take data from the employee record table.*/
select emp_id,first_name,last_name,exp from emp_record_table
WHERE exp IN (
SELECT exp
FROM emp_record_table
WHERE exp > 10
);


/*13.Write a query to create a stored procedure to retrieve the details of the employees
 whose experience is more than three years. Take data from the employee record table.*/

USE `employee_management`;
DROP procedure IF EXISTS `emp_exp`;

USE `employee_management`;
DROP procedure IF EXISTS `employee_management`.`emp_exp`;
;

DELIMITER $$
USE `employee_management`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `emp_exp`()
BEGIN
 select * from emp_record_table
 where exp>3;
END$$

DELIMITER ;
;

call emp_exp();
/*14.Write a query using stored functions in the project table to check
 whether the job profile assigned to each employee in the data science team 
 matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.*/
USE `employee_management`;
DROP procedure IF EXISTS `check_role`;

USE `employee_management`;
DROP procedure IF EXISTS `employee_management`.`check_role`;
;

DELIMITER $$
USE `employee_management`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_role`()
BEGIN
    SELECT emp_id, first_name, exp,
        CASE 
            WHEN exp <= 2 THEN 'JUNIOR DATA SCIENTIST'
            WHEN exp BETWEEN 3 AND 5 THEN 'ASSOCIATE DATA SCIENTIST'
            WHEN exp BETWEEN 6 AND 10 THEN 'SENIOR DATA SCIENTIST'
            WHEN exp BETWEEN 11 AND 12 THEN 'LEAD DATA SCIENTIST'
            WHEN exp BETWEEN 13 AND 16 THEN 'MANAGER'
            ELSE 'ALL GOOD'
        END AS assigned_role
    FROM emp_record_table;
END$$

DELIMITER ;
;


call check_role();

/*15.Create an index to improve the cost and performance of the query to find the employee whose 
FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/

ALTER TABLE emp_record_table ADD INDEX fname_index (first_name);
SELECT * FROM emp_record_table WHERE first_name = 'Eric';


/*16.Write a query to calculate the bonus for all the employees, based on their ratings
 and salaries (Use the formula: 5% of salary * employee rating).*/
select first_name,last_name,salary, floor(salary*5/100*emp_rating) as bonus from emp_record_table;

/*17.Write a query to calculate the average salary distribution based on the continent and country.
 Take data from the employee record table.
*/
select continent, floor(avg(salary))as avg_sal
 from emp_record_table group by continent
 order by continent asc;
 select country, avg(salary)as avg_sal
 from emp_record_table group by country 
 order by country asc;
