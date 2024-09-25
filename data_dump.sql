-- Table creation 
CREATE TABLE IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, 
    item_img TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    summary TEXT,
    prep_time INTEGER,
    cook_time INTEGER,
    serves TEXT,
    recipe_img TEXT,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS recipe_ingredients (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity REAL NOT NULL,  -- This stores the quantity (e.g., 2, 1/4, 3.5)
    unit TEXT NOT NULL, --Cups, tablespoons, etc
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id),
    PRIMARY KEY (recipe_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS recipe_tag (
    recipe_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY (recipe_id, tag_id)
);

CREATE TABLE IF NOT EXISTS recipe_steps (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER NOT NULL,
    step_number INTEGER NOT NULL, -- The order of the step
    step_bold INTEGER NOT NULL, 
    step_description TEXT NOT NULL, -- The description of the step
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL, -- This will store the hashed password
    role TEXT NOT NULL CHECK(role IN ('admin', 'user')) -- Defines whether the user is admin or regular
);


-- Data insertion


INSERT INTO ingredients (name) VALUES 
    ('Steel cut oatmeal'),
    ('Cinnamon'),
    ('Sugar'),
    ('Pecans'),
    ('Strawberries'),
    ('Water');

INSERT INTO categories (name, item_img) VALUES 
    ('Breakfast', 'https://food.fnr.sndimg.com/content/dam/images/food/plus/fullset/2020/04/30/0/FNK_The-Best-Cheddar-And-Herb-Chaffle_H_s4x3.jpg.rend.hgtvcom.1280.960.suffix/1588257306685.jpeg');

INSERT INTO recipes (title, summary, prep_time, cook_time, serves, recipe_img, category_id) VALUES 
    ('Cinnamon Sugar Oatmeal', 'There’s nothing quite like starting the day with a warm, comforting bowl of hearty oatmeal. This wholesome dish, cooked to creamy perfection, is topped with a generous sprinkle of sweet cinnamon and sugar, adding just the right touch of warmth and flavor. Whether you’re cozying up on a chilly morning or seeking a nutritious breakfast to fuel your day, this simple yet satisfying meal offers a perfect balance of taste and comfort. Every spoonful delivers a delightful blend of textures and cozy flavors, making it an ideal choice to nourish both body and soul.', 10, 5, 1, 'https://simple-veganista.com/wp-content/uploads/2018/11/cinnamon-oatmeal.jpg', 1);

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit) VALUES 
    (1, 1, 0.5, 'cup'),
    (1, 2, 0.5, 'teaspoon'),
    (1, 3, 1, 'teaspoon'),
    (1, 4, 1, 'tablespoon'),
    (1, 5, 0.25, 'cup'),
    (1, 6, 1, 'cup');

INSERT INTO tags (name) VALUES 
    ('30 minute'),
    ('Side dish'),
    ('Dairy-Free'),
    ('Mediterranean');

INSERT INTO recipe_tag (recipe_id, tag_id) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4);

INSERT INTO recipe_steps (recipe_id, step_number, step_bold, step_description) VALUES 
    (1, 1, 'Boil the liquid', 'Combine 1/2 cup of oatmeal with 1 cup of water.'),
    (1, 2, 'Add the oats', 'Once the liquid is boiling, stir in 1/2 cup of oats.'),
    (1, 3, 'Cook the oats', 'Simmer for 1–2 minutes, stirring frequently.'),
    (1, 4, 'Let it sit', 'After cooking, remove the pot from heat and let the oatmeal sit for 1-2 minutes to thicken.'),
    (1, 5, 'Mix the cinnamon sugar', 'In a small bowl, mix 1/2 teaspoon of ground cinnamon with 1 teaspoon of sugar.'),
    (1, 6, 'Add toppings', 'Sprinkle the cinnamon sugar mix evenly over the top of the oatmeal. Add chopped pecans and fresh strawberry slices.');
