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

    # 삭제 전 undo_test 테이블 건수 확인
    cursor.execute("SELECT COUNT(*) FROM undo_test")
    row_count = cursor.fetchone()[0]
    print(f"[삭제 전 데이터 건수] undo_test 테이블 : {row_count} 건")
    
    
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
