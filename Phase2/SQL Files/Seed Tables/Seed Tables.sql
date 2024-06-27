TRUNCATE users, cryptocurrencies, networks, wallets ,brokers,
markets, transactions, wallet_transactions, orders,
trades, users_trades, orderbooks, purchase_lists, sales_lists
RESTART IDENTITY CASCADE;

-- haroomzadeha inja ro namoosi nakonin
INSERT INTO users(first_name, last_name, email, password, phone_number, address, is_admin, national_code) VALUES 
	('Mahdi', 'Akhi', 'mahdi.akhi@gmail.com', 'Akhi1234', '+989021214455', 'Tehran, Azadi, Sharif', FALSE, 0058764541),
	('Mohammad', 'Jafaripour', 'm.sws@gmail.com', 'MAMAli83', '+989051234567', 'Tehran, Shahrak Gharb, Shafagh', FALSE, 1278905481),
	('Nima', 'Pasha', 'nim.pash@gmail.com', 'Pash222', '+989071434567', 'Tehran, Gisha, Azari', TRUE, 1278542481),
	('Mohi', 'Heidari', 'mohitamiz@gmail.com', 'heidar31', '+9890512310964', 'Isf, Khominishahr', FALSE, 1284605481),
	('Mamadali', 'Abam', 'abam@sharif.edu', 'abam1234', '+989123459876', 'Tehran, Sharif', FALSE, 0056769881),
	('Abool', 'Norian', 'reifgh.baz@gmail.com', '43abol21', '+989054321567', 'Isf, Badrood, Mahan', TRUE, 1118905481);
	
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

INSERT INTO transactions (crypto_id, source_wallet_id, destination_wallet_id, fill, wage, date,market_id) VALUES
	(1, 1, 8, 100, 5, '2020-06-08', 1),--modulo 7
	(2, 2, 16, 200, 6, '2021-08-08', 2),
	(3, 3, 24, 100, 1, '2023-05-08', 3),
	(4, 11, 18, 100, 2, '2023-07-08', 4),
	(5, 19, 33, 100, 1, '2010-06-08', 5),
	(6, 6, 13, 100, 10, '2012-03-08', 6),
	(7, 21, 42, 100, 12, '2020-05-12', 7),

	(1, 8, 23, 100, 5, '2022-05-11', 1),
	(2, 9, 2, 100, 7 ,'2019-06-07', 2),
	(3, 17, 31, 100, 7, '2015-05-03', 3),---------------------------------------------
	(4, 4, 11, 100, 5, '2020-06-08', 4),
	(5, 5, 12, 200, 6, '2021-08-08', 5),
	(6, 20, 34, 100, 1, '2023-05-08', 6),
	(7, 7, 14, 100, 2, '2023-07-08', 7),
	(1, 1, 10, 100, 1, '2010-06-08', 1),
	(2, 2, 30, 100, 10, '2012-03-08', 2),
	(3, 31, 3, 100, 12, '2020-05-12', 3),
	(4, 18, 4, 100, 5, '2022-05-11', 4),
	(5, 12, 5, 100, 7 ,'2019-06-07', 5),
	(6, 20, 6, 100, 7, '2015-05-03', 6);
	
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
	
INSERT INTO orders (sales_lists_id,purchase_lists_id,is_sell,state,fill,client_id,date,market_id,amount) VALUES
	(1, NULL, TRUE, 'end', 2, 5, '2020-06-08', 1, 100),
	(2, NULL, TRUE, 'end', 6, 6, '2021-06-08', 2, 50),
	(6, NULL, TRUE, 'end', 8, 2, '2021-07-08', 6, 100),
	(3, NULL, TRUE, 'end', 10, 2, '2023-06-08', 3,70),
	(4, NULL, TRUE, 'end', 2, 5, '2020-06-08', 4, 100),
	(5, NULL, TRUE, 'end', 6, 6, '2021-06-08', 5, 50),
	(5, NULL, TRUE, 'fill', 8, 3, '2021-07-08', 5, 100),
	(5, NULL, TRUE, 'fill', 10, 1, '2023-06-08', 5,70),
	
	
	(NULL,1, FALSE, 'end', 2, 3, '2020-06-08', 1, 100),
	(NULL,2, FALSE, 'end', 6, 2, '2021-06-08', 2, 50),
	(NULL,6, FALSE, 'end', 8, 1, '2021-07-08', 6, 100),
	(NULL,3, FALSE, 'end', 10, 5, '2023-06-08', 3,70),
	(NULL,7, FALSE, 'end', 2, 5, '2020-06-08', 7,550),
	(NULL,3, FALSE, 'end', 6, 5, '2021-06-08', 3, 50),
	(NULL,3, FALSE, 'fill', 8, 5, '2021-07-08',3,100),
	(NULL,3, FALSE, 'fill', 10, 3, '2023-06-08', 3,70),
	
	
	
	
	(2, NULL, TRUE, 'end', 2, 5, '2020-06-08', 2, 100),
	(2, NULL, TRUE, 'end', 6, 6, '2021-06-08', 2, 50),
	(2, NULL, TRUE, 'end', 8, 2, '2021-07-08', 2, 100),
	(2, NULL, TRUE, 'end', 10, 2, '2023-06-08', 2,70),
	(2, NULL, TRUE, 'end', 2, 5, '2020-06-08', 2, 100),
	(2, NULL, TRUE, 'end', 6, 6, '2021-06-08', 2, 50),
	(2, NULL, TRUE, 'fill', 8, 3, '2021-07-08', 2, 100),
	(2, NULL, TRUE, 'fill', 10, 1, '2023-06-08', 2,70),
	
	
	(NULL,2, FALSE, 'end', 2, 3, '2020-06-08', 2, 100),
	(NULL,2, FALSE, 'end', 6, 2, '2021-06-08', 2, 50),
	(NULL,2, FALSE, 'end', 8, 1, '2021-07-08', 2, 100),
	(NULL,2, FALSE, 'end', 10, 5, '2023-06-08',2,70),
	(NULL,2, FALSE, 'end', 2, 4, '2020-06-08', 2,100),
	(NULL,2, FALSE, 'end', 6, 5, '2021-06-08', 2, 50),
	(NULL,2, FALSE, 'fill', 8, 5, '2021-07-08',2,100),
	(NULL,2, FALSE, 'fill', 10, 3, '2023-06-08', 2,70);	
	
	
	
	
	

	
	
INSERT INTO trades (date_placed,fill,wage,value,min_fill_remainder,type,market_id,
					taker_order_id,maker_order_id,taker_id,maker_id,broker_id,admin_id) VALUES 
	('2021-10-08', 100, 2, 20, 100, 'p2p', 1, 9, 1,5, 3, 1, null),
	('2022-10-08', 50 , 3, 20, 50, 'p2p', 2, 10, 2,6, 2, 1, null),
	('2022-11-08', 100 , 5, 45, 100, 'p2p', 6, 11, 3,2, 1, 1, null) ,
	('2021-11-08', 70, 2, 20, 70, 'p2p', 7, 4, 12,2, 5, 1, null),
	

	
	
	('2022-09-08', 550, 5, 40, 550, 'otc', 3, 13, null,5, null, null, 3);
	

INSERT INTO users_trades (trade_id, user_id ) VALUES
	(1, 5), (1,3),
	(2, 6), (2, 2),
	(3, 2), (3, 1),
	(4, 2), (4, 5),
	(5, 5);
