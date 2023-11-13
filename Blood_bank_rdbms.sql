SELECT * FROM BB_Manager;
SELECT * FROM blood_donor;
SELECT * FROM bloodspecimen;
SELECT * FROM city;
SELECT * FROM diseasefinder;
SELECT * FROM recipient;
SELECT * FROM recording_staff;
SELECT * FROM hospital_info_1;
SELECT * FROM hospital_info_2;


-- 1. recipients and donors names having the same blood group registered on the same date and the name of recording staff name.
select Blood_Donor.bd_name,Recipient.reci_name,reco_Name 
from Recording_Staff  
inner join Blood_Donor 
on Recording_Staff.reco_ID = Blood_Donor.reco_ID 
inner join Recipient on Recording_Staff.reco_ID = Recipient.reco_ID 
where Blood_Donor.bd_Bgroup = Recipient.reci_Brgp and Blood_Donor.bd_reg_date = Recipient.reci_reg_date;

-- 2. Show the blood specimen verified by disease finder shivam which are pure (status=1)
Select specimen_number,b_group 
from BloodSpecimen,DiseaseFinder 
WHERE BloodSpecimen.dfind_ID= DiseaseFinder.dfind_ID AND dfind_name='shivam' AND status=1;

-- 3. blood donors who haven't donated in the last six months
SELECT bd_name, MAX(bd_reg_date) AS LastDonationDate
FROM Blood_Donor
GROUP BY bd_name
HAVING LastDonationDate < CURDATE() - INTERVAL 6 MONTH;

-- 4. total cities count of the blood donated by donors for each blood group:
SELECT bd_Bgroup, count(City_name) AS Total_cities_count
FROM Blood_Donor
JOIN City ON Blood_Donor.City_ID = City.City_ID
GROUP BY bd_bgroup;

-- 5. the total quantity of blood donated by donors from each city
SELECT c.City_name, SUM(r.reci_Bqnty) AS TotalDonation
FROM recipient r
JOIN City c ON r.City_ID = c.City_ID
GROUP BY c.City_name;

-- 6. percentage of each blood group in the total blood quantity:
SELECT b.bd_Bgroup, (SUM(r.reci_Bqnty) / (SELECT SUM(reci_Bqnty) FROM recipient)) * 100 AS Percentage
FROM Blood_Donor b
JOIN recipient r on b.city_id = r.city_id
GROUP BY b.bd_Bgroup;

-- 7. Hospitals That Haven't Specified Blood Requirements
SELECT Hospital_Info_1.hosp_name
FROM Hospital_Info_1
LEFT JOIN Hospital_Info_2 ON Hospital_Info_1.hosp_ID = Hospital_Info_2.hosp_ID
WHERE Hospital_Info_2.hosp_needed_Bgrp IS NULL;

-- 8. the Average Age of Recipients
SELECT AVG(CAST(reci_age AS DECIMAL(10,2))) AS average_age
FROM Recipient
WHERE reci_age IS NOT NULL;

-- 9. Hospitals in a Specific City Managed by a Specific Manager
SELECT Hospital_Info_1.hosp_name, City.City_name, BB_Manager.mName
FROM Hospital_Info_1
JOIN City ON Hospital_Info_1.City_ID = City.City_ID
JOIN BB_Manager ON Hospital_Info_1.M_id = BB_Manager.M_id;

-- 10. Retrieve Blood Specimens with Manager and Disease Finder Information
SELECT BloodSpecimen.*, BB_Manager.mName, DiseaseFinder.dfind_name
FROM BloodSpecimen
JOIN BB_Manager ON BloodSpecimen.M_id = BB_Manager.M_id
JOIN DiseaseFinder ON BloodSpecimen.dfind_ID = DiseaseFinder.dfind_ID;

-- 11.List Hospitals and the Required Blood Groups with Quantities:
SELECT Hospital_Info_1.hosp_name, Hospital_Info_2.hosp_needed_Bgrp, Hospital_Info_2.hosp_needed_qnty
FROM Hospital_Info_1
LEFT JOIN Hospital_Info_2 ON Hospital_Info_1.hosp_ID = Hospital_Info_2.hosp_ID;

-- 12. Calculate the Rank of Blood Donors Based on Blood Quantity, Partitioned by Blood Group
SELECT
    bd_ID,
	bd_Bgroup,
    RANK() OVER (PARTITION BY bd_Bgroup ORDER BY bd_ID DESC) AS blood_donor_rank
FROM Blood_Donor;

-- 13. Determine the Lead Blood Group Needed by Each Hospital in Hospital_Info_2:
SELECT
    hosp_ID,
    hosp_name,
    hosp_needed_Bgrp,
    LEAD(hosp_needed_Bgrp) OVER (PARTITION BY hosp_ID ORDER BY hosp_needed_Bgrp) AS lead_blood_group
FROM Hospital_Info_2;

-- 14. the Recipients with Blood Quantity Below the Average for Their Age Group:
SELECT
    reci_ID,
    reci_name,
    reci_age,
    reci_Bqnty
FROM (
    SELECT
        reci_ID,
        reci_name,
        reci_age,
        reci_Bqnty,
        AVG(reci_Bqnty) OVER (PARTITION BY reci_age) AS avg_blood_quantity
    FROM Recipient
) AS RecipientsWithAvg
WHERE reci_Bqnty < avg_blood_quantity;

-- 15. Percentage of Blood Donors for Each Recording Staff:
SELECT
    rs.reco_ID,
    rs.reco_Name,
    COUNT(bd.bd_ID) AS total_donors,
    COUNT(bd.bd_ID) * 100.0 / SUM(COUNT(bd.bd_ID)) OVER () AS percentage
FROM Recording_Staff rs
LEFT JOIN Blood_Donor bd ON rs.reco_ID = bd.reco_ID
GROUP BY rs.reco_ID, rs.reco_Name;



















