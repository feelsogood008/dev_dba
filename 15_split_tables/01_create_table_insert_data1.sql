
CREATE DATABASE IF NOT EXISTS demo_db;


USE demo_db;


DROP TABLE IF EXISTS orders;

-- 주문 기본 테이블인데 모든 정보를 한 테이블에 담아두는 형태이다. 
-- 설계관점에서는 올바른 정규화의 형태가 아닐 가능성이 크다.
CREATE TABLE orders (
  id           BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_id  INT NOT NULL,
  order_date   DATETIME NOT NULL,
  -- 주문 정보
  total_amount DECIMAL(10,2) NOT NULL,
  status       VARCHAR(20) NOT NULL,
  -- 결제 정보
  payment_method VARCHAR(20),
  payment_date   DATETIME,
  payment_status VARCHAR(20),
  -- 배송 정보
  shipping_address VARCHAR(200),
  shipping_date    DATETIME,
  delivery_status  VARCHAR(20),
  -- 환불 정보
  refund_date   DATETIME,
  refund_amount DECIMAL(10,2),
  refund_reason VARCHAR(200),
  -- 고객 메모
  customer_note TEXT
) ENGINE=InnoDB;




INSERT INTO orders
(customer_id, order_date, total_amount, status,
 payment_method, payment_date, payment_status,
 shipping_address, shipping_date, delivery_status,
 refund_date, refund_amount, refund_reason, customer_note)
VALUES
(1, NOW(), 100.00, 'ordered',
 'card', NOW(), 'paid',
 'Seoul', NULL, 'PREPARING',
 NULL, NULL, NULL, '첫 주문'),
(2, NOW(), 50.00, 'CANCEL_REQUESTED',
 NULL, NULL, NULL,
 NULL, NULL, NULL,
 NOW(), 50.00, '고객 변심', '취소 처리됨');





