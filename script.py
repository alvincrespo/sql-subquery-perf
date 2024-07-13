import mysql.connector
from faker import Faker
import random

# Initialize Faker
fake = Faker()

# Database connection
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='my-secret-pw',
    database='library'
)
cursor = conn.cursor()

# Number of records to generate
num_authors = 1000  # Number of authors
num_books = 1000000  # Number of books

# Generate and insert fake authors
authors = []
for _ in range(num_authors):
    name = fake.name()
    birthdate = fake.date_of_birth(minimum_age=25, maximum_age=90)
    nationality = fake.country()
    authors.append((name, birthdate, nationality))

author_insert_query = """
    INSERT INTO authors (name, birthdate, nationality) VALUES (%s, %s, %s)
"""
cursor.executemany(author_insert_query, authors)
conn.commit()

# Get author IDs
cursor.execute("SELECT author_id FROM authors")
author_ids = [row[0] for row in cursor.fetchall()]

# Generate and insert fake books
books = []
for _ in range(num_books):
    title = fake.sentence(nb_words=6)
    publication_year = random.randint(1900, 2024)
    genre = fake.word()
    author_id = random.choice(author_ids)
    books.append((title, publication_year, genre, author_id))

book_insert_query = """
    INSERT INTO books (title, publication_year, genre, author_id) VALUES (%s, %s, %s, %s)
"""

# Insert books in batches to avoid memory issues
batch_size = 10000
for i in range(0, len(books), batch_size):
    cursor.executemany(book_insert_query, books[i:i + batch_size])
    conn.commit()

# Close connection
cursor.close()
conn.close()

print(f"Inserted {num_authors} authors and {num_books} books.")
