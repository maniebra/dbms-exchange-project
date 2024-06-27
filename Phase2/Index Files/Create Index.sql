CREATE INDEX IF NOT EXISTS datePlacedIdx ON trades(date_placed);

CREATE INDEX IF NOT EXISTS walletIdIdx ON transactions(source_wallet_id);

CREATE INDEX IF NOT EXISTS amountIdx ON orders(amount);