WITH LatestTransactions AS (
    SELECT
        market_id,
        MAX(date_placed) AS latest_date
    FROM
        p2p
    GROUP BY
        market_id
),
MarketPrices AS (
    SELECT
        p.market_id,
        p.fill * o.amount AS price
    FROM
        p2p p
    JOIN
        orders o ON p.maker_order_id = o.order_id
    JOIN
        LatestTransactions lt ON p.market_id = lt.market_id AND p.date_placed = lt.latest_date
),
SupplyDemand AS (
    SELECT
        m.market_id,
        c.name AS crypto_name,
        SUM(CASE WHEN o.is_sell THEN o.amount ELSE 0 END) AS total_supply,
        SUM(CASE WHEN NOT o.is_sell THEN o.amount ELSE 0 END) AS total_demand
    FROM
        markets m
    JOIN
        orders o ON m.market_id = o.market_id
    JOIN
        cryptocurrencies c ON m.crypto_id = c.crypto_id
    GROUP BY
        m.market_id, c.name
)
SELECT
    sd.crypto_name,
    sd.total_supply,
    sd.total_demand,
    mp.price
FROM
    SupplyDemand sd
JOIN
    MarketPrices mp ON sd.market_id = mp.market_id;
;