﻿USE MASTER
GO
IF DB_ID('QLDT') IS NOT NULL
	DROP DATABASE COMPUTER

CREATE DATABASE QLDT
GO
USE QLDT
GO
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(10),
	HOTEN NVARCHAR(50),
	LUONG FLOAT,
	PHAI NCHAR(3),
	NGSINH DATETIME,
	DIACHI NVARCHAR(50),
	GVQLCM CHAR(10),
	MABM CHAR(10),

	CONSTRAINT PK_GV
	PRIMARY KEY (MAGV)
)
GO

CREATE TABLE BOMON
(
	MABM CHAR(10),
	TENBM NVARCHAR(50),
	PHONG VARCHAR(10),
	DIENTHOAI VARCHAR(10),
	TRUONGBM CHAR(10),
	MAKHOA CHAR(10),
	NGAYNHANCHUC DATETIME,
	
	CONSTRAINT PK_BM
	PRIMARY KEY(MABM)
)
GO

CREATE TABLE KHOA
(
	MAKHOA CHAR(10),
	TENKHOA NVARCHAR(50),
	NAMTL DATETIME,
	PHONG VARCHAR(10),
	DIENTHOAI VARCHAR(10),
	TRUONGKHOA CHAR(10),
	NGAYNHANCHUC DATETIME,

	CONSTRAINT PK_KHOA
	PRIMARY KEY (MAKHOA)
)
GO

CREATE TABLE GV_DT
(
	MAGV CHAR(10),
	DIENTHOAI VARCHAR(10),

	CONSTRAINT PK_GVDT
	PRIMARY KEY (MAGV, DIENTHOAI)
)
GO

CREATE TABLE NGUOITHAN 
(
	MAGV CHAR(10),
	TEN NVARCHAR(50),
	NGSINH DATETIME,
	PHAI NCHAR(3),

	CONSTRAINT PK_NT
	PRIMARY KEY (MAGV, TEN)
)
GO

CREATE TABLE THAMGIADT
(
	MAGV CHAR(10),
	MADT CHAR(10),
	STT INT,
	PHUCAP FLOAT,
	KETQUA NVARCHAR(10),
	
	CONSTRAINT PK_TGDT
	PRIMARY KEY (MAGV, MADT, STT)
)
GO

CREATE TABLE CONGVIEC
(
	MADT CHAR(10),
	SOTT INT,
	TENCV NVARCHAR(50),
	NGAYBD DATETIME,
	NGAYKT DATETIME,

	CONSTRAINT PK_CV
	PRIMARY KEY (MADT, SOTT)
)
GO

CREATE TABLE DETAI
(
	MADT CHAR(10),
	TENDT NVARCHAR(50),
	CAPQL NVARCHAR(50),
	KINHPHI FLOAT,
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	MACD CHAR(10),
	GVCNDT CHAR(10),

	CONSTRAINT PK_DT
	PRIMARY KEY (MADT)
)
GO

CREATE TABLE CHUDE
(
	MACD CHAR(10),
	TENCD NVARCHAR(50),
	
	CONSTRAINT PK_CD
	PRIMARY KEY (MACD)
)
GO

ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT FK_GVQL
	FOREIGN KEY (GVQLCM)
	REFERENCES GIAOVIEN (MAGV),
	CONSTRAINT FK_BM
	FOREIGN KEY (MABM) 
	REFERENCES BOMON (MABM)

ALTER TABLE KHOA
ADD 
	CONSTRAINT FK_TK
	FOREIGN KEY (TRUONGKHOA)
	REFERENCES GIAOVIEN (MAGV)

ALTER TABLE BOMON
ADD
	CONSTRAINT FK_TBM
	FOREIGN KEY (TRUONGBM)
	REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT FK_MK
	FOREIGN KEY (MAKHOA)
	REFERENCES KHOA (MAKHOA)

ALTER TABLE GV_DT
ADD
	CONSTRAINT FK_GV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN (MAGV)

ALTER TABLE NGUOITHAN
ADD
	CONSTRAINT FK_MGV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN (MAGV)

ALTER TABLE DETAI
ADD
	CONSTRAINT FK_CNDT
	FOREIGN KEY (GVCNDT)
	REFERENCES GIAOVIEN (MAGV),
	CONSTRAINT FK_MACD
	FOREIGN KEY (MACD)
	REFERENCES CHUDE (MACD)

ALTER TABLE THAMGIADT
ADD
	CONSTRAINT FK_MAGV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN (MAGV),
	FOREIGN KEY (MADT, STT)
	REFERENCES CONGVIEC (MADT, SOTT)

ALTER TABLE CONGVIEC
ADD
	CONSTRAINT FK_DT
	FOREIGN KEY (MADT)
	REFERENCES DETAI (MADT)

GO

INSERT GIAOVIEN
VALUES
	('001', N'Nguyễn Hoài An', 2000.0, N'Nam', '1973-02-15', N'25/3 Lạc Long Quân, Q.10, TP HCM', NULL, NULL),
	('002', N'Trần Trà Hương', 2500.0, N'Nữ', '1960-06-20', N'125 Trần Hưng Đạo, Q.1, TP HCM', NULL, NULL),
	('003', N'Nguyễn Ngọc Ánh', 2200.0, N'Nữ', '1975-05-11', N'12/21 Võ Văn Ngân Thủ Đức, TP HCM', NULL, NULL),
	('004', N'Trương Nam Sơn', 2300.0, N'Nam', '1959-06-20', N'215 Lý Thường Kiệt, TP Biên Hòa', NULL, NULL),
	('005', N'Lý Hoàng Hà', 2500.0, N'Nam', '1954-10-23', N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM', NULL, NULL),
	('006', N'Trần Bạch Tuyết', 1500.0, N'Nữ', '1980-05-20', N'127 Hùng Vương, TP Mỹ Tho', '004', NULL),
	('007', N'Nguyễn An Trung', 2100.0, N'Nam', '1976-06-05', N'234 3/2, TP Biên Hòa', NULL, NULL),
	('008', N'Trần Trung Hiếu', 1800.0, N'Nam', '1977-08-06', N'22/11 Lý Thường Kiệt, TP Mỹ Tho', NULL, NULL),
	('009', N'Trần Hoàng Nam', 2000.0, N'Nam', '1975-11-22', N'234 Trấn Não, An Phú, TP HCM', '001', NULL),
	('010', N'Phạm Nam Thanh', 1500.0, N'Nam', '1980-12-12', N'221 Hùng Vương, Q.5, TP HCM', NULL, NULL)

INSERT GV_DT 
VALUES
	('001', '0838912112'),
	('001', '0903123123'),
	('002', '0913454545'),
	('003', '0838121212'),
	('003', '0903656565'),
	('003', '0937125135'),
	('006', '0937888888'),
	('008', '0653717171'),
	('008', '0913232323')

INSERT NGUOITHAN
VALUES
	('001', N'Hùng', '1990-01-14', N'Nam'),
	('001', N'Thủy','1994-12-08', N'Nữ'),
	('003', N'Hà', '1998-09-03', N'Nữ'),
	('003', N'Thu', '1998-09-03', N'Nữ'),
	('007', N'Mai', '2003-03-26', N'Nữ'),
	('007', N'Vy', '2000-02-14', N'Nữ'),
	('008', N'Nam', '1991-05-06', N'Nam'),
	('009', N'An', '1996-08-19', N'Nam'),
	('010', N'Nguyệt', '2006-01-14', N'Nữ')

INSERT KHOA 
VALUES
	('CNTT', N'Công Nghệ Thông Tin', 1995, 'B11', 0838123456, '002', 2005-02-20),
	('HH', N'Hóa học', 1980, 'B41', 0838456456, '007', 2001-10-15),
	('SH', N'Sinh học', 1980, 'B31', 0838454545, '004', 2000-10-11),
	('VL', N'Vật lý', 1976, 'B21', 0838223223, '005', 2003-09-18)

INSERT BOMON
VALUES
	('CNTT', N'Công nghệ tri thức', 'B15', 0838126126, NULL, 'CNTT', NULL),
	('HHC', N'Hóa hữu cơ', 'B44', 0832222222, NULL, 'HH', NULL),
	('HL', N'Hóa lý', 'B42', 0838878787, NULL, 'HH', NULL),
	('HPT', N'Hóa phân tích', 'B43', 0838777777, '007', 'HH', '2007-10-15'),
	('HTTT', N'Hệ thống thông tin', 'B13', 0838125125, '002', 'CNTT', '2004-09-20'),
	('MMT', N'Mạng máy tính', 'B16', 0838676767, '001', 'CNTT', '2005-05-15'),
	('SH', N'Sinh hóa', 'B33', 0838898989, NULL, 'SH', NULL),
	('VLĐT', N'Vật lý điện tử', 'B23', 0838234234, NULL, 'VL', NULL),
	('VLƯD', N'Vật lý ứng dụng', 'B24', 0838454545, '005', 'VL', '2006-02-18'),
	('VS', N'Vi sinh', 'B32', 0838909090, '004', 'SH', '2007-01-01')

INSERT CHUDE
VALUES 
	('NCPT', N'Nghiên cứu phát triển'),
	('QLGD', N'Quản lý giáo dục'),
	('ƯDCN', N'Ứng dụng công nghệ')

INSERT DETAI
VALUES
	('001', N'HTTT quản lý các trường ĐH', 'ĐHQG', 20.0, '2007-10-20', '2008-10-20', 'QLGD', '002'),
	('002', N'HTTT quản lý giáo vụ cho một Khoa', N'Trường', 20.0, '2000-10-12', '2001-10-12', 'QLGD', '002'),
	('003', N'Nghiên cứu chế tạo sợi Nano Platin', 'ĐHQG', 300.0, '2008-05-15', '2010-05-15', 'NCPT', '005'),
	('004', N'Tạo vật liệu sinh học bằng màng ối người', N'Nhà nước', 100.0, '2007-01-01', '2009-12-31', 'NCPT', '004'),
	('005', N'Ứng dụng hóa học xanh', N'Trường', 200.0, '2003-10-10', '2004-12-10', 'ƯDCN', '007'),
	('006', N'Nghiên cứu tế bào gốc', N'Nhà nước', 4000.0, '2006-10-20', '2009-10-20', 'NCPT', '004'),
	('007', N'HTTT quản lý thư viện ở các trường ĐH', N'Trường', 20.0, '2009-05-10', '2010-05-10', 'QLGD', '001')
	
INSERT CONGVIEC
VALUES
	('001', 1, N'Khởi tạo và Lập kế hoạch', '2007-10-20', '2008-12-20'),
	('001', 2, N'Xác định yêu cầu', '2008-12-21', '2008-03-21'),
	('001', 3, N'Phân tích hệ thống', '2008-03-22', '2008-05-22'),
	('001', 4, N'Thiết kế hệ thống', '2008-05-23', '2008-06-23'),
	('001', 5, N'Cài đặt thử nghiệm', '2008-06-24', '2008-10-20'),
	('002', 1, N'Khởi tạo và Lập kế hoạch', '2009-05-10', '2009-07-10'),
	('002', 2, N'Xác định yêu cầu', '2009-07-11', '2009-10-11'),
	('002', 3, N'Phân tích hệ thống', '2009-10-12', '2009-12-20'),
	('002', 4, N'Thiết kế hệ thống', '2009-12-21', '2010-03-22'),
	('002', 5, N'Cài đặt thử nghiệm', '2010-03-23', '2010-05-10'),
	('006', 1, N'Lấy mẫu', '2006-10-20', '2007-02-20'),
	('006', 2, N'Nuôi cấy', '2007-02-21', '2008-08-21')

INSERT THAMGIADT
VALUES
	('001', '002', 1, 0.0, NULL),
	('001', '002', 2, 2.0, NULL),
	('002', '001', 4, 2.0, N'Đạt'),
	('003', '001', 1, 1.0, N'Đạt'),
	('003', '001', 2, 0.0, N'Đạt'),
	('003', '001', 4, 1.0, N'Đạt'),
	('003', '002', 2, 0.0, NULL),
	('004', '006', 1, 0.0, N'Đạt'),
	('004', '006', 2, 1.0, N'Đạt'),
	('006', '006', 2, 1.5, N'Đạt'),
	('009', '002', 3, 0.5, Null),
	('009', '002', 4, 1.5, Null)

UPDATE GIAOVIEN
SET GVQLCM = '002' WHERE MAGV = '003'
UPDATE GIAOVIEN 
SET GVQLCM = '007' WHERE MAGV = '008'
UPDATE GIAOVIEN 
SET GVQLCM = '001' WHERE MAGV = '009'
UPDATE GIAOVIEN 
SET GVQLCM = '007' WHERE MAGV = '010'
UPDATE GIAOVIEN 
SET MABM = 'MMT' WHERE MAGV = '001'
UPDATE GIAOVIEN 
SET MABM = 'HTTT' WHERE MAGV = '002'
UPDATE GIAOVIEN 
SET MABM = 'HTTT' WHERE MAGV = '003'
UPDATE GIAOVIEN 
SET MABM = 'VS' WHERE MAGV = '004'
UPDATE GIAOVIEN 
SET MABM = 'VLĐT' WHERE MAGV = '005'
UPDATE GIAOVIEN 
SET MABM = 'VS' WHERE MAGV = '006'
UPDATE GIAOVIEN 
SET MABM = 'HPT' WHERE MAGV = '007'
UPDATE GIAOVIEN 
SET MABM = 'HPT' WHERE MAGV = '008'
UPDATE GIAOVIEN SET MABM = 'MMT' WHERE MAGV = '009'
UPDATE GIAOVIEN SET MABM = 'HPT' WHERE MAGV = '010'

--Q58
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV, THAMGIADT TGDT, DETAI DT
WHERE GV.MAGV = TGDT.MAGV
AND TGDT.MADT = DT.MADT
GROUP BY GV.HOTEN
HAVING COUNT(DISTINCT DT.MACD) = (SELECT COUNT(CD.MACD)
									FROM CHUDE CD)

--Q59
SELECT DISTINCT DT.TENDT
FROM DETAI DT, GIAOVIEN GV, THAMGIADT TGDT
WHERE GV.MABM = 'HTTT'
AND GV.MAGV = TGDT.MAGV
AND TGDT.MADT = DT.MADT
EXCEPT
SELECT DT1.TENDT
FROM DETAI DT1, GIAOVIEN GV, THAMGIADT TGDT
WHERE GV.MABM != 'HTTT'
AND GV.MAGV = TGDT.MAGV
AND TGDT.MADT = DT1.MADT

--Q60
SELECT DISTINCT DT.TENDT
FROM DETAI DT, GIAOVIEN GV, THAMGIADT TGDT, BOMON BM
WHERE BM.TENBM = N'Hệ thống thông tin'
AND GV.MABM = BM.MABM
AND TGDT.MADT = DT.MADT
AND TGDT.MAGV = GV.MAGV
EXCEPT
SELECT DT1.TENDT
FROM DETAI DT1, GIAOVIEN GV, THAMGIADT TGDT, BOMON BM
WHERE BM.TENBM != N'Hệ thống thông tin'
AND GV.MABM = BM.MABM
AND TGDT.MADT = DT1.MADT
AND TGDT.MAGV = GV.MAGV

--Q61
SELECT DISTINCT GV.*
FROM GIAOVIEN GV, THAMGIADT TGDT, DETAI DT
WHERE TGDT.MAGV = GV.MAGV
AND TGDT.MADT = DT.MADT
AND DT.MACD = 'QLGD'
AND NOT EXISTS (SELECT DT1.MADT
				FROM DETAI DT1
				WHERE TGDT.MADT = DT1.MADT
				AND DT1.MACD != 'QLGD')

--Q62
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV, THAMGIADT TGDT
WHERE GV.MAGV = TGDT.MAGV
AND TGDT.MADT IN (SELECT TGDT.MADT 
					FROM THAMGIADT TGDT, GIAOVIEN GV1
					WHERE GV1.HOTEN = N'Trần Trà Hương'
					AND GV1.MAGV = TGDT.MAGV)
EXCEPT
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.HOTEN = N'Trần Trà Hương'

--Q63
SELECT DISTINCT DT.TENDT
FROM DETAI DT, THAMGIADT TGDT, GIAOVIEN GV, BOMON BM
WHERE GV.MAGV = TGDT.MAGV
AND BM.TENBM = N'Hệ thống thông tin'
AND BM.MABM = GV.MABM
AND TGDT.MADT = DT.MADT
AND DT.MADT NOT IN (SELECT GV1.MAGV
				FROM GIAOVIEN GV1
				WHERE GV1.MABM = BM.MABM
				AND GV1.MAGV != TGDT.MAGV)


--Q64
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT CV.SOTT
				FROM CONGVIEC CV
				WHERE CV.MADT = '006')
				EXCEPT
				(SELECT TGDT.STT
				FROM THAMGIADT TGDT, GIAOVIEN GV2
				WHERE GV2.MAGV = GV.MAGV
				AND TGDT.MAGV = GV2.MAGV
				AND TGDT.MADT = '006'))

--Q65 
SELECT GV.*
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT DT.MADT
				FROM DETAI DT, CHUDE CD
				WHERE DT.MACD = CD.MACD
				AND CD.TENCD =	N'Ứng dụng công nghệ')
				EXCEPT
				(SELECT DT.MADT
				FROM THAMGIADT TGDT, DETAI DT, CHUDE CD
				WHERE CD.TENCD = N'Ứng dụng công nghệ'
				AND CD.MACD = DT.MACD
				AND DT.MADT = TGDT.MADT))

--Q66
SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT DT.MADT
				FROM DETAI DT, GIAOVIEN TTH
				WHERE TTH.HOTEN = N'Trần Trà Hương'
				AND TTH.MAGV = DT.GVCNDT)
				EXCEPT
				(SELECT TGDT.MADT
				FROM THAMGIADT TGDT
				WHERE TGDT.MAGV = GV.MAGV))

---Q67
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS ((SELECT TGDT.MADT
				FROM THAMGIADT TGDT,BOMON BM, GIAOVIEN GV
				WHERE TGDT.MAGV = GV.MAGV
				AND GV.MABM = BM.MABM
				AND BM.MAKHOA = 'CNTT')
				EXCEPT
				(SELECT TGDT2.MADT 
				FROM THAMGIADT TGDT2
				WHERE DT.MADT = TGDT2.MADT))

--Q68
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT TGDT.MADT, TGDT.STT
					FROM DETAI DT, CONGVIEC CV, THAMGIADT TGDT
					WHERE DT.TENDT = N'Nghiên cứu tế bào gốc'
					AND TGDT.MADT = DT.MADT
					AND TGDT.MADT = CV.MADT
					AND TGDT.STT = CV.SOTT)
					EXCEPT
					(SELECT TGDT.MADT, TGDT.STT
					FROM THAMGIADT TGDT
					WHERE TGDT.MAGV = GV.MAGV))

--Q69
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT DT.MADT
					FROM DETAI DT
					WHERE DT.KINHPHI > 100)
					EXCEPT
					(SELECT TGDT.MADT
					FROM THAMGIADT TGDT
					WHERE TGDT.MAGV = GV.MAGV))

--Q70
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS ((SELECT TGDT.MADT
				FROM THAMGIADT TGDT,BOMON BM, GIAOVIEN GV, KHOA K
				WHERE TGDT.MAGV = GV.MAGV
				AND GV.MABM = BM.MABM
				AND BM.MAKHOA = K.MAKHOA
				AND K.TENKHOA = N'Sinh học')
				EXCEPT
				(SELECT TGDT2.MADT 
				FROM THAMGIADT TGDT2
				WHERE DT.MADT = TGDT2.MADT))

--Q71
SELECT GV.HOTEN, GV.MAGV, GV.NGSINH
FROM GIAOVIEN GV
WHERE NOT EXISTS ((SELECT TGDT.MADT, TGDT.STT
					FROM DETAI DT, CONGVIEC CV, THAMGIADT TGDT
					WHERE DT.TENDT = N'Ứng dụng hóa học xanh'
					AND TGDT.MADT = DT.MADT
					AND TGDT.MADT = CV.MADT
					AND TGDT.STT = CV.SOTT)
					EXCEPT
					(SELECT TGDT.MADT, TGDT.STT
					FROM THAMGIADT TGDT
					WHERE TGDT.MAGV = GV.MAGV))

--Q72
SELECT GV.HOTEN, GV.MAGV, BM.TENBM, QL.HOTEN
FROM GIAOVIEN GV, BOMON BM, GIAOVIEN QL
WHERE GV.GVQLCM = QL.MAGV
AND GV.MABM = BM.MABM
AND NOT EXISTS ((SELECT DT.MADT
				FROM DETAI DT, CHUDE CD
				WHERE CD.TENCD = N'Nghiên cứu phát triển'
				AND DT.MACD = CD.MACD)
				EXCEPT
				(SELECT TGDT.MADT
				FROM THAMGIADT TGDT
				WHERE TGDT.MAGV = GV.MAGV))