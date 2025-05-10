CREATE DATABASE royallib;
USE royallib;

CREATE TABLE Authors(
    Author_ID INT PRIMARY KEY NOT NULL,
    Author_name VARCHAR(100),
    Author_country VARCHAR(50)
);

CREATE TABLE Books(
    Book_ID INT PRIMARY KEY NOT NULL,       
    Book_title VARCHAR(255),     
    Book_genre ENUM('Fantasy', 'Science Fiction', 'Mystery', 'Romance', 'Thriller', 'Non-Fiction') NOT NULL,             
    Author_ID INT NOT NULL, 
    Book_year INT,                         
    Download_count INT,
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID)
);

CREATE TABLE Users(
    User_ID INT PRIMARY KEY NOT NULL,     
    Username VARCHAR(50) UNIQUE NOT NULL,  
    Email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Downloads (
    Download_id INT PRIMARY KEY,
    User_ID INT,
    Book_ID INT,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

ALTER TABLE Authors ADD COLUMN Author_birthdate DATE;
ALTER TABLE Authors DROP COLUMN Author_birthdate;

INSERT INTO Authors (Author_ID, Author_name, Author_country) VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'Isaac Asimov', 'United States'),
(3, 'Agatha Christie', 'United Kingdom'),
(4, 'Fedor Dostoevsky', 'Russia');

INSERT INTO Books (Book_ID, Book_title, Book_genre, Author_ID, Book_year, Download_count) VALUES
(1, 'Harry Potter and the Sorcerer\'s Stone', 'Fantasy', 1, 1997, 1200),
(2, 'Foundation', 'Science Fiction', 2, 1951, 800),
(3, 'Murder on the Orient Express', 'Mystery', 3, 1934, 1500);

INSERT INTO Users (User_ID, Username, Email) VALUES
(1, 'user_1', 'user_1@example.com'),
(2, 'user_2', 'user_2@example.com');

INSERT INTO Downloads (Download_id, User_ID, Book_ID) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3);


SELECT * FROM Authors WHERE Author_country = 'United Kingdom';

SELECT Book_title, Book_year, Book_genre FROM Books WHERE Book_year < 1997 AND Book_year > 1934;

SELECT Username, Book_title, Download_count 
FROM Users JOIN Downloads ON Users.User_ID = Downloads.User_ID  
JOIN Books ON Books.Book_ID = Downloads.Book_ID 
WHERE Download_count < 1000 OR Download_count > 1200;

DELETE FROM Authors WHERE Author_name = 'Fedor Dostoevsky';
SELECT * FROM Authors