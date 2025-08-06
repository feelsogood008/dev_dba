import mysql.connector
from mysql.connector import Error

try:
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='your_password',
        database='demo_db'
    )
    cursor = conn.cursor()

    cursor.execute("DROP TABLE IF EXISTS undo_test")
    cursor.execute("""
        CREATE TABLE undo_test (
            id INT AUTO_INCREMENT PRIMARY KEY,
            data VARCHAR(255)
        ) ENGINE=InnoDB
    """)
    conn.commit()

    cursor.execute("START TRANSACTION")
    for i in range(500000):
        cursor.execute("INSERT INTO undo_test (data) VALUES (%s)", ('x' * 200,))
        if i % 10000 == 0:
            print(f"{i} rows inserted...")

    print("Data insert complete. Sleeping to delay commit...")
    input("Press Enter to commit the transaction...")

    conn.commit()
    print("Committed.")

except Error as e:
    print(f"Error: {e}")
finally:
    if conn.is_connected():
        cursor.close()
        conn.close()
