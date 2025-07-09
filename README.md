# 📊 MySQL Social Media Analytics – Query Collection

This project contains a curated set of 16 MySQL queries that analyze a **social media platform's user activity**, including posts, likes, comments, hashtags, logins, and follower behavior.

All queries are written, tested, and optimized for **MySQL**. They're ideal for understanding how to write complex SQL logic for analytics and user behavior tracking.

---

## 📁 File Structure

```
├── data_script.sql             # SQL script to create and populate the database
├── social_media_queries.sql    # Main SQL script (16 queries with comments)
├── ER Diagram.png              # Entity-Relationship Diagram
└── README.md                   # You're here!
```

---

## 🧩 ER Diagram

Here’s the entity-relationship diagram of the database schema:

![ER Diagram](ER%20Diagram.png)

---

## 🚀 Getting Started

### 1. Setup the Database

Before running the queries, you need to create and populate the database:

```sql
-- Run this first
source data_script.sql;
```

This script will create all the necessary tables and insert data that matches the ER diagram.

### 2. Run the Analytics Queries

```sql
-- Then run the analytical queries
source social_media_queries.sql;
```

You can run them using any MySQL client (e.g., MySQL Workbench, phpMyAdmin, or CLI).

---

## 📌 Topics Covered in the Queries

| #  | Description |
|----|-------------|
| 1  | Users who have posted and are located in Agra, Maharashtra, or West Bengal |
| 2  | Count of followers for each hashtag |
| 3  | Top 10 most used hashtags on posts |
| 4  | Users who have never posted |
| 5  | Posts ranked by total number of likes |
| 6  | Average number of posts per user (two methods shown) |
| 7  | Total number of logins per user |
| 8  | Users who have liked **every post** |
| 9  | Users who have **not commented** on any post (via `LEFT JOIN` or `NOT IN`) |
| 10 | Users who have commented on **every post** |
| 11 | Users who have **no followers** |
| 12 | Users who are **not following anyone** |
| 13 | Users who posted **more than 5 times** |
| 14 | Users who have **more than 40 followers** |
| 15 | Comments containing the words "good" or "beautiful" |
| 16 | Top 5 posts with the **longest captions** |

---

## 🛠️ Technologies Used

- **MySQL** (tested on version 8.x, compatible with 5.x)
- SQL joins, subqueries, aggregation functions
- Logical operators, pattern matching, filtering

---

## 🎯 Use Cases

- SQL portfolio or GitHub showcase
- Interview prep (SQL joins, aggregations, analytics)
- Practice project for data analysts or engineers

---

## 🙋‍♀️ Author

Created by [Soham S Rikame (cazual-coder)]  
Feel free to fork, contribute, or open issues!

---

## 📄 License

This project is open source.
