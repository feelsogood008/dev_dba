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

    cursor.execute("DROP TABLE IF EXISTS undo_test")
    cursor.execute("""
        CREATE TABLE undo_test (
            id INT AUTO_INCREMENT PRIMARY KEY,
            data VARCHAR(255)
        ) ENGINE=InnoDB
    """)
    conn.commit()

    cursor.execute("START TRANSACTION")
    
    # 약 2,000,000건 데이터 생성
    total_rows = 2000000
    batch_size = 1000
    sample_text = "X" * 255  # 255자 데이터

    for i in range(0, total_rows, batch_size):
        data_batch = [(sample_text,) for _ in range(batch_size)]
        cursor.executemany("INSERT INTO undo_test (data) VALUES (%s)", data_batch)        

        if i % 10000 == 0:
            print(f"  {i}건 입력 완료...")

    
    print(f"[완료] 총 {total_rows}건 데이터 입력 완료")


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
