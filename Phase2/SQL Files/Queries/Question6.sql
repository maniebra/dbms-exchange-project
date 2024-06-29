DROP FUNCTION get_best_volume_sell_orders(bigint,integer);

CREATE OR REPLACE FUNCTION get_best_volume_sell_orders(target_volume BIGINT, market_id_param INT)
RETURNS TABLE (
    order_id INT,
    fill BIGINT,
    amount BIGINT,
    price BIGINT,
    market_id INT,
    date TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    WITH RankedOrders AS (
        SELECT
            o.order_id,
            o.fill,
            o.amount,
            o.market_id,
            o.date,
            (o.fill * o.amount) AS price,
            ROW_NUMBER() OVER (ORDER BY o.amount ASC) AS rn,
            SUM(o.amount) OVER (ORDER BY o.amount ASC) AS cumulative_amount
        FROM
            orders o
        WHERE
            o.is_sell = TRUE
            AND o.market_id = market_id_param
		ORDER BY o.fill ASC
    ),
    FinalOrders AS (
        SELECT
            ro.order_id,
            ro.fill,
            ro.amount,
            ro.price,
            ro.market_id,
            ro.date,
            ro.cumulative_amount,
            CASE 
                WHEN ro.cumulative_amount >= target_volume THEN 'sufficient'
                ELSE 'insufficient'
            END AS status
        FROM
            RankedOrders ro
    ),
    SufficientOrders AS (
        SELECT
            fo.*
        FROM
            FinalOrders fo
        WHERE
            fo.status = 'sufficient'
        ORDER BY
            fo.fill, fo.cumulative_amount
        LIMIT 1
    )
    SELECT
        fo.order_id,
        fo.fill,
        fo.amount,
        fo.price,
        fo.market_id,
        fo.date
    FROM
        FinalOrders fo
    WHERE
        fo.status = 'insufficient'
    UNION ALL
    SELECT
        so.order_id,
        so.fill,
        so.amount,
        so.price,
        so.market_id,
        so.date
    FROM
        SufficientOrders so;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM get_best_volume_sell_orders(100,1);
