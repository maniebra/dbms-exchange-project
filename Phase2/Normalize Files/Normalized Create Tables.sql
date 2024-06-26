-- DROP ALL CURRENT TABLES (IF ANY) IN DATABASE

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS cryptocurrencies CASCADE;
DROP TABLE IF EXISTS wallets CASCADE;
DROP TABLE IF EXISTS networks CASCADE;
DROP TABLE IF EXISTS brokers CASCADE;
DROP TABLE IF EXISTS markets CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS wallet_transactions CASCADE;
DROP TABLE IF EXISTS purchase_lists CASCADE;
DROP TABLE IF EXISTS sales_lists CASCADE;
DROP TABLE IF EXISTS orderbooks CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS trades CASCADE;
DROP TABLE IF EXISTS p2p CASCADE;
DROP TABLE IF EXISTS otc CASCADE;
DROP TABLE IF EXISTS users_otc CASCADE;
DROP TABLE IF EXISTS users_trades CASCADE;
DROP TYPE IF EXISTS origin_dest_enum CASCADE;
-- CREATE NEW TABLES

CREATE TABLE users (--check
					user_id SERIAL PRIMARY KEY,
					first_name TEXT,
					last_name TEXT,
					email TEXT,
					password TEXT,
					phone_number TEXT,
					address TEXT,
					is_admin BOOLEAN,
					national_code BIGINT
					);
					
CREATE TABLE cryptocurrencies (--check
								crypto_id SERIAL PRIMARY KEY,
								name TEXT,
								total_amount BIGINT,
								fixed_amount BIGINT,
								fixed_value BIGINT,
								type TEXT
								);
								
CREATE TABLE networks (--check
	network_id SERIAL PRIMARY KEY,
	wage BIGINT,
	name TEXT,
	time TIMESTAMP,
	crypto_id INT,
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id)
);

CREATE TABLE wallets (--check
	wallet_id SERIAL PRIMARY KEY,
	owner_id INT,
	crypto_id INT,
	free_value BIGINT,
	locked_value BIGINT,
	CONSTRAINT owner_fk FOREIGN KEY (owner_id) REFERENCES users(user_id),
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id)
-- 	PRIMARY KEY (crypto_id, owner_id)change of plans wallet is now a strong entity
);

CREATE TABLE brokers (--check
	broker_id SERIAL PRIMARY KEY,
	name TEXT
);

CREATE TABLE markets (--check
	market_id SERIAL PRIMARY KEY,
	broker_id INT,
	base_currency_id INT, 
	crypto_id INT,
	fee BIGINT,
	wage BIGINT,
	CONSTRAINT broker_fk FOREIGN KEY (broker_id) REFERENCES brokers(broker_id),
	CONSTRAINT base_currency_fk FOREIGN KEY (base_currency_id) REFERENCES cryptocurrencies(crypto_id),
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id)
);

CREATE TABLE transactions (--check
	transaction_id SERIAL PRIMARY KEY,
	source_wallet_id INT,
	destination_wallet_id INT,
	fill BIGINT,
	wage BIGINT,
	date TIMESTAMP,
	market_id INT,
	CONSTRAINT source_wallet_fk FOREIGN KEY (source_wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT destination_wallet_fk FOREIGN KEY (destination_wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TYPE origin_dest_enum AS ENUM ('origin', 'dest');
CREATE TABLE wallet_transactions (--check
	wallet_id INT,
	transaction_id INT,
	origin_or_dest origin_dest_enum,
	PRIMARY KEY(wallet_id, transaction_id),
	CONSTRAINT wallet_fk FOREIGN KEY (wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT transaction_fk FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

CREATE TABLE purchase_lists (--check
	purchase_lists_id SERIAL PRIMARY KEY,
	market_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TABLE sales_lists (--check
	sales_lists_id SERIAL PRIMARY KEY,
	market_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TABLE orderbooks (--check--changed
	market_id INT PRIMARY KEY,
	purchase_list_id INT,
	sales_list_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id),
	CONSTRAINT plist_fk FOREIGN KEY (purchase_list_id) REFERENCES purchase_lists(purchase_lists_id),
	CONSTRAINT slist_fk FOREIGN KEY (sales_list_id) REFERENCES sales_lists(sales_lists_id)

);

CREATE TABLE orders (--check
	order_id SERIAL PRIMARY KEY,
	is_sell BOOLEAN,
	state TEXT,
	fill BIGINT,
	client_id INT,
	date TIMESTAMP,
	market_id INT,
	amount BIGINT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id),
	CONSTRAINT client_fk FOREIGN KEY (client_id) REFERENCES users(user_id)
);

CREATE TABLE p2p (
	p2p_id SERIAL PRIMARY KEY,
	date_placed TIMESTAMP,
	fill BIGINT,
	wage BIGINT,
	value BIGINT,
	min_fill_remainder BIGINT,
	market_id INT,
	taker_order_id INT,
	maker_order_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id),
	CONSTRAINT maker_order_fk FOREIGN KEY (maker_order_id) REFERENCES orders(order_id),
	CONSTRAINT taker_order_fk FOREIGN KEY (taker_order_id) REFERENCES orders(order_id)
);

CREATE TABLE otc (
	otc_id SERIAL PRIMARY KEY,
	date_placed TIMESTAMP,
	fill BIGINT,
	wage BIGINT,
	value BIGINT,
	taker_id INT,
	broker_id INT,
	admin_id INT,
	CONSTRAINT taker_fk FOREIGN KEY (taker_id) REFERENCES users(user_id),
	CONSTRAINT admin_fk FOREIGN KEY (admin_id) REFERENCES users(user_id),
	CONSTRAINT broker_fk FOREIGN KEY (broker_id) REFERENCES brokers(broker_id)
);

CREATE TABLE users_otc (
	otc_id INT,
	user_id INT,
	PRIMARY KEY(user_id, otc_id),
	CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT otc_fk FOREIGN KEY (otc_id) REFERENCES otc(otc_id)
);
