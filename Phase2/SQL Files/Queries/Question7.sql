DROP FUNCTION IF EXISTS get_best_p2p_sell_orders(bigint,integer);

CREATE OR REPLACE FUNCTION get_best_p2p_sell_orders(target_volume BIGINT, market_id_param INT)
RETURNS TABLE (
    order_id INT,
    fill BIGINT,
    amount BIGINT,
    price BIGINT,
    market_id INT,
    date TIMESTAMP,
    average_price NUMERIC
) AS $$
DECLARE
    total_selected_volume BIGINT;
    total_selected_price BIGINT;
BEGIN
    RETURN QUERY
    WITH RankedOrders AS (
        SELECT
            o.order_id,
            o.fill,
            o.amount,
            o.market_id,
            o.date,
            ROW_NUMBER() OVER (ORDER BY o.fill ASC) AS rn,
            SUM(o.amount) OVER (ORDER BY o.fill ASC) AS cumulative_volume
        FROM
            orders o
        WHERE
            o.is_sell = TRUE
            AND o.market_id = market_id_param
    ),
    OrdersWithPrev AS (
        SELECT
            ro.*,
            LAG(ro.cumulative_volume) OVER (ORDER BY ro.rn) AS prev_cumulative_volume
        FROM
            RankedOrders ro
    ),
    SelectedOrders AS (
        SELECT
            ow.order_id,
            ow.fill,
            ow.amount,
            ow.market_id,
            ow.date,
            ow.cumulative_volume,
            ow.prev_cumulative_volume
        FROM
            OrdersWithPrev ow
        WHERE
            ow.cumulative_volume <= target_volume
            OR (ow.cumulative_volume > target_volume AND ow.prev_cumulative_volume <= target_volume)
    ),
    AggregatedResults AS (
        SELECT
            so.order_id,
            so.fill,
            so.amount,
            (so.fill * so.amount) AS price,
            so.market_id,
            so.date,
            SUM(so.amount) OVER () AS total_selected_volume,
            SUM(so.fill * so.amount) OVER () AS total_selected_price
        FROM
            SelectedOrders so
    )
    SELECT
        ar.order_id,
        ar.fill,
        ar.amount,
        ar.price,
        ar.market_id,
        ar.date,
        (CASE WHEN ar.total_selected_volume >= target_volume THEN ar.total_selected_price::NUMERIC / target_volume ELSE NULL END) AS average_price
    FROM
        AggregatedResults ar
    WHERE
        ar.total_selected_volume <= target_volume
    UNION ALL
    SELECT
        ar.order_id,
        ar.fill,
        ar.amount,
        ar.price,
        ar.market_id,
        ar.date,
        (CASE WHEN ar.total_selected_volume >= target_volume THEN ar.total_selected_price::NUMERIC / target_volume ELSE NULL END) AS average_price
    FROM
        AggregatedResults ar
    WHERE
        ar.total_selected_volume > target_volume
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_best_p2p_sell_orders(1000,1);
