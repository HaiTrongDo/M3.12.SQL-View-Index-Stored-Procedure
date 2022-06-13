-- Bước 1: Tạo cơ sở dữ liệu demo
CREATE DATABASE demo;
USE demo;

-- Bước 2: Tạo bảng Products với các trường dữ liệu sau:
CREATE TABLE Products(
productId INT primary key auto_increment,
productCode INT,
productName VARCHAR(40),
productPrice INT,
productAmount INT,
productDescription varchar(255),
productStatus VARCHAR(20)
);

-- Bước 3: Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
ALTER TABLE Products ADD INDEX idx_product_code(productCode);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
ALTER TABLE Products ADD INDEX idx_name_price(productName,productPrice);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN SELECT * FROM Products;

-- Bước 4: Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
CREATE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus 
FROM  Products;

-- Tiến hành sửa đổi view
CREATE OR REPLACE VIEW product_views AS
SELECT productId, productCode, productName, productPrice, productStatus
FROM  Products;

-- Tiến hành xoá view
DROP VIEW product_views;

-- Bước 5: Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE showallproducts()
BEGIN
  SELECT * FROM Products;
END //
DELIMITER ;

-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE add_new_product
(IN pCode INT,
pName VARCHAR(40),
pPrice INT,
pAmount INT,
pDescription varchar(255),
pStatus VARCHAR(20))
BEGIN
  INSERT INTO Products (productCode,
						productName,
						productPrice,
						productAmount,
						productDescription,
						productStatus) 
VALUES (pCode,pName,pPrice,pAmount,pDescription,pStatus);
END //
DELIMITER ;

-- Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE edit_product
(IN pID INT,
pCode INT,
pName VARCHAR(40),
pPrice INT,
pAmount INT,
pDescription varchar(255),
pStatus VARCHAR(20))
BEGIN
UPDATE Products  SET productCode = pCode,
						productName = pName ,
						productPrice = pPrice,
						productAmount = pAmount,
						productDescription =pDescription,
						productStatus = pStatus
WHERE Products.productId = pID;
END //
DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE delete_entity (id INT)
BEGIN
DELETE FROM Products WHERE productId=id;
END //
DELIMITER ;