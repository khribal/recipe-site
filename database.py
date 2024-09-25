from flask import g
import sqlite3
import bcrypt

# Path to the SQLite database
DATABASE = 'instance/recipes.db'

def get_db():
    return sqlite3.connect('instance/recipes.db')

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

#Select specific recipe 
def get_a_recipe(recipe_id):
    sql = "SELECT * FROM recipes where id=?"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql, (recipe_id,))
        recipes = cursor.fetchall()
    
    return recipes

#Get ingredients for recipe based on recipe ID 
def get_ingredients(recipeID):
    sql = "SELECT i.name, ri.quantity, ri.unit FROM ingredients i JOIN recipe_ingredients ri ON i.id = ri.ingredient_id WHERE ri.recipe_id = ?"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql, (recipeID,))
        ingredients = cursor.fetchall()
    
    return ingredients

#Get instructions 
def get_instructions(recipeID):
    sql = "SELECT step_number, step_bold, step_description FROM recipe_steps WHERE recipe_id = ? ORDER BY step_number;"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql, (recipeID,))
        instructions = cursor.fetchall()
    
    return instructions

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

#Return first recipe image with the tag, to display with the tag
def get_tag_and_img():
    sql = "SELECT t.name AS tag_name, MIN(r.recipe_img) AS recipe_imag FROM tags as t JOIN recipe_tag rt ON t.id = rt.tag_id JOIN recipes r ON rt.recipe_id = r.id GROUP BY t.name;"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql)
        tag_img = cursor.fetchall()
    
    return tag_img

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


#Return all the recipes by category ID
def get_category_recipes(category_id):
    sql = "SELECT * FROM recipes where category_id = ?"
    conn = get_db()

    conn.row_factory = sqlite3.Row  
    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql, (category_id,))
        categories = cursor.fetchall()
    
    return categories

#Get login credentials
def get_login(): 
    sql = "SELECT user, pass from admin_cred;"
    conn = get_db()

    with conn: 
        cursor = conn.cursor() 
        cursor.execute(sql)
        creds = cursor.fetchall()
    login = [cred for cred in creds]

    return login
   

def insert_user(username, password):
    user = username
    passw = password 

    hashed_password = bcrypt.hashpw(passw.encode('utf-8'), bcrypt.gensalt())
    conn = get_db()
    cursor = conn.cursor()

    insert_query = '''
        INSERT INTO users (username, password, role) 
        VALUES (?, ?, ?)
    '''

    cursor.execute(insert_query, (user, hashed_password, 'user'))

    # Commit the changes and close the connection
    conn.commit()
    conn.close()

    return 

def get_user_by_username(username):
    conn = get_db()
    cursor = conn.cursor()
    
    cursor.execute("SELECT username, password, role FROM users WHERE username = ?", (username,))
    user = cursor.fetchone()
    
    conn.close()
    
    return user

