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

INSERT INTO categories (name, item_img) VALUES 
    ('Breakfast', 'https://food.fnr.sndimg.com/content/dam/images/food/plus/fullset/2020/04/30/0/FNK_The-Best-Cheddar-And-Herb-Chaffle_H_s4x3.jpg.rend.hgtvcom.1280.960.suffix/1588257306685.jpeg');

INSERT INTO recipes (title, summary, prep_time, cook_time, serves, recipe_img, category_id) VALUES 
    ('Cinnamon Sugar Oatmeal', 'A warm, comforting bowl of hearty oatmeal topped with a sprinkle of sweet cinnamon and sugar, delivering a perfect blend of cozy flavors for a satisfying breakfast.', 10, 5, 1, 'https://simple-veganista.com/wp-content/uploads/2018/11/cinnamon-oatmeal.jpg', 1);

INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4);

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