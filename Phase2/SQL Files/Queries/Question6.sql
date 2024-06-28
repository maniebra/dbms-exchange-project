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
            ow.rn,
            ow.cumulative_volume,
            ow.prev_cumulative_volume
        FROM
            OrdersWithPrev ow
        WHERE
            ow.cumulative_volume <= target_volume
            OR (ow.cumulative_volume > target_volume AND ow.prev_cumulative_volume <= target_volume)
    )
    SELECT
        so.order_id,
        so.fill,
        so.amount,
        (so.fill * so.amount) AS price,
        so.market_id,
        so.date
    FROM
        SelectedOrders so
    ORDER BY so.amount;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_best_volume_sell_orders(1000,1);
