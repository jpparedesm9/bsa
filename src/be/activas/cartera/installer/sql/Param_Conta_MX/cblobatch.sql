
use cobis 
go 

delete from ba_login_batch
where lb_login = 'admuser'
and   lb_sarta = 2
and   lb_batch in (7001, 7002)
go

delete from ba_login_batch
where lb_login = 'admuser'
and   lb_sarta = 3
and   lb_batch in (
2224, 6080, 6084, 6525, 6811, 6812, 6910, 7003, 7004, 7005, 7006, 7010, 7063, 7065, 7066, 7074, 7099,
7117, 7946, 19070, 21006, 21042, 21043, 21059, 21062, 21089, 21220, 21434, 21439, 21441, 21987, 28534,
28535, 28536, 28537, 28538, 28539, 28540, 28541, 28574, 28605, 28608, 28793)
go

delete from ba_login_batch
where lb_login = 'admuser'
and   lb_sarta = 4
and   lb_batch in (
4011, 4026, 4037, 4053, 4196, 4204, 4232, 4253, 6010, 6017, 6064, 6074, 6085, 6100, 6101, 6110,
6220, 6935, 7000, 7007, 7025, 7067, 7099, 7300, 7898, 14001, 14007, 14048, 14093, 14999, 17001, 28793)
go

delete from ba_login_batch
where lb_login = 'usrbatch'
and   lb_sarta = 2
and   lb_batch in (7001, 7002)
go

delete from ba_login_batch
where lb_login = 'usrbatch'
and   lb_sarta = 3
and   lb_batch in (
2224, 6080, 6084, 6525, 6811, 6812, 6910, 7003, 7004, 7005, 7006, 7010, 7063, 7065, 7066, 7074, 7099,
7117, 7946, 19070, 21006, 21042, 21043, 21059, 21062, 21089, 21220, 21434, 21439, 21441, 21987, 28534,
28535, 28536, 28537, 28538, 28539, 28540, 28541, 28574, 28605, 28608, 28793)
go

delete from ba_login_batch
where lb_login = 'usrbatch'
and   lb_sarta = 4
and   lb_batch in (
4011, 4026, 4037, 4053, 4196, 4204, 4232, 4253, 6010, 6017, 6064, 6074, 6085, 6100, 6101, 6110,
6220, 6935, 7000, 7007, 7025, 7067, 7099, 7300, 7898, 14001, 14007, 14048, 14093, 14999, 17001, 28793)
go


INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 2, 7001, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 2, 7002, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 2224, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6080, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6084, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6525, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6811, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6812, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 6910, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7003, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7004, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7005, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7006, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7010, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7063, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7065, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7066, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7074, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7117, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 7946, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 19070, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21006, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21042, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21043, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21059, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21062, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21089, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21220, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21434, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21439, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21441, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 21987, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28534, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28535, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28536, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28537, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28538, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28539, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28540, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28541, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28574, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28605, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28608, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 3, 28793, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4011, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4026, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4037, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4053, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4196, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4204, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4232, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 4253, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6010, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6017, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6064, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6074, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6085, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6100, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6101, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6110, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6220, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 6935, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 7000, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 7007, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 7025, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 7067, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 7300, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 14001, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 14007, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 14048, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 14093, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 14999, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 17001, getdate(), 'V', 'admuser', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('admuser', 4, 28793, getdate(), 'V', 'admuser', getdate())
GO




INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 2, 7001, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 2, 7002, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 2224, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6080, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6084, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6525, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6811, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6812, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 6910, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7003, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7004, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7005, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7006, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7010, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7063, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7065, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7066, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7074, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7117, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 7946, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 19070, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21006, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21042, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21043, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21059, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21062, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21089, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21220, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21434, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21439, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21441, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 21987, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28534, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28535, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28536, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28537, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28538, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28539, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28540, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28541, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28574, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28605, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28608, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 3, 28793, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4011, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4026, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4037, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4053, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4196, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4204, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4232, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 4253, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6010, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6017, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6064, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6074, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6085, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6100, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6101, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6110, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6220, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 6935, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 7000, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 7007, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 7025, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 7067, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 7300, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 14001, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 14007, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 14048, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 14093, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 14999, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 17001, getdate(), 'V', 'usrbatch', getdate())
GO

INSERT INTO dbo.ba_login_batch (lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
VALUES ('usrbatch', 4, 28793, getdate(), 'V', 'usrbatch', getdate())
GO

------------------------------
delete from ba_login_batch
where lb_login in ('admuser', 'usrbatch')
and   lb_sarta = 12
go

delete from ba_login_batch
where lb_login in ('admuser', 'usrbatch')
and   lb_sarta = 13
go

delete from ba_login_batch
where lb_login in ('admuser', 'usrbatch')
and   lb_sarta = 22
go

---------------------------------
INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'admuser', sb_sarta, sb_batch, getdate(), 'V', 'admuser', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 12
GO

INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'usrbatch', sb_sarta, sb_batch, getdate(), 'V', 'usrbatch', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 12
GO

INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'admuser', sb_sarta, sb_batch, getdate(), 'V', 'admuser', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 13
GO

INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'usrbatch', sb_sarta, sb_batch, getdate(), 'V', 'usrbatch', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 13
GO

INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'admuser', sb_sarta, sb_batch, getdate(), 'V', 'admuser', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 22
GO

INSERT INTO dbo.ba_login_batch 
(lb_login, lb_sarta, lb_batch, lb_fecha_aut, lb_estado, lb_usuario, lb_fecha_ult_mod)
select distinct 'usrbatch', sb_sarta, sb_batch, getdate(), 'V', 'usrbatch', getdate()
from cobis..ba_sarta_batch
where sb_sarta = 22
GO
---------------------------------

