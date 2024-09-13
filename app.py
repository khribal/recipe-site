from flask import Flask, render_template, g
import sqlite3
import os
import database


app = Flask(__name__)


@app.route('/')
def home():
    recipes = database.get_recipes()
    return  render_template('index.html', recipes=recipes)


@app.teardown_appcontext
def close_db(exception):
    db = g.pop('db', None)
    if db is not None:
        db.close()

# Call init_db() to create tables when the application starts
if __name__ == '__main__':
    app.run(debug=True)


