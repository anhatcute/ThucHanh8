CREATE DATABASE QuanLyBanHang;
GO
USE QuanLyBanHang;
GO

CREATE TABLE TACGIA (
	MaTG INT IDENTITY(1,1) PRIMARY KEY,
	TenTG NVARCHAR(100),
	DiaChi NVARCHAR(100),
	TieuSu NVARCHAR(100),
	DienThoai VARCHAR(15)
);

CREATE TABLE KHACHHANG (
	MaKH INT IDENTITY(1,1) PRIMARY KEY,
	TenKH NVARCHAR(100),
	GioiTinh NVARCHAR(10),
	TaiKhoan NVARCHAR(100),
	MatKhau NVARCHAR(100),
	Email NVARCHAR(100),
	DiaChiKH NVARCHAR(100),
	DienThoaiKH VARCHAR(15),
	NgaySinh DATE
);

CREATE TABLE DONDATHANG (
	MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
	DaThanhToan BIT DEFAULT 0,
	TinhTrangGiaoHang NVARCHAR(50) DEFAULT N'Chưa giao',
	NgayDat DATE,
	NgayGiao DATE,
	MaKH INT,
	CONSTRAINT FK_DONDATHANG_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

CREATE TABLE CHUDE (
	MaCD INT IDENTITY(1,1) PRIMARY KEY,
	TenChuDe NVARCHAR(100)
);

CREATE TABLE NHAXUATBAN (
	MaNXB INT IDENTITY(1,1) PRIMARY KEY,
	TenNXB NVARCHAR(100),
	DiaChi NVARCHAR(100),
	DienThoai VARCHAR(15)
);

CREATE TABLE SACH (
	MaSach INT IDENTITY(1,1) PRIMARY KEY,
	TenSach NVARCHAR(100),
	GiaBan DECIMAL(18,0),
	MoTa NVARCHAR(MAX),
	AnhBia NVARCHAR(100),
	NgayCapNhat DATE,
	SoLuongTon INT,
	MaCD INT,
	MaNXB INT,
	MOI BIT DEFAULT 0,
	CONSTRAINT FK_SACH_CHUDE FOREIGN KEY (MaCD) REFERENCES CHUDE(MaCD),
	CONSTRAINT FK_SACH_NHAXUATBAN FOREIGN KEY (MaNXB) REFERENCES NHAXUATBAN(MaNXB)
);

CREATE TABLE CHITIETDONHANG (
	MaDonHang INT,
	MaSach INT,
	SoLuong INT,
	DonGia DECIMAL(18,0),
	PRIMARY KEY (MaDonHang, MaSach),
	CONSTRAINT FK_CHITIETDONHANG_DONDATHANG FOREIGN KEY (MaDonHang) REFERENCES DONDATHANG(MaDonHang),
	CONSTRAINT FK_CHITIETDONHANG_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE THAMGIA (
	MaTG INT,
	MaSach INT,
	VaiTro NVARCHAR(50),
	ViTri NVARCHAR(50),
	PRIMARY KEY (MaTG, MaSach),
	CONSTRAINT FK_THAMGIA_TACGIA FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG),
	CONSTRAINT FK_THAMGIA_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);


-- Bảng Chủ đề
INSERT INTO CHUDE (TenChuDe) VALUES 
(N'Tiểu thuyết'),
(N'Khoa học'),
(N'Thiếu nhi'),
(N'Lịch sử');

-- Bảng Nhà xuất bản
INSERT INTO NHAXUATBAN (TenNXB, DiaChi, DienThoai) VALUES
(N'NXB Trẻ', N'TP. Hồ Chí Minh', '02838224567'),
(N'NXB Kim Đồng', N'Hà Nội', '02438437677'),
(N'NXB Giáo Dục', N'Hà Nội', '02437261545');

-- Bảng Tác giả
INSERT INTO TACGIA (TenTG, DiaChi, TieuSu, DienThoai) VALUES
(N'Nguyễn Nhật Ánh', N'Quảng Nam', N'Nhà văn Việt Nam nổi tiếng với sách thiếu nhi', '0912345678'),
(N'Tô Hoài', N'Hà Nội', N'Tác giả Dế Mèn Phiêu Lưu Ký', '0987654321'),
(N'Trần Đăng Khoa', N'Hải Dương', N'Nhà thơ, nhà văn Việt Nam', '0977777777');

INSERT INTO SACH (TenSach, GiaBan, MoTa, AnhBia, NgayCapNhat, SoLuongTon, MaCD, MaNXB, MOI)
VALUES
(N'Mắt Biếc', 85000, N'Tiểu thuyết lãng mạn của Nguyễn Nhật Ánh', N'matbiec.jpg', GETDATE(), 120, 1, 1, 1),
(N'Dế Mèn Phiêu Lưu Ký', 65000, N'Truyện thiếu nhi kinh điển của Tô Hoài', N'demen.jpg', GETDATE(), 200, 3, 2, 0),
(N'Chuyện Con Mèo Dạy Hải Âu Bay', 78000, N'Sách thiếu nhi nổi tiếng', N'meo.jpg', GETDATE(), 150, 3, 1, 1),
(N'Tuổi Trẻ Đáng Giá Bao Nhiêu', 120000, N'Sách truyền cảm hứng', N'tuoitre.jpg', GETDATE(), 80, 2, 3, 1);

INSERT INTO KHACHHANG (TenKH, GioiTinh, TaiKhoan, MatKhau, Email, DiaChiKH, DienThoaiKH, NgaySinh)
VALUES
(N'Lê Minh Anh', N'Nữ', N'minhanh', N'123456', N'minhanh@gmail.com', N'Hà Nội', '0901111222', '1999-03-21'),
(N'Nguyễn Văn Bảo', N'Nam', N'baonguyen', N'654321', N'baonguyen@gmail.com', N'TP.HCM', '0903333444', '1998-08-09');

INSERT INTO DONDATHANG (DaThanhToan, TinhTrangGiaoHang, NgayDat, NgayGiao, MaKH)
VALUES
(1, N'Đã giao', '2025-10-10', '2025-10-12', 1),
(0, N'Chưa giao', '2025-10-15', NULL, 2);


INSERT INTO CHITIETDONHANG (MaDonHang, MaSach, SoLuong, DonGia)
VALUES
(1, 1, 2, 85000),
(1, 2, 1, 65000),
(2, 3, 1, 78000),
(2, 4, 1, 120000);

INSERT INTO THAMGIA (MaTG, MaSach, VaiTro, ViTri)
VALUES
(1, 1, N'Tác giả chính', N'Chính'),
(2, 2, N'Tác giả chính', N'Chính'),
(3, 3, N'Đồng tác giả', N'Phụ'),
(1, 4, N'Tư vấn biên tập', N'Phụ');

