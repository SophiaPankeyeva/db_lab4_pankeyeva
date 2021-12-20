
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
