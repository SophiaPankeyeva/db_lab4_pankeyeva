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



-- Процедура, яка створює нову таблицю з даними про назви продуктів для заданого типу їжі

CREATE OR REPLACE PROCEDURE create_table_food(food_specific_type varchar(40))
LANGUAGE 'plpgsql'
AS $$
BEGIN
	DROP TABLE IF EXISTS food_by_food_type;
	CREATE TABLE food_by_food_type
	AS
	(SELECT food_id, food_name, food_type_name FROM food 
	 JOIN food_types ON food.food_type_id = food_types.food_type_id
	 WHERE food_type_name = food_specific_type);
END;
$$;

CALL create_table_food('Fruits');
select * from food_by_food_type




-- Триггер для додавання у таблицю changes_food при кожному оновленні таблиці food рядків з інформацією про
-- час оновлення назва їжі
DROP TABLE IF EXISTS changes_food;
CREATE TABLE changes_food(
	id SERIAL PRIMARY KEY,
	updated_at TIMESTAMP,
	old_food_name VARCHAR(50) NOT NULL,
	new_food_name VARCHAR(50) NOT NULL
);

CREATE OR REPLACE FUNCTION update_food_details() RETURNS trigger AS
$$
BEGIN
 	IF NEW.food_name <> OLD.food_name THEN
		INSERT INTO changes_food(updated_at, old_food_name, new_food_name)
		VALUES(NOW(), OLD.food_name, NEW.food_name);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER show_update_food_name_logs 
BEFORE UPDATE ON food
FOR EACH ROW EXECUTE FUNCTION update_food_details();

UPDATE food
SET food_name = 'Tomato' WHERE food_name = 'Applesauce';

UPDATE food
SET food_name = 'Potato' WHERE food_name = 'Canned Cherries';

SELECT * FROM changes_food; 
