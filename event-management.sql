-- Active: 1731724539000@@127.0.0.1@3306
CREATE DATABASE Event_management;
USE Event_management;

-- Create a user for event management
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,          
    name VARCHAR(100) NOT NULL,                     
    email VARCHAR(100) UNIQUE NOT NULL,      
    password VARCHAR(255) NOT NULL,   
    phoneNumber VARCHAR(15),                     
    role ENUM('user', 'organizer', 'admin','super_admin') DEFAULT 'user',                  
    bio TEXT,                                       
    address VARCHAR(255),                           
    date_of_birth DATE,
    is_active BOOLEAN DEFAULT TRUE,       
   
);

-- Insert the value for user table
INSERT INTO Users (
    name, 
    email, 
    password, 
    phoneNumber, 
    role, 
    bio, 
    address, 
    date_of_birth, 
    is_active
) VALUES 
('Mizanur Rahman', 'mizanur.rahman@gmail.com', 'user12345', '01712345678', 'user', 'A software developer from Dhaka, Bangladesh with a passion for web development and mobile apps.', 'House 123, Road 10, Dhanmondi, Dhaka, Bangladesh', '1990-05-15', TRUE),
('Shamima Akter', 'shamima.akter@gmail.com', 'organizer12345', '01823456789', 'organizer', 'Event organizer who specializes in large-scale corporate events in Dhaka and Chittagong.', 'Block A, Gulshan-1, Dhaka, Bangladesh', '1985-08-25', TRUE),
('Aminul Islam', 'aminul.islam@gmail.com', 'admin12345', '01987654321', 'admin', 'Experienced admin managing web infrastructure and cloud services for leading companies in Bangladesh.', '15/1, Banani C/A, Dhaka, Bangladesh', '1982-12-10', TRUE),
('Rupom Hossain', 'rupom.hossain@gmail.com', 'user12345', '01876543210', 'user', 'Outdoor enthusiast who loves exploring the scenic beauty of Bangladesh, particularly in Sylhet and the Sundarbans.', 'Block B, Uttara, Dhaka, Bangladesh', '1995-02-20', FALSE),
('Sultana Begum', 'sultana.begum@gmail.com', 'admin12345', '01734567890', 'super_admin', 'Super admin with extensive experience in managing databases, security, and user roles in large tech companies.', '24, Mouchak, Motijheel, Dhaka, Bangladesh', '1978-07-30', TRUE),
('Farhan Khan', 'farhan.khan@gmail.com', 'user12345', '01722334455', 'user', 'Tech enthusiast and software engineer, focusing on AI and machine learning applications for local startups.', 'House 76, Mirpur-12, Dhaka, Bangladesh', '1992-04-05', TRUE);

-- show user table info
SELECT * FROM Users;
SELECT * FROM Users WHERE user_id = 1;
SELECT * FROM Users WHERE role = 'user';
SELECT * FROM Users WHERE is_active = TRUE;
SELECT role, COUNT(*) as role_count FROM Users GROUP BY role;
SELECT * FROM Users WHERE email LIKE '%@gmail.com';
UPDATE Users 
SET phoneNumber = '01911122334' 
WHERE user_id = 1;
DELETE FROM Users WHERE user_id = 6;
SELECT * FROM Users WHERE bio LIKE '%developer%';


-- create a venue for event management
CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    description TEXT,
    contact_info VARCHAR(255),
    facilities TEXT,
    booking_status ENUM('Available', 'Booked') DEFAULT 'Available',
    total_price DECIMAL(10, 2),  
    images TEXT,          
    manager_name VARCHAR(255),
    manager_contact VARCHAR(255),
    opening_hours VARCHAR(255),  -- Example: "Mon-Fri, 9:00 AM - 6:00 PM"
    parking_availability ENUM('Available', 'Not Available') DEFAULT 'Available'
);
-- insert data into venue table
INSERT INTO Venues (name, location, capacity, description, contact_info, facilities, booking_status, total_price, images, manager_name, manager_contact, opening_hours, parking_availability) 
VALUES 
('Dhaka Conference Center', 'House 5, Road 12, Gulshan-2, Dhaka', 500, 'A large conference venue for seminars, conferences, and exhibitions in Dhaka city.', '0171-2345678', 'Wi-Fi, Projector, Sound System, AC, Parking', 'Available', 15000.00, '["dhaka_conference_1.jpg", "dhaka_conference_2.jpg"]', 'Ahmed Rahman', 'ahmed.rahman@example.com', 'Mon-Sun, 9:00 AM - 6:00 PM', 'Available'),
('Chittagong Banquet Hall', 'Chittagong City Center, Bangladesh', 300, 'An elegant venue ideal for weddings, corporate events, and large gatherings.', '0182-3456789', 'Wi-Fi, Stage, AC, Lighting, Parking', 'Booked', 10000.00, '["chittagong_banquet_1.jpg", "chittagong_banquet_2.jpg"]', 'Mita Begum', 'mita.begum@example.com', 'Mon-Sun, 10:00 AM - 8:00 PM', 'Available'),
('Sylhet Luxury Lounge', 'Mirpur Road, Sylhet, Bangladesh', 150, 'A luxurious venue for intimate parties, conferences, and private gatherings.', '0175-9876543', 'DJ Setup, Projector, Bar, AC, Parking', 'Available', 12000.00, '["sylhet_lounge_1.jpg", "sylhet_lounge_2.jpg"]', 'Sajib Ali', 'sajib.ali@example.com', 'Mon-Sun, 11:00 AM - 10:00 PM', 'Not Available'),
('Rajshahi Outdoor Arena', 'Rajshahi Stadium, Rajshahi, Bangladesh', 1000, 'An open-air arena for concerts, festivals, and large-scale events.', '0191-2468101', 'Sound System, Stage, VIP Area, AC, Parking', 'Available', 20000.00, '["rajshahi_arena_1.jpg", "rajshahi_arena_2.jpg"]', 'Suman Sarkar', 'suman.sarkar@example.com', 'Fri-Sun, 12:00 PM - 11:00 PM', 'Available');

-- query for venues
SELECT * FROM Venues;
SELECT * FROM Venues WHERE booking_status = 'Available';

SELECT * FROM Venues WHERE capacity >= 300;
SELECT * FROM Venues WHERE location LIKE '%Dhaka%';
UPDATE Venues
SET total_price = 16000.00
WHERE venue_id = 1;
SELECT booking_status, COUNT(*) AS venue_count
FROM Venues
GROUP BY booking_status;


-- Organizer table create for event management

CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    organizer_id INT,
    venue_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);

-- Insert value for Events table

INSERT INTO Events (title, description, start_date, end_date, organizer_id, venue_id) VALUES
('Tech Conference', 'Annual Tech Meet', '2024-12-01', '2024-12-02', 2, 9);

--  Fetch all events along with the organizer's name and email
SELECT 
    e.event_id,
    e.title AS event_title,
    e.description AS event_description,
    e.start_date,
    e.end_date,
    u.name AS organizer_name,
    u.email AS organizer_email
FROM 
    Events e
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id;

--Find all events organized by a specific organizer
SELECT 
    e.event_id,
    e.title AS event_title,
    e.description AS event_description,
    e.start_date,
    e.end_date,
    u.name AS organizer_name
FROM 
    Events e
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id
WHERE 
    u.name = 'Shamima Akter';

--  Get the total number of events organized by each user
SELECT 
    u.user_id,
    u.name AS organizer_name,
    COUNT(e.event_id) AS total_events
FROM 
    Users u
LEFT JOIN 
    Events e
ON 
    u.user_id = e.organizer_id
WHERE 
    u.role = 'organizer'
GROUP BY 
    u.user_id, u.name;

-- List all events along with the venue details and organizer's contact information
SELECT 
    e.event_id,
    e.title AS event_title,
    e.start_date,
    e.end_date,
    v.name AS venue_name,
    v.location AS venue_location,
    u.name AS organizer_name,
    u.phoneNumber AS organizer_contact
FROM 
    Events e
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id
JOIN 
    Venues v
ON 
    e.venue_id = v.venue_id;

-- Find events hosted at venues with a capacity greater than 500
SELECT 
    e.event_id,
    e.title AS event_title,
    v.name AS venue_name,
    v.capacity,
    u.name AS organizer_name
FROM 
    Events e
JOIN 
    Venues v
ON 
    e.venue_id = v.venue_id
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id
WHERE 
    v.capacity > 500;

-- Find the events scheduled for December 2024 along with their organizer and venue details

SELECT 
    e.event_id,
    e.title AS event_title,
    e.start_date,
    e.end_date,
    u.name AS organizer_name,
    u.email AS organizer_email,
    v.name AS venue_name,
    v.location AS venue_location
FROM 
    Events e
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id
JOIN 
    Venues v
ON 
    e.venue_id = v.venue_id
WHERE 
    e.start_date BETWEEN '2024-12-01' AND '2024-12-31';

-- Fetch events where the organizer's bio contains the word "developer"
SELECT 
    e.event_id,
    e.title AS event_title,
    u.name AS organizer_name,
    u.bio AS organizer_bio
FROM 
    Events e
JOIN 
    Users u
ON 
    e.organizer_id = u.user_id
WHERE 
    u.bio LIKE '%developer%';

-- Events table query
SELECT * FROM Events;
SELECT * 
FROM Events
WHERE start_date BETWEEN '2024-12-01' AND '2024-12-31';

SELECT * 
FROM Events
WHERE organizer_id = 2;

SELECT COUNT(*) AS total_events 
FROM Events;
SELECT * 
FROM Events
WHERE venue_id = 9;
SELECT * 
FROM Events
WHERE title LIKE '%Tech%';

UPDATE Events
SET description = 'Updated description for the event'
WHERE event_id = 1;

SELECT *, DATEDIFF(end_date, start_date) AS event_duration
FROM Events
WHERE DATEDIFF(end_date, start_date) > 1;

SELECT * 
FROM Events
ORDER BY start_date ASC;


-- Create a Tickets table for event management
CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT,
    ticket_type ENUM('REGULAR', 'VIP', 'VVIP') DEFAULT 'REGULAR',
    price DECIMAL(10, 2),
    purchase_date DATE,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert value in Ticket table
INSERT INTO Tickets (event_id, user_id, ticket_type, price, purchase_date) 
VALUES 
(3, 2, 'REGULAR', 100.00, '2024-11-01'),
(3, 3, 'VIP', 200.00, '2024-11-02'),
(2, 4, 'VVIP', 300.00, '2024-11-05'),
(2, 5, 'REGULAR', 100.00, '2024-11-06'),
(3, 6, 'VIP', 250.00, '2024-11-10'),
(3, 2, 'REGULAR', 120.00, '2024-11-12'),
(4, 3, 'VVIP', 350.00, '2024-11-15'),
(4, 5, 'REGULAR', 150.00, '2024-11-18');


-- Query From  Tickets Table

SELECT 
    t.ticket_id,
    t.ticket_type,
    t.price,
    t.purchase_date,
    u.name AS buyer_name,
    e.title AS event_title
FROM 
    Tickets t
JOIN 
    Users u ON t.user_id = u.user_id
JOIN 
    Events e ON t.event_id = e.event_id;

SELECT * FROM Tickets;

SELECT * FROM Tickets
WHERE ticket_type = 'VIP';

SELECT event_id, SUM(price) AS total_revenue
FROM Tickets
WHERE event_id = 3
GROUP BY event_id;

SELECT * FROM Tickets
WHERE purchase_date = '2024-11-02';


--Get all tickets purchased by a specific user
SELECT 
    t.ticket_id,
    t.ticket_type,
    t.price,
    t.purchase_date,
    e.title AS event_title,
    e.start_date AS event_start_date
FROM 
    Tickets t
JOIN 
    Events e ON t.event_id = e.event_id
WHERE 
    t.user_id = 2;
-- Get all events along with the number of tickets sold for each
SELECT 
    e.event_id,
    e.title AS event_title,
    COUNT(t.ticket_id) AS tickets_sold
FROM 
    Events e
LEFT JOIN 
    Tickets t ON e.event_id = t.event_id
GROUP BY 
    e.event_id, e.title;

--List all users who purchased VIP tickets
SELECT 
    u.user_id,
    u.name AS user_name,
    u.email,
    t.ticket_id,
    e.title AS event_title
FROM 
    Tickets t
JOIN 
    Users u ON t.user_id = u.user_id
JOIN 
    Events e ON t.event_id = e.event_id
WHERE 
    t.ticket_type = 'VIP';

--Find the total revenue generated from ticket sales for a specific event
SELECT 
    e.event_id,
    e.title AS event_title,
    SUM(t.price) AS total_revenue
FROM 
    Tickets t
JOIN 
    Events e ON t.event_id = e.event_id
WHERE 
    e.event_id = 2 
GROUP BY 
    e.event_id, e.title;

-- Get details of tickets purchased between specific dates
SELECT 
    t.ticket_id,
    u.name AS user_name,
    e.title AS event_title,
    t.ticket_type,
    t.price,
    t.purchase_date
FROM 
    Tickets t
JOIN 
    Users u ON t.user_id = u.user_id
JOIN 
    Events e ON t.event_id = e.event_id
WHERE 
    t.purchase_date BETWEEN '2024-11-01' AND '2024-11-30'; 

-- Find the top 3 users who have spent the most on ticket purchases
SELECT 
    u.user_id,
    u.name AS user_name,
    u.email,
    SUM(t.price) AS total_spent
FROM 
    Tickets t
JOIN 
    Users u ON t.user_id = u.user_id
GROUP BY 
    u.user_id, u.name, u.email
ORDER BY 
    total_spent DESC
LIMIT 3;

-- Retrieve events with no tickets sold
SELECT 
    e.event_id,
    e.title AS event_title,
    e.start_date,
    e.end_date
FROM 
    Events e
LEFT JOIN 
    Tickets t ON e.event_id = t.event_id
WHERE 
    t.ticket_id IS NULL;
--- CREATE SPONSORS TABLE
CREATE TABLE Sponsors (
    sponsor_id INT AUTO_INCREMENT PRIMARY KEY,    
    name VARCHAR(255) NOT NULL,                  
    contact_person VARCHAR(255),               
    contact_email VARCHAR(255) UNIQUE NOT NULL, 
    contact_phone VARCHAR(15),                 
    sponsorship_amount DECIMAL(10, 2) NOT NULL, 
    sponsorship_type ENUM('Platinum', 'Gold', 'Silver', 'Bronze') DEFAULT 'Bronze', 
    logo TEXT,                              
    event_id INT, 
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
SELECT * FROM Events;

INSERT INTO Sponsors (
    name, 
    contact_person, 
    contact_email, 
    contact_phone, 
    sponsorship_amount, 
    sponsorship_type, 
    logo, 
    event_id
) VALUES
('Tech Innovators', 'John Doe', 'john.doe@techinnovators.com', '01712345678', 5000.00, 'Platinum', '["tech_innovators_logo.jpg"]', 2),
('Smart Solutions', 'Jane Smith', 'jane.smith@smartsolutions.com', '01823456789', 3000.00, 'Gold', '["smart_solutions_logo.jpg"]', 6),
('Green Energy', 'Alice Brown', 'alice.brown@greenenergy.com', '01934567890', 2000.00, 'Silver', '["green_energy_logo.jpg"]', 3),
('Fresh Start', 'Bob Davis', 'bob.davis@freshstart.com', '01745678901', 1000.00, 'Bronze', '["fresh_start_logo.jpg"]', 4);

SELECT 
    s.sponsor_id,
    s.name AS sponsor_name,
    s.contact_person,
    s.contact_email,
    s.sponsorship_amount,
    s.sponsorship_type,
    e.title AS event_title
FROM 
    Sponsors s
JOIN 
    Events e
ON 
    s.event_id = e.event_id
WHERE 
    e.event_id = 2;

SELECT 
    e.event_id,
    e.title AS event_title,
    SUM(s.sponsorship_amount) AS total_sponsorship
FROM 
    Events e
LEFT JOIN 
    Sponsors s
ON 
    e.event_id = s.event_id
GROUP BY 
    e.event_id, e.title;
SELECT event_id, COUNT(sponsor_id) AS sponsor_count
FROM Sponsors
GROUP BY event_id;

SELECT event_id, MAX(sponsorship_amount) AS highest_sponsorship
FROM Sponsors
GROUP BY event_id;

SELECT * 
FROM Sponsors


-- Attendence table
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    status ENUM('Present', 'Absent') NOT NULL,
    check_in_time DATETIME,
    check_out_time DATETIME,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);


INSERT INTO Attendance (event_id, status, check_in_time, check_out_time)
VALUES
( 4, 'Present', '2024-11-15 09:00:00', '2024-11-15 17:00:00'),
( 2, 'Absent', NULL, NULL),
( 3, 'Present', '2024-11-16 10:30:00', '2024-11-16 15:30:00');


CREATE TABLE Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    attendance_id INT NOT NULL,
    event_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (attendance_id) REFERENCES Attendance(attendance_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);


INSERT INTO Feedback (attendance_id, event_id, rating, comments)
VALUES
(4, 4, 5, 'Great event! Very well organized.'),
(5, 2, 3, 'Could not attend, but the event seemed interesting.'),
(6, 3, 4, 'Good event overall, but the venue was a bit crowded.');

--Fetch All Feedback with Attendance Details
SELECT 
    f.feedback_id,
    f.event_id,
    f.rating,
    f.comments,
    a.status,
    a.check_in_time,
    a.check_out_time
FROM 
    Feedback f
JOIN 
    Attendance a ON f.attendance_id = a.attendance_id;

--List all attendance records along with event details:
SELECT 
    Attendance.attendance_id,
    Attendance.status,
    Attendance.check_in_time,
    Attendance.check_out_time,
    Events.title AS event_title,
    Events.start_date,
    Events.end_date
FROM 
    Attendance
JOIN 
    Events ON Attendance.event_id = Events.event_id;

--Fetch feedback details along with associated attendance and event information:
SELECT 
    Feedback.feedback_id,
    Feedback.rating,
    Feedback.comments,
    Feedback.feedback_date,
    Events.title AS event_title,
    Attendance.status AS attendance_status,
    Attendance.check_in_time,
    Attendance.check_out_time
FROM 
    Feedback
JOIN 
    Attendance ON Feedback.attendance_id = Attendance.attendance_id
JOIN 
    Events ON Feedback.event_id = Events.event_id;

--Retrieve feedback summary (average rating) for each event:
SELECT 
    Events.event_id,
    Events.title AS event_title,
    AVG(Feedback.rating) AS average_rating
FROM 
    Feedback
JOIN 
    Events ON Feedback.event_id = Events.event_id
GROUP BY 
    Events.event_id, Events.title;
--List events where at least one attendee has provided feedback:
SELECT DISTINCT
    Events.event_id,
    Events.title AS event_title,
    Events.start_date,
    Events.end_date
FROM 
    Feedback
JOIN 
    Events ON Feedback.event_id = Events.event_id;
--Find events with no attendees marked as "Absent":
SELECT 
    Events.event_id,
    Events.title AS event_title,
    Events.start_date,
    Events.end_date
FROM 
    Events
LEFT JOIN 
    Attendance ON Events.event_id = Attendance.event_id AND Attendance.status = 'Absent'
WHERE 
    Attendance.attendance_id IS NULL;
    
  CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,   
    ticket_id INT,                             
    user_id INT,                                
    amount DECIMAL(10, 2) NOT NULL,               
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending', 
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash') DEFAULT 'Credit Card', --
    transaction_id VARCHAR(255) UNIQUE,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

SELECT * FROM Users;

-- Insert sample data into Payments table
INSERT INTO Payments (ticket_id, user_id, amount, payment_status, payment_method, transaction_id)
VALUES
(16, 1, 100.00, 'Completed', 'Credit Card', 'TXN123456789'),
(17, 2, 200.00, 'Completed', 'PayPal', 'TXN987654321'),
(18, 3, 300.00, 'Pending', 'Bank Transfer', 'TXN112233445'),
(19, 4, 150.00, 'Failed', 'Cash', 'TXN556677889'),
(20, 5, 250.00, 'Completed', 'Debit Card', 'TXN223344556');

SELECT * FROM Payments;

-- Fetch payments with status 'Completed'
SELECT * FROM Payments WHERE payment_status = 'Completed';

-- Fetch total amount paid by each user
SELECT 
    user_id,
    SUM(amount) AS total_paid
FROM 
    Payments
WHERE 
    payment_status = 'Completed'
GROUP BY 
    user_id;

-- Fetch all payments for a specific ticket
SELECT * FROM Payments WHERE ticket_id = 3;

-- Update payment status
UPDATE Payments
SET payment_status = 'Refunded'
WHERE payment_id = 4;

-- Fetch payments made in the last 7 days
SELECT * FROM Payments 
WHERE payment_date >= DATE_SUB(NOW(), INTERVAL 7 DAY);

-- Fetch payment details along with user and ticket information
SELECT 
    p.payment_id,
    p.amount,
    p.payment_status,
    p.payment_method,
    t.ticket_type,
    t.price AS ticket_price,
    u.name AS user_name,
    u.email AS user_email
FROM 
    Payments p
JOIN 
    Tickets t ON p.ticket_id = t.ticket_id
JOIN 
    Users u ON p.user_id = u.user_id;  


-- CREATE EventReviews
CREATE TABLE EventReviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
--Insert Event Review
INSERT INTO EventReviews (event_id, user_id, rating, review)
VALUES 
(6, 1, 5, 'Amazing event! Very well organized.'), 
(2, 2, 4, 'Great experience, but the venue was a bit crowded.'), 
(4, 3, 3, 'Decent event, but could have been better managed.'), 
(3, 2, 5, 'Fantastic! Loved every moment of it.'), 
(2, 1, 2, 'Disappointing. The event started late and lacked coordination.');


-- Fetch all eventReviews
SELECT * FROM EventReviews;

--Get All Reviews for a Specific Event
SELECT er.review_id, u.name AS reviewer_name, er.rating, er.review, er.created_at
FROM EventReviews er
JOIN Users u ON er.user_id = u.user_id
WHERE er.event_id = 2

--  Get Average Rating for an Event
SELECT AVG(rating) AS average_rating
FROM EventReviews
WHERE event_id = 2;

 --List Top 3 Events with the Highest Average Ratings

SELECT e.event_id, e.title, AVG(er.rating) AS average_rating
FROM Events e
JOIN EventReviews er ON e.event_id = er.event_id
GROUP BY e.event_id, e.title
ORDER BY average_rating DESC
LIMIT 3;
-- Get Reviews Written by a Specific User

SELECT er.review_id, e.title AS event_title, er.rating, er.review, er.created_at
FROM EventReviews er
JOIN Events e ON er.event_id = e.event_id
WHERE er.user_id = 3;
-- Update a Review
UPDATE EventReviews
SET rating = 4, review = 'Great event, but could improve the sound system.'
WHERE review_id = 1;


-- create category table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- update category table
ALTER TABLE Events
ADD COLUMN category_id INT,
ADD FOREIGN KEY (category_id) REFERENCES Categories(category_id);

--Insert category table
INSERT INTO Categories (name, description)
VALUES
('Music', 'Events featuring live music performances.'),
('Sports', 'Sporting events like matches and tournaments.'),
('Technology', 'Tech conferences, hackathons, and expos.'),
('Education', 'Workshops, seminars, and educational events.'),
('Art', 'Art exhibitions, galleries, and creative showcases.');


-- Query
-- List All Categories with Event Counts
SELECT c.category_id, c.name AS category_name, COUNT(e.event_id) AS event_count
FROM Categories c
LEFT JOIN Events e ON c.category_id = e.category_id
GROUP BY c.category_id, c.name
ORDER BY event_count DESC;

-- List Events Organized by a Specific User Along with Categories

SELECT e.event_id, e.title, e.start_date, e.end_date, c.name AS category_name
FROM Events e
JOIN Categories c ON e.category_id = c.category_id
WHERE e.organizer_id = 2;


--Events Schedules
CREATE TABLE EventSchedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    activity_name VARCHAR(255) NOT NULL,
    description TEXT,
    schedule_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id) ON DELETE CASCADE
);

SELECT * FROM Events;

INSERT INTO EventSchedules (event_id, activity_name, description, schedule_date, start_time, end_time) VALUES
(2, 'Keynote Speech', 'Opening speech by the keynote speaker.', '2024-12-10', '10:00:00', '11:00:00'),
(3, 'Panel Discussion', 'Discussion on emerging technologies.', '2024-12-10', '11:30:00', '13:00:00'),
(4, 'Opening Band Performance', 'Performance by the opening band.', '2024-06-20', '15:00:00', '16:30:00'),
(6, 'Headline Performance', 'Main performance by the headliner.', '2024-06-20', '18:00:00', '20:00:00');

SELECT 
    e.title AS event_title, 
    es.activity_name, 
    es.description AS activity_description, 
    es.schedule_date, 
    es.start_time, 
    es.end_time
FROM 
    EventSchedules es
JOIN 
    Events e 
ON 
    es.event_id = e.event_id
WHERE 
    e.event_id = 2;

SELECT 
    event_id, 
    title, 
    start_date, 
    end_date
FROM 
    Events
WHERE 
    start_date >= '2024-12-01' 
    AND end_date <= '2024-12-31';

SELECT 
    e.title AS event_title, 
    COUNT(es.schedule_id) AS schedule_count
FROM 
    Events e
LEFT JOIN 
    EventSchedules es 
ON 
    e.event_id = es.event_id
GROUP BY 
    e.event_id;



--Notifications
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT,
    message TEXT NOT NULL,
    notification_type VARCHAR(50) NOT NULL, 
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

INSERT INTO Notifications (user_id, event_id, message, notification_type) VALUES
(1, 2, 'Your event "Tech Conference 2024" has a new schedule update.', 'Schedule Update'),
(2, 3, 'The "Summer Music Fest" has been rescheduled to a new date.', 'Event Update'),
(3, 4, 'Welcome to our Event Management Platform!', 'General');

SELECT 
    notification_id, 
    message, 
    notification_type, 
    created_at
FROM 
    Notifications
WHERE 
    user_id = 1 
    AND is_read = FALSE;

UPDATE Notifications
SET is_read = TRUE
WHERE notification_id = 1;

SELECT 
    notification_id, 
    user_id, 
    message, 
    is_read, 
    created_at
FROM 
    Notifications
WHERE 
    event_id = 2;



CREATE TABLE Vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    category ENUM('catering', 'decorating', 'sound_system', 'transportation') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT, 
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    availability_status ENUM('available', 'unavailable') DEFAULT 'available',
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id) ON DELETE CASCADE
);


CREATE TABLE Transportation (
    transport_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT, 
    vehicle_type ENUM('bus', 'van', 'truck', 'car') NOT NULL,
    capacity INT NOT NULL,
    price_per_hour DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id) ON DELETE CASCADE
);


CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT, 
    name VARCHAR(100) NOT NULL,
    rental_price DECIMAL(10, 2),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id) ON DELETE CASCADE
);

INSERT INTO Vendors (user_id, name, contact_email, phone, address, category)
VALUES 
(3, 'Best Catering Service', 'catering@example.com', '5551234567', '789 Food Lane', 'catering'),
(3, 'Elegant Decorations', 'decorations@example.com', '5552345678', '101 Event Rd', 'decorating');


INSERT INTO Services (vendor_id, name, description, price, availability_status)
VALUES 
(1, 'Wedding Buffet', 'A complete wedding buffet for up to 200 guests.', 1000.00, 'available'),
(1, 'Birthday Party Catering', 'Catering service for birthday parties, including cakes and snacks.', 500.00, 'available'),
(2, 'Floral Decoration', 'Beautiful floral arrangements for weddings and events.', 300.00, 'available'),
(2, 'Table Settings', 'Elegant table settings with fine china and napkins for formal events.', 150.00, 'available');


INSERT INTO Transportation (vendor_id, vehicle_type, capacity, price_per_hour)
VALUES 
(1, 'bus', 50, 200.00),
(1, 'van', 15, 80.00),
(2, 'car', 4, 50.00);

INSERT INTO Equipment (vendor_id, name, rental_price)
VALUES 
(1, 'Food Warmer', 75.00),
(1, 'Serving Trays', 25.00),
(2, 'Chairs', 10.00),
(2, 'Tablecloths', 15.00);

SELECT 
    v.vendor_id,
    v.name AS vendor_name,
    v.contact_email,
    v.phone,
    v.address,
    v.category AS vendor_category,
    s.service_id,
    s.name AS service_name,
    s.description AS service_description,
    s.price AS service_price,
    s.availability_status AS service_availability,
    t.transport_id,
    t.vehicle_type,
    t.capacity AS vehicle_capacity,
    t.price_per_hour AS vehicle_price_per_hour,
    e.equipment_id,
    e.name AS equipment_name,
    e.rental_price AS equipment_rental_price
FROM 
    Vendors v
LEFT JOIN 
    Services s ON v.vendor_id = s.vendor_id
LEFT JOIN 
    Transportation t ON v.vendor_id = t.vendor_id
LEFT JOIN 
    Equipment e ON v.vendor_id = e.vendor_id;

SELECT 
    v.vendor_id,
    v.name AS vendor_name,
    v.contact_email,
    v.phone,
    v.address,
    v.category AS vendor_category,
    s.service_id,
    s.name AS service_name,
    s.description AS service_description,
    s.price AS service_price,
    s.availability_status AS service_availability
FROM 
    Vendors v
JOIN 
    Services s ON v.vendor_id = s.vendor_id;

SELECT 
    v.vendor_id,
    v.name AS vendor_name,
    v.contact_email,
    v.phone,
    v.address,
    v.category AS vendor_category,
    s.service_id,
    s.name AS service_name,
    s.description AS service_description,
    s.price AS service_price,
    s.availability_status AS service_availability
FROM 
    Vendors v
LEFT JOIN 
    Services s ON v.vendor_id = s.vendor_id;


CREATE TABLE EventStaff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    name VARCHAR(100) NOT NULL,
    role ENUM('security', 'coordinator', 'photographer', 'usher') NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (event_id) REFERENCES Events(event_id) ON DELETE CASCADE
);


INSERT INTO EventStaff (event_id, name, role, phone, email)
VALUES 
(2, 'John Doe', 'security', '555-1234', 'johndoe@eventstaff.com'),
(4, 'Jane Smith', 'coordinator', '555-5678', 'janesmith@eventstaff.com'),
(2, 'Emily Johnson', 'photographer', '555-8765', 'emilyjohnson@eventstaff.com'),
(2, 'Michael Brown', 'usher', '555-4321', 'michaelbrown@eventstaff.com');

SELECT 
    e.title AS event_title,
    e.start_date,
    e.end_date,
    es.name AS staff_name,
    es.role AS staff_role,
    es.phone AS staff_phone,
    es.email AS staff_email
FROM 
    EventStaff es
JOIN 
    Events e ON es.event_id = e.event_id
WHERE 
    e.event_id = 2;  

SELECT 
    e.title AS event_title,
    e.start_date,
    e.end_date,
    es.name AS staff_name,
    es.role AS staff_role,
    es.phone AS staff_phone,
    es.email AS staff_email
FROM 
    EventStaff es
JOIN 
    Events e ON es.event_id = e.event_id;
