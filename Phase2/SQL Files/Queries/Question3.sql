WITH LatestPrices AS (
    SELECT
        m.market_id,
        m.crypto_id,
        (p.fill * o.amount) / NULLIF(o.amount, 0) AS latest_price,
        ROW_NUMBER() OVER (PARTITION BY m.crypto_id ORDER BY p.date_placed DESC) AS rn
    FROM
        p2p p
    JOIN
        orders o ON p.maker_order_id = o.order_id
    JOIN
        markets m ON p.market_id = m.market_id
),
FilteredPrices AS (
    SELECT
        market_id,
        crypto_id,
        latest_price
    FROM
        LatestPrices
    WHERE
        rn = 1
),
UserWalletValues AS (
    SELECT
        w.owner_id,
        w.crypto_id,
        (w.free_value + w.locked_value) * fp.latest_price AS total_value
    FROM
        wallets w
    JOIN
        FilteredPrices fp ON w.crypto_id = fp.crypto_id
)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COALESCE(SUM(uwv.total_value), 0) AS total_money_in_rials
FROM
    users u
LEFT JOIN
    UserWalletValues uwv ON u.user_id = uwv.owner_id
GROUP BY
    u.user_id, u.first_name, u.last_name;
