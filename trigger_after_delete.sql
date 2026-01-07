DELIMITER |

CREATE TRIGGER matview_delete
AFTER DELETE ON bill_products
FOR EACH ROW
BEGIN
    UPDATE ventas_diarias_m set 
        cantidad = (SELECT COUNT(*) FROM bill_products WHERE DATE(date_added) = DATE(OLD.date_added)),
        total = (SELECT SUM(total) FROM bill_products WHERE DATE(date_added) = DATE(OLD.date_added))
    where fecha = DATE(OLD.date_added);
END
|
DELIMITER ;
