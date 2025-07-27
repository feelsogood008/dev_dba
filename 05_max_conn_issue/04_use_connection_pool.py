# 커넥션 풀 사용하여 효율적 연결 관리
from mysql.connector import pooling
import time

dbconfig = {
    "host": "localhost",
    "user": "conn_test",
    "password": "P@ssw0rd",
    "database": "demo_db"
}

try:
    pool = pooling.MySQLConnectionPool(
        pool_name="mypool",
        pool_size=10,
        **dbconfig
    )

    for i in range(50):
        conn = pool.get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT NOW();")
        print(f"[{i+1}] 연결 성공: {cursor.fetchone()}")
        cursor.close()
        conn.close()
        time.sleep(0.1)
except Exception as e:
    print("❌ 커넥션 풀 사용 중 오류:", e)
