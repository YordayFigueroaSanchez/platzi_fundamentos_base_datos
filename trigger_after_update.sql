DELIMITER |

CREATE TRIGGER matview_update
AFTER UPDATE ON bill_products
FOR EACH ROW
BEGIN
    -- cuando la fecha cambie
    IF date(NEW.date_added) <> date(OLD.date_added) THEN
        UPDATE ventas_diarias_m set 
            cantidad = (SELECT COUNT(*) FROM bill_products WHERE DATE(date_added) = DATE(OLD.date_added)),
            total = (SELECT SUM(total) FROM bill_products WHERE DATE(date_added) = DATE(OLD.date_added))
        where fecha = DATE(OLD.date_added);
    END IF;
    -- cuando la fecha NO cambie
    UPDATE ventas_diarias_m set 
        cantidad = (SELECT COUNT(*) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added)),
        total = (SELECT SUM(total) FROM bill_products WHERE DATE(date_added) = DATE(NEW.date_added))
    where fecha = DATE(NEW.date_added);
END
|

DELIMITER ;
