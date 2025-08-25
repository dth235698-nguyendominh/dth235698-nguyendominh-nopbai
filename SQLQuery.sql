CREATE DATABASE QLGV_DB
ON(
	NAME = QuanLyGiaoVien_dat,
	FILENAME='D:\UNIVERCITY\THIRD_YEAR\First_semester\NET_programing\Project_QLGV\SQL\QuanLyGiaoVien_dat.mdf',
	SIZE=10,
	MAXSIZE=50,
	FILEGROWTH=2
)
LOG ON(
	NAME= QuanLyGiaoVien_log,
	FILENAME='D:\UNIVERCITY\THIRD_YEAR\First_semester\NET_programing\Project_QLGV\SQL\QuanLyGiaoVien_log.ldf',
	SIZE=5,
	MAXSIZE=50,
	FILEGROWTH=5
)
go

USE QLGV_DB
go


create table GIAOVIEN
(
	MaGV nvarchar(20) primary key,
	Ten nvarchar(30) not null,	
	NgSinh datetime,
	DiaChi nvarchar(30),
	SDT nvarchar(30),
	Email nvarchar(30) unique check (Email LIKE '%_@_%._%'),
	GT nvarchar(4),
	MaBM nvarchar(10) null,
)
go

create table MONHOC
(
	MaBM nvarchar(10),
	TenMH nvarchar(20) not null,
	MaGV nvarchar(20),
	TGDay nvarchar(5),
	NgayDay datetime ,
	TruongBM nvarchar(20) null,
)
go

create table LOPHOC
(
	MaLop nvarchar(10) primary key,
	GVCN nvarchar(20) null,
	TGBatDau date,
	TGKetThuc date ,
	Siso tinyint 
)

create table HOPDONG
(
	MaHD nvarchar(20) primary key,
	MaGV nvarchar(20) ,
	NgayBD datetime,
	NgayKT datetime,
	LuongCB nvarchar(20),
	LuongTT nvarchar(20),
	SoTietDay int not null,
)
go


create table LICHDAY
(
	MaGV nvarchar(20),
	MaLichDay nvarchar(10) primary key,
	MaBM nvarchar(10) ,
	MaLop nvarchar(10),
	NgayDay datetime not null ,
	SoTiet int not null check (SoTiet >=1 and SoTiet <=5),
	TietBD int not null check (TietBD >=1 and TietBD <=10) ,
	-- Theo thứ 
	Thu int Check (Thu >= 2 AND Thu<= 8)
)
go

create table ACCOUNT
(
	Id int identity primary key ,
	UserName nvarchar(100) not null,
	DisPlayName nvarchar(100) not null,
	PassWord nvarchar(100) not null default 1, 
	Type INT NOT NULL DEFAULT 0 -- 1: admin && 0: staff
)
go


ALTER TABLE dbo.MONHOC 
ADD CONSTRAINT FK_TRP_MH_GV 
FOREIGN KEY (TruongBM) REFERENCES dbo.GIAOVIEN(MaGV)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Xem
ALTER TABLE dbo.MONHOC
ADD CONSTRAINT FK_MAGV_MH_GV
FOREIGN KEY (MaGV) REFERENCES dbo.GIAOVIEN(MaGV)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE dbo.HOPDONG
ADD CONSTRAINT FK_MAGV_HD_GV
FOREIGN KEY (MaGV) REFERENCES dbo.GIAOVIEN(MaGV)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE dbo.LICHDAY
ADD CONSTRAINT FK_MAGV_LD_GV
FOREIGN KEY (MaGV) REFERENCES dbo.GIAOVIEN(MaGV)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE dbo.LOPHOC
ADD CONSTRAINT FK_MAGV_LOP_GV
FOREIGN KEY (GVCN) REFERENCES dbo.GIAOVIEN(MaGV)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Chỉnh lại 
ALTER TABLE LICHDAY
ADD CONSTRAINT FK_MALOP_LD_LOP
FOREIGN KEY (MaLop) REFERENCES LOPHOC(MaLop)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Thêm dữ liệu vào bảng 

-- Thêm vào bảng giáo viên

INSERT INTO dbo.GIAOVIEN 
(
	MaGV,
	Ten ,	
	NgSinh ,
	DiaChi,
	SDT ,
	Email ,
	MaBM , -- Null (MONHOC)
	GT
)
VALUES 
    ('001', N'Nguyễn Văn A', '1990/12/01', N'Long Xuyên', '0358256254', 'vana@gmail.com', null, N'Nam'),
	('002', N'Nguyễn Văn B', '1989/11/20', N'Long Xuyên', '0358256194', 'vanb@gmail.com', null, N'Nữ'),
	('003', N'Nguyễn Hân ', '1989/01/20', N'Thoại Sơn', '0909547564', 'han@gmail.com', null, N'Nữ'),
	('004', N'Phạm Khúc', '1985/09/01', N'Chợ Mới', '0954865475', 'khucp@gmail.com', null, N'Nữ'),
	('005', N'Nguyễn Kha', '1992/12/20', N'Long Xuyên', '0909254256', 'khang@gmail.com', null, N'Nam'),
	('006', N'Nguyễn Thi', '1987/05/13', N'Long Xuyên', '0952254256', 'ngthi@gmail.com', null, N'Nữ'),
	('007', N'Nguyễn Mẫn', '1989/11/20', N'Long Xuyên', '0354985425', 'nguyenman@gmail.com', null, N'Nam'),
	('008', N'Nguyễn Tình', '1988/03/20', N'Long Xuyên', '0358154954', 'nguyentinh@gmail.com', null, N'Nữ'),
	('009', N'Trần Khanh', '1992/01/12', N'Thoại Sơn', '0354254895', 'trankhanh@gmail.com', null, N'Nam'),
	('010', N'Lê Anh', '1991/12/03', N'Long Xuyên', '03598257485', 'leanh@gmail.com', null, N'Nam'),
	('011', N'Trần Kha', '1980/07/20', N'Long Xuyên', '0358478452', 'trankha@gmail.com', null, N'Nam'),
	('012', N'Trần Thanh', '1992/01/12', N'Thoại Sơn', '0354254895', 'tranthanh@gmail.com', null, N'Nữ'),
	('013', N'Lê Anh Kỳ', '1991/12/03', N'Long Xuyên', '03598257485', 'leanhky@gmail.com', null, N'Nam'),
	('014', N'Trần Quang', '1980/07/20', N'Long Xuyên', '0358478452', 'tranquang@gmail.com', null, N'Nam'),
	('015', N'Trần Bảo', '1992/01/12', N'Thoại Sơn', '0354254895', 'tranbao@gmail.com', null, N'Nam'),
	('016', N'Lê Kiệt', '1991/12/03', N'Long Xuyên', '03598257485', 'lekiet@gmail.com', null, N'Nam'),
	('017', N'Trần Hoa', '1980/07/20', N'Long Xuyên', '0358478452', 'tranhoa@gmail.com', null, N'Nữ')
 GO


-- Thêm vào bảng LOPHOC

INSERT INTO dbo.LOPHOC
(
	MaLop,
	GVCN, -- Null (GIAOVIEN)
	TGBatDau,
	TGKetThuc,
	Siso 
)
VALUES 
    ('12A1', '001', '2022/01/01', '2023/01/01', 22),
	('11A1', '002', '2022/01/01', '2023/01/01', 25),
	('10A1', '003', '2022/01/01', '2023/01/01', 28),
	('10A2', '004', '2022/01/01', '2023/01/01', 15),
	('10A3', '005', '2022/01/01', '2023/01/01', 19),
	('11A3', '006', '2022/01/01', '2023/01/01', 19),
	('11A2', '007', '2022/01/01', '2023/01/01', 19),
	('12A3', '008', '2022/01/01', '2023/01/01', 19),
	('12A4', '009', '2022/01/01', '2023/01/01', 19),
	('11A4', '010', '2022/01/01', '2023/01/01', 19),
	('10A4', '011', '2022/01/01', '2023/01/01', 19),
	('10A5', '012', '2022/01/01', '2023/01/01', 19),
	('12A2', '013', '2022/01/01', '2023/01/01', 19)
GO
-- Thêm vào bảng MONHOC

INSERT INTO dbo.MONHOC
(
	MaBM,
	TenMH, 
	MaGV , --GIAOVIEN
	TGDay, -- Date
	NgayDay, -- LICHDAY
	TruongBM --
)
VALUES 
    ('TOAN', N'Toán', '001',  '5',  '2023/01/01', '001'),
    ('ANH', N'Anh', '002', '5',  '2023/01/01', '002'),
    ('VAN', N'Văn', '003',  '5',  '2023/01/01', '003'),
    ('DIA', N'Địa', '004',  '5',  '2023/01/01', '004'),
    ('SU', N'Sử', '005',  '5',  '2023/01/01', '005'),
    ('SINH', N'Sinh', '006',  '5',  '2023/01/01', '006'),
    ('LY', N'Lý', '007',  '5',  '2023/01/01', '007'),
    ('HOA', N'Hoá', '008',  '5',  '2023/01/01', '008'),
    ('GDCD', N'Giáo dục công dân', '009',  '5',  '2023/01/01', '009'),
    ('THEDUC', N'Thể dục', '010', '5',  '2023/01/01' , '010'),
    ('TIN', N'Tin học', '011', '5',  '2023/01/01' , '011')
GO


INSERT INTO dbo.HOPDONG
(
	MaHD,
	MaGV  , -- GIAOVIEN
	NgayBD ,
	NgayKT ,
	LuongCB ,
	LuongTT ,
	SoTietDay
)
VALUES 
    ('hd001', '001', '2014/12/12', '2054/12/12', '2000' , '2500', 20),
    ('hd002', '002', '2014/12/12', '2054/12/12', '3000' , '3200', 20),
    ('hd003', '003', '2014/12/12', '2054/12/12', '3000' , '3500', 20),
    ('hd004', '004', '2014/12/12', '2054/12/12', '2000' , '2500', 20),
    ('hd005', '005', '2014/12/12', '2054/12/12', '1500' , '2500', 20),
    ('hd006', '006', '2014/12/12', '2054/12/12', '2000' , '2500', 20)
GO
-- Thêm vào bảng LICHDAY

-- Tạo Procedure Thêm Lịch Dạy 
CREATE PROCEDURE InsertLichDay
	@MaGV nvarchar(20),
	@MaLichDay nvarchar(10),
	@MaBM nvarchar(10) ,
	@MaLop nvarchar(10),
	@NgayDay datetime  ,
	@SoTiet int ,
	@TietBD int 
AS
BEGIN
    DECLARE @Thu INT;
    SET @Thu = DATEPART(WEEKDAY, @NgayDay);
	IF NOT EXISTS (SELECT 1 FROM dbo.LICHDAY WHERE MaLichDay = @MaLichDay)
	BEGIN
		-- Thêm dữ liệu vào bảng
		INSERT INTO dbo.LICHDAY (MaGV, MaLichDay, MaBM, MaLop, NgayDay, SoTiet, TietBD, Thu)
		VALUES (@MaGV, @MaLichDay, @MaBM, @MaLop, @NgayDay, @SoTiet, @TietBD, @Thu);
	END
	ELSE 
		RETURN 
END; 
GO
EXEC InsertLichDay '001', '1010101', 'TOAN', '12A1', '2023/12/20', 5, 1;
EXEC InsertLichDay '002', '1020101', 'ANH', '11A1', '2023/12/20', 5, 1;
EXEC InsertLichDay '003', '1030101', 'VAN', '10A1', '2023/12/25', 4, 2;
EXEC InsertLichDay '004', '1040101', 'DIA', '11A2', '2023/12/25', 4, 2;
GO

-- Tạo Procedure để Sửa dữ liệu 
CREATE PROCEDURE UpdateLichDay
    @MaLichDay nvarchar(10),
    @MaGV nvarchar(20),
    @MaBM nvarchar(10),
    @MaLop nvarchar(10),
    @NgayDay datetime,
    @SoTiet int,
    @TietBD int
AS
BEGIN
    -- Kiểm tra xem @MaLichDay có tồn tại trong bảng không
    IF EXISTS (SELECT 1 FROM dbo.LICHDAY WHERE MaLichDay = @MaLichDay)
    BEGIN
        -- Cập nhật dữ liệu trong bảng
        UPDATE dbo.LICHDAY
        SET
            MaGV = @MaGV,
            MaBM = @MaBM,
            MaLop = @MaLop,
            NgayDay = @NgayDay,
            SoTiet = @SoTiet,
            TietBD = @TietBD
        WHERE MaLichDay = @MaLichDay;
    END
    ELSE
    BEGIN
		RETURN
    END
END;
GO

-- Thêm vào bảng ACCOUNT

INSERT INTO dbo.ACCOUNT
        ( UserName ,
		  DisPlayName,
          PassWord ,
          Type
        )
VALUES  ( N'a' , N'Admin',N'1' ,1 ),
		( N'staff' ,N'Staff', N'1' ,  0)

GO

-- Update dữ liệu cho bảng giaovien
--Cập nhật thêm dữ liệu cho bảng GIAOVIEN
update GIAOVIEN set MaBM = 'TOAN' where (MaGV = '001')
update GIAOVIEN set MaBM = 'ANH' where (MaGV = '002')
update GIAOVIEN set MaBM = 'VAN' where (MaGV = '003')
update GIAOVIEN set MaBM = 'DIA' where (MaGV = '004')
update GIAOVIEN set MaBM = 'SU' where (MAGV = '005')
update GIAOVIEN set MaBM = 'SINH' where (MaGV = '006')
update GIAOVIEN set MaBM = 'LY' where (MAGV = '007')
update GIAOVIEN set MaBM = 'HOA' where (MaGV = '008')
update GIAOVIEN set MaBM = 'GDCD' where (MaGV = '009')
update GIAOVIEN set MaBM = 'THEDUC' where (MaGV = '010')
update GIAOVIEN set MaBM = 'TOAN' where (MaGV = '011')
update GIAOVIEN set MaBM = 'ANH' where (MaGV = '012')
update GIAOVIEN set MaBM = 'VAN' where (MaGV = '013')
update GIAOVIEN set MaBM = 'DIA' where (MaGV = '014')
update GIAOVIEN set MaBM = 'SU' where (MaGV = '015')
update GIAOVIEN set MaBM = 'HOA' where (MaGV = '016')
update GIAOVIEN set MaBM = 'GDCD' where (MaGV = '017')
GO


-- Tạo Store Produce sử dụng để đăng nhập	
Create PROC USP_Login 
@userName nvarchar(100), @passWord nvarchar(100) 
AS 
BEGIN 
	SELECT * FROM DBO.ACCOUNT WHERE UserName =  @userName and PassWord = @passWord
END
GO

-- Tạo Store Produce thay đổi thông tin 
CREATE PROC USP_UpdateAccount
@userName nvarchar(100), @displayName nvarchar(100) , @password nvarchar(100),
@newPass nvarchar(100)
AS
BEGIN
	DECLARE @isPass int = 0

	SELECT @isPass = COUNT(*) FROM dbo.ACCOUNT WHERE UserName = @userName AND PassWord = @password
	-- Nhap dung ten va mat khau
	IF (@isPass = 1) 
	BEGIN
		IF (@newPass = null OR @newPass = '')
		BEGIN
		-- Cập nhật khi đổi tên hiển thị
			UPDATE DBO.ACCOUNT SET DisPlayName = @displayName WHERE UserName = @userName
		END
		ELSE
		BEGIN
		-- Cập nhật khi đổi pass
			UPDATE DBO.ACCOUNT SET DisPlayName = @displayName, PassWord = @newPass WHERE UserName = @userName
		END
	END
END
GO


--DROP PROCEDURE USP_UpdateAccount
--DROP DATABASE QLGV_DB

SELECT * FROM LICHDAY
SELECT * FROM HOPDONG


SELECT gv.Ten ,hd.* FROM HOPDONG hd, GIAOVIEN gv WHERE gv.MaGV = hd.MaGV