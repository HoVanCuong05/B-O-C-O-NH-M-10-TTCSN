use master 
go
create database QLPHONGTRO
go
use QLPHONGTRO

-- creatable (tạo bảng)

-- Bang CHU_TRO
create table CHU_TRO(
	MaChuTro nchar(10) primary key not null,
	TenChuTro nvarchar(30),
	Email nvarchar(30),
	SDT nchar(10)
)

-- Bang NHA_TRO
create table NHA_TRO(
	MaNhaTro nchar(10) primary key not null,
	MaChuTro nchar(10),
	TenNhaTro nvarchar(30),
	DienTich nchar(10),
	QuanLy nvarchar(30),
	DiaChi nvarchar(30),
	constraint fk_NT_CT foreign key (MaChuTro) references CHU_TRO(MaChuTro)
)

-- Bang PHONG_TRO
create table PHONG_TRO(
	MaPhong nchar(10) primary key not null,
	MaNhaTro nchar(10),
	TenPhong nvarchar(30),
	MoTa nvarchar(50),
	TienPhong money,
	constraint fk_PT_NT foreign key (MaNhaTro) references NHA_TRO(MaNhaTro)
)

-- Bang NGUOI_THUE_TRO
create table NGUOI_THUE_TRO(
	MaNguoiThueTro nchar(10) primary key not null,
	MaPhong nchar(10),
	Email nvarchar(30),
	SDT nchar(10),
	TenTK nvarchar(30),
	MatKhau nvarchar(30),
	constraint fk_NTT_PT foreign key (MaPhong) references PHONG_TRO(MaPhong)
)

-- Bang HOP_DONG 
create table HOP_DONG(
	MaHopDong nchar(10) primary key not null,
	MaChuTro nchar(10),
	MaNguoiThueTro nchar(10),
	NgayBatDau date,
	NgayKetThuc date,
	SoTienNop money,
	constraint fk_HD_CT foreign key (MaChuTro) references CHU_TRO(MaChuTro),
	constraint fk_HD_NTT foreign key (MaNguoiThueTro) references NGUOI_THUE_TRO(MaNguoiThueTro)
)


-- Bang THIET_BI_PHONG
create table THIET_BI_PHONG(
	MaThietBiPhong nchar(10) primary key not null,
	TenThietBi nvarchar(30),
	TinhTrang nvarchar(50),
	GhiChu nvarchar(50),
)

-- Bang THIET_BI_PHONG_TRO
create table THIET_BI_PHONG_TRO(
	MaPhong nchar(10) not null,
	MaThietBiPhong nchar(10) not null,
	SoLuong int,
	TinhTrang nvarchar(50),
	constraint pk_TBPT primary key (MaPhong, MaThietBiPhong),
	constraint fk_TBPT_PT foreign key (MaPhong) references PHONG_TRO(MaPhong),
	constraint fk_TBPT_TBP foreign key (MaThietBiPhong) references THIET_BI_PHONG(MaThietBiPhong)
)

-- Bang GIAO_DICH
create table GIAO_DICH(
	MaGiaoDich nchar(10) primary key not null,
	MaHopDong nchar(10),
	MaNguoiThueTro nchar(10),
	NgayGiaoDich date,
	NgayHetHan date,
	GiamGia money,
	TongTien money,
	constraint fk_GD_HP foreign key (MaHopDong) references HOP_DONG(MaHopDong),
	constraint fk_GD_NTT foreign key (MaNguoiThueTro) references NGUOI_THUE_TRO(MaNguoiThueTro)
)

-- Bang DICH_VU
create table DICH_VU(
	MaDichVu nchar(10) primary key not null,
	TenDichVu nvarchar(30),
	GiaDichVu money,
	MoTa nvarchar(50)
)

-- Bang CHI_TIET_GIAO_DICH
create table CHI_TIET_GIAO_DICH(
	MaGiaoDich nchar(10) not null,
	MaDichVu nchar(10) not null,
	ThoiGian date,
	SoLuong int,
	GiaTien money,
	constraint pk_GD_DV primary key (MaGiaoDich, MaDichVu),
	constraint fk_CTGD_GD foreign key (MaGiaoDich) references GIAO_DICH(MaGiaoDich),
	constraint fk_CTGD_DV foreign key (MaDichVu) references DICH_VU(MaDichVu)
)
-- CHU_TRO
INSERT INTO CHU_TRO (MaChuTro, TenChuTro, Email, SDT) VALUES
('CT001', N'Nguyễn Văn A', 'a.nguyen@gmail.com', '0900000001'),
('CT002', N'Trần Thị B', 'b.tran@gmail.com', '0900000002'),
('CT003', N'Lê Văn C', 'c.le@gmail.com', '0900000003'),
('CT004', N'Phạm Thị D', 'd.pham@gmail.com', '0900000004'),
('CT005', N'Hồ Văn E', 'e.ho@gmail.com', '0900000005'),
('CT006', N'Bùi Thị F', 'f.bui@gmail.com', '0900000006'),
('CT007', N'Võ Minh G', 'g.vo@gmail.com', '0900000007'),
('CT008', N'Đinh Thị H', 'h.dinh@gmail.com', '0900000008'),
('CT009', N'Cao Văn I', 'i.cao@gmail.com', '0900000009'),
('CT010', N'Phan Thị J', 'j.phan@gmail.com', '0900000010');

-- NHA_TRO
INSERT INTO NHA_TRO (MaNhaTro, MaChuTro, TenNhaTro, DienTich, QuanLy, DiaChi) VALUES
('NT001', 'CT001', N'Nhà trọ A', '120m2', N'Trần Văn Tùng', N'Q1, TP.HCM'),
('NT002', 'CT002', N'Nhà trọ B', '100m2', N'Nguyễn Văn Bảo', N'Q2, TP.HCM'),
('NT003', 'CT003', N'Nhà trọ C', '150m2', N'Lê Thị Cúc', N'Q3, TP.HCM'),
('NT004', 'CT004', N'Nhà trọ D', '90m2',  N'Huỳnh Tấn Dũng', N'Q4, TP.HCM'),
('NT005', 'CT005', N'Nhà trọ E', '110m2', N'Võ Nhật Nam', N'Q5, TP.HCM'),
('NT006', 'CT006', N'Nhà trọ F', '80m2',  N'Lâm Thị Hoa', N'Q6, TP.HCM'),
('NT007', 'CT007', N'Nhà trọ G', '200m2', N'Nguyễn Thị Nga', N'Q7, TP.HCM'),
('NT008', 'CT008', N'Nhà trọ H', '160m2', N'Phạm Minh Phúc', N'Q8, TP.HCM'),
('NT009', 'CT009', N'Nhà trọ I', '140m2', N'Cao Thanh Hằng', N'Q9, TP.HCM'),
('NT010', 'CT010', N'Nhà trọ J', '180m2', N'Đặng Văn Trí', N'Tân Phú, TP.HCM');

-- PHONG_TRO
INSERT INTO PHONG_TRO (MaPhong, MaNhaTro, TenPhong, MoTa, TienPhong) VALUES
('P001', 'NT001', N'Phòng 101', N'Phòng đơn, có ban công', 2500000),
('P002', 'NT002', N'Phòng 102', N'Phòng đôi, có máy lạnh', 3000000),
('P003', 'NT003', N'Phòng 201', N'Phòng đơn, có WC riêng', 2700000),
('P004', 'NT004', N'Phòng 202', N'Phòng đôi, yên tĩnh', 3200000),
('P005', 'NT005', N'Phòng 103', N'Phòng đơn, gần cửa sổ', 2600000),
('P006', 'NT006', N'Phòng 104', N'Phòng đôi, có giường tầng', 2800000),
('P007', 'NT007', N'Phòng 301', N'Phòng có view đẹp', 3500000),
('P008', 'NT008', N'Phòng 302', N'Phòng có ban công và bếp', 3600000),
('P009', 'NT009', N'Phòng 303', N'Phòng nhỏ, tiết kiệm', 2200000),
('P010', 'NT010', N'Phòng 304', N'Phòng rộng, có điều hòa', 3300000);

-- NGUOI_THUE_TRO
INSERT INTO NGUOI_THUE_TRO (MaNguoiThueTro, MaPhong, Email, SDT, TenTK, MatKhau) VALUES
('NTT001', 'P001', 'thue1@gmail.com', '0911111111', 'user1', 'pass1'),
('NTT002', 'P002', 'thue2@gmail.com', '0911111112', 'user2', 'pass2'),
('NTT003', 'P003', 'thue3@gmail.com', '0911111113', 'user3', 'pass3'),
('NTT004', 'P004', 'thue4@gmail.com', '0911111114', 'user4', 'pass4'),
('NTT005', 'P005', 'thue5@gmail.com', '0911111115', 'user5', 'pass5'),
('NTT006', 'P006', 'thue6@gmail.com', '0911111116', 'user6', 'pass6'),
('NTT007', 'P007', 'thue7@gmail.com', '0911111117', 'user7', 'pass7'),
('NTT008', 'P008', 'thue8@gmail.com', '0911111118', 'user8', 'pass8'),
('NTT009', 'P009', 'thue9@gmail.com', '0911111119', 'user9', 'pass9'),
('NTT010', 'P010', 'thue10@gmail.com', '0911111120', 'user10', 'pass10');

-- HOP_DONG 
INSERT INTO HOP_DONG (MaHopDong, MaChuTro, MaNguoiThueTro, NgayBatDau, NgayKetThuc, SoTienNop) VALUES
('HD001', 'CT001', 'NTT001', '2025-01-01', '2025-12-31', 30000000),
('HD002', 'CT002', 'NTT002', '2025-02-01', '2026-01-31', 32000000),
('HD003', 'CT003', 'NTT003', '2025-03-01', '2026-02-28', 33000000),
('HD004', 'CT004', 'NTT004', '2025-04-01', '2026-03-31', 31000000),
('HD005', 'CT005', 'NTT005', '2025-05-01', '2026-04-30', 34000000),
('HD006', 'CT006', 'NTT006', '2025-06-01', '2026-05-31', 29000000),
('HD007', 'CT007', 'NTT007', '2025-07-01', '2026-06-30', 36000000),
('HD008', 'CT008', 'NTT008', '2025-08-01', '2026-07-31', 37000000),
('HD009', 'CT009', 'NTT009', '2025-09-01', '2026-08-31', 28000000),
('HD010', 'CT010', 'NTT010', '2025-10-01', '2026-09-30', 35000000);

-- THIET_BI_PHONG
INSERT INTO THIET_BI_PHONG (MaThietBiPhong, TenThietBi, TinhTrang, GhiChu) VALUES
('TB001', N'Quạt trần', N'Tốt', N'Chạy êm'),
('TB002', N'Máy lạnh', N'Bình thường', N'Cần vệ sinh'),
('TB003', N'Giường tầng', N'Cũ', N'Có vết xước'),
('TB004', N'Tủ lạnh', N'Tốt', N'Mới mua'),
('TB005', N'Bếp điện', N'Hoạt động', N'Dùng chung'),
('TB006', N'Máy giặt', N'Hỏng nhẹ', N'Chờ sửa'),
('TB007', N'Bàn học', N'Tốt', N'Gỗ thông'),
('TB008', N'Tủ quần áo', N'Cũ', N'Chưa thay'),
('TB009', N'Tivi', N'Tốt', N'Có điều khiển'),
('TB010', N'Bàn ủi', N'Bình thường', N'Đã thay dây');

-- THIET_BI_PHONG_TRO
INSERT INTO THIET_BI_PHONG_TRO (MaPhong, MaThietBiPhong, SoLuong, TinhTrang) VALUES
('P001', 'TB001', 1, N'Tốt'),
('P001', 'TB003', 2, N'Cũ'),
('P002', 'TB002', 1, N'Bình thường'),
('P002', 'TB004', 1, N'Tốt'),
('P003', 'TB005', 1, N'Hoạt động'),
('P003', 'TB006', 1, N'Hỏng nhẹ'),
('P004', 'TB007', 2, N'Tốt'),
('P004', 'TB008', 1, N'Cũ'),
('P005', 'TB009', 1, N'Tốt'),
('P006', 'TB001', 1, N'Tốt'),
('P007', 'TB002', 1, N'Bình thường'),
('P008', 'TB005', 1, N'Hoạt động'),
('P009', 'TB010', 1, N'Bình thường'),
('P010', 'TB004', 1, N'Tốt'),
('P010', 'TB008', 1, N'Cũ');

-- GIAO_DICH
INSERT INTO GIAO_DICH (MaGiaoDich, MaHopDong, MaNguoiThueTro, NgayGiaoDich, NgayHetHan, GiamGia, TongTien) VALUES
('GD001', 'HD001', 'NTT001', '2025-01-05', '2025-02-05', 0, 2500000),
('GD002', 'HD002', 'NTT002', '2025-02-05', '2025-03-05', 200000, 2800000),
('GD003', 'HD003', 'NTT003', '2025-03-05', '2025-04-05', 0, 2700000),
('GD004', 'HD004', 'NTT004', '2025-04-05', '2025-05-05', 100000, 3100000),
('GD005', 'HD005', 'NTT005', '2025-05-05', '2025-06-05', 0, 2600000),
('GD006', 'HD006', 'NTT006', '2025-06-05', '2025-07-05', 50000, 2750000),
('GD007', 'HD007', 'NTT007', '2025-07-05', '2025-08-05', 0, 3500000),
('GD008', 'HD008', 'NTT008', '2025-08-05', '2025-09-05', 0, 3600000),
('GD009', 'HD009', 'NTT009', '2025-09-05', '2025-10-05', 0, 2200000),
('GD010', 'HD010', 'NTT010', '2025-10-05', '2025-11-05', 0, 3300000);

-- DICH_VU
INSERT INTO DICH_VU (MaDichVu, TenDichVu, GiaDichVu, MoTa) VALUES
('DV001', N'Internet', 100000, N'Tốc độ cao'),
('DV002', N'Nước sinh hoạt', 50000, N'Tính theo đầu người'),
('DV003', N'Điện', 3000, N'Tính theo kWh'),
('DV004', N'Giữ xe', 100000, N'Trong nhà xe'),
('DV005', N'Rác thải', 20000, N'Thu gom hàng tuần'),
('DV006', N'Giặt ủi', 150000, N'Tuần/lần'),
('DV007', N'Dọn phòng', 80000, N'Tuần 2 lần'),
('DV008', N'Camera an ninh', 50000, N'24/24h'),
('DV009', N'Truyền hình cáp', 60000, N'Gói cơ bản'),
('DV010', N'Wifi riêng', 200000, N'Cho từng phòng');

-- CHI_TIET_GIAO_DICH
INSERT INTO CHI_TIET_GIAO_DICH (MaGiaoDich, MaDichVu, ThoiGian, SoLuong, GiaTien) VALUES
('GD001', 'DV001', '2025-01-05', 1, 100000),
('GD001', 'DV002', '2025-01-05', 1, 50000),
('GD002', 'DV003', '2025-02-05', 100, 300000),
('GD003', 'DV001', '2025-03-05', 1, 100000),
('GD004', 'DV004', '2025-04-05', 1, 100000),
('GD005', 'DV002', '2025-05-05', 1, 50000),
('GD006', 'DV006', '2025-06-05', 1, 150000),
('GD007', 'DV003', '2025-07-05', 80, 240000),
('GD008', 'DV005', '2025-08-05', 1, 20000),
('GD009', 'DV007', '2025-09-05', 1, 80000),
('GD010', 'DV008', '2025-10-05', 1, 50000),
('GD010', 'DV001', '2025-10-05', 1, 100000),
('GD009', 'DV010', '2025-09-05', 1, 200000),
('GD008', 'DV009', '2025-08-05', 1, 60000),
('GD007', 'DV001', '2025-07-05', 1, 100000);


select * from CHU_TRO
select * from NHA_TRO
select * from PHONG_TRO
select * from NGUOI_THUE_TRO
select * from HOP_DONG
select * from THIET_BI_PHONG
select * from THIET_BI_PHONG_TRO
select * from GIAO_DICH
select * from DICH_VU
select * from CHI_TIET_GIAO_DICH

-- CHUONG 4 : TRUY VAN KIEM TRA DU LIEU 

-- Đếm số các phòng đã thuê
select  count(distinct MaPhong) as SoPhongDaThue
from NGUOI_THUE_TRO

-- Đếm số các phòng chưa được thuê
select count(*) as SoPhongChuaThue
from PHONG_TRO
where MaPhong not in (select distinct MaPhong from NGUOI_THUE_TRO)

-- Đếm số phòng còn hiệu lực
select count(*) as SoHDHieuLuc
from HOP_DONG
where NgayKetThuc >= getdate()

-- Đếm số thiết bị hỏng trong tất cả các phòng 
select count(*) as SoThietBiHong
from THIET_BI_PHONG_TRO
where TinhTrang like N'%hỏng%'

-- Tổng doanh thu từ các dao dịch 
select sum(TongTien) as TongDoanhThu
from GIAO_DICH

--  Đếm số người có trong nhà trọ
select count(*) as SoNguoiThueTro
from NGUOI_THUE_TRO

-- Đếm số hợp đồng trên 5 triệu
select count(*)	as SoHopDongLon
from HOP_DONG
where SoTienNop > 5000000

-- Đếm số phòng trong nhà trọ 
select count(*) as TongSoPhongTrongTro
from PHONG_TRO


-- CHƯƠNG 6 : TÔI ƯU HÓA (INDEX)

-- Bảng PHONG_TRO
-- 1 Truy vấn tìm phòng theo nhà trọ theo ma nha tro
create index idx_PHONGTRO_MaNhaTro on PHONG_TRO(MaNhaTro)
-- 2 Truy vấn lọc theo giá phòng
create index idx_PHONGTRO_TienPhong on PHONG_TRO(TienPhong)
-- 3 Tìm kiếm phòng theo tên phòng
create index idx_PHONGTRO_TenPhong on PHONG_TRO(TenPhong)

-- Bảng NGUOI_THUE_TRO
--  Giúp join nhanh với PHONG_TRO khi tra người thuê theo phòng
create index idx_NGUOITHUETRO_MaPhong on NGUOI_THUE_TRO(MaPhong)
-- Tăng tốc tìm người thuê theo email (unique : email không bị trùng)
create unique index idx_NGUOITHUETRO_Email on NGUOI_THUE_TRO(Email)
--  Tăng tốc tìm người thuê theo tên tài khoản
create index idx_NGUOITHUETRO_TenTK on NGUOI_THUE_TRO(TenTK)


-- Bảng HOP_DONG
--  Hỗ trợ tra cứu hợp đồng theo người thuê
create index idx_HOPDONG_MaNguoiThueTro on HOP_DONG(MaNguoiThueTro)
--  Tăng tốc tìm hợp đồng đã hết hạn hoặc còn hiệu lực
create index idx_HOPDONG_NgayKetThuc on HOP_DONG(NgayKetThuc)
--  Tăng hiệu suất tìm kiếm theo ngày bắt đầu thuê
create index idx_HOPDONG_NgayBatDau on HOP_DONG(NgayBatDau)

-- Bảng GIAO_DICH
-- Hỗ trợ join và thống kê giao dịch theo hợp đồng
create index idx_GIAODICH_MaHopDong on GIAO_DICH(MaHopDong)
-- Hỗ trợ truy vấn giao dịch theo ngày
create index idx_GIAODICH_NgayGiaoDich on GIAO_DICH(NgayGiaoDich)
-- Tăng tốc lọc giao dịch theo người thuê
create index idx_GIAODICH_MaNguoiThue on GIAO_DICH(MaNguoiThueTro)



-- Các hàm quan trọng
-- 1. Hàm kiểm tra trạng thái phòng (đã thuê hay chưa thuê)
create function fn_trangthaiphong(@maphong nchar(10))
returns nvarchar(30)
as
begin
	declare @trangthai nvarchar(30)
	if(exists (select 1 from NGUOI_THUE_TRO where MaPhong = @maphong))
		set @trangthai = N'Đã thuê'
	else
		set @trangthai = N'Còn trống'
	return @trangthai
end
-- Thực thi
select dbo.fn_trangthaiphong('P001') as 'Trạng Thái Phòng'
select dbo.fn_trangthaiphong('P0011') as 'Trạng Thái Phòng'


-- 2. Hàm thống kê doanh thu theo tháng
create function fn_thongkedoanhthu(@thang int, @nam int)
returns money 
as
begin
	declare @doanhthu money
	select @doanhthu = sum(TongTien)
	from GIAO_DICH
	where month(NgayGiaoDich) = @thang and year(NgayGiaoDich) = @nam
	return @doanhthu
end
-- Thực thi
select dbo.fn_thongkedoanhthu(7, 2025) as 'Doanh thu theo tháng và năm'
select dbo.fn_thongkedoanhthu(7, 2026) as 'Doanh thu theo tháng và năm'


-- 3. Hàm đếm số lượng phòng còn trống trong nhà trọ
create function fn_demsophongtrong(@manhatro nchar(10))
returns int
as 
begin
	declare @sophongtrong int
	select @sophongtrong = count(*)
	from PHONG_TRO
	where MaNhaTro = @manhatro and not exists (select 1 
	from NGUOI_THUE_TRO inner join PHONG_TRO on NGUOI_THUE_TRO.MaPhong = PHONG_TRO.MaPhong)
	return @sophongtrong
end
-- Thực thi
select dbo.fn_demsophongtrong('NT003') as 'Số phòng trống trong 1 nhà trọ'


-- 4. Hàm liệt kê tổng chi phí dịch vụ trong 1 năm của 1 người thuê trọ
create function fn_tongchiphidichvu(@manguoithuetro nchar(10), @nam int)
returns money 
as
begin
	declare @tongchiphi money
	select @tongchiphi = sum(GiaTien)
	from GIAO_DICH inner join CHI_TIET_GIAO_DICH	on GIAO_DICH.MaGiaoDich = CHI_TIET_GIAO_DICH.MaGiaoDich
	where MaNguoiThueTro = @manguoithuetro and year(NgayGiaoDich) = @nam
	return @tongchiphi
end
-- Thực thi
select dbo.fn_tongchiphidichvu('NTT004', 2025)


-- Các thủ tục (stored procedures)
-- 1. Thủ tục thêm phòng trọ mới với mã phòng nhập từ bàn phím. Nếu đã có đưa ra thông báo, chưa có cho phép thêm phòng
create proc sp_themphongmoi(@MaPhong nchar(10),
    @TenPhong nvarchar(50),
    @MaNhaTro nchar(10),
	@MoTa nvarchar(50),
    @TienPhong money)
as
begin
	if(exists (select * from PHONG_TRO where MaPhong = @MaPhong))
		print N'Phòng đã tồn tại'
	else 
		begin
			insert into PHONG_TRO values (@MaPhong, @TenPhong, @MaNhaTro, @MoTa, @TienPhong)
			print N'Thêm phòng thành công'
		end
end
-- Thực thi
exec sp_themphongmoi 'P0011', 'NT0011', N'Phòng 333', N'Phòng nhỏ, tiết kiệm', 2900000


-- 2. Thủ tục thêm người thuê trọ với mã người thuê trọ được nhập từ bàn phím 
create proc sp_themnguoithuetro(@MaNguoiThueTro nchar(10), @MaPhong nchar(10), @Email nvarchar(30), @SDT nchar(10),
								@TenTK nvarchar(30), @MatKhau nvarchar(30))
as
begin
	if(exists (select * from NGUOI_THUE_TRO where MaNguoiThueTro = @MaNguoiThueTro))
		print N'Người thuê trọ đã tồn tại'
	else 
		begin
			insert into NGUOI_THUE_TRO values (@MaNguoiThueTro, @MaPhong, @Email, @SDT, @TenTK, @MatKhau)
			print N'Đã thêm người thuê trọ mới thành công'
		end
end
-- Thực thi
exec sp_themnguoithuetro 'NTT0011', 'P0011', 'thue11@gmail.com', '0911111993', 'user11', 'pass11'

-- 3. Thủ tục sửa số điện thoại của người thuê trọ với mã người thuê trọ được nhập từ bàn phím 
alter proc sp_suasodienthoai(@MaNguoiThueTro nchar(10), @sdt nchar(10))
as
begin
	if( not exists (select * from NGUOI_THUE_TRO where MaNguoiThueTro = @MaNguoiThueTro))
		print N'Không tồn tại mã người thuê trọ '
	else 
		begin
			update NGUOI_THUE_TRO
			set SDT = @sdt
			where MaNguoiThueTro = @MaNguoiThueTro
			print N'Đã cập nhật thànhg công'
		end
end
-- Thực thi
exec sp_suasodienthoai 'NTT007', '099999999'


-- Các trigger quan trọng 

-- 1. Trigger kiểm tra số lượng thiết bị không được nhỏ hơn 0 
create trigger trg_kiemtrasoluongthietbi
on THIET_BI_PHONG_TRO
after insert
as
begin
	if(exists(select * from inserted where SoLuong < 0))
		begin
			raiserror('Số lượng thiết bị phòng trọ không được nhỏ hơn 0',16,1)
			rollback transaction
		end
	else
		begin
			insert into THIET_BI_PHONG_TRO values (MaPhong, MaThietBiPhong, SoLuong, TinhTrang)
			select MaPhong, MaThietBiPhong, SoLuong, TinhTrang from inserted
		end
end

-- 2. Trigger tự động cập nhật số tiền trong bảng GIAO_DICH dựa vào bảng CHI_TIET_GIAO_DICH
create trigger trg_capnhattongtien
on CHI_TIET_GIAO_DICH
after insert
as
begin
	update GIAO_DICH
	set TongTien = (
		select sum(GiaTien) from CHI_TIET_GIAO_DICH  where MaGiaoDich = inserted.MaGiaoDich
	)
	from GIAO_DICH inner join inserted on GIAO_DICH.MaGiaoDich = inserted.MaGiaoDich
end


-- 3. Trigger không cho phép trùng mã hợp đồng của cùng một người 
create trigger trg_kiemtramahopdongbitrung
on HOP_DONG
after insert
as
begin
	if(exists(select * from inserted inner join HOP_DONG on inserted.MaNguoiThueTro = HOP_DONG.MaNguoiThueTro ))
		begin
			raiserror (N'Người thuê trọ đã có hợp đồng với mã này', 16, 1)
			rollback transaction
		end
	else
		begin
			insert into HOP_DONG(MaHopDong, MaChuTro, MaNguoiThueTro, NgayBatDau, NgayKetThuc, SoTienNop)
			select MaHopDong, MaChuTro, MaNguoiThueTro, NgayBatDau, NgayKetThuc, SoTienNop from inserted
		end
end


--CRUD

--Quan ly phong
--them moi
INSERT INTO PHONG_TRO (MaPhong, MaNhaTro, TenPhong, MoTa, TienPhong)
VALUES ('P011', 'NT001', N'Phòng 105', N'Phòng mới xây, có điều hòa', 2900000);
select*from PHONG_TRO where MaPhong='P011';
--Sua thong tin phong
update PHONG_TRO
set TenPhong = N'Phòng 105 (sửaa)',
    MoTa = N'Phòng đã nâng cấp nội thất',
    TienPhong = 3100000
where MaPhong = 'P011';
select*from PHONG_TRO where MaPhong='P011';
--Xoa mot phong
delete from PHONG_TRO
where MaPhong = 'P011';
select*from PHONG_TRO where MaPhong='P011';

--Quan ly khach hang
--them khach hang
INSERT INTO NGUOI_THUE_TRO (MaNguoiThueTro, MaPhong, Email, SDT, TenTK, MatKhau)
VALUES ('NTT011', 'P002', 'thue11@gmail.com', '0911222333', 'user11', 'pass11');
select*from NGUOI_THUE_TRO where MaNguoiThueTro='NTT011';
--Sua thong tin khach hang
update NGUOI_THUE_TRO
set Email = 'thue11@gmail.com',
    SDT = '0988777666',
    TenTK = 'user11',
    MatKhau = 'pass11'
where MaNguoiThueTro = 'NTT011';
select*from NGUOI_THUE_TRO where MaNguoiThueTro='NTT011';
--Xoa
delete from NGUOI_THUE_TRO
where MaNguoiThueTro = 'NTT011';
select*from NGUOI_THUE_TRO where MaNguoiThueTro='NTT011';

--Quan ly dich vu
--Them dich vu
INSERT INTO DICH_VU (MaDichVu, TenDichVu, GiaDichVu, MoTa)
VALUES ('DV011', N'Nước uống', 30000, N'Cung cấp mới phòng hàng ngày');
select*from DICH_VU where MaDichVu='DV011';
--Sua dich vu
update DICH_VU
set TenDichVu = N'Nước uống tinh khiết',
    GiaDichVu = 35000,
    MoTa = N'Cung cấp 2 bình/tuần'
where MaDichVu = 'DV011';
select*from DICH_VU where MaDichVu='DV011';
--Xoa dich vu
delete from DICH_VU
where MaDichVu = 'DV011';
select*from DICH_VU where MaDichVu='DV011';

--Truy van nag cao
--Dem so phong dang thue cua cac nha tro
select nt.TenNhaTro, count(*) as SoPhongDangThue
from PHONG_TRO pt
inner join NHA_TRO nt on pt.MaNhaTro = nt.MaNhaTro
inner join NGUOI_THUE_TRO ntt on pt.MaPhong = ntt.MaPhong
group by nt.TenNhaTro;

--Tinh tong doanh thu cua cac nha tro
select NHA_TRO.TenNhaTro, sum(TongTien) as TongDoanhThu
from GIAO_DICH
inner join NGUOI_THUE_TRO on GIAO_DICH.MaNguoiThueTro = NGUOI_THUE_TRO.MaNguoiThueTro
inner join PHONG_TRO on NGUOI_THUE_TRO.MaPhong = PHONG_TRO.MaPhong
inner join NHA_TRO on PHONG_TRO.MaNhaTro = NHA_TRO.MaNhaTro
GROUP BY NHA_TRO.TenNhaTro;

--Trung binh gia thue cua cac nha tro
select NHA_TRO.TenNhaTro, AVG(PHONG_TRO.TienPhong) as TrungBinhTienPhong
from PHONG_TRO
inner join NHA_TRO on PHONG_TRO.MaNhaTro = NHA_TRO.MaNhaTro
group by NHA_TRO.TenNhaTro;



--Xem phong
declare @MaPhong nchar(10);
set @MaPhong = 'P003';
select * from PHONG_TRO
where MaPhong = @MaPhong;

--Tim kiem phong theo gia
--gia cu the
declare @GiaPhong money;
set @GiaPhong = 2800000;
select * from PHONG_TRO
where TienPhong = @GiaPhong;
--Gia toi da
declare @GiaToiDa money;
set @GiaToiDa = 3000000;
select * from PHONG_TRO
where TienPhong <= @GiaToiDa;
--gia toi thieu
declare @GiaToiThieu money;
set @GiaToiThieu = 3000000;
Select * from PHONG_TRO
where TienPhong >= @GiaToiThieu;

--Thue tro
--them nguoi thue
INSERT INTO NGUOI_THUE_TRO
VALUES ('NTT011', 'P005', 'nguoi11@gmail.com', '0911122233', 'user11', 'pass11');
--them hop dong
INSERT INTO HOP_DONG
VALUES ('HD011','CT005','NTT011','2025-05-11','2026-05-10',31000000);
--them giao dich va chi tiet giao dich neu co
INSERT INTO GIAO_DICH
VALUES ('GD011', 'HD011', 'NTT011', '2025-05-11', '2025-06-11', 0, 2600000);
INSERT INTO CHI_TIET_GIAO_DICH
VALUES ('GD011', 'DV001', '2025-03-08', 1, 100000);


--test thue tro
select*from NGUOI_THUE_TRO;
select*from HOP_DONG;
select*from GIAO_DICH;
select*from CHI_TIET_GIAO_DICH;


delete from HOP_DONG
where MaHopDong = 'HD011';
delete from NGUOI_THUE_TRO
where MaNguoiThueTro='NTT011';
delete from GIAO_DICH
where MaGiaoDich='GD011';
delete from CHI_TIET_GIAO_DICH


------------------------------------------------------------------------------------------

--Dang nhap
CREATE PROCEDURE sp_dangnhap_nguoithuetro
    @TenTK NVARCHAR(30),
    @MatKhau NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM NGUOI_THUE_TRO
        WHERE TenTK = @TenTK AND MatKhau = @MatKhau
    )
    BEGIN
        PRINT N'Đăng nhập thành công';
        SELECT MaNguoiThueTro, TenTK, Email, SDT 
        FROM NGUOI_THUE_TRO
        WHERE TenTK = @TenTK;
    END
    ELSE
    BEGIN
        PRINT N'Tài khoản hoặc mật khẩu không đúng';
    END
END

EXEC sp_dangnhap_nguoithuetro @TenTK = 'user1', @MatKhau = 'pass1';

EXEC sp_dangnhap_nguoithuetro @TenTK = 'user1', @MatKhau = 'sai_mat_khau';




--tao user
-- Tao login
create login user1 with password = 'matkhau';
create login user2 with password = 'matkhau';

-- Tao user trong database
create user user1 for login user1;
create user user2 for login user2;


--cap quyen cho user
--cap quen select va insert cho user tren 1 bang
grant select, insert on PHONG_TRO to user1;
grant select, insert on HOP_DONG to user2;
--cap quyen thuc thi thu tuc
GRANT EXECUTE ON OBJECT::dbo.sp_dangnhap_nguoithuetro TO user1;
GRANT EXECUTE ON OBJECT::dbo.sp_dangnhap_nguoithuetro TO user2;

--Cap tat ca quyen trên mot bang
grant ALL on GIAO_DICH to user1;
grant ALL on THIET_BI_PHONG to user2;

--Chi cap quyen select
--bang hop dong
revoke insert, update, delete on HOP_DONG from user2;
grant select on HOP_DONG to user2;
--bang giao dich
revoke insert, update, delete on GIAO_DICH from user2;
grant select on GIAO_DICH to user2;

--Thu hoi quyen
----select va insert trên 1 b?ng c? th?
revoke select, insert on PHONG_TRO from user1;
revoke select, insert on HOP_DONG to user2;
revoke EXECUTE ON OBJECT::dbo.sp_dangnhap_nguoithuetro TO user1;
revoke EXECUTE ON OBJECT::dbo.sp_dangnhap_nguoithuetro TO user2;
revoke ALL on GIAO_DICH to user1;
revoke ALL on THIET_BI_PHONG to user2;