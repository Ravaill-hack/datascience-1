--
-- Ajout des colonnes manquantes
--

ALTER TABLE customers
DROP COLUMN item_id,
DROP COLUMN category_id,
DROP COLUMN category_code,
DROP COLUMN brand,
ADD COLUMN item_id INTEGER,
ADD COLUMN category_id BIGINT,
ADD COLUMN category_code VARCHAR(255),
ADD COLUMN brand VARCHAR(255);

--
-- Injection des donnees de items dans customers
--

UPDATE customers
SET
    item_id = i.id,
    category_id = i.category_id,
    category_code = i.category_code,
    brand = i.brand
FROM items i
WHERE customers.product_id = i.product_id;