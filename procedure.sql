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
