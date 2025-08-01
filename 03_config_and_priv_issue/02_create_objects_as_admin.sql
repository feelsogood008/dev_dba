-- 관리자 계정으로 테이블과 뷰, 프로시저 등 생성
USE demo_db;

-- 기존에 존재하던 테이블
CREATE TABLE legacy_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO legacy_users (name, email) VALUES('lee','lee@a.b');

-- 새로 추가된 테이블
CREATE TABLE new_payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10, 2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO new_payments (user_id, amount) VALUES(1,1000);


-- 신규 뷰
CREATE VIEW recent_payments AS
SELECT user_id, amount, created_at
FROM new_payments
WHERE created_at > NOW() - INTERVAL 30 DAY;


-- 신규 저장 프로시저
DELIMITER //
CREATE PROCEDURE get_user_email(IN uid INT)
BEGIN
    SELECT email FROM legacy_users WHERE id = uid;
END;
//
DELIMITER ;

-- 권한 할당 legacy_users 에만 SELECT 권한 부여
GRANT SELECT ON demo_db.legacy_users TO 'svc_api'@'%';
FLUSH PRIVILEGES;
