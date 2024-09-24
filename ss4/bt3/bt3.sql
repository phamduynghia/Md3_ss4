
create database session04_bai3 ;

create table PhieuXuat(
soPX int auto_increment primary key ,
ngayXuat datetime not null
);
insert into PhieuXuat(ngayXuat)
values ('2024-09-10'),
('2024-09-11'),
('2024-09-12'),
('2024-09-13'),
('2024-09-14'),
('2024-09-15'),
('2024-09-16'),
('2024-09-17'),
('2024-09-18'),
('2024-09-19');


create table VatTu (
maVT int auto_increment primary key ,
tenVT varchar(255) not null 
);

insert into VatTu(tenVT)
values ("vat tu 01"),
("vat tu 02"),
("vat tu 03"),
("vat tu 04"),("vat tu 05"),
("vat tu 06"),
("vat tu 07"),
("vat tu 08"),
("vat tu 09"),
("vat tu 010");

create table PhieuNhap(
soPN int auto_increment primary key ,
ngayNhap datetime not null
);

insert into PhieuNhap(ngayNhap)
values ('2024-09-01'),
('2024-09-02'),
('2024-09-03'),
('2024-09-04'),
('2024-09-05'),
('2024-09-06'),
('2024-09-07'),
('2024-09-08'),
('2024-09-09'),
('2024-09-10');

create table PhieuXuatChiTiet(
soPX int not null,
maVT int not null ,
donGiaXuat double not null check (donGiaXuat > 0),
soLuongXuat int not null check (soLuongXuat > 0) ,
foreign key (soPX) references PhieuXuat(soPx),
foreign key (maVT) references VatTu(maVt)
);

insert into PhieuXuatChiTiet(soPX,maVT,donGiaXuat,soLuongXuat)
values (1,2,15000,15),
(2,3,25000,19),
(3,5,35000,150),
(4,6,14000,20),
(5,3,25000,22),
(6,1,155000,100),
(7,7,19000,45),
(8,9,15000,302),
(9,10,55000,13),
(10,8,35000,46);


create table PhieuNhapChiTiet(
soPN int not null ,
maVT int not null ,
donGiaNhap double not null,
soLuongNhap int not null
);

insert into PhieuNhapChiTiet(soPN,maVT,donGiaNhap,soLuongNhap)
values (1,2,15000,15),
(2,3,25000,19),
(3,5,35000,150),
(4,6,14000,20),
(5,3,25000,22),
(6,1,155000,100),
(7,7,19000,45),
(8,9,15000,302),
(9,10,55000,13),
(10,8,35000,46);

create table NhaCungCap (
maNCC int auto_increment primary key ,
tenNCC varchar(255) not null,
diachi varchar(255) not null ,
soDienThoai varchar(11) not null
);

insert into NhaCungCap (tenNCC,diachi,soDienThoai)
values ("ncc1","dc 01 " , "1234567890"),
("ncc2","dc 02 " , "1234567891"),
("ncc3","dc 03 " , "1234567892"),
("ncc4","dc 04 " , "1234567893"),
("ncc5","dc 05 " , "1234567894"),
("ncc6","dc 06 " , "1234567895"),
("ncc7","dc 07 " , "1234567896"),
("ncc8","dc 08 " , "1234567897"),
("ncc9","dc 09 " , "1234567898"),
("ncc10","dc 010 " , "1234567899");


create table DonDatHang(
soDH int auto_increment primary key ,
maNCC int not null ,
ngayDH datetime not null,
foreign key (maNCC) references NhaCungCap(maNCC)
);

insert into DonDatHang(maNCC,ngayDH)
values (1,'2024-09-15'),
(2,'2024-09-16'),
(3,'2024-09-17'),
(4,'2024-09-18'),
(5,'2024-09-19'),
(6,'2024-09-20'),
(7,'2024-09-21'),
(8,'2024-09-22'),
(9,'2024-09-23'),
(10,'2024-09-24');

create table ChiTietDonDatHang(
maVT int not null ,
soDH int not null ,
foreign key (maVT) references VatTu(maVT),
foreign key (soDH) references DonDatHang(soDH)
);

insert into ChiTietDonDatHang(maVT,soDH)
values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Hiển thị tất cả vật tự dựa vào phiếu xuất có số lượng lớn hơn 10
select VatTu.maVT , VatTu.tenVT , PhieuXuatChiTiet.soLuongXuat from PhieuXuat
inner join PhieuXuatChiTiet on PhieuXuat.soPX = PhieuXuatChiTiet.soPX
inner join VatTu on PhieuXuatChiTiet.maVT = VatTu.maVT
where PhieuXuatChiTiet.soLuongXuat ;

-- Hiển thị tất cả vật tư mua vào ngày 12/2/2023
select VatTu.maVT , VatTu.tenVT , sum(PhieuNhapChiTiet.soLuongNhap) as SoLuongNhap , PhieuNhap.ngayNhap from PhieuNhap
inner join PhieuNhapChiTiet on PhieuNhap.soPN = PhieuNhapChiTiet.soPN
inner join VatTu on PhieuNhapChiTiet.maVT = VatTu.maVT
where PhieuNhap.ngayNhap = '2023-02-12'
group by VatTu.maVT ;

-- Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1.200.000
select VatTu.maVT , VatTu.tenVT , sum(PhieuNhapChiTiet.soLuongNhap * PhieuNhapChiTiet.donGiaNhap) as amount , PhieuNhap.ngayNhap from PhieuNhap
inner join PhieuNhapChiTiet on PhieuNhap.soPN = PhieuNhapChiTiet.soPN
inner join VatTu on PhieuNhapChiTiet.maVT = VatTu.maVT
group by  VatTu.maVT, 
    VatTu.tenVT, 
    PhieuNhap.ngayNhap
having amount > 1200000 ;

-- Hiển thị tất cả vật tư được dựa vào phiếu xuất có số lượng lớn hơn 5
select VatTu.maVT, VatTu.tenVT , PhieuXuatChiTiet.donGiaXuat , sum(PhieuXuatChiTiet.soLuongXuat) as SoLuongXuat  from PhieuXuat
inner join PhieuXuatChiTiet on PhieuXuat.soPX = PhieuXuatChiTiet.soPX
inner join VatTu on PhieuXuatChiTiet.maVT = VatTu.maVT
group by  VatTu.maVT, VatTu.tenVT , PhieuXuatChiTiet.donGiaXuat
having SoLuongXuat > 5 ;

-- Hiển thị tất cả nhà cung cấp ở long biên có SoDienThoai bắt đầu với 09
select * from nhacungcap
where diachi = 'long biên' and soDienThoai like '09%' ;
