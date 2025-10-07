USE demo_db;


DROP TABLE IF EXISTS new_orders;
DROP TABLE IF EXISTS order_payments;
DROP TABLE IF EXISTS order_shipments;
DROP TABLE IF EXISTS order_refunds;
DROP TABLE IF EXISTS order_notes;



-- 주문 기본 테이블
CREATE TABLE new_orders (
  id           BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_id  INT NOT NULL,
  order_date   DATETIME NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status       VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- 결제 테이블
CREATE TABLE order_payments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  method VARCHAR(20),
  payment_date DATETIME,
  status VARCHAR(20),
  FOREIGN KEY (order_id) REFERENCES new_orders(id)
) ENGINE=InnoDB;

-- 배송 테이블
CREATE TABLE order_shipments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  address VARCHAR(200),
  shipping_date DATETIME,
  delivery_status VARCHAR(20),
  FOREIGN KEY (order_id) REFERENCES new_orders(id)
) ENGINE=InnoDB;

-- 환불 테이블
CREATE TABLE order_refunds (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  refund_date DATETIME,
  amount DECIMAL(10,2),
  reason VARCHAR(200),
  FOREIGN KEY (order_id) REFERENCES new_orders(id)
) ENGINE=InnoDB;

-- 고객 메모 테이블
CREATE TABLE order_notes (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  note TEXT,
  FOREIGN KEY (order_id) REFERENCES new_orders(id)
) ENGINE=InnoDB;


-- 주문 기본 테이블 (new_orders) 진행 (id는 1~5로 가정)
INSERT INTO new_orders (customer_id, order_date, total_amount, status) VALUES (101, '2025-10-07 10:20:00', 15000.00, 'PENDING');
INSERT INTO new_orders (customer_id, order_date, total_amount, status) VALUES (102, '2025-10-07 10:21:00', 23000.00, 'PAID');
INSERT INTO new_orders (customer_id, order_date, total_amount, status) VALUES (103, '2025-10-07 10:22:00', 12000.00, 'REFUNDED');
INSERT INTO new_orders (customer_id, order_date, total_amount, status) VALUES (104, '2025-10-07 10:23:00', 21000.00, 'SHIPPED');
INSERT INTO new_orders (customer_id, order_date, total_amount, status) VALUES (105, '2025-10-07 10:24:00', 32000.00, 'CANCELED');

-- 결제 테이블 (order_payments, order_id는 new_orders의 id 값)
INSERT INTO order_payments (order_id, method, payment_date, status) VALUES (1, 'CARD', '2025-10-07 10:25:00', 'PAID');
INSERT INTO order_payments (order_id, method, payment_date, status) VALUES (2, 'CASH', '2025-10-07 10:26:00', 'PENDING');
INSERT INTO order_payments (order_id, method, payment_date, status) VALUES (3, 'TRANSFER', '2025-10-07 10:27:00', 'REFUNDED');
INSERT INTO order_payments (order_id, method, payment_date, status) VALUES (4, 'CARD', '2025-10-07 10:28:00', 'PAID');
INSERT INTO order_payments (order_id, method, payment_date, status) VALUES (5, 'CASH', '2025-10-07 10:29:00', 'CANCELED');

-- 배송 테이블 (order_shipments)
INSERT INTO order_shipments (order_id, address, shipping_date, delivery_status) VALUES (1, '서울특별시 강남구 1번지', '2025-10-07 11:00:00', 'SHIPPED');
INSERT INTO order_shipments (order_id, address, shipping_date, delivery_status) VALUES (2, '부산광역시 해운대구 2번지', '2025-10-07 11:10:00', 'PREPARING');
INSERT INTO order_shipments (order_id, address, shipping_date, delivery_status) VALUES (3, '대구광역시 달서구 3번지', '2025-10-07 11:20:00', 'RETURNED');
INSERT INTO order_shipments (order_id, address, shipping_date, delivery_status) VALUES (4, '인천광역시 부평구 4번지', '2025-10-07 11:30:00', 'DELIVERED');
INSERT INTO order_shipments (order_id, address, shipping_date, delivery_status) VALUES (5, '광주광역시 남구 5번지', '2025-10-07 11:40:00', 'CANCEL_REQUESTED');

-- 환불 테이블 (order_refunds)
INSERT INTO order_refunds (order_id, refund_date, amount, reason) VALUES (1, '2025-10-07 12:00:00', 5000.00, '고객 요청');
INSERT INTO order_refunds (order_id, refund_date, amount, reason) VALUES (2, '2025-10-07 12:10:00', 23000.00, '결제 오류');
INSERT INTO order_refunds (order_id, refund_date, amount, reason) VALUES (3, '2025-10-07 12:20:00', 12000.00, '상품 결함');
INSERT INTO order_refunds (order_id, refund_date, amount, reason) VALUES (4, '2025-10-07 12:30:00', 11000.00, '단순 변심 환불');
INSERT INTO order_refunds (order_id, refund_date, amount, reason) VALUES (5, '2025-10-07 12:40:00', 32000.00, '입력 실수로 인한 전체 환불');

-- 고객 메모 테이블 (order_notes)
INSERT INTO order_notes (order_id, note) VALUES (1, '고객이 빠른 배송을 요청했습니다.');
INSERT INTO order_notes (order_id, note) VALUES (2, '배송지 변경 요청이 있었습니다.');
INSERT INTO order_notes (order_id, note) VALUES (3, '환불 요청 코멘트가 있습니다.');
INSERT INTO order_notes (order_id, note) VALUES (4, '상품 평점 대기중.');
INSERT INTO order_notes (order_id, note) VALUES (5, '고객이 취소 요청 후 재주문 예정.');


