from flask import Flask, render_template, g
import sqlite3
import os

app = Flask(__name__)

# Path to the SQLite database
DATABASE = 'instance/recipes.db'

def get_db():
    if not hasattr(g, 'db'):
        g.db = sqlite3.connect(DATABASE)
        g.db.row_factory = sqlite3.Row
        g.db.execute('PRAGMA foreign_keys = ON;')  # Enable foreign key support
    return g.db

@app.route('/')
def home():
    return "Hello, Flask!"

def init_db():
    with app.app_context():
        db = get_db()
        db.execute('''CREATE TABLE IF NOT EXISTS ingredients (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL
                    )''')
        db.execute('''CREATE TABLE IF NOT EXISTS categories (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL
                    )''')
        db.execute('''CREATE TABLE IF NOT EXISTS recipes (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT NOT NULL,
                    summary TEXT,
                    prep_time INTEGER,
                    cook_time INTEGER,
                    category_id INTEGER,
                    FOREIGN KEY (category_id) REFERENCES categories(id)
                    )''')
        db.execute('''CREATE TABLE IF NOT EXISTS recipe_ingredients (
                    recipe_id INTEGER NOT NULL,
                    ingredient_id INTEGER NOT NULL,
                    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
                    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id),
                    PRIMARY KEY (recipe_id, ingredient_id)
                    )''')
        db.execute('''CREATE TABLE IF NOT EXISTS tags (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL
                    )''')
        db.execute('''CREATE TABLE IF NOT EXISTS recipe_tag (
                    recipe_id INTEGER NOT NULL,
                    tag_id INTEGER NOT NULL,
                    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
                    FOREIGN KEY (tag_id) REFERENCES tags(id),
                    PRIMARY KEY (recipe_id, tag_id)
                    )''')
        db.commit()

@app.teardown_appcontext
def close_db(exception):
    db = g.pop('db', None)
    if db is not None:
        db.close()

@app.route('/check_db')
def check_db():
    db = get_db()
    cursor = db.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    table_list = [table[0] for table in tables]
    return "<br>".join(table_list)

# Call init_db() to create tables when the application starts
if __name__ == '__main__':
    init_db()
    app.run(debug=True)


