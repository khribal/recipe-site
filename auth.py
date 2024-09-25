from database import get_user_by_username
import bcrypt
from flask import session 


def login_user(username, password):
    role = verify_user_login(username, password)
    
    if role:
        # Set session variables based on the role
        session['username'] = username
        session['role'] = role
        session['logged_in'] = True
        print(f"Login successful! Role: {role}")
    else:
        print("Invalid credentials.")

def verify_user_login(username, password):
    user = get_user_by_username(username)
    
    if user:
        stored_hashed_password = user[1]
        
        if bcrypt.checkpw(password.encode('utf-8'), stored_hashed_password.encode('utf-8')):
            return user[2]  # Return the user's role (e.g., 'admin', 'user', etc.)
        else:
            return None  # Invalid password
    else:
        return None  # User doesn't exist
