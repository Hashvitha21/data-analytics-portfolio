-- ============================================
-- STUDENT PERFORMANCE ANALYSIS 
-- ============================================

-- NOTE:
-- SQL_SAFE_UPDATES disabled temporarily for bulk updates

SET SQL_SAFE_UPDATES = 0;
SELECT * FROM student_performance_data_raw;

-- Rename table
RENAME TABLE `student_performance_data _raw` TO Student_Performance_Data;

-- ----------------------------
-- Convert encoded values
-- ----------------------------

-- Parental Support

ALTER TABLE Student_Performance_Data
Modify Column ParentalSupport VARCHAR(20);

Update Student_Performance_Data
set ParentalSupport = case 
when ParentalSupport = 0 then "None"
when ParentalSupport = 1 then "Low"
when ParentalSupport = 2 then "Moderate"
when ParentalSupport = 3 then "High"
when ParentalSupport = 4 then "Very High" 
else ParentalSupport
end;

-- Extracurricular

ALTER TABLE Student_Performance_Data
MODIFY COLUMN Extracurricular VARCHAR(10);

update Student_Performance_Data
set Extracurricular = case 
when Extracurricular = 0 then 'No'
when Extracurricular = 1 then 'Yes'
else Extracurricular
end;

-- Tutoring

alter table Student_Performance_Data
MODIFY COLUMN Tutoring Varchar(10);

UPDATE Student_Performance_Data
SET Tutoring = CASE 
WHEN Tutoring = 0 THEN 'No'
WHEN Tutoring =1 THEN 'Yes'
ELSE Tutoring 
END;

-- Sports

ALTER TABLE Student_Performance_Data
MODIFY COLUMN Sports Varchar(10);

UPDATE Student_Performance_Data
SET Sports = CASE 
WHEN Sports = 0 THEN 'No'
WHEN Sports = 1 THEN 'Yes'
ELSE Sports
END;

-- Music

ALTER TABLE Student_Performance_Data
MODIFY COLUMN Music Varchar(10);

UPDATE Student_Performance_Data
SET Music = CASE 
WHEN Music = 0 THEN 'No'
WHEN Music = 1 THEN 'Yes'
ELSE Music
END;

-- Volunteering

ALTER TABLE Student_Performance_Data 
MODIFY COLUMN Volunteering VARCHAR(10);

UPDATE Student_Performance_Data
SET Volunteering = CASE 
WHEN Volunteering = 0 THEN 'No'
WHEN Volunteering = 1 THEN 'Yes'
ELSE Volunteering
END;

-- Gender

ALTER TABLE Student_Performance_Data 
MODIFY COLUMN Gender VARCHAR(10);

UPDATE Student_Performance_Data
SET Gender = CASE 
WHEN Gender = 0 THEN "Male"
WHEN Gender = 1 THEN "Female"
ELSE Gender
END;

-- Ethnicity

ALTER TABLE Student_Performance_Data 
MODIFY COLUMN Ethnicity VARCHAR(30);

UPDATE Student_Performance_Data
SET Ethnicity = case
when Ethnicity = 0 then "Caucasian"
when Ethnicity = 1 then "African American"
when Ethnicity = 2 then "Asian"
when Ethnicity = 3 then "Other"
else Ethnicity 
end;

-- Parental Education

ALTER TABLE Student_Performance_Data 
MODIFY COLUMN ParentalEducation VARCHAR(30);

UPDATE Student_Performance_Data
SET ParentalEducation = CASE 
WHEN ParentalEducation = 0 THEN "None"
WHEN ParentalEducation = 1 THEN "High School"
WHEN ParentalEducation = 2 THEN "Some College"
WHEN ParentalEducation = 3 THEN "Bachelor's"
WHEN ParentalEducation = 4 THEN "Higher"
ELSE ParentalEducation
END;

-- Convert Grades

ALTER TABLE Student_Performance_Data
MODIFY COLUMN GradeClass varchar(10);

update Student_Performance_Data
set GradeClass = case 
when GradeClass = 0 then 'A'
when GradeClass = 1 then 'B'
when GradeClass = 2 then 'C'
when GradeClass = 3 then 'D'
when GradeClass = 4 then 'F'
else GradeClass
end;

-- Numeric Formatting

ALTER TABLE Student_Performance_Data
MODIFY COLUMN StudyTimeWeekly DECIMAL(6,3),
MODIFY COLUMN GPA decimal(6,3);

-- --------------------------------------------
-- DATA MODELING (DIMENSION TABLES)
-- --------------------------------------------

-- Gender Dimension

create table dim_gender(
ID INT AUTO_INCREMENT PRIMARY KEY,
Gender_name varchar(10) unique);

insert into dim_gender(Gender_name)
SELECT DISTINCT Gender FROM Student_Performance_Data;

ALTER TABLE Student_Performance_Data ADD  Gender_ID INT;

update Student_Performance_Data S
join dim_gender D
on S.Gender = D.Gender_name
set S.Gender_ID = D.ID;

ALTER TABLE Student_Performance_Data
ADD CONSTRAINT fk_genderid
FOREIGN KEY (Gender_ID)
REFERENCES dim_gender(ID);

select * from dim_gender; 

alter table Student_Performance_Data
drop column Gender;

-- Grade Dimension

create table dim_grade(
ID int AUTO_INCREMENT primary key,
Grade varchar(10) unique);

insert into dim_grade(Grade)
select distinct GradeClass from Student_Performance_Data
where GradeClass is not null;

alter table Student_Performance_Data
add column Grade_ID int;

update Student_Performance_Data S
join dim_grade d
on S.GradeClass = d.Grade
set S.Grade_ID = d.ID; 

alter table Student_Performance_Data
add constraint fk_grade
foreign key (Grade_ID)
references dim_grade(ID);

select * from dim_grade; 

alter table Student_Performance_Data
drop column GradeClass;

-- Parental Support Dimension

create table dim_support(
ID int auto_increment primary key,
Parental_Support varchar(25) unique);

insert into dim_support (Parental_Support)
select distinct ParentalSupport from Student_Performance_Data
where ParentalSupport is not null;

alter table Student_Performance_Data
add column Parental_Support_ID int ;

update Student_Performance_Data S
join dim_support T
on S.ParentalSupport = T.Parental_Support
set S.Parental_Support_ID = T.ID; 

alter table Student_Performance_Data
add constraint fk_support
foreign key (Parental_Support_ID)
references dim_support(ID);

select * from dim_support;

alter table Student_Performance_Data
drop column ParentalSupport;

-- --------------------------------------------
-- ANALYSIS
-- --------------------------------------------

-- 1. Tutoring vs Performance

SELECT 
  s.Tutoring,
  AVG(
    CASE 
      WHEN g.Grade = 'A' THEN 5
      WHEN g.Grade = 'B' THEN 4
      WHEN g.Grade = 'C' THEN 3
      WHEN g.Grade = 'D' THEN 2
      WHEN g.Grade = 'F' THEN 1
    END
  ) AS avg_performance
FROM Student_Performance_Data s
JOIN dim_grade g
  ON s.Grade_ID = g.ID
GROUP BY s.Tutoring;

-- 2. Study Time vs GPA
 
select StudyTimeWeekly, avg(GPA) as avg_performance,
COUNT(*) AS num_students
from Student_Performance_Data  
group by StudyTimeWeekly
order by StudyTimeWeekly;

-- 3. Absences vs Performance

select 
case 
when Absences between 0 and 5 then "low"
when Absences between 6 and 15 then "medium"
when Absences between 16 and 29 then "high"
end as abs_performance ,
avg(case 
when g.Grade = "A" then 5
when g.Grade = "B" then 4
when g.Grade = "C" then 3
when g.Grade = "D" then 2
when g.Grade = "F" then 1
end )as grade_performance ,count(*) as num
from Student_Performance_Data s
join dim_grade g
on s.Grade_ID = g.ID
group by abs_performance
order by abs_performance;

-- 4. Parental Support vs Grades

select 
p.Parental_Support,
avg(case
  when g.Grade = 'A' then 5
  when g.Grade = 'B' then 4
  when g.Grade = 'C' then 3
  when g.Grade = 'D' then 2
  when g.Grade = 'F' then 1
end) as grade_performance,
count(*) as num
from Student_Performance_Data s
join dim_support p
  on p.ID = s.Parental_Support_ID
join dim_grade g
  on g.ID = s.Grade_ID
group by p.Parental_Support
order by 
case 
  when p.Parental_Support = 'None' then 1
  when p.Parental_Support = 'Low' then 2
  when p.Parental_Support = 'Moderate' then 3
  when p.Parental_Support = 'High' then 4
  when p.Parental_Support = 'Very High' then 5
end;

-- 5. Extracurricular vs GPA

select Extracurricular, avg(GPA) as AVG_GPA,
count(*) as num_students from Student_Performance_Data
group by Extracurricular
order by Extracurricular;

-- ============================================
-- END OF PROJECT
-- ============================================

SET SQL_SAFE_UPDATES = 1;
