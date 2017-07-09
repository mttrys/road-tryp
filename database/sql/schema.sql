DROP DATABASE IF EXISTS toads;
CREATE DATABASE IF NOT EXISTS toads;
USE toads;
-- USE heroku_e8a2cb7b5c6d858;


CREATE TABLE IF NOT EXISTS users(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username  VARCHAR(100) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  password VARCHAR(512) NOT NULL,
  img_url VARCHAR(1024),
  phone_number VARCHAR(20),
  token VARCHAR(2048),
  vin VARCHAR(50),
  make VARCHAR(50),
  model VARCHAR(50),
  year VARCHAR(4),
  type VARCHAR(50),
  license_plate VARCHAR(20) ,
  avg_rating INT
);

CREATE TABLE IF NOT EXISTS trips (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  driver_id INT NOT NULL,
  departure_date DATE,
  departure_time TIME,
  departure_address_line1 VARCHAR(100),
  departure_address_line2 VARCHAR (100),
  departure_city VARCHAR(50),
  departure_state VARCHAR(50),
  departure_zip INT(10),
  arrival_date DATE,
  arrival_time TIME,
  arrival_address_line1 VARCHAR(100),
  arrival_address_line2 VARCHAR (100),
  arrival_city VARCHAR(50),
  arrival_state VARCHAR(50),
  arrival_zip INT(10),
  seats INT(3),
  price INT(10),
  CONSTRAINT `fkusers_trips`
  FOREIGN KEY `fkusers_trips` (`driver_id`)
  REFERENCES `users` (`id`)
);

CREATE TABLE IF NOT EXISTS trips_toads (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,
  user_id INT NOT NULL,
  CONSTRAINT `fktrip_trips`
  FOREIGN KEY `fktrip_trips` (`trip_id`)
  REFERENCES `trips` (`id`),
  CONSTRAINT `fktrip_users`
  FOREIGN KEY `fktrip_users` (`user_id`)
  REFERENCES `users` (`id`)
);

CREATE TABLE IF NOT EXISTS driver_reviews(
  id INT NOT NULL AUTO_INCREMENT,
  rider_id INT NOT NULL,
  driver_id INT NOT NULL,
  overall_rating INT NOT NULL,
  communication_rating INT NOT NULL,
  driving_rating INT NOT NULL,
  accuracy_rating INT NOT NULL,
  written_review TEXT NOT NULL,
  add_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (rider_id) REFERENCES users(id),
  FOREIGN KEY (driver_id) REFERENCES users(id)
);

-- DUMMY DATA --

INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name) VALUES ('jun123', 'jun@abc.com', '123456', 'https://lh3.google.com/u/0/d/0B5jkFvXDZd_WZzNGY0xtalg4QWc=w2878-h1472-iv1', '719-420-7890', 'Jun', 'Park');
INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name) VALUES ('solomon123', '123@abc.com', '123456', 'https://lh3.google.com/u/0/d/0B5jkFvXDZd_WT2tnY0xxdzRXM1U=w2878-h1472-iv1', '123-456-7890', 'Solomon', 'Tang');
INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name) VALUES ('kirk123', 'kirk@abc.com', '456', 'https://lh3.google.com/u/0/d/0B5jkFvXDZd_WeVRtZTlKVEwxRGc=w2878-h1472-iv1', '123-123-7890', 'Kirk', 'Rohani');
INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name) VALUES ('dylan123', 'dylan@abc.com', '123456', 'https://lh3.google.com/u/0/d/0B7wkVNnd3usbMmp5QVdlcThGLWM=w2878-h1472-iv3', '777-456-7290', 'Dylan', 'Gould');

INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name, vin, make, model, year, type, license_plate) VALUES ('james123', 'james@abc.com', '1234ng56', 'http://vignette2.wikia.nocookie.net/jamesbond/images/b/b2/James_Bond_%28Sean_Connery%29_-_Profile.jpg/revision/latest?cb=20130509150135', '415-420-7890', 'James', 'Bond', '1km2nj3nj3n', 'Aston Martin', 'F1', '2017', 'Sportscar', 'ABC123');
INSERT INTO users (username, email, password, img_url, phone_number, first_name, last_name, vin, make, model, year, type, license_plate) VALUES ('donald123', 'donald@abc.com', 'mickey', 'https://static.comicvine.com/uploads/original/0/77/4338755-donald-duck-30.jpg', '909-000-0001', 'Donald', 'Duck', '1mk2jnj3ni1', 'Ford', 'Explorer', '2015', 'SUV', '123XYZ');

INSERT INTO trips (
  driver_id,
  departure_date,
  departure_time,
  departure_address_line1,
  departure_city,
  departure_state,
  departure_zip,
  arrival_date,
  arrival_time,
  arrival_address_line1,
  arrival_city,
  arrival_state,
  arrival_zip,
  seats,
  price) VALUES (
    (SELECT id FROM users WHERE first_name = 'Donald'),
    '2017-07-08',
    '04:25:36',
    '944 Market St',
    'San Francisco',
    'CA',
    94102,
    '2017-07-08',
    '08:30:30',
    '101 Sunset Blvd',
    'Los Angeles',
    'CA',
    90210,
    4,
    65
);
INSERT INTO trips (
  driver_id,
  departure_date,
  departure_time,
  departure_address_line1,
  departure_city,
  departure_state,
  departure_zip,
  arrival_date,
  arrival_time,
  arrival_address_line1,
  arrival_city,
  arrival_state,
  arrival_zip,
  seats,
  price) VALUES (
    (SELECT id FROM users WHERE first_name = 'James'),
    '2017-07-08',
    '07:25:36',
    '555 McKinney St',
    'San Francisco',
    'CA',
    94158,
    '2017-07-08',
    '11:30:30',
    '1564 Mission St.',
    'Napa',
    'CA',
    90210,
    2,
    125
);
INSERT INTO trips (
  driver_id,
  departure_date,
  departure_time,
  departure_address_line1,
  departure_city,
  departure_state,
  departure_zip,
  arrival_date,
  arrival_time,
  arrival_address_line1,
  arrival_city,
  arrival_state,
  arrival_zip,
  seats,
  price) VALUES (
    (SELECT id FROM users WHERE first_name = 'Donald'),
    '2017-07-08',
    '08:25:36',
    '351 King St',
    'San Francisco',
    'CA',
    94102,
    '2017-07-08',
    '18:30:30',
    '15 NE 4th St',
    'Los Angeles',
    'CA',
    90210,
    4,
    70
);
INSERT INTO trips (
  driver_id,
  departure_date,
  departure_time,
  departure_address_line1,
  departure_city,
  departure_state,
  departure_zip,
  arrival_date,
  arrival_time,
  arrival_address_line1,
  arrival_city,
  arrival_state,
  arrival_zip,
  seats,
  price) VALUES (
    (SELECT id FROM users WHERE first_name = 'Donald'),
    '2017-07-08',
    '07:25:36',
    '728 E 4th St',
    'Pueblo',
    'CO',
    81001,
    '2017-07-08',
    '09:35:15',
    '2203 S Josephine St',
    'Denver',
    'CO',
    80210,
    3,
    25
);

INSERT INTO trips_toads (trip_id, user_id) VALUES ((SELECT id FROM trips WHERE departure_address_line1 = '944 Market St'), (SELECT id FROM users WHERE first_name = 'Jun'));
INSERT INTO trips_toads (trip_id, user_id) VALUES ((SELECT id FROM trips WHERE departure_address_line1 = '555 McKinney St'), (SELECT id FROM users WHERE first_name = 'Solomon'));
INSERT INTO trips_toads (trip_id, user_id) VALUES ((SELECT id FROM trips WHERE departure_address_line1 = '351 King St'), (SELECT id FROM users WHERE first_name = 'Dylan'));
INSERT INTO trips_toads (trip_id, user_id) VALUES ((SELECT id FROM trips WHERE departure_address_line1 = '728 E 4th St'), (SELECT id FROM users WHERE first_name = 'Kirk'));


INSERT INTO driver_reviews ( rider_id,driver_id, overall_rating, communication_rating, driving_rating, accuracy_rating, written_review ) VALUES (1, 2, 4, 3, 5, 4, 'This was a great trip. Thank you!!');
INSERT INTO driver_reviews ( rider_id,driver_id, overall_rating, communication_rating, driving_rating, accuracy_rating, written_review ) VALUES (2, 3, 4, 3, 5, 4, 'This tryp was aight');
INSERT INTO driver_reviews ( rider_id,driver_id, overall_rating, communication_rating, driving_rating, accuracy_rating, written_review ) VALUES (4, 6, 4, 3, 5, 4, 'This tryp was pretty cool I guess');
INSERT INTO driver_reviews ( rider_id,driver_id, overall_rating, communication_rating, driving_rating, accuracy_rating, written_review ) VALUES (4, 6, 3, 3, 5, 4, 'This tryp was tight');
