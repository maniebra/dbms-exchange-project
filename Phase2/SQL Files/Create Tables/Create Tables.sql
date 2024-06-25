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

-- CREATE NEW TABLES

CREATE TABLE users (
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
					
CREATE TABLE cryptocurrencies (
								crypto_id SERIAL PRIMARY KEY,
								name TEXT,
								total_amount BIGINT,
								fixed_amount BIGINT,
								fixed_value BIGINT
								);
								
CREATE TABLE networks (
	network_id SERIAL PRIMARY KEY,
	wage BIGINT,
	name TEXT,
	time TIMESTAMP,
	crypto_id INT,
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id)
);

CREATE TABLE wallets (
	wallet_id SERIAL PRIMARY KEY,
	owner_id INT,
	crypto_id INT,
	free_value BIGINT,
	locked_value BIGINT,
	CONSTRAINT owner_fk FOREIGN KEY (owner_id) REFERENCES users(user_id),
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id)
-- 	PRIMARY KEY (crypto_id, owner_id)
);

CREATE TABLE brokers (
	broker_id SERIAL PRIMARY KEY
);

CREATE TABLE markets (
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

CREATE TABLE transactions (
	transaction_id SERIAL PRIMARY KEY,
	crypto_id INT,
	source_wallet_id INT,
	destination_wallet_id INT,
	fill BIGINT,
	wage BIGINT,
	date TIMESTAMP,
	market_id INT,
	CONSTRAINT source_wallet_fk FOREIGN KEY (source_wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT destination_wallet_fk FOREIGN KEY (destination_wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT crypto_fk FOREIGN KEY (crypto_id) REFERENCES cryptocurrencies(crypto_id),
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);


CREATE TABLE wallet_transactions (
	wallet_id INT,
	transaction_id INT,
	PRIMARY KEY(wallet_id, transaction_id),
	CONSTRAINT wallet_fk FOREIGN KEY (wallet_id) REFERENCES wallets(wallet_id),
	CONSTRAINT transaction_fk FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

CREATE TABLE purchase_lists (
	purchase_lists_id SERIAL PRIMARY KEY,
	market_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TABLE sales_lists (
	sales_lists_id SERIAL PRIMARY KEY,
	market_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id)
);

CREATE TABLE orderbooks (
	market_id INT,
	list_id INT,
	CONSTRAINT market_fk FOREIGN KEY (market_id) REFERENCES markets(market_id),
	CONSTRAINT plist_fk FOREIGN KEY (list_id) REFERENCES purchase_lists(purchase_lists_id),
	CONSTRAINT slist_fk FOREIGN KEY (list_id) REFERENCES sales_lists(sales_lists_id)
);