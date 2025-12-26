# Vehicle Rental System Database

A simple **database** for managing vehicle rentals, built with **PostgreSQL**. It includes tables for user, vehicle inventory, and booking tracking along with sample queries for common operations.

---

## 🔹 Features

- **User** – Admin and Customer roles  
- **Vehicle Inventory** – Cars, Bikes, and Trucks with status tracking (`available`, `rented`, `maintenance`)  
- **Booking System** – Track bookings with start/end dates, total cost, and status (`pending`, `confirmed`, `completed`, `cancelled`)  
- **Sample Queries** – JOIN, EXISTS, WHERE, GROUP BY, HAVING  

---

## 🔹 Database Design

## 🔹 Database Design

🔗 [View ERD Diagram](https://drawsql.app/teams/md-salauddin/diagrams/vehicle-rental-system-database-design)

- Tables: `users`, `vehicles`, `bookings`  
- Relationships:  
  - One `user` can have many `bookings`  
  - One `vehicle` can have many `bookings`  

---

## 🔹 ALL Queries
- Retrieve booking info with customer & vehicle names  
- Find vehicles never booked  
- List available vehicles of a specific type  
- Count total bookings per vehicle  

---

## 🔹 Viva/Presentation

- **Viva Video:** [Watch Video](https://drive.google.com/file/d/1yaIFro-6yAP79GfXuxzXX_p6Y6bKaE9b/view?usp=drivesdk)  

---

## 🔹 Setup Instructions

1. Create a PostgreSQL database.  
2. Run the provided SQL scripts to create the tables: `users`, `vehicles`, `bookings`.  
3. Insert the sample data.  
4. Run sample queries to explore the database structure and relationships.  
