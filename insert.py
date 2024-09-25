import sqlite3
import bcrypt

# Function to hash a password and insert it into the database
def insert_user_with_hashed_password(username, password, role):
    # Connect to your SQLite database
    conn = sqlite3.connect('instance/recipes.db')
    cursor = conn.cursor()

    # Hash the password using bcrypt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    # Insert the user, hashed password, and role into the database
    cursor.execute("INSERT INTO users (username, password, role) VALUES (?, ?, ?)", 
                   (username, hashed_password.decode('utf-8'), role))
    
    # Commit the changes and close the connection
    conn.commit()
    conn.close()

    print(f"User {username} inserted successfully with hashed password.")

# Example of how to call the function
username = 'admin'
password = 'pass0603$'
role = 'admin'

# Call the function to insert the user with a hashed password
insert_user_with_hashed_password(username, password, role)
