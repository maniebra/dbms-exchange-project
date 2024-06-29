DROP FUNCTION IF EXISTS compare_p2p_and_otc(bigint, integer, numeric);

CREATE OR REPLACE FUNCTION compare_p2p_and_otc(target_volume BIGINT, market_id_param INT, otc_price NUMERIC)
RETURNS TABLE (
    source TEXT,
    average_price NUMERIC
) AS $$
DECLARE
    total_price NUMERIC;
    final_adjustment BIGINT;
BEGIN
    -- Retrieve and adjust the order data
    WITH OrderData AS (
        SELECT 
            gt.amount, 
            gt.fill,
            SUM(gt.amount) OVER (ORDER BY gt.fill ASC) AS cumulative_volume,
            ROW_NUMBER() OVER (ORDER BY gt.fill ASC) AS rn
        FROM get_best_volume_sell_orders(target_volume, market_id_param) gt
    ),
    AdjustedData AS (
        SELECT 
            od.amount,
            od.fill,
            CASE 
                WHEN od.cumulative_volume > target_volume THEN od.amount - (od.cumulative_volume - target_volume)
                ELSE od.amount
            END AS adjusted_amount,
            od.rn
        FROM OrderData od
    ),
    FinalData AS (
        SELECT 
            ad.amount,
            ad.fill,
            ad.adjusted_amount,
            (ad.fill * ad.adjusted_amount) AS weighted_price
        FROM AdjustedData ad
    ),
    Adjustment AS (
        SELECT 
            amount,
            fill,
            adjusted_amount,
            weighted_price
        FROM FinalData
        UNION ALL
        SELECT 
            0 AS amount,
            MAX(fill) AS fill,
            -(SUM(adjusted_amount) - target_volume) AS adjusted_amount,
            (MAX(fill) * -(SUM(adjusted_amount) - target_volume)) AS weighted_price
        FROM FinalData
    )
    SELECT 
        SUM(a.weighted_price)::NUMERIC / target_volume AS average_price
    INTO total_price
    FROM Adjustment a;

    -- Compare the weighted average price with OTC price
    IF total_price IS NULL OR total_price > otc_price THEN
        RETURN QUERY SELECT 'OTC' AS source, otc_price AS average_price;
    ELSE
        RETURN QUERY SELECT 'P2P' AS source, total_price AS average_price;
    END IF;
END;
$$ LANGUAGE plpgsql;

<<<<<<< HEAD
-- Call the function with your desired parameters
--the third parameter is the price for over the counter deal asked from the admin in the moment of the sale.
SELECT * FROM compare_p2p_and_otc(100, 1, 1.5);
=======


-- Call the function with your desired parameters
--the third parameter is the price for over the counter deal asked from the admin in the moment of the sale.

SELECT * FROM compare_p2p_and_otc(320, 1, 1.5);
>>>>>>> 509580b4540bd21de5f4979b52bb8e9d699ba3a9
