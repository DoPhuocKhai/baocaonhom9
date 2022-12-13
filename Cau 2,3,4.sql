create table VatTu (
MAVT int,
TenVT varchar(50),
DVTinh money,
SLCon int
constraint pk_vt primary key(MAVT)
);

create table HDBan(
MAHD int,
NgayXuat smalldatetime,
HoTenKhach nvarchar(50)
constraint pk_hdb primary key(MAHD)
);


create table HangXuat (
MAHD int,
MAVT int,
DonGia money,
SLBan int
constraint pk_hx primary key(MAHD,MAVT)
);



--Câu 2:

SELECT TOP 1 (SLBAN* DONGIA) AS 'TONG TIEN ', MAHD
 FROM  HANGXUAT
 ORDER BY [TONG TIEN ] DESC


 --câu 4: 
 CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;



--câu 3
CREATE FUNCTION f3 (
    @MAHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MAHD,
        HD.NGAYXUAT,
        HD.MAVT,
        HX.DONGIA,
        HX.SLBAN,  
        CASE
            WHEN WEEKDAY(HD.NGAYXUAT) = 0 THEN N'Thứ hai'            
            WHEN WEEKDAY(HD.NGAYXUAT) = 1 THEN N'Thứ ba'
            WHEN WEEKDAY(HD.NGAYXUAT) = 2 THEN N'Thứ tư'
            WHEN WEEKDAY(HD.NGAYXUAT) = 3 THEN N'Thứ năm'
            WHEN WEEKDAY(HD.NGAYXUAT) = 4 THEN N'Thứ sáu'
            WHEN WEEKDAY(HD.NGAYXUAT) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HANGXUAT HX
    INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
    WHERE HX.MAHD = @MAHD;