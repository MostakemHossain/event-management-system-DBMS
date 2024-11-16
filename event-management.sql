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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
