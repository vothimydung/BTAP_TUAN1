--Câu 1:Th?ng kê s? lo?i s?n ph?m c?a m?i h?ng s?n xu?t: vbnet

SELECT Hangsx.mahangsx, Hangsx.tenhang, COUNT(Sanpham.masp) AS SoLoaiSanPham
FROM Hangsx
LEFT JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.mahangsx, Hangsx.tenhang;

--Câu 2:Th?ng kê t?ng ti?n nh?p c?a m?i s?n ph?m trong nãm 2018:

SELECT Sanpham.masp, Sanpham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Sanpham.masp, Sanpham.tensp;

--Câu 3:Th?ng kê các s?n ph?m có t?ng s? lý?ng xu?t nãm 2018 là l?n hõn 10.000 s?n ph?m c?a h?ng Samsung:

SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM Sanpham
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Sanpham.mahangsx = 'SAMSUNG' 
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;

--Câu 4:Th?ng kê s? lý?ng nhân viên nam c?a m?i ph?ng ban:

SELECT Nhanvien.phong, COUNT(*) AS SoLuongNhanVienNam
FROM Nhanvien
WHERE Nhanvien.gioitinh = N'Nam'
GROUP BY Nhanvien.phong;

--Câu 5: Th?ng kê t?ng s? lý?ng nh?p c?a m?i h?ng s?n xu?t trong nãm 2018.

SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Hangsx
INNER JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang

--Câu 6:H?y th?ng kê xem t?ng lý?ng ti?n xu?t c?a m?i nhân viên trong nãm 2018 là bao nhiêu.

SELECT Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS TongTienXuat
FROM Nhanvien
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.tennv

--Câu 7:H?y ðýa ra t?ng ti?n nh?p c?a m?i nhân viên trong tháng 8 – nãm 2018 có t?ng giá tr? l?n hõn 100.000.

SELECT Nhanvien.tennv, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
WHERE YEAR(Nhap.ngaynhap) = 2018 AND MONTH(Nhap.ngaynhap) = 8
GROUP BY Nhanvien.tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000

--Câu 8:H?y ðýa ra danh sách các s?n ph?m ð? nh?p nhýng chýa xu?t bao gi?.

SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
LEFT JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Xuat.masp IS NULL

--Câu 9:H?y ðýa ra danh sách các s?n ph?m ð? nh?p nãm 2018 và ð? xu?t nãm 2018.

SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018

--Câu 10:H?y ðýa ra danh sách các nhân viên v?a nh?p v?a xu?t.

SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv

--Câu 11:H?y ðýa ra danh sách các nhân viên không tham gia vi?c nh?p và xu?t.

SELECT *
FROM Nhanvien
LEFT JOIN Nhap ON Nhanvien.manv = Nhap.manv
LEFT JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Nhap.manv IS NULL AND Xuat.manv IS NULL;
