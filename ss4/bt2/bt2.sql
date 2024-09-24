
create database session04_bai2 ;

create table products(
pId int auto_increment primary key ,
pName varchar(255) not null ,
pPrice double not null 
);

insert into products (pId,pName,pPrice)
values (1,"bat" , 900),
(2,"chao" , 500),
(3,"xoong" , 300),
(4,"dia",900),
(5,"thot",500),
(6,"dao",500);

create table customers (
cId int auto_increment primary key ,
cName varchar(255) not null ,
cAge int not null
);

insert into customers(cName,cAge)
values ("Minh",10),
("Nga",20),
("yen",50);

insert into customers(cName,cAge)
values ("ngia",30);

create table orders (
oId int auto_increment primary key ,
cId int not null,
oDate datetime not null,
oTotalPrice double not null ,
foreign key (cId) references customers(cId)
);

insert into orders (oId,cId,oDate,oTotalPrice)
values (1,1,'2016-3-11',350000),
(2,2,'2016-2-23',250000),
(3,1,'2016-6-26',430000);

insert into orders (oId,cId,oDate,oTotalPrice)
values (4,4,'2020-2-21',0);

create table orderDetail (
oId  int not null,
pId int not null,
odQuantity int not null,
foreign key (oId)  references  orders(oId),
foreign key (pId) references products(pId)
);

insert into orderDetail(oId,pId,odQuantity)
values (1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

insert into orderDetail(oId,pId,odQuantity)
values (4,1,0);

-- Hiển thị tất cả customer có đơn hàng trên 150000
select customers.cName , orders.oTotalPrice from orders
inner join customers on orders.cId = customers.cId 
where orders.oTotalPrice > 150000;

-- Hiển thị sản phẩm chưa được bán cho bất cứ ai
select products.pName from products
left join orderDetail on products.pId = orderDetail.pId
where orderDetail.oId is null ;

-- Hiển thị tất cả đơn hàng mua trên 2 sản phẩm
select orders.oId , count(orderDetail.odQuantity) totalProduct from orders
inner join orderdetail on orders.oId = orderDetail.oId
group by orders.oId
having totalProduct > 2 ;


select orders.oId , sum(orderDetail.odQuantity * products.pPrice)as totalPrice from orders
inner join orderdetail on orders.oId = orderDetail.oId
inner join products on orderDetail.pId = products.pId
group by orders.oId
order by totalPrice desc
limit 1 ;

-- Hiển thị sản phẩm có giá tiền lớn nhất
select * from products
order by pPrice desc
limit 1 ;

-- Hiển thị người dùng nào mua nhiều sản phẩm “Bep Dien” nhất
select customers.cName, products.pName , count(orderDetail.odQuantity) as quantity from orderDetail
inner join products on orderDetail.pId = products.pId
inner join orders on orderDetail.oId = orders.oId
inner join customers on orders.cId = customers.cId
where products.pName = "dao"
group by customers.cName
order by quantity desc
limit 1 ;
