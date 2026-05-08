-- Bulk UPDATE and DELETE statements were executed in MySQL.
-- SQL_SAFE_UPDATES was disabled locally to allow data cleaning operations.

select * from pharmaceutical_sales;

-- ==============================
-- CLEANING
-- ==============================

update pharmaceutical_sales
set unit_price = replace(unit_price,'â‚¹','₹');

SELECT DISTINCT city
FROM pharmaceutical_sales; 

update pharmaceutical_sales
set city = replace(city,'Bengaluru','bangalore');

update pharmaceutical_sales
set city = replace(city,'Hyd','Hyderabad');

update pharmaceutical_sales
set total_amount = ''
where total_amount = 'not defined';

update pharmaceutical_sales
set unit_price = replace(unit_price,'₹','');

update pharmaceutical_sales
set total_amount = replace(total_amount,'₹','');

update pharmaceutical_sales 
set city = trim(city);

select (quantity*unit_price) as total_amount from pharmaceutical_sales;

update pharmaceutical_sales
set total_amount = quantity*unit_price
where total_amount = '';


-- ==============================
-- STANDARDIZATION
-- ==============================

update pharmaceutical_sales
set city = lower(city);

update pharmaceutical_sales
set city=concat(upper(left(city,1)),substring(city,2));

update pharmaceutical_sales
set category = lower(category);

update pharmaceutical_sales
set category = concat(upper(left(category,1)),substring(category,2));

-- DATA INSPECTION 
select distinct medicine from pharmaceutical_sales; 

update pharmaceutical_sales
set medicine = case 
when medicine in ('Ator-10mg', 'Aztor 10mg','Ator-10 mg') then 'Aztor 10 mg'
when medicine in ('Metformin 500MG','Metformin-500 mg') then 'Metformin 500 mg'
when medicine in ('Azith 250mg') then 'Azithromycin 250 mg'
when medicine in ('Vita-D3','VitaD-3') then 'Vitamin-D3'
when medicine in ('Pan 40mg') then 'Pantaprazole 40 mg'
when medicine in ('Losar 50 mg','Losartan 50mg') then 'Losartan 50 mg'
when medicine in ('Amox-500 mg','Amoxicillin 500mg') then 'Amoxicillin 500 mg'
when medicine in ('Rabe-20 mg','Rabeprazole 20mg') then 'Rabeprazole 20 mg'
when medicine in ('Telmi-40 mg','Telmisartan 40mg') then 'Telmisartan 40 mg'
when medicine in ('Cetz 10 mg','Cetirizine 10mg') then 'Cetirizine 10 mg'
when medicine in ('PCM-650 mg','Paracetamol 650mg') then 'Paracetamol 650 mg'
when medicine in ('Thyro-50 mcg','Thyroxine 50mcg') then 'Thyroxine 50 mg'
when medicine in ('Amlo 5mg') then 'Amlodipine 5 mg'
when medicine in ('Met XL 25mg') then 'Metoprolol 25 mg'
when medicine in ('Ondem 4mg','Ondansetron 4mg') then 'Ondansetron 4 mg'
when medicine in ('Calci-500','Calcimax 500') then 'Calcimax 500 mg'
when medicine in ('Ecospr-75 mg','Ecosprin 75mg') then 'Ecosprin 75 mg'
when medicine in ('Vit-B12') then 'Vitamin-B12'
when medicine in ('Amlo 2.5mg') then 'Amlodipine 2.5 mg'
when medicine in ('Nex-20 mg','Nexpro 20mg') then 'Nexpro 20 mg'
when medicine in ('Mont-LC') then 'Montair LC'
when medicine in ('Atorva 20mg') then 'Atorvastatin 20 mg'
when medicine in ('Amoxclav 625','Amoxiclav 625mg') then 'Amoxiclav 625 mg'
when medicine in ('Dolo-650 mg','Dolo 650mg') then 'Dolo 650 mg'
when medicine in ('Levocet 5mg') then 'Levocetirizine 5 mg'
when medicine in ('Domstal 10mg') then 'Domperidone 10 mg'
when medicine in ('Augment-625 mg','Augmentin 625mg') then 'Augmentin 625 mg'
when medicine in ('Sucral-O') then 'Sucralfate O'
when medicine in ('Glyco-500 mg','Glycomet 500mg') then 'Glycomet 500 mg'
when medicine in ('Isol-20 mg','Isolaz 20mg') then 'Isolaz 20 mg'
when medicine in ('Reclim-0.5 mg','Reclimet 0.5mg') then 'Reclimet 0.5 mg'
when medicine in ('Trypt-10 mg','Tryptomer 10mg') then 'Tryptomer 10 mg'
when medicine in ('Eptus-25 mg','Eptus 25mg') then 'Eptus 25 mg'
when medicine in ('Rose-10 mg','Roseday 10mg') then 'Roseday 10 mg'
when medicine in ('Metro-400 mg','Metrogyl 400mg') then 'Metrogyl 400 mg'
when medicine in ('Calpol-650 mg','Calpol 650mg') then 'Calpol 650 mg'
when medicine in ('Omna-10 mg','Omnacortil 10mg') then 'Omnacortil 10 mg'
when medicine in ('Rabis-20 mg','Rabista 20mg') then 'Rabista 20 mg'
when medicine in ('Clav-625 mg','Clavam 625mg') then 'Clavam 625 mg'
when medicine in ('Nicip+') then 'Nicip Plus'
when medicine in ('O-2 tab') then 'O2 Tablet' 
when medicine in ('Visco-dyn') then 'Viscodyne'
when medicine in ('Glim-M2') then 'Glimy M2'
when medicine in ('Ecos-AV') then 'Ecosprin AV'
when medicine in ('Panto-40 mg') then 'Pantocid 40mg' 
else medicine 
end;

-- DATA INSPECTION 
select distinct hospital from pharmaceutical_sales; 

update pharmaceutical_sales
set hospital = case 
when hospital in ('CityCare Hospital','City Care') then 'City care hospital'
when hospital in ('Sunrise hosp','Sunrise') then 'Sunrise Hospital'
when hospital = ('Healing Touch') then 'Healing Touch Clinic'
when hospital in ('Life care hosp','LifeCare Hospital','Lifecare','Life care') then 'Life Care Hospital'
when hospital = ('Mediplus') then 'MediPlus Clinic'
when hospital = ('Shree hosp') then 'Shree Hospital'
when hospital = ('Hopecare') then 'HopeCare Clinic'
when hospital = ('City hosp') then 'City Hospital'
when hospital = ('Lotus') then 'Lotus Clinic'
else hospital 
end;

-- DATA INSPECTION
select distinct city from pharmaceutical_sales ;

update pharmaceutical_sales  
set city = case
when city in ('Hyderabaderabaderabad','Hyderabaderabaderabaderabad') then 'Hyderabad'
else city 
end;

-- DATA INSPECTION
select distinct doctor_name from pharmaceutical_sales;

UPDATE pharmaceutical_sales
SET doctor_name = CASE
    WHEN doctor_name IN ('Dr. Aijay Kumar', 'Dr Aijay K.', 'Dr A. Kumar') THEN 'Dr. Aijay Kumar'
    WHEN doctor_name IN ('Dr. Meena Rao', 'Drr Meena R.') THEN 'Dr. Meena Rao'
    WHEN doctor_name IN ('Dr. Sanjiv Singh', 'Dr Sanjiv S') THEN 'Dr. Sanjiv Singh'
    WHEN doctor_name IN ('Dr. Priya Shah', 'Dr P. Shah', 'Dr P Shah') THEN 'Dr. Priya Shah'
    WHEN doctor_name IN ('Dr. John Mathew', 'Dr. Jhon Matheu') THEN 'Dr. John Mathew'
    WHEN doctor_name IN ('Dr. Shruti Mehra', 'Dr S Mehra') THEN 'Dr. Shruti Mehra'
    WHEN doctor_name IN ('Dr. Rohit Lal', 'Dr. R. Laal') THEN 'Dr. Rohit Lal'
    WHEN doctor_name IN ('Dr. Radhika Rao', 'Dr R Rao') THEN 'Dr. Radhika Rao'
    WHEN doctor_name IN ('Dr. Neha Jain', 'Dr N. Jain') THEN 'Dr. Neha Jain'
    WHEN doctor_name IN ('Dr. Ajit Verma', 'Dr Ajit V') THEN 'Dr. Ajit Verma'
    WHEN doctor_name IN ('Dr. Isha Rana', 'Dr I. Rana') THEN 'Dr. Isha Rana'
    WHEN doctor_name IN ('Dr. Amit Shah', 'Dr Amit S') THEN 'Dr. Amit Shah'
    WHEN doctor_name IN ('Dr. Ritu Malhotra', 'Dr Ritu M') THEN 'Dr. Ritu Malhotra'
    WHEN doctor_name IN ('Dr. Rakesh Kumar', 'Dr R. Kumar') THEN 'Dr. Rakesh Kumar'
    WHEN doctor_name IN ('Dr. Swati Gupta', 'Dr S. Gupta') THEN 'Dr. Swati Gupta'
    WHEN doctor_name IN ('Dr. Vansh Tiwari', 'Dr V Tiwari') THEN 'Dr. Vansh Tiwari'
    WHEN doctor_name IN ('Dr. Leena Seth', 'Dr L. Seth') THEN 'Dr. Leena Seth'
    WHEN doctor_name IN ('Dr. Tushar Mehta', 'Dr T Mehta') THEN 'Dr. Tushar Mehta'
    WHEN doctor_name IN ('Dr. Rani Chopra', 'Dr R Chopra') THEN 'Dr. Rani Chopra'
    WHEN doctor_name IN ('Dr. Arjun Khanna', 'Dr A Khanna') THEN 'Dr. Arjun Khanna'
    WHEN doctor_name IN ('Dr. Kavita Jain', 'Dr K. Jain') THEN 'Dr. Kavita Jain'
    WHEN doctor_name IN ('Dr. Rohan Desai', 'Dr R Desai') THEN 'Dr. Rohan Desai'
    WHEN doctor_name IN ('Dr. Sneha Pillai', 'Dr S Pillai') THEN 'Dr. Sneha Pillai'
    WHEN doctor_name IN ('Dr. Varun Sehgal', 'Dr V Sehgal') THEN 'Dr. Varun Sehgal'
    WHEN doctor_name IN ('Dr. Megha Saini', 'Dr M Saini') THEN 'Dr. Megha Saini'
    WHEN doctor_name IN ('Dr. Ajay Anand', 'Dr A Anand') THEN 'Dr. Ajay Anand'
    WHEN doctor_name IN ('Dr. Manish Gupta', 'Dr M Gupta') THEN 'Dr. Manish Gupta'
    WHEN doctor_name IN ('Dr. Kavya Rao', 'Dr K Rao') THEN 'Dr. Kavya Rao'
    WHEN doctor_name IN ('Dr. Sandeep Shah', 'Dr S Shah') THEN 'Dr. Sandeep Shah'
    WHEN doctor_name IN ('Dr. Anita Joseph', 'Dr A Joseph') THEN 'Dr. Anita Joseph'
    WHEN doctor_name IN ('Dr. Hemant Verma', 'Dr H Verma') THEN 'Dr. Hemant Verma'
    WHEN doctor_name IN ('Dr. Noor Ali', 'Dr N Ali') THEN 'Dr. Noor Ali'
    WHEN doctor_name IN ('Dr. Raghav Suri', 'Dr R Suri') THEN 'Dr. Raghav Suri'
    WHEN doctor_name IN ('Dr. Sonia Bhat', 'Dr S Bhat') THEN 'Dr. Sonia Bhat'
    WHEN doctor_name IN ('Dr. Ashok Goyal', 'Dr A Goyal') THEN 'Dr. Ashok Goyal'
    WHEN doctor_name IN ('Dr. Veena Menon', 'Dr V Menon') THEN 'Dr. Veena Menon'
    WHEN doctor_name IN ('Dr. Jatin Gupta', 'Dr J Gupta') THEN 'Dr. Jatin Gupta'
    WHEN doctor_name IN ('Dr. Vivek Jain', 'Dr V Jain') THEN 'Dr. Vivek Jain'
    WHEN doctor_name IN ('Dr. Radha Mishra', 'Dr R Mishra') THEN 'Dr. Radha Mishra'
    WHEN doctor_name IN ('Dr. Anil Raj', 'Dr A Raj') THEN 'Dr. Anil Raj'
    WHEN doctor_name IN ('Dr. Mahesh Shah', 'Dr M Shah') THEN 'Dr. Mahesh Shah'
    WHEN doctor_name IN ('Dr. Pooja Kapoor', 'Dr P Kapoor') THEN 'Dr. Pooja Kapoor'
    WHEN doctor_name IN ('Dr. Nishant Arya', 'Dr N Arya') THEN 'Dr. Nishant Arya'
    WHEN doctor_name IN ('Dr. Ritika Shah', 'Dr R Shah') THEN 'Dr. Ritika Shah'
    WHEN doctor_name IN ('Dr. Prakash Jain', 'Dr P Jain') THEN 'Dr. Prakash Jain'
    WHEN doctor_name IN ('Dr. Sushil Verma', 'Dr S Verma') THEN 'Dr. Sushil Verma'
    WHEN doctor_name IN ('Dr. Farah Khan', 'Dr F Khan') THEN 'Dr. Farah Khan'
    WHEN doctor_name IN ('Dr. Mohan Lal', 'Dr M Lal') THEN 'Dr. Mohan Lal'
    ELSE doctor_name
END;

select * from pharmaceutical_sales;

-- ==============================
-- TYPE CONVERSION
-- ==============================

update pharmaceutical_sales 
set prescription_date = str_to_date(prescription_date,'%d-%m-%Y');

alter table pharmaceutical_sales 
modify prescription_date date;

-- ==============================
-- DEDUPLICATION
-- ==============================

select * from (
select *,
row_number() over(partition by doctor_name,hospital,city,medicine,category,total_amount,prescription_date) as rn 
from pharmaceutical_sales  ) as t 
where rn >1;

delete p from pharmaceutical_sales p 
join (
select order_id from (
select order_id,
row_number() over(partition by doctor_name,hospital,city,medicine,category,total_amount,prescription_date) as rn 
from pharmaceutical_sales  ) as t 
where rn >1 ) as duplicates 
on p.order_id = duplicates.order_id ;

with numbered as (
select order_id, row_number() over(order by order_id) as id
from pharmaceutical_sales )
update pharmaceutical_sales p
join numbered n on p.order_id = n.order_id
set p.order_id = n.id;

-- ==============================
-- ANALYSIS
-- ==============================

select medicine, sum(quantity) as total_quantity 
from pharmaceutical_sales
group by medicine
order by total_quantity desc
limit 10; 

select medicine, sum(total_amount) as total_revenue
from pharmaceutical_sales
group by medicine 
order by total_revenue desc 
limit 10;

select city,sum(total_amount) as highest_sales
from pharmaceutical_sales
group by city
order by highest_sales
limit 10;

select doctor_name, sum(total_amount) as doctor_revenue
from pharmaceutical_sales
group by doctor_name
order by doctor_revenue desc
limit 10;

SELECT 
    DATE_FORMAT(prescription_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_revenue
FROM pharmaceutical_sales
GROUP BY month
ORDER BY month;

select category, medicine, sum(total_amount) as revenue 
from pharmaceutical_sales
where category = 'Diabetes'
group by category,medicine
order by revenue;

-- ==============================
-- Outlier detection
-- ==============================

select * from pharmaceutical_sales;

WITH stats AS (
  WITH Ordered AS (
    SELECT 
        total_amount,
        NTILE(4) OVER (ORDER BY total_amount) AS quartile
    FROM pharmaceutical_sales
  )
  SELECT
      MIN(CASE WHEN quartile = 1 THEN total_amount END) AS Q1,
      MAX(CASE WHEN quartile = 3 THEN total_amount END) AS Q3
  FROM Ordered
)
SELECT t.*
FROM  pharmaceutical_sales t
JOIN stats s
ON t.total_amount < (s.Q1 - 1.5*(s.Q3 - s.Q1))
   OR
   t.total_amount > (s.Q3 + 1.5*(s.Q3 - s.Q1));
