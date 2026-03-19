-- EXERCISE 1

CREATE TABLE authors(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT,
    title VARCHAR(255) NOT NULL,
    word_count INT CHECK(word_count>=0),
    views INT,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
INSERT INTO authors (name) VALUES
('Maria Charlotte'),
('Juan Perez'),
('Gemma Alcocer');

INSERT INTO posts (author_id, title, word_count, views) VALUES
(1, 'Best Paint Colors', 814, 14),
(2, 'Small Space Decorating Tips', 1146, 221),
(1, 'Hot Accessories', 986, 105),
(1, 'Mixing Textures', 765, 22),
(2, 'Kitchen Refresh', 1242, 307),
(1, 'Homemade Art Hacks', 1002, 193),
(3, 'Refinishing Wood Floors', 1571, 7542);

-- EXERCISE 2

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20),
    total_mileage INT CHECK(total_mileage>=0)
);

CREATE TABLE aircrafts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100) NOT NULL,
    total_seats INT CHECK(total_seats>=0)
);

CREATE TABLE flights (
    id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) UNIQUE,
    aircraft_id INT,
    mileage INT CHECK(mileage>=0),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id)
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    flight_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (flight_id) REFERENCES flights(id)
);

INSERT INTO customers (name, status, total_mileage) VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);

INSERT INTO aircrafts (model, total_seats) VALUES
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);

INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES
('DL143', 1, 135),
('DL122', 2, 4370),
('DL53', 3, 2078),
('DL222', 3, 1765),
('DL37', 1, 531);

INSERT INTO bookings (customer_id, flight_id) VALUES
(1,1),
(1,2),
(2,2),
(3,2),
(3,3),
(1,1),
(1,1),
(4,1),
(1,1),
(3,4),
(5,1),
(4,1),
(6,4),
(7,4),
(5,2),
(4,5),
(8,4);

SELECT COUNT(DISTINCT flight_number) FROM flights;
SELECT AVG(mileage) FROM flights;
SELECT AVG(total_seats) FROM aircrafts;
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
SELECT COUNT(*) FROM aircrafts WHERE model LIKE '%Boeing%';
SELECT * FROM flights WHERE mileage  BETWEEN 300 AND 2000;

SELECT c.status,
 AVG(f.mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_id = f.id
GROUP BY c.status;

SELECT 
    a.model, 
    COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_id = f.id
JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.model
ORDER BY total_bookings DESC
LIMIT 1;
