from flask import g
import sqlite3

# Path to the SQLite database
DATABASE = 'instance/recipes.db'

def get_db():
    return sqlite3.connect('recipes.db')

#Return all the recipes within the category
def get_recipes():
    sql = "SELECT * FROM recipes"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql)
        recipes = cursor.fetchall()
    
    return recipes

#Get ingredients for recipe based on recipe ID 
def get_ingredients(recipeID):
    sql = "SELECT i.name FROM ingredients i JOIN recipe_ingredients ri ON i.id = ri.ingredient_id WHERE ri.recipe_id = ?"
    conn = get_db()

    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql, (recipeID,))
        ingredients = cursor.fetchall()
    
        ingredient_names = [ingredient[0] for ingredient in ingredients]
    return ingredient_names

#Return all the tags
def get_tags():
    sql = "SELECT * FROM tags"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql)
        tags = cursor.fetchall()
    
    return tags

#Return all the categories of foods
def get_categories():
    sql = "SELECT * FROM categories"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql)
        categories = cursor.fetchall()
    
    return categories


   
