#!/bin/bash

# Check if the instance directory exists, if not, create it
if [ ! -d "instance" ]; then
    mkdir instance
fi

# Populate the SQLite database with the dump file
sqlite3 instance/recipes.db < data_dump.sql

echo "Database has been loaded from data_dump.sql"
