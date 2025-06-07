create database student;
use student;

--create table--
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Major VARCHAR(50)
);

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50)
);

CREATE TABLE Job_Postings (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(100),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    StudentID INT,
    JobID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (JobID) REFERENCES Job_Postings(JobID)
);

---insert sample data--
INSERT INTO Students VALUES
(1, 'Alice', 20, 'Computer Science'),
(2, 'Bob', 21, 'IT'),
(3, 'Charlie', 22, 'ECE');

INSERT INTO Companies VALUES
(1, 'Google', 'Technology'),
(2, 'Amazon', 'E-Commerce');

INSERT INTO Job_Postings VALUES
(1, 1, 'Software Engineer'),
(2, 2, 'Data Analyst');

INSERT INTO Applications VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);




--WINDOW FUNCTION--
SELECT
    a.StudentID,
    s.Name,
    COUNT(a.ApplicationID) AS TotalApplications,
    RANK() OVER (ORDER BY COUNT(a.ApplicationID) DESC) AS ApplicationRank
FROM Applications a
JOIN Students s ON a.StudentID = s.StudentID
GROUP BY a.StudentID, s.Name;

--SUBQUERY--
SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT a.StudentID
    FROM Applications a
    JOIN Job_Postings j ON a.JobID = j.JobID
    JOIN Companies c ON j.CompanyID = c.CompanyID
    WHERE c.Name = 'Google'
);

---CTE--
WITH AppCount AS (
    SELECT
        StudentID,
        COUNT(ApplicationID) AS TotalApplications
    FROM Applications
    GROUP BY StudentID
)
SELECT
    s.Name,
    a.TotalApplications
FROM AppCount a
JOIN Students s ON a.StudentID = s.StudentID
WHERE a.TotalApplications > 1;


