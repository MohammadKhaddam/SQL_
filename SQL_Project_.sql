/** This project is for demonstration purposes only, where I write and execute SQL queries to answer some questions to showcase 
my abilities to write SQL queries.
I will use a hospital database that contains fake data with four tables: Patents, admissions, doctors, and province names.
The questions will range from easy level to advanced level questions.*/

/**Question 1: Show first name of patients that start with the letter 'C' */
select first_name from patients
where first_name like "C%";

/**Question 2: Show first name and last name of patients who does not have allergies. */
select first_name, last_name from patients 
where allergies is NULL;

/**Question 3: Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)*/
select first_name, last_name from patients
where weight  between 100 and 120;

/**Question 4: Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */
update patients 
set allergies='NKA'
where allergies is null;

/**Question 5: Show first name, last name, and the full province name of each patient. */
select pa.first_name, pa.last_name, pr.province_name from patients as pa, province_names as pr
where pa.province_id=pr.province_id;

/**Question 6: Show the first_name, last_name, and height of the patient with the greatest height. */
select first_name, last_name, max(height) from patients;

/**Question 7: Show all the columns from admissions where the patient was admitted and discharged on the same day.*/
select * from admissions
where admission_date=discharge_date;

/**Question 8: Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null */
select first_name,last_name,allergies from patients 
where city='Hamilton' and allergies is not NULL;

/**Question 9: Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). 
Show the result order in ascending by city. */
select distinct(city) from patients
where city like 'a%' or city like 'e%' or city like 'o%' or city like 'i%' or city like 'u%'
order by city asc;
/**or**/
select distinct(city) from patients
where substr(city,1,1) in ('a','e','o','i','u')
order by city asc;
 
/**Question 10: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.*/
select patient_id, first_name from patients
where lower(first_name) like 's%____%s';

/**Question 11: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table. */
select pa.patient_id, pa.first_name, ad.last_name from patients as pa, admissions as ad
where pa.patient_id=ad.patient_id and ad.diagnosis='Dementia';

/**Question 12: Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */

SELECT  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
		(SELECT count(*) FROM patients WHERE gender='F') AS female_count;

/**Question 13: Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
select patient_id, diagnosis from admissions
group by patient_id, diagnosis
having count(*)>1;

/**Question 14: Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.*/
select city, count(first_name) as num_patients from patients
group by city
order by num_patients desc, city asc;


/**Question 15: Display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters.
 Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane */
select concat(upper(last_name),',',lower(first_name)) as new_name_format from patients
order by first_name desc;


/**Question 16: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
select max(weight)-min(weight) as weight_delta from patients
where last_name ='Maroni';

/**Question 17: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
Sort by the day with most admissions to least admissions. */
SELECT DAY(admission_date) AS day_number, COUNT(*) AS number_of_admissions FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;

/**Question 18: Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30. Weight is in units kg and height is in units cm. */
select patient_id, weight, height, case
                                when weight/(POWER(height/100.0,2)) >= 30 then 1
                                else  0 end as isObese from patients;

/**Question 19: Show patient_id, first_name, last_name, and attending doctor's specialty. 
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa' */
select pat.patient_id, pat.first_name, pat.last_name, doc.specialty from patients as pat
join admissions as ad
on pat.patient_id = ad.patient_id
join doctors as doc
on ad.attending_doctor_id = doc.doctor_id
where ad.diagnosis = 'Epilepsy' and doc.first_name='Lisa';

/**Question 20: All patients who have gone through admissions, can see their medical documents on our site.
 Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date */

select pat.patient_id, concat(ad.patient_id,length(pat.last_name),year(pat.birth_date)) as temp_password
from patients as pat
join admissions as ad
on pat.patient_id = ad.patient_id
group by ad.patient_id






