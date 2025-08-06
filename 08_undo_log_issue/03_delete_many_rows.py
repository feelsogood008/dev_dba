import mysql.connector
from mysql.connector import Error

try:
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='P@ssw0rd',
        database='demo_db'
    )
    cursor = conn.cursor()

    cursor.execute("START TRANSACTION")
    cursor.execute("DELETE FROM undo_test")

    print("Rows deleted. Sleeping before commit...")
    input("Press Enter to commit the deletion...")

    conn.commit()
    print("Committed.")

except Error as e:
    print(f"Error: {e}")
finally:
    if conn.is_connected():
        cursor.close()
        conn.close()
