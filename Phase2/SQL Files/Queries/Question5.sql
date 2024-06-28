DROP FUNCTION get_best_sell_offers(crypto_id integer, total_rials bigint) CASCADE;

CREATE OR REPLACE FUNCTION get_best_sell_offers(crypto_id INT, total_rials BIGINT)
RETURNS TABLE (
    offer_id INT,
    amt BIGINT,
    ppu BIGINT,
    total BIGINT
) AS $$
DECLARE
    remaining_rials BIGINT := total_rials;
    total_offer_value BIGINT;
BEGIN
    RETURN QUERY
    WITH RankedSellOffers AS (
        SELECT 
            order_id,
            amount,
            fill AS price_per_unit,
            fill * amount AS total_price,
            SUM(fill * amount) OVER (ORDER BY fill ASC) AS cumulative_total,
            ROW_NUMBER() OVER (ORDER BY fill ASC) AS rank
        FROM orders
        WHERE is_sell = TRUE AND market_id = crypto_id
    ),
    LimitedSellOffers AS (
        SELECT *
        FROM RankedSellOffers
        WHERE cumulative_total <= total_rials OR rank = (
            SELECT MIN(rank)
            FROM RankedSellOffers
            WHERE cumulative_total > total_rials
        )
    )
    SELECT 
        order_id AS offer_id,
        amount,
        price_per_unit,
        CASE
            WHEN remaining_rials - total_price > 0 THEN total_price
            ELSE remaining_rials
        END AS total_price
    FROM LimitedSellOffers
    ORDER BY price_per_unit ASC;
    
    -- Adjust the last offer if necessary
    IF remaining_rials - (SELECT SUM(total_price) FROM LimitedSellOffers) > 0 THEN
        UPDATE LimitedSellOffers
        SET total_price = remaining_rials - (SELECT SUM(total_price) FROM LimitedSellOffers) + total_price
        WHERE rank = (SELECT MAX(rank) FROM LimitedSellOffers);
    END IF;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_best_sell_offers(1, 1000000); -- Replace 1 with the crypto_id and 1000000 with the total_rials

