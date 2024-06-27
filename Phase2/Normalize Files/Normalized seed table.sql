TRUNCATE users, cryptocurrencies, networks, wallets ,brokers,
markets, transactions, wallet_transactions, orders,
p2p, otc, users_otc, orderbooks, purchase_lists, sales_lists
RESTART IDENTITY CASCADE;

-- haroomzadeha inja ro namoosi nakonin
INSERT INTO users(first_name, last_name, email, password, phone_number, address, is_admin, national_code) VALUES 
	('Mahdi', 'Akhi', 'mahdi.akhi@gmail.com', 'Akhi1234', '+989021214455', 'Tehran, Azadi, Sharif', FALSE, 0058764541),
	('Mohammad', 'Jafaripour', 'm.sws@gmail.com', 'MAMAli83', '+989051234567', 'Tehran, Shahrak Gharb, Shafagh', FALSE, 1278905481),
	('Nima', 'Pasha', 'nim.pash@gmail.com', 'Pash222', '+989071434567', 'Tehran, Gisha, Azari', TRUE, 1278542481),
	('Mohi', 'Heidari', 'mohitamiz@gmail.com', 'heidar31', '+9890512310964', 'Isf, Khominishahr', FALSE, 1284605481),
	('Mamadali', 'Abam', 'abam@sharif.edu', 'abam1234', '+989123459876', 'Tehran, Sharif', FALSE, 0056769881),
	('Abool', 'Norian', 'reifgh.baz@gmail.com', '43abol21', '+989054321567', 'Isf, Badrood, Mahan', TRUE, 1118905481),
	('Aryan', 'Harroni', 'aryanhn@gmail.com', '43ary21', '+989054470567', 'Isf, khane isf, gol', FALSE, 1834905481);
	
INSERT INTO cryptocurrencies (name, total_amount, fixed_amount, fixed_value, type) VALUES 
	('rial', NULL, 8, 7, 'stable'),
	('Doge', 20000, NULL, NULL, 'unstable'),
	('Tether', 5000, 3, 3, 'stable'),
	('Ethereum', 20000, NULL, NULL, 'unstable'),
	('BNB', 20000, NULL, NULL, 'unstable'),
	('Shiba', 20000, NULL, NULL, 'unstable'),
	('notcoin', 40000, NULL, NULL, 'unstable');


INSERT INTO networks (wage, name, time, crypto_id) VALUES 
	(5, 'net1', '2020-05-08', 1),
	(2, 'ote', '2023-05-08', 1),
	(10, 'www', '2021-05-08', 1),
	(7, 'zse', '2012-05-08', 2),
	(2, 'netter', '2020-07-08', 2),
	(2, 'tetrax', '2021-05-11', 3),
	(3, 'xbit', '2022-05-12', 3);
	
INSERT INTO wallets (owner_id, crypto_id, free_value, locked_value) VALUES
	(1, 1, 500, 200),
	(1, 2, 100, 50),
	(1, 3, 250, 150),
	(1, 4, 320, 120),
	(1, 5, 100, 50),
	(1, 6, 250, 150),
	(1, 7, 320, 120),
	(2, 1, 500, 200),
	(2, 2, 100, 50),
	(2, 3, 250, 150),
	(2, 4, 320, 120),
	(2, 5, 100, 50),
	(2, 6, 250, 150),
	(2, 7, 320, 120),
	(3, 1, 500, 200),
	(3, 2, 100, 50),
	(3, 3, 250, 150),
	(3, 4, 320, 120),
	(3, 5, 100, 50),
	(3, 6, 250, 150),
	(3, 7, 320, 120),
	(4, 1, 500, 200),
	(4, 2, 100, 50),
	(4, 3, 250, 153),
	(4, 4, 320, 123),
	(4, 5, 100, 54),
	(4, 6, 250, 152),
	(4, 7, 320, 124),
	(5, 1, 500, 230),
	(5, 2, 100, 54),
	(5, 3, 250, 154),
	(5, 4, 320, 121),
	(5, 5, 100, 45),
	(5, 6, 250, 151),
	(5, 7, 320, 123),
	(6, 1, 320, 212),
	(6, 2, 200, 55),
	(6, 3, 350, 155),
	(6, 4, 120, 123),
	(6, 5, 132, 52),
	(6, 6, 251, 151),
	(6, 7, 324, 123);
	
INSERT INTO brokers (name) VALUES
	('alibaba'),
	('coinTrade');
	
INSERT INTO markets (broker_id, base_currency_id, crypto_id, fee, wage) VALUES
	(1, 1, 1, 5, 7),
	(1, 1, 2, 6, 4),
	(1, 1, 3, 3, 8),
	(1, 1, 4, 6, 12),
	(1, 1, 5, 2, 10),
	(1, 1, 6, 1, 3),
	(1, 1, 7, 2, 5);
	
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO transactions (source_wallet_id, destination_wallet_id, fill, wage, date,market_id) VALUES
	(1, 8, 100, 5, '2020-06-08', 1),--modulo 7
	(2, 16, 200, 6, '2021-08-08', 2),
	(3, 24, 100, 1, '2023-05-08', 3),
	(11, 18, 100, 2, '2023-07-08', 4),
	(19, 33, 100, 1, '2010-06-08', 5),
	(6, 13, 100, 10, '2012-03-08', 6),
	(21, 42, 100, 12, '2020-05-12', 7),

	(8, 23, 100, 5, '2022-05-11', 1),
	(9, 2, 100, 7 ,'2019-06-07', 2),
	(17, 31, 100, 7, '2015-05-03', 3),---------------------------------------------
	(4, 11, 100, 5, '2020-06-08', 4),
	(5, 12, 200, 6, '2021-08-08', 5),
	(20, 34, 100, 1, '2023-05-08', 6),
	(7, 14, 100, 2, '2023-07-08', 7),
	(1, 10, 100, 1, '2010-06-08', 1),
	(2, 30, 100, 10, '2012-03-08', 2),
	(31, 3, 100, 12, '2020-05-12', 3),
	(18, 4, 100, 5, '2022-05-11', 4),
	(12, 5, 100, 7 ,'2019-06-07', 5),
	(20, 6, 100, 7, '2015-05-03', 6);
	
INSERT INTO wallet_transactions (wallet_id, transaction_id, origin_or_dest) VALUES
	( 1,1, 'origin'),(8, 1, 'dest'),
	( 2,2, 'origin'),(16, 2, 'dest'),
	( 3,3, 'origin'),(24, 3, 'dest'),
	( 11,4, 'origin'),(18, 4, 'dest'),
	( 19,5, 'origin'),(33, 5, 'dest'),
	( 6,6, 'origin'),(13, 6, 'dest'),
	( 21,7, 'origin'),(42, 7, 'dest'),
	( 8,8, 'origin'),(23, 8, 'dest'),
	( 9,9, 'origin'),(2, 9, 'dest'),
	( 17,10, 'origin'),(31, 10, 'dest'),
	-------------------------------------------
	( 4,11, 'origin'),(11, 11, 'dest'),
	( 5,12, 'origin'),(12, 12, 'dest'),
	( 20,13, 'origin'),(34, 13, 'dest'),
	( 7,14, 'origin'),(14, 14, 'dest'),
	( 1,15, 'origin'),(10, 15, 'dest'),
	( 2,16, 'origin'),(30, 16, 'dest'),
	( 31,17, 'origin'),(3, 17, 'dest'),
	( 18,18, 'origin'),(4, 18, 'dest'),
	( 12,19, 'origin'),(5, 19, 'dest'),
	( 20,20, 'origin'),(6, 20, 'dest');	
	

INSERT INTO purchase_lists (market_id) VALUES
	(1),(2),(3), (4), (5), (6), (7);

INSERT INTO sales_lists (market_id) VALUES
	(1),(2),(3), (4), (5), (6), (7);

INSERT INTO orderbooks (market_id ,purchase_list_id, sales_list_id) VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 4),
	(5, 5, 5),
	(6, 6, 6),
	(7, 7, 7);
	
INSERT INTO orders (is_sell,state,fill,client_id,date,market_id,amount) VALUES
	(TRUE, 'end', 30, 5, '2020-06-08', 1, 240),
	(TRUE, 'end', 29 , 6, '2021-06-08', 2,230),
	(TRUE, 'end', 28, 2, '2021-07-08', 6, 220),
	(TRUE, 'end', 27, 2, '2023-06-08', 3,210),
	(TRUE, 'end', 26, 5, '2020-06-08', 4, 200),
	(TRUE, 'end', 6, 6, '2021-06-08', 1, 190),
	(TRUE, 'fill', 8, 3, '2021-07-08', 1, 180),
	(TRUE, 'fill', 10, 1, '2023-06-08', 1,170),
	
	(FALSE, 'end', 2, 3, '2020-06-07', 1, 240),
	(FALSE, 'end', 6, 2, '2021-06-07', 2, 230),
	(FALSE, 'end', 8, 1, '2021-07-07', 6, 220),
	(FALSE, 'end', 10, 5, '2023-06-07', 3,210),
	(FALSE, 'end', 2, 4, '2020-06-07', 4, 200),
	(FALSE, 'end', 6, 5, '2021-06-07', 1, 190),
	(FALSE, 'fill', 8, 5, '2021-07-07',1 , 180),
	(FALSE, 'fill', 10, 3, '2023-06-07', 1, 170),
	
	
	
	
	(TRUE, 'end', 2, 5, '2020-06-06', 1, 160),
	(TRUE, 'end', 6, 5, '2021-06-06', 2, 150),
	(TRUE, 'end', 8, 7, '2021-07-06', 3, 140),
	(TRUE, 'end', 10, 7, '2023-06-06', 5,130),
	(TRUE, 'end', 2, 7, '2020-06-06', 1, 120),
	(TRUE, 'end', 6, 2, '2021-06-06', 1, 110),
	(TRUE, 'fill', 3, 4, '2021-07-06', 6, 100),
	(TRUE, 'fill', 4, 4, '2023-06-06', 7, 90),
	
	(FALSE, 'end', 5, 1, '2020-06-05', 1, 160),
	(FALSE, 'end', 6, 2, '2021-06-05', 2, 150),
	(FALSE, 'end', 8, 1, '2021-07-05', 3, 140),
	(FALSE, 'end', 10, 4, '2023-06-05', 5, 130),
	(FALSE, 'end', 11, 4, '2020-06-05', 1, 120),
	(FALSE, 'end', 10, 5, '2021-06-05', 1, 110),
	(FALSE, 'fill', 9, 5, '2021-07-05', 6, 100),
	(FALSE, 'fill', 8, 1, '2023-06-05', 7,90),
	
	
	
	
	(TRUE, 'end', 7, 4, '2020-06-04', 1, 80),
	(TRUE, 'end', 6, 6, '2021-06-04', 1, 70),
	(TRUE, 'end', 4, 6, '2021-07-04', 1, 60),
	(TRUE, 'end', 3, 3, '2023-06-04', 1, 50),
	(TRUE, 'end', 2, 2, '2020-06-04', 1, 40),
	(TRUE, 'end', 1, 6, '2021-06-04', 1, 30),
	(TRUE, 'fill', 1, 3, '2021-07-04', 1, 20),
	(TRUE, 'fill', 2, 2, '2023-06-04', 1, 10),
	
	(FALSE, 'end', 3, 3, '2020-06-03', 1, 80),
	(FALSE, 'end', 4, 3, '2021-06-03', 1, 70),
	(FALSE, 'end', 5, 4, '2021-07-03', 1, 60),
	(FALSE, 'end', 6, 5, '2023-06-03', 1, 50),
	(FALSE, 'end', 7, 7, '2020-06-03', 1, 40),
	(FALSE, 'end', 8, 4, '2021-06-03', 1, 30),
	(FALSE, 'fill', 9, 7, '2021-07-03', 1, 20),
	(FALSE, 'fill', 10, 3, '2023-06-03', 1, 10);	
	
	
	
	
	

	
	
INSERT INTO p2p (date_placed,fill,wage,value,min_fill_remainder,market_id, taker_order_id,maker_order_id) VALUES 
	('2023-11-28', 240, 1, 230, 240, 1, 9, 1),
	('2023-11-27', 230 , 2, 220, 230, 2, 10, 2),
	('2023-11-26', 220 , 3, 210, 220, 6, 11, 3),
	('2023-11-25', 210, 4, 200, 210, 3, 12, 4),
	('2023-11-24', 200, 5, 190, 200, 4, 13, 5),
	('2023-11-23', 190, 6, 180, 190, 1, 14, 6),
	('2023-11-22', 180, 7, 170, 180, 1, 15, 7),
	('2023-11-21', 170, 8, 160, 170, 1, 16, 8),
	
	('2023-11-20', 160, 1, 150, 160, 1, 25, 17),
	('2023-11-19', 150, 2, 140, 150, 2, 26, 18),
	('2023-11-18', 140, 3, 130, 140, 3, 27, 19),
	('2023-11-17', 130, 4, 120, 130, 5, 28, 20),
	('2023-11-16', 120, 5, 110, 120, 1, 29, 21),
	('2023-11-15', 110, 6, 100, 110, 1, 30, 22),
	('2023-11-14', 100, 7, 90, 100, 6, 31, 23),
	('2023-11-13', 90, 8, 80, 90, 7, 32, 24),
	
	('2023-11-12', 80, 1, 70, 80, 1, 41, 33),
	('2023-11-11', 70, 2, 60, 70, 1, 42, 34),
	('2023-11-10', 60, 3, 50, 60, 1, 43, 35),
	('2023-11-09', 50, 4, 40, 50, 1, 44, 36),
	('2023-11-08', 40, 5, 30, 40, 1, 45, 37),
	('2023-11-07', 30, 6, 20, 30, 1, 46, 38),
	('2023-11-06', 20, 7, 10, 20, 1, 47, 39),
	('2023-11-05', 10, 8, 5, 10, 1, 48, 40);
	

	
INSERT INTO otc (date_placed,fill,wage,value,taker_id,broker_id,admin_id) VALUES
	('2022-11-20', 160, 1, 350, 1, 1, 3),
	('2022-11-19', 150, 2, 340, 2, 1, 3),
	('2022-11-18', 140, 3, 330, 1, 1, 3),
	('2022-11-17', 130, 4, 320, 5, 1, 3),
	('2022-11-16', 120, 5, 310, 1, 1, 3),
	
	('2022-11-15', 110, 6, 300, 1, 2, 6),
	('2022-11-14', 100, 7, 290, 3, 2, 6),
	('2022-11-13', 90, 8, 280, 3, 2, 6),
	('2022-11-12', 80, 1, 270, 7, 2, 6),
	('2022-11-11', 70, 2, 260, 7, 2, 6);
	

INSERT INTO users_otc (otc_id, user_id )VALUES
	(1, 1), (1, 3),
	(2, 2), (2, 3),
	(3, 1), (3, 3),
	(4, 5), (4, 3),
	(5, 1), (5, 3),
	
	(6, 1), (6, 6),
	(7, 3), (7, 6),
	(8, 3), (8, 6),
	(9, 7), (9, 6),
	(10, 7), (10, 6);
