-- ============================================================
-- Title:  MySQL Query Collection – Social Media Analytics
-- Author: [Soham S Rikame]
-- Date:   2025-07-08
-- Description:
--   This SQL script contains 16 queries run on a sample social
--   media database. It covers user engagement, post statistics,
--   hashtag analysis, login data, follower/following behavior,
--   and content metrics.
--   The script is written and tested on MySQL.
-- ============================================================

USE social_media;

-- ------------------------------------------------------------
-- 1. Users from specific locations who have posted content
-- ------------------------------------------------------------

SELECT DISTINCT username
FROM users u
JOIN post p ON u.user_id = p.user_id
WHERE location IN ('Agra', 'Maharashtra', 'West Bengal');

-- ------------------------------------------------------------
-- 2. Count of followers per hashtag (popularity ranking)
-- ------------------------------------------------------------

SELECT hashtag_name, COUNT(hf.user_id) AS counts
FROM hashtags h 
JOIN hashtag_follow hf ON h.hashtag_id = hf.hashtag_id 
GROUP BY hashtag_name
ORDER BY counts DESC;

-- ------------------------------------------------------------
-- 3. Top 10 most used hashtags across all posts
-- ------------------------------------------------------------

SELECT h.hashtag_name, COUNT(p.post_id) AS counts
FROM hashtags h
JOIN post_tags p ON h.hashtag_id = p.hashtag_id
GROUP BY h.hashtag_name
ORDER BY counts DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 4. Users who have never posted
-- ------------------------------------------------------------

SELECT u.username 
FROM users u
LEFT JOIN post p ON u.user_id = p.user_id
WHERE p.post_id IS NULL;

-- ------------------------------------------------------------
-- 5. Posts with their like counts (sorted by popularity)
-- ------------------------------------------------------------

SELECT p.post_id, COUNT(pl.post_id) AS like_counts 
FROM post p
JOIN post_likes pl ON p.post_id = pl.post_id
GROUP BY p.post_id
ORDER BY like_counts DESC;

-- ------------------------------------------------------------
-- 6. Average number of posts per user (two approaches)
-- ------------------------------------------------------------

SELECT u.username, AVG(p.post_id) AS avg_posts
FROM users u
LEFT JOIN post p ON u.user_id = p.user_id
GROUP BY u.username;

-- OR

SELECT COUNT(post_id) / COUNT(DISTINCT user_id) AS avg_post
FROM post;

-- ------------------------------------------------------------
-- 7. Total number of logins per user
-- ------------------------------------------------------------

SELECT user_id, COUNT(login_id) AS total_logins 
FROM login
GROUP BY user_id
ORDER BY total_logins DESC;

-- ------------------------------------------------------------
-- 8. Users who have liked every post
-- ------------------------------------------------------------

SELECT u.user_id, u.username
FROM users u
JOIN (
    SELECT pl.user_id
    FROM post_likes pl
    GROUP BY pl.user_id
    HAVING COUNT(DISTINCT pl.post_id) = (SELECT COUNT(*) FROM post)
) liked_all ON u.user_id = liked_all.user_id;

-- ------------------------------------------------------------
-- 9. Users who have not commented on any post
-- ------------------------------------------------------------

SELECT *
FROM users u
LEFT JOIN comments c ON u.user_id = c.user_id
WHERE c.user_id IS NULL;

-- OR

SELECT * 
FROM users 
WHERE user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM comments
);

-- ------------------------------------------------------------
-- 10. Users who have commented on every post
-- ------------------------------------------------------------

SELECT u.user_id, u.username
FROM users u
JOIN (
    SELECT c.user_id
    FROM comments c
    GROUP BY c.user_id
    HAVING COUNT(DISTINCT c.post_id) = (SELECT COUNT(*) FROM post)
) AS users_commented_all_posts ON u.user_id = users_commented_all_posts.user_id;

-- ------------------------------------------------------------
-- 11. Users who have no followers
-- ------------------------------------------------------------

SELECT u.user_id
FROM users u
LEFT JOIN follows f ON u.user_id = f.followee_id
WHERE f.follower_id IS NULL;

-- ------------------------------------------------------------
-- 12. Users who are not following anyone
-- ------------------------------------------------------------

SELECT user_id 
FROM users 
WHERE user_id NOT IN (
    SELECT DISTINCT follower_id 
    FROM follows
);

-- ------------------------------------------------------------
-- 13. Users who have posted more than 5 times
-- ------------------------------------------------------------

SELECT user_id, COUNT(DISTINCT post_id) AS total_post
FROM post
GROUP BY user_id
HAVING total_post > 5
ORDER BY total_post DESC;

-- ------------------------------------------------------------
-- 14. Users who have more than 40 followers
-- ------------------------------------------------------------

SELECT username
FROM users u 
JOIN (
    SELECT followee_id, COUNT(DISTINCT follower_id) AS total_followers 
    FROM follows
    GROUP BY followee_id
    HAVING total_followers > 40
) AS followers ON followers.followee_id = u.user_id;

-- ------------------------------------------------------------
-- 15. Comments containing specific keywords ("good", "beautiful")
-- ------------------------------------------------------------

SELECT * 
FROM comments
WHERE comment_text LIKE '%good%' 
   OR comment_text LIKE '%beautiful%';

-- ------------------------------------------------------------
-- 16. Top 5 longest captions among posts
-- ------------------------------------------------------------

SELECT *, LENGTH(caption) AS caption_length
FROM post
ORDER BY caption_length DESC
LIMIT 5;
