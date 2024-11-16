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
