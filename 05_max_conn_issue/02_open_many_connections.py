# 다수의 연결을 생성하여 max_connections 초과 현상 재현
import mysql.connector
import time

connections = []

try:
    for i in range(200):  # 현재 기본값(151)을 넘게 시도
        conn = mysql.connector.connect(
            host='localhost',
            user='conn_test',
            password='P@ssw0rd',
            database='demo_db'
        )
        connections.append(conn)
        print(f"[{i+1}] 연결 생성 성공")
        time.sleep(0.3)
except Exception as e:
    print("❌ 연결 실패 발생:", e)
finally:
    input("👉 아무 키나 누르면 연결 종료...")
    for conn in connections:
        conn.close()
