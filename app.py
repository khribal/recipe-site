from flask import Flask, render_template, g, jsonify
import sqlite3
import os
import database


app = Flask(__name__)


@app.route('/')
def home():
    categories = database.get_categories()

    recipes = database.get_recipes()  # Or any method that returns all recipes

    #how many recipes in total
    recipe_count = len(recipes)

   # Render the initial HTML with all recipes
    recipes_html = render_template('recipes_partial.html', recipes=recipes)
    return render_template('index.html', recipes_html=recipes_html, categories=categories, recipe_count=recipe_count)

@app.route('/recipes_by_category/<int:category_id>', methods=['GET'])
def recipes_by_category(category_id):
    
    #default ID set for all categories
    if category_id == 0:
        recipes = database.get_recipes()
    else:
        recipes = database.get_category_recipes(category_id)


    # Render a partial template for the recipes
    recipes_html = render_template('recipes_partial.html', recipes=recipes)
    return jsonify({'recipes_html': recipes_html})


@app.route('/category/<int:category_id>')
def category(category_id):
    recipes = database.get_category_recipes(category_id)

    # Render a template, passing the recipes to the template
    return render_template('category.html', recipes=recipes, category_id=category_id)


@app.route('/recipe/<int:recipe_id>')
def recipe(recipe_id):
    ingredients = database.get_ingredients(recipe_id)

    recipe = database.get_a_recipe(recipe_id)
    # Render a template, passing the recipes to the template
    return render_template('recipe.html', ingredients=ingredients, recipe=recipe, recipe_id=recipe_id)


@app.teardown_appcontext
def close_db(exception):
    db = g.pop('db', None)
    if db is not None:
        db.close()

# Call init_db() to create tables when the application starts
if __name__ == '__main__':
    app.run(debug=True)


