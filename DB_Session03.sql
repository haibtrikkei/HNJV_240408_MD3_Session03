create database db_jv240408;
use db_jv240408;
create table category(
	id int auto_increment primary key,
    name varchar(100) not null unique,
    status bit);
    
create table product(
	id int auto_increment primary key,
    name varchar(100),
    producer varchar(100),
    year_making int,
    expire_date date,
    quantity int,
    price double,
    category_id int,
    status bit,
    foreign key(category_id) references category(id));

create table users(
	id int auto_increment primary key,
    name varchar(100),
    gender bit,
    birthday date,
    email varchar(100) not null unique,
    phone varchar(20) not null unique,
    status bit);

create table address(
	id int auto_increment primary key,
    user_id int,
    address_name varchar(200) not null unique,
    receive_name varchar(100),
    status bit,
    foreign key(user_id) references users(id));

create table orders(
	id int auto_increment primary key,
    user_id int not null,
    order_date date not null,
    receive_name varchar(100),
    receive_address varchar(200),
    receive_phone varchar(20),
    status enum('WAITING','CONFIRM','DELIVERY','SUCCESS'),
    foreign key(user_id) references users(id));

create table order_detail(
	order_id int not null,
    product_id int not null,
    quantity int,
    price double,
    foreign key(order_id) references orders(id),
    foreign key(product_id) references product(id));
    
-- create primary key for oder_detail
alter table order_detail add constraint PK_OrderId_ProductId primary key(order_id,product_id);

/* Nhóm lệnh DML (Data Manipulation Language) */
/* insert data category */
select * from category;

insert into category(name,status) values ('Điện tử',1);
insert into category(name,status) values ('Điện lạnh',1),
										 ('Điện dân dụng',1),
										 ('Thời trang nam',1),
                                         ('Thời trang nữ',1),
                                         ('Thời trang công sở',1);

-- insert data to product
select * from product;
insert into product(name,producer,year_making,expire_date,quantity,price,category_id) values
('Tivi','Toshiba',2022,'2022-12-21',100,12000000,1),
('Tủ lạnh','Sanyo',2021,'2022-05-11',50,10000000,2),
('Nồi cơm điện','Cooku',2023,'2023-12-15',120,3000000,3),
('Điều hòa','Panasonic',2023,'2024-05-15',20,15000000,2),
('Bàn là','Shunhouse',2023,'2023-11-05',70,500000,1),
('Áo sơ mi nam','Việt Tiến',2022,'2022-12-21',200,500000,4),
('Áo sơ mi nữ','Việt Tiến',2022,'2022-12-21',200,500000,5),
('Giày Adidas','Adidas',2022,'2022-12-21',50,1200000,6),
('Giày nữ','Adidas',2022,'2022-12-21',70,14000000,6);

-- insert data for user table
select * from users;
insert into users(name,gender,birthday,email,phone) values
('Nguyễn Tuấn Anh',1,'2000-05-11','tuananh@gmail.com','0912322324'),
('Nguyễn Thị Huyền',0,'2001-11-27','huyen@gmail.com','0865123432'),
('Lê Mạnh Cường',1,'2000-10-22','cuong@gmail.com','034123432'),
('Ngô Mạnh Đạt',1,'2001-09-15','dat@gmail.com','0986123535'),
('Trần Thảo My',0,'2000-08-22','thaomy@gmail.com','0234651245');

update users set status = 1;
-- data address
select * from address;
insert into address(user_id,address_name,receive_name,status) values
(1,'Ba Đình - Hà Nôi','Nguyễn Văn Cường',1),
(1,'Gia Lâm - Hà Nôi','Nguyễn Tuấn Anh',1),
(1,'Hà Đông - Hà Nôi','Nguyễn Tuấn Anh',1),
(2,'Sơn Tây - Hà Nôi','Nguyễn Thị Huyền',1),
(2,'Phúc Thọ - Hà Nôi','Nguyễn Thị Huyền',1),
(3,'Việt Trì - Phú Thọ','Lê Mạnh Cường',1),
(3,'Lâm Thao - Phú Thọ','Lê Mạnh Cường',1);

-- data orders
select * from orders;
insert into orders(user_id,order_date,receive_name,receive_address,receive_phone,status) values
(1,'2024-02-12','Nguyễn Tuấn Anh','Ba Đình - Hà Nôi','0912322324','WAITING'),
(3,'2024-03-05','Lê Mạnh Cường','Việt Trì - Phú Thọ','034123432','WAITING'),
(2,'2023-12-27','Nguyễn Thị Huyền','Sơn Tây - Hà Nôi','0865123432','WAITING'),
(2,'2024-02-12','Nguyễn Thị Huyền','Phúc Thọ - Hà Nôi','0865123432','WAITING');

-- truncate orders;
-- SET FOREIGN_KEY_CHECKS = 0; 
-- TRUNCATE table orders; 
-- SET FOREIGN_KEY_CHECKS = 1;
-- data for order detail
select * from order_detail;
insert into order_detail(order_id,product_id,quantity,price) values
(1,1,1,11000000),
(1,2,1,10000000),
(2,1,1,12000000),
(3,3,2,3000000),
(3,5,1,500000),
(4,4,1,15000000);

-- SELECT ĐƠN GIẢN
select * from product; 

update product set status = 1;

select * from category;

-- select với case .. when
/*
	case expression
    when value1 then return_value1
    when value2 then return_value2
    ...
    end as 'column_name'
*/
select id,name,case status when 1 then 'active' when 0 then 'unactive' end as status from category;

-- select thông qua liên kết
-- Đưa ra kết quả: Mã danh mục, tên danh mục, tên sản phẩm, số lượng, đơn giá
select c.id as 'MaDM',c.name as 'TenDM',p.name as 'TenSP',p.quantity as 'Soluong',p.price as 'Gia' from category c inner join product p on c.id=p.category_id;

-- Đưa ra kết quả: Mã đơn hàng, ngày đặt hàng, họ tên, địa chỉ, tên sản phẩm, số lượng, giá mua
select o.id as 'MaDH',o.order_date as 'NgayDH',o.receive_name as 'HoTen', o.receive_address as 'DiaChi',p.name,od.quantity,od.price 
from orders o inner join users u on o.user_id=u.id
inner join order_detail od on o.id = od.order_id inner join product p on od.product_id=p.id;


select * from orders;

-- left join
-- Hiển thị ra những người chưa mua hàng bao giờ?
select * from users where id not in (select distinct user_id from orders);

select u.*,o.* from users u left join orders o on u.id=o.user_id;

-- RIGHT JOIN
select u.*,o.* from orders o right join users u on u.id=o.user_id;

-- WHERE: Điều kiện
-- Lấy thông tin những người mua hàng ở Hà Nội
select * from users u inner join address a on u.id = a.user_id where a.address_name like '%Phú Thọ';

-- Đưa ra những sản phẩm có giá từ 10tr -> 15tr
select * from product where price between 10000000 and 15000000;

-- Đưa ra những sản phẩm có giá là 10tr, 12tr, 13tr
select * from product where price in (10000000,12000000,13000000);

-- Đưa ra những sản phẩm có giá bán cao nhất?
select * from product where price = (select max(price) from product);

-- Đưa ra 2 sản phẩm có giá bán cao nhất?
select * from product order by price desc limit 2;

-- GROUP BY
-- Đưa ra thông tin giá trị đơn hàng của các đơn hàng đã mua (mã đơn hàng, ngày đặt hàng, người mua hàng, tổng giá trị)
/*
	phân tích:
		Mã đơn hàng, ngày đặt hàng, người mua hàng trong bảng orders
        Tổng giá trị: Phải sử dụng hàm sum() ở bảng order_detail
*/
select o.id as 'ma_dh', o.order_date as 'ngay_dh', o.receive_name as 'nguoi_mua_hang', sum(od.price) as 'tong_gia_tri' 
from orders o inner join order_detail od on o.id = od.order_id
group by o.id;


-- HAVING
-- : Đưa ra nhữn đơn hàng có giá trị từ 15tr trở lên
select o.id as 'ma_dh', o.order_date as 'ngay_dh', o.receive_name as 'nguoi_mua_hang', sum(od.price) as 'tong_gia_tri' 
from orders o inner join order_detail od on o.id = od.order_id
group by o.id
having tong_gia_tri>=15000000

