# demo_db 의 현재 커넥션 수를 0.1초 간격으로 출력하는 모니터링 도구

import time
import mysql.connector

# DB 접속 정보 정의
dbconfig = {
    "host": "localhost",
    "user": "conn_test",
    "password": "P@ssw0rd",
    "database": "demo_db"
}

try:
    conn = mysql.connector.connect(**dbconfig)
    cursor = conn.cursor()

    print("🔍 현재 커넥션 수를 0.1초 간격으로 모니터링합니다. 중지하려면 Ctrl+C")
    while True:
        cursor.execute("SHOW STATUS LIKE 'Threads_connected';")
        result = cursor.fetchone()
        connected = result[1] if result else 'N/A'
        print(f"[{time.strftime('%H:%M:%S')}] 현재 커넥션 수: {connected}")
        time.sleep(0.1)

except KeyboardInterrupt:
    print("\n🛑 모니터링을 중단합니다.")

except mysql.connector.Error as err:
    print(f"❌ DB 연결 오류: {err}")

finally:
    if 'cursor' in locals() and cursor:
        cursor.close()
    if 'conn' in locals() and conn and conn.is_connected():
        conn.close()
