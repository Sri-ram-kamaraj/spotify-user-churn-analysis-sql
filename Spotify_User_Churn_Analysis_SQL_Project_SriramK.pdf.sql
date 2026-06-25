CREATE DATABASE IF NOT EXISTS spotify_churn_analysis;
USE spotify_churn_analysis;

DROP TABLE IF EXISTS customer_;


CREATE TABLE spotify_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    gender VARCHAR(10),
    age INT,
    country VARCHAR(10),
    subscription_type VARCHAR(20),  -- Free, Premium, Student, Family
    listening_time INT,             -- Daily minutes
    songs_played_per_day INT,
    skip_rate DECIMAL(4,2),         -- e.g., 0.15 = 15% skips
    device_type VARCHAR(20),        -- Mobile, Desktop, Web
    ads_listened_per_week INT,
    offline_listening INT,          -- 1 = Yes, 0 = No
    is_churned INT                  -- 1 = Unsubscribed, 0 = Active
);


INSERT INTO spotify_users (gender, age, country, subscription_type, listening_time, songs_played_per_day, skip_rate, device_type, ads_listened_per_week, offline_listening, is_churned) VALUES
('Female', 54, 'CA', 'Free', 26, 23, 0.20, 'Desktop', 31, 0, 1),
('Other', 33, 'DE', 'Family', 141, 62, 0.34, 'Web', 0, 1, 0),
('Male', 38, 'AU', 'Premium', 199, 38, 0.04, 'Mobile', 0, 1, 1),
('Female', 22, 'CA', 'Student', 36, 2, 0.31, 'Mobile', 0, 1, 0),
('Other', 29, 'US', 'Family', 250, 57, 0.36, 'Mobile', 0, 1, 1),
('Male', 41, 'IN', 'Premium', 210, 85, 0.05, 'Mobile', 0, 1, 0),
('Female', 19, 'PK', 'Free', 15, 4, 0.58, 'Web', 45, 0, 1),
('Male', 25, 'US', 'Student', 180, 48, 0.12, 'Desktop', 12, 0, 0),
('Female', 31, 'UK', 'Premium', 285, 90, 0.02, 'Mobile', 0, 1, 0),
('Male', 48, 'FR', 'Free', 45, 12, 0.40, 'Desktop', 28, 0, 1),
('Other', 21, 'IN', 'Student', 135, 33, 0.22, 'Mobile', 8, 1, 0),
('Female', 35, 'DE', 'Premium', 25, 3, 0.55, 'Web', 0, 0, 1),
('Male', 28, 'US', 'Free', 60, 18, 0.25, 'Desktop', 20, 0, 0),
('Female', 44, 'AU', 'Family', 165, 50, 0.08, 'Mobile', 0, 1, 0),
('Male', 23, 'PK', 'Student', 190, 72, 0.07, 'Mobile', 0, 1, 0);

SELECT COUNT(*) FROM spotify_users ;

 
SELECT  country ,COUNT(*) as users_by_country
FROM spotify_users 
group by country 
order by  COUNT(*) desc;

SELECT  subscription_type ,COUNT(*) as users_by_sub_type
FROM spotify_users 
group by subscription_type ;

select avg (listening_time)  as AVG_listening
FROM spotify_users ;

select *
FROM spotify_users
order by listening_time desc
limit 5;


SELECT 
    subscription_type,
    COUNT(*) AS total_users,
    SUM(is_churned) AS churned_users,
    ROUND((SUM(is_churned) / COUNT(*)) * 100, 2) AS churn_rate_percentage
FROM spotify_users
GROUP BY subscription_type
ORDER BY churn_rate_percentage DESC;


SELECT subscription_type,
round(avg(listening_time),2) as avg_listening_time
FROM spotify_users 
group by subscription_type;

SELECT subscription_type,
round(avg(skip_rate),2) as avg_skip_rate
FROM spotify_users 
group by subscription_type;


SELECT device_type,
       COUNT(*) AS total_users
FROM spotify_users
GROUP BY device_type
ORDER BY total_users DESC;

select device_type,
round(avg(listening_time),2) as avg_listening_time
FROM spotify_users
GROUP BY device_type
ORDER BY avg(listening_time) DESC;

select sum(is_churned) as total_churned
FROM spotify_users;

select
case when is_churned =1 then 'Cancelled (Churned)'
 else 'Active user' end as user_status,
 round ( avg (listening_time),1) as avg_lis,
  round ( avg (songs_played_per_day),1) as avg_songs_played,
   round ( avg ( ads_listened_per_week),1)as avg_ads,
    round ( avg ( skip_rate),1)as avg_skip
    from spotify_users
    GROUP BY is_churned;
     
SELECT 
    device_type,
    COUNT(*) AS total_users,
    SUM(is_churned) AS churned_users,
    ROUND((SUM(is_churned) / COUNT(*)) * 100, 2) AS churn_rate_percentage
FROM spotify_users
GROUP BY device_type
ORDER BY churn_rate_percentage DESC;


SELECT subscription_type,
       COUNT(*) AS total_users
FROM spotify_users
GROUP BY subscription_type
having COUNT(*) >3;


select  user_id,listening_time
from spotify_users
where listening_time >
        ( 
        select avg (listening_time)
        from spotify_users);
        
        
        
        
select  user_id,skip_rate
from spotify_users
where skip_rate >

  ( 
        select avg (skip_rate)
        from spotify_users)
        limit 2;
        

select user_id,
       listening_time,
       row_number () over ( order by  listening_time desc) as row_num
 from spotify_users ;   
 
 
     
     
     
        
        
 select user_id,       
      rank() over ( order by  listening_time desc) as rank_num
 from spotify_users   
limit 5;  



select user_id,
      subscription_type,
      rank() over ( order by subscription_type desc) as rank_num
 from spotify_users ;   
 
 select user_id,
      subscription_type,
      dense_rank() over ( order by subscription_type desc) as dense_rank_num
 from spotify_users ;  
  
  
  create view churned_summary as
 SELECT subscription_type,
       COUNT(*) AS total_users,
       sum(is_churned) AS churned_users
FROM spotify_users
GROUP BY subscription_type;

select * from churned_summary;

select country,
round(avg(listening_time),2) as avg_listening_time
FROM spotify_users
GROUP BY country
ORDER BY avg(listening_time) DESC
limit 5;

select  user_id,
listening_time
from spotify_users
order by listening_time desc
limit 3;
   
SELECT country,
       COUNT(*) AS total_users,
       SUM(is_churned) AS churned_users
FROM spotify_users
GROUP BY country
ORDER BY churned_users DESC; 
	
        












