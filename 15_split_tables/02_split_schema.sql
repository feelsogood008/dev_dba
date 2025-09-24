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
