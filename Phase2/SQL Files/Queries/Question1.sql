WITH LatestTransactions AS (
    SELECT
        market_id,
        MAX(date_placed) AS latest_date
    FROM
        p2p
    GROUP BY
        market_id
)
SELECT
    p.market_id, p.date_placed,
    p.fill * o.amount AS price
FROM
    p2p p
JOIN
    orders o ON p.maker_order_id = o.order_id
JOIN
    LatestTransactions lt 
    ON p.market_id = lt.market_id
    AND p.date_placed = lt.latest_date;
	
