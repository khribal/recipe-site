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
INSERT INTO ingredients (name) VALUES ('Dessert');
INSERT INTO categories (name) VALUES ('Sugar');
INSERT INTO recipes (title, summary, prep_time, cook_time, category_id) VALUES ('Cake', 'A sweet cake', 20, 40, 1);
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES ('Cake', 'A sweet cake', 20, 40, 1);
INSERT INTO tags (name) VALUES ('Sugar');
INSERT INTO recipe_tag (recipe_id, tag_id) VALUES ('Sugar');
