-- PROJECT  = SOCIAL MEDIA DATA ANALYSIS


-- Designed and implemented a MySQL-based social media analysis project, 
-- leveraging relational database capabilities to efficiently 
-- store, retrieve, and analyze extensive social media data. 
-- Developed features including user profiles, post storage, s
-- entiment analysis, and trend tracking to provide 
-- aluable insights into user behavior and trending topics. 
-- Demonstrated proficiency in database management for 
-- effective data organization and retrieval, showcasing 
-- a keen understanding of scalable and well-structured MySQL systems

USE social_media;
SELECT * FROM post;
SELECT * FROM users;
SELECT * FROM login;


# 1. display location of users from MH,DELHI,AGRA
SELECT location from post;
 -- no specific location is present
 
 # 2. TOTAL POST
 SELECT count(*) FROM post;
 -- TOTAL 100 POSTS ARE DONE BY USERS
 
 
 #3. TOTAL USERS
  SELECT count(*) FROM users;
  -- TOTAL 50 users ARE DONE.
  
  SELECT count(*)/( SELECT count(*) FROM users) AVRG_POST FROM post;
  SELECT round (count(post_id)/count( DISTINCT user_id)) AVRG_POST FROM post;
  -- on an avrg. 2 post are done by each users
  
  #5. DISPLAY USRES WHO HAVE DONE 5 OR MORE POST
  SELECT u1.username,count(p1.post_id) as total_post FROM post p1
  INNER JOIN users u1
  ON U1.user_id=p1.user_id
  GROUP BY u1.username
  HAVING total_post>=5;
  
  -- 4 usres have posted 5/ more post
  
  # DISPLAY USRES WITH 0 COMMENT
   SELECT u1.user_id,u1.username,count(c1.comment_id) as total_comment FROM users u1
  LEFT JOIN comments c1
  ON U1.user_id=c1.user_id
  GROUP BY u1.username
  HAVING total_comment=0;
  
  -- only one user have not commented
          # or
  select username,user_id from users
  where user_id not in (select user_id from comments);
  
  
  # MOST TRENDING HASHTAG
  SELECT h1.hashtag_id,h2.hashtag_name,count(*) FROM hashtag_follow h1
  inner join hashtags h2
  on h1.hashtag_id=h2.hashtag_id
  group by hashtag_id
  order by 3 desc limit 1;
  
  --  MOST TRENDING HASHTAG is  #festivesale in our data
 
 USE social_media; 
  # TASK 8.DISPLAY USERS WHO DONT FOLLOW ANYBODY
 select user_id,username from users
  where user_id not in (select follower_id from follows);
  -- no such user who dont follow any one
  
  # TASK 9. MOST INACTIVE USER 
 select username,user_id from users
  where user_id not in (select user_id from post);
  
  #task 10. find bot i.e users who commented on every post
  
   SELECT username,count(*) as num_comment FROM users u1
  LEFT JOIN comments c1
  ON U1.user_id=c1.user_id
  GROUP BY u1.username
  having num_comment=(select count(distinct post_id) from comments);
  
  #TASK 10= users who like every post
SELECT username,count(*),POST_ID as num_post FROM users u1
INNER JOIN post_likes p1
ON U1.user_id=p1.user_id
GROUP BY p1.user_id
having num_post=(select count(distinct post_id) from post_likes);
  
  #TASK 10. DISPLAY MOST LIKED POST
with cte1 as(SELECT post_id,count(*) as countlike
from post_likes
group by post_id 
order by 2 desc limit 1)
 select post_id,user_id,caption
 FROM post where post_id=(select post_id from cte1);
 
 # task13. people who have using the platform for the longesst time
 select username,user_id, created_at from users order by 3 limit 5;
 
 # tasl 14. find the longest caption
 select user_id,post_id ,caption,length(caption) from post order by 4 desc limit 5;
 
 # task 15. find users who has >40 followers
 select followee_id,count(follower_id) as follower_count from follows
 group by followee_id
 having follower_count>40
 order by 2 ;
 
 -- composite key concept
 -- syntax=
/* CREATE TABLE example_table (
    column1 INT,
    column2 INT,
    column3 VARCHAR(255),
    PRIMARY KEY (column1, column2)
);*/
  
  
  -- TASK 16 comments eith good|beautiful
  select comment_text
  from comments
  where comment_text regexp 'good|beautiful';
  
  