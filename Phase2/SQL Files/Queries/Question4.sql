WITH TopBuyOffers AS (
    SELECT 
        order_id,
        is_sell,
        state,
        fill,
        client_id,
        date,
        market_id,
        amount,
        ROW_NUMBER() OVER (PARTITION BY market_id ORDER BY amount DESC) AS rank
    FROM 
        orders
    WHERE 
        is_sell = FALSE
),
TopSellOffers AS (
    SELECT 
        order_id,
        is_sell,
        state,
        fill,
        client_id,
        date,
        market_id,
        amount,
        ROW_NUMBER() OVER (PARTITION BY market_id ORDER BY amount ASC) AS rank
    FROM 
        orders
    WHERE 
        is_sell = TRUE
)
SELECT crypto_id, x.* FROM (
SELECT 
    'Buy' AS offer_type,
    order_id,
    is_sell,
    state,
    fill,
    client_id,
    date,
    market_id,
    amount
FROM 
    TopBuyOffers
 
WHERE 
    rank <= 10
UNION ALL
SELECT 
    'Sell' AS offer_type,
    order_id,
    is_sell,
    state,
    fill,
    client_id,
    date,
    market_id,
    amount
FROM 
    TopSellOffers
WHERE 
    rank <= 10
ORDER BY 
    market_id, offer_type, amount DESC) x
JOIN markets ON markets.market_id = x.market_id;

