DELIMITER |
CREATE TRIGGER matview_insert
AFTER INSERT ON bill_products
FOR EACH ROW
BEGIN
    INSERT INTO ventas_diarias_m (fecha, cantidad, total)
    VALUES (
        DATE(NEW.date_added),
        (SELECT COUNT(*) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added)),
        (SELECT SUM(total) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added))
    )
    ON DUPLICATE KEY UPDATE
    cantidad = VALUES(cantidad),
    total = VALUES(total);
END
|
DELIMITER ;

SHOW TRIGGERS;
