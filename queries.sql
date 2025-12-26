-- USERS TABLE
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  email varchar(150) UNIQUE NOT NULL,
  password varchar(255),
  phone varchar(20),
  role varchar(20) CHECK (role IN ('Admin', 'Customer')) NOT NULL
);


-- Insert user datad Into user table
INSERT INTO
  users (user_id, name, email, phone, role)
VALUES
  (
    1,
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  (
    2,
    'Bob',
    'bob@example.com',
    '0987654321',
    'Admin'
  ),
  (
    3,
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  );


-- VEHICLES TABLE
CREATE TABLE vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  type varchar(20) CHECK (type IN ('car', 'bike', 'truck')) NOT NULL,
  model int NOT NULL,
  registration_number varchar(50) UNIQUE NOT NULL,
  rental_price int NOT NULL,
  status varchar(20) CHECK (status IN ('available', 'rented', 'maintenance')) NOT NULL
);


INSERT INTO vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');



-- BOOKINGS TABLE
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id int NOT NULL,
  vehicle_id int NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status varchar(20) CHECK (
    status IN ('pending', 'confirmed', 'completed', 'cancelled')
  ) NOT NULL,
  total_cost int NOT NULL,
  CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT fk_bookings_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id) ON DELETE CASCADE
);


INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

-- INDEXES
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_vehicle_id ON bookings (vehicle_id);
CREATE INDEX idx_vehicles_type_status ON vehicles (type, status);



-- ALL QUERY

-- Query 1: JOIN
-- Requirement: Retrieve booking information along with Customer name and Vehicle name.

SELECT 
  b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
  from bookings b
  
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id



-- Query 2: EXISTS
-- Requirement: Find all vehicles that have never been booked.
  
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
)
ORDER BY vehicle_id;


-- Query 3: WHERE
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).

SELECT *
FROM vehicles
WHERE type = 'car'


-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.



SELECT 
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b 
    ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;



