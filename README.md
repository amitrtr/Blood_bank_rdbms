# Blood_bank_rdbms Using MySQL
This project aims to develop a Blood Bank Management System and our system can be used to find required type of blood in emergency situations from either blood bank or even blood donors.
BLOOD BANK MANAGEMENT SYSTEM
 ABOUT THE PROJECT	:
This project aims to develop a Blood Bank Management System. A Blood Bank Management System can be used in any clinic, hospital, labs or any emergency situation which requires blood units for survival. Our system can be used to find required type of blood in emergency situations from either blood bank or even blood donors.  Current system uses a grapevine communication for finding blood in cases of emergency, may it be by a donor or blood bank. The intentions of proposing such a system is to abolish the panic caused during an emergency due to unavailability of blood.

RELATIONAL SCHEMAS:
Donor Table:  
• The relationship with Recording staff and Donor is 1 to many. That’s why primary key of Recording staff is used as a foreign key in Donor. 
• The relationship with City and Donor  is  1  to  many.  That’s why primary key of City is used as a foreign key in Donor.   
Recipient Table:  
•  The relationship  with  Recording  staff  and  Blood  Recipient  is  1  to many. That’s why primary key of Recording staff is used as a foreign key in Blood Recipient.  
• The relationship with City and Blood Recipient is 1 to many. That’s why primary key of City is used as a foreign key in Blood Recipient.  
• The relationship with Blood Bank Manager and Blood Recipient is 1 to many.  That’s why primary  key  of  Blood  Specimen  is  used  as  a foreign key in Blood Recipient.   
City Table:  
• The relationship between City and Recipients, Donor, Hospital info are all  of  1  to  many. So that’s why primary  key of  City  is  used  as  a foreign key in Recipients, Donor and Hospital info.   
Recording Staff Table:  
•  The relationship between Recording  Staff  and  Blood  Donor, Recipients  are  all  of  1  to  many.  That’s why the primary  key  of Recording staff is used as a foreign key in Donor and Recipient.   
Blood Specimen Table:  
•  The relationship with Disease finder and  Blood  Specimen  is  1  to many. That’s why primary key of Disease finder is used as a foreign key in Blood Specimen.
Disease Finder Table: 
• The relationship with Disease finder and Blood Specimen is of 1 to many. Therefore, the primary key of Disease finder is used as a foreign key in Blood Specimen.   

Blood Bank Manager Table:  
• The relationship between Blood Bank Manager and Blood Specimen, Recipient, Hospital info are all of 1 to many. So therefore, the primary key of Blood Bank Manager is used as a foreign key in Blood Specimen, Recipient and Hospital info.  
Hospital info Table:    
• The relationship with City and Hospital info is 1 to many. That’s why primary key of City is used as a foreign key in Hospital info.  
• The relationship with Blood Bank Manager and Hospital info is 1 to many.  That’s  why  primary  key  of  Blood  Bank  manager  is  used  as  a foreign key in Hospital info.

SCHEMA DIAGRAM OF RDBMS:

 


