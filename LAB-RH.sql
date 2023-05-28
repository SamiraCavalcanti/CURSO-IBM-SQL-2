------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(25) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
                            
                            
                            
      
SELECT * FROM EMPLOYEES;
------------------------------------------
--QUERY-1RECUPERE TODOS OS FUNCIONÁRIOS cujo endereço está em Elgin, IL--
--------------------------------------------

SELECT ADDRESS FROM EMPLOYEES
WHERE ADDRESS like '%IL';

------------------------------------------
--Query 2:Recupere todos os funcionários que nasceram durante a década de 1970.--
--------------------------------------------
SELECT 
* FROM employees
WHERE 
B_DATE 
LIKE '197%';
-----------------------------------------
--Query 3:Recupere todos os funcionários do departamento 5 cujo salário está entre 60000 e 70000...--
--------------------------------------------

SELECT * 
FROM EMPLOYEES 
WHERE 
DEP_ID =5  
AND SALARY 
BETWEEN  60000 
AND 70000;

------------------------------------------
--Query 4A:Recupere uma lista de funcionários ordenados por ID de departamento..--
--------------------------------------------
SELECT F_NAME,L_NAME,DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;

------------------------------------------
/* Query 4B:Recupere uma lista de funcionários ordenados em ordem decrescente por
ID do departamento e dentro de cada departamento ordenado alfabeticamente em
ordem decrescente por sobrenome...*/
-------------------------------------------
SELECT DEP_ID,F_NAME,L_NAME
FROM EMPLOYEES
ORDER BY 1 DESC, 3 DESC;
-----------------------------------------
--OR...--
--------------------------------------------
SELECT DEP_ID,L_NAME,F_NAME
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;
-----------------------------------------
--QUERY 5A-Para cada ID de departamento, recupere o número de funcionários no departamento.--
--------------------------------------------

SELECT DEP_ID, COUNT(*) AS "NÚMERO DE FUNCIONÁRIOS" 
FROM EMPLOYEES
GROUP BY DEP_ID;
-----------------------------------------
--QUERY 5B-Para cada departamento, recupere o número de funcionários no
--departamento e o salário médio dos funcionários do departamento..--
--------------------------------------------
SELECT DEP_ID,COUNT(*),
AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID;
--QUERY 5C-rotule as colunas computadas no conjunto de resultados da Consulta 5B como
--“NUM_EMPLOYEES” e “AVG_SALARY”..--
--------------------------------------------
--Na Consulta 5D limitar o resultado a departamentos com menos de 4 funcionários.
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES",AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID;

--QUERY  5C-Na Consulta 5C ordene o resultado definido pelo Salário Médio.
SELECT DEP_ID,COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY)AS AVG_SALARY 
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;
--QUERY 6-Semelhante ao 4B, mas em vez do ID do departamento, use o departamento
--nome. Recupere uma lista de funcionários ordenados por nome de departamento e dentro
--cada departamento ordenado alfabeticamente em ordem decrescente pelo sobrenome
SELECT DEP_ID,COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING  COUNT(*) < 4
ORDER BY AVG_SALARY;

---
SELECT EMPLOYEES.F_NAME,EMPLOYEES.L_NAME,DEPARTMENTS.DEP_NAME
FROM EMPLOYEES
INNER JOIN DEPARTMENTS ON EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP
ORDER BY DEP_NAME, L_NAME DESC;

--OR
SELECT D.DEP_NAME, E.F_NAME,E.L_NAME
FROM EMPLOYEES AS E, DEPARTMENTS AS D
WHERE D.DEPT_ID_DEP = E.DEP_ID
ORDER BY D.DEP_NAME,E.L_NAME DESC

