1.1 - select DISTINCT area from Q1, Q1 Q1I
WHERE Q1.area = Q1I.area AND Q1.department <> Q1I.department

1.2 - SELECT area FROM Q1
GROUP BY area
HAVING COUNT(DISTINCT department) > 1;

2.1 - select client from q2
GROUP BY client
HAVING COUNT(department) = (select COUNT(department) from q1) AND COUNT(accountno) = COUNT(department)

3 - select client from Q1 JOIN Q2 USING(department)
GROUP BY client
HAVING COUNT(DISTINCT area) > 1;

4 - SELECT department FROM Q1 Q1Outer
WHERE NOT EXISTS 
	(select 1 from Q2 JOIN Q1 USING(department)
     where Q1.area = Q1Outer.Area AND Q1.Department <> Q1Outer.Department
     GROUP BY Client
     HAVING COUNT(accountno) > 0)

5 - SELECT DISTINCT client FROM Q2 Q2O
WHERE remain = (SELECT MAX(remain) FROM Q2 WHERE department = Q2O.department)

6 - SELECT student FROM R1
GROUP BY student
HAVING COUNT(DISTINCT department) > 1;

6.1 - SELECT DISTINCT R1.student FROM R1, R1 AS R1O
WHERE R1.student = R1O.student 
	AND R1.department <> R1O.department

7 - SELECT DISTINCT department FROM R1,R3 
WHERE R1.Student = R3.Student AND year = 3

7.1 - SELECT DISTINCT department from R1 JOIN R3 USING(Student)
WHERE year = 3


8 - SELECT DISTINCT R1O.department FROM R1 AS R1O JOIN R4 AS R4O USING(department)
WHERE EXISTS
	(
      SELECT 1 FROM (R3 AS R3I JOIN R2 USING(groupno)) 
      	JOIN R4 AS R4I USING(department)
      WHERE R4O.faculty <> R4I.faculty AND R1O.student = R3I.student)

9 - SELECT workttile FROM ((R2 JOIN R3 USING(groupno)) JOIN R4 USING(department)) 
	JOIN R1 USING(student)
WHERE year >= 3
GROUP BY workttile
HAVING COUNT(DISTINCT student) > 1 AND COUNT(DISTINCT faculty) > 1;

10 - SELECT department FROM R4
EXCEPT
SELECT DISTINCT department from R1
WHERE EXISTS (
  SELECT 1 FROM R2 JOIN R3 USING(groupno)
  WHERE R2.Department <> R1.department AND R3.Student = R1.student)