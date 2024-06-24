-- DROP ALL CURRENT TABLES (IF ANY) IN DATABASE

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS cryptocurrencies CASCADE;
DROP TABLE IF EXISTS networks CASCADE;

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
								
