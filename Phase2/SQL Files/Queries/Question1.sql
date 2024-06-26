SELECT DISTINCT ON (markets.market_id) markets.market_id, orders.amount, orders.date
FROM markets
JOIN orders ON orders.market_id = markets.market_id
ORDER BY markets.market_id, orders.date DESC NULLS LAST, markets.market_id;
