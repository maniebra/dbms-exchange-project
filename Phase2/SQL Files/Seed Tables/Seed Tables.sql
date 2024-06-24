TRUNCATE TABLE users CASCADE;

INSERT INTO users(first_name, last_name, email, password, phone_number, address, is_admin, national_code) VALUES 
	('Mahdi', 'Akhi', 'mahdi.akhi@gmail.com', 'Akhi1234', '+989021214455', 'Tehran, Azadi, Sharif', FALSE, 0058764541),
	('Mohammad', 'Jafaripour', 'm.sws@gmail.com', 'MAMAli83', '+989051234567', 'Tehran, Shahrak Gharb, Shafagh', TRUE, 1278905481);