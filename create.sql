
CREATE TABLE food_types (
    food_type_id SERIAL PRIMARY KEY  ,
	food_type_name VARCHAR(30)
);

CREATE TABLE food (
    food_id SERIAL PRIMARY KEY  ,
	food_name VARCHAR(80),
	food_weight_in_grams INT,
	food_type_id INT REFERENCES food_types(food_type_id)
);

CREATE TABLE energy_values_of_food (
    energy_values_of_food_id SERIAL PRIMARY KEY  ,
	Cals_per100grams INT,
	KJ_per100grams INT,
	food_id INT 
);


ALTER TABLE energy_values_of_food ADD FOREIGN KEY (food_id) REFERENCES food(food_id); 
