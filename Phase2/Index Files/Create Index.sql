CREATE INDEX IF NOT EXISTS date_placed_idx ON p2p(date_placed);

CREATE INDEX IF NOT EXISTS wallet_id_idx ON transactions(source_wallet_id);

CREATE INDEX IF NOT EXISTS amount_idx ON orders(amount);