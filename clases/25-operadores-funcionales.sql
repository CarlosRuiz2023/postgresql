select id,
    UPPER(name) AS upper_name,
    LOWER(name) AS lower_name,
    LENGTH(name) AS length_name,
    (20 * 2) AS constante,
    '*' || id || '-' || name || '*' AS barcode,
    CONCAT('*', id, '-', name, '*') AS concat_name,
    name
from users;