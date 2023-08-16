-- CREATE statements

CREATE TABLE R1 (
  GroupNo INT PRIMARY KEY,
  Department VARCHAR(40),
  FOREIGN KEY (Department) REFERENCES R2(Department)
)

CREATE TABLE R2 (
	Department VARCHAR(40),
    Faculty VARCHAR(40),
    PRIMARY KEY (Department, Faculty)
)

CREATE TABLE R3 (
  Student VARCHAR(40),
  Groupno INT,
  Year INT NOT NULL,
  PRIMARY KEY (student, groupno),
  FOREIGN KEY (groupno) REFERENCES R1(groupno)
)

CREATE TABLE R4 (
  Student VARCHAR(40),
  Worktitle VARCHAR(40),
  Worktype VARCHAR(40),
  department VARCHAR(40),
  PRIMARY KEY (student, Worktitle),
  FOREIGN KEY (department) REFERENCES R2(department),
  FOREIGN KEY (student) REFERENCES R3(student)
 )

-- Queries

-- #1
SELECT R1.department froM (R1 JOIN R3 USING(groupno)) JOIN R4 USING(student)
GROUP BY R1.Department
HAVING COUNT(DISTINCT worktype) = (SELECT COUNT(DISTINCT worktype) FROM R4)

-- #2
SELECT DISTINCT faculty FROM R2
EXCEPT
SELECT DISTINCT faculty FROM R2 JOIN R4 USING(department)

-- #2 (alternative version)
SELECT DISTINCT faculty FROM R2 AS R2O
WHERE NOT EXISTS
	(SELECT 1 FROM R2, R4
      WHERE R2.Department = R4.department 
         AND R2O.department = R4.department)

-- #3
SELECT DISTINCT groupno FROM R3 JOIN R4 USING(student)
GROUP BY groupno 
HAVING COUNT(DISTINCT worktype) = 1 AND worktype = "Physics"

-- #4
SELECT DISTINCT student FROM R1 JOIN R3 USING(groupno)
WHERE year = 1 AND student IN 
  (SELECT student FROM R4
    WHERE R4.department = R1.department)

-- #4 (alternative version)
SELECT DISTINCT student FROM (R1 JOIN R3 USING(groupno)) JOIN R4 USING(student)
WHERE R1.Department = R4.Department AND year = 1

-- #5
SELECT DISTINCT worktitle FROM ((R1 JOIN R2 USING(department)) 
    JOIN R3 USING(groupno)) JOIN R4 USING(student)
GROUP BY worktitle
HAVING COUNT(DISTINCT faculty) = 1 AND 
   COUNT(DISTINCT student) > 1 AND COUNT(DISTINCT R1.department) > 1;