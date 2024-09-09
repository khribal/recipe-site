-- Table creation 
CREATE TABLE IF NOT EXISTS ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    summary TEXT,
    prep_time INTEGER,
    cook_time INTEGER,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS recipe_ingredients (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
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


-- Data insertion
INSERT INTO ingredients (name) VALUES 
    ('Steel cut oatmeal'),
    ('Cinnamon sugar'),
    ('Pecans'),
    ('Strawberries');

INSERT INTO categories (name) VALUES 
    ('Breakfast');

INSERT INTO recipes (title, summary, prep_time, cook_time, serves, category_id) VALUES 
    ('Cinnamon Sugar Oatmeal', 'A warm, comforting bowl of hearty oatmeal topped with a sprinkle of sweet cinnamon and sugar, delivering a perfect blend of cozy flavors for a satisfying breakfast.', 10, 5, 1, 1);

INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4);

INSERT INTO tags (name) VALUES 
    ('Sugar'),
    ('Sweet'),
    ('Fruit'),
    ('Berries');

INSERT INTO recipe_tag (recipe_id, tag_id) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4);