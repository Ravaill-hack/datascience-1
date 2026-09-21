--
-- 1ere etape : on visualise les donnees identifiees comme doublons
--

-- le select indique uniquement les donnees qui seront montrees
SELECT
    t1.id AS id1,
    t2.id AS id2,
    t1.event_time AS time1,
    t2.event_time AS time2,
    t1.event_type,
    t1.product_id,
    t1.price,
    t1.user_id,
    t1.user_session
FROM customers t1
JOIN customers t2 -- on fusionne 2 instances de la table
    ON t1.id < t2.id
    AND t1.event_type = t2.event_type
    AND t1.product_id = t2.product_id
    AND t1.price = t2.price
    AND t1.user_id = t2.user_id
    AND t1.user_session = t2.user_session
    AND ABS(
        EXTRACT(
            EPOCH FROM (
                t1.event_time::timestamp - t2.event_time::timestamp
            )
        )
    ) <= 1 -- on est oblige de convertir la date en timestamp pour comparer les secondes
ORDER BY t1.event_time;

--
-- 2eme etape : on supprime les donnees identifiees comme doublons
--
DELETE FROM customers t1
WHERE EXISTS (
    SELECT 1
    FROM customers t2
    WHERE t1.id > t2.id
      AND t1.event_type = t2.event_type
      AND t1.product_id = t2.product_id
      AND t1.price = t2.price
      AND t1.user_id = t2.user_id
      AND t1.user_session = t2.user_session
      AND ABS(
          EXTRACT(
              EPOCH FROM (
                  t1.event_time::timestamp - t2.event_time::timestamp
              )
          )
      ) <= 1
);