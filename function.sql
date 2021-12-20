-- Функція, яка яка виводить кількість  калорій в кілограмі продукту

CREATE OR REPLACE FUNCTION get_calories_per_kilo(kal_in_100_grams int)
RETURNS int
LANGUAGE 'plpgsql'
AS $$
DECLARE kal_in_kilo INT;

BEGIN
	kal_in_kilo = kal_in_100_grams * 10;
	RETURN kal_in_kilo;
END;
$$;

SELECT get_calories_per_kilo(100); 
