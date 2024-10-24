import mysql.connector
import os
from dotenv import load_dotenv
from faker import Faker

load_dotenv()

def create_connection():
    print("Connecting to database...")
    try:
        conn = mysql.connector.connect(
            host=os.getenv("DB_HOST"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            database=os.getenv("DB_NAME")
        )
        print("Connection successful!")
        return conn
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def insert_data(cursor):
    fake = Faker()

    print("Inserting categories...")
    categories = ['Action', 'Adventure', 'RPG', 'Sports', 'Puzzle']
    for category in categories:
        cursor.execute("INSERT IGNORE INTO categories (category_name) VALUES (%s)", (category,))
    print("Categories inserted.")

    print("Inserting users...")
    print("This may take some time due to the large number of entries.")
    for _ in range(500000):
        username = fake.user_name()
        email = fake.email()
        cursor.execute("INSERT IGNORE INTO users (username, email) VALUES (%s, %s)", (username, email))
        if _ % 10000 == 0:
            print(f"Inserted {_} users.")
    print("Users inserted.")

    cursor.execute("SELECT category_id FROM categories")
    category_ids = [row[0] for row in cursor.fetchall()]

    print("Inserting games...")
    titles = set()  
    games_to_insert = []

    for _ in range(10000):
        title = fake.unique.catch_phrase() 
        titles.add(title)
        games_to_insert.append((title, fake.year(), fake.random_element(category_ids)))

    cursor.executemany("INSERT IGNORE INTO games (title, release_year, category_id) VALUES (%s, %s, %s)", games_to_insert)
    print("Games inserted.")

    print("Inserting orders...")
    orders_to_insert = []

    for _ in range(100000):
        orders_to_insert.append((fake.random_int(min=1, max=500000),))

    cursor.executemany("INSERT IGNORE INTO orders (user_id) VALUES (%s)", orders_to_insert)
    print("Orders inserted.")

    print("Inserting reviews...")
    reviews_to_insert = []

    for _ in range(20000):
        reviews_to_insert.append(
            (fake.random_int(min=1, max=10000), 
             fake.random_int(min=1, max=500000), 
             fake.random_int(min=1, max=5), 
             fake.sentence())
        )

    cursor.executemany(
        "INSERT IGNORE INTO reviews (game_id, user_id, rating, review_text) VALUES (%s, %s, %s, %s)", 
        reviews_to_insert
    )
    print("Reviews inserted.")

def main():
    db = create_connection()
    if db is not None:
        cursor = db.cursor()
        try:
            insert_data(cursor)
            db.commit()  
            print("All data inserted successfully!")
        except mysql.connector.Error as err:
            print(f"Error while inserting data: {err}")
            db.rollback()  
        finally:
            cursor.close()
            db.close()
    else:
        print("Failed to create database connection.")

if __name__ == "__main__":
    main()
