# chinook-sql-analysis
# 🎵 Chinook SQL Analysis Project

This project demonstrates practical SQL analysis using a **custom version** of the Chinook music store database. It includes queries that extract business insights related to customers, sales, tracks, genres, revenue, and more — ideal for analytics portfolios and interview preparation.

---


---

## 🔍 Features Covered

- Track details and pricing
- Customer profiles and regions
- Album–Artist relationships
- Playlist contents and size
- Top-selling tracks by quantity
- Genre-wise revenue and pricing trends
- Invoice totals by country and customer

---

## 🗂️ Dataset

The project uses a **custom CSV version of the Chinook Database**:


The dataset includes:
- Track
- Album
- Artist
- Customer
- Invoice
- Playlist
- Genre
- MediaType
- Employee
- InvoiceLine

> 🔧 You can load this CSV into any SQL-compatible platform (e.g., PostgreSQL, MySQL, SQLite) using built-in import tools or SQL loaders.

---

## 🧠 Sample Query Example

```sql
-- List all albums with their artist names
SELECT Alb."Title", Art."Name"
FROM "Album" AS Alb
JOIN "Artist" AS Art ON Alb."ArtistId" = Art."ArtistId";
