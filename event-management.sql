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
