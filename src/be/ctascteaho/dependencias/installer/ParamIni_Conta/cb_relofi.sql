
Use cob_conta
go

IF OBJECT_ID ('dbo.cb_relofi') IS NOT NULL
	DROP TABLE dbo.cb_relofi
GO

CREATE TABLE dbo.cb_relofi
	(
	re_filial  TINYINT NOT NULL,
	re_empresa TINYINT NOT NULL,
	re_ofadmin SMALLINT NOT NULL,
	re_ofconta SMALLINT NOT NULL,
	CONSTRAINT pk_cb_relofi PRIMARY KEY (re_filial,re_empresa,re_ofadmin)
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_relofi_Key
	ON dbo.cb_relofi (re_filial,re_empresa,re_ofadmin)
GO




INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 19, 19)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 28, 28)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 107, 107)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 2001, 2001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 2002, 2002)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3001, 3001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3002, 3002)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3003, 3003)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3007, 3007)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3009, 3009)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 3010, 3010)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4003, 4003)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4005, 4005)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4006, 4006)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4007, 4007)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4008, 4008)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4009, 4009)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4010, 4010)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4011, 4011)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4014, 4014)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4015, 4015)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4016, 4016)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4017, 4017)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4018, 4018)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4019, 4019)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4022, 4022)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4024, 4024)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4025, 4025)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4027, 4027)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4030, 4030)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4031, 4031)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4032, 4032)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4033, 4033)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4034, 4034)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4035, 4035)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4036, 4036)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4040, 4040)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4043, 4043)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4044, 4044)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4045, 4045)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4046, 4046)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4047, 4047)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4049, 4049)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4050, 4050)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4051, 4051)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4053, 4053)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4054, 4054)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4056, 4056)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4057, 4057)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4058, 4058)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4059, 4059)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4060, 4060)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4061, 4061)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4064, 4064)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4065, 4065)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4067, 4067)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4068, 4068)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4069, 4069)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4070, 4070)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4071, 4071)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4072, 4072)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4073, 4073)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4074, 4074)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4075, 4075)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4076, 4076)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4077, 4077)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4078, 4078)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4079, 4079)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4080, 4080)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4081, 4081)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4082, 4082)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4086, 4086)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4087, 4087)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4088, 4088)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4089, 4089)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4100, 4100)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4101, 4101)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4102, 4102)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4103, 4103)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4104, 4104)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4105, 4105)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4106, 4106)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4107, 4107)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4108, 4108)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4109, 4109)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4110, 4110)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4111, 4111)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4112, 4112)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4114, 4114)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4115, 4115)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4116, 4116)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4117, 4117)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4525, 4525)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4551, 4551)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4564, 4564)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4570, 4570)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4571, 4571)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 4670, 4670)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 5000, 5000)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 6001, 6001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 6002, 6002)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 6003, 6003)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 6004, 6004)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 6050, 6050)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7001, 7001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7002, 7002)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7003, 7003)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7004, 7004)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7005, 7005)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7006, 7006)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7007, 7007)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7008, 7008)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7009, 7009)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7010, 7010)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7011, 7011)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7012, 7012)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7013, 7013)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7014, 7014)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7015, 7015)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7016, 7016)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7017, 7017)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7018, 7018)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7019, 7019)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7020, 7020)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7021, 7021)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7022, 7022)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7023, 7023)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7024, 7024)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7025, 7025)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7026, 7026)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7027, 7027)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7028, 7028)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7029, 7029)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7030, 7030)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7031, 7031)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7032, 7032)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7033, 7033)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7034, 7034)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7035, 7035)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7036, 7036)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7037, 7037)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7038, 7038)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7039, 7039)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7040, 7040)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7041, 7041)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7042, 7042)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7043, 7043)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7044, 7044)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7045, 7045)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7046, 7046)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7047, 7047)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7048, 7048)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7049, 7049)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7051, 7051)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7052, 7052)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7053, 7053)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7054, 7054)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7055, 7055)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7056, 7056)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7057, 7057)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7059, 7059)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7060, 7060)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7061, 7061)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7062, 7062)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7064, 7064)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7065, 7065)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7066, 7066)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7067, 7067)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7068, 7068)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7069, 7069)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7070, 7070)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7071, 7071)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7072, 7072)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7073, 7073)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7074, 7074)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7075, 7075)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7076, 7076)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7077, 7077)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7078, 7078)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7079, 7079)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7080, 7080)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7081, 7081)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7082, 7082)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7083, 7083)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7084, 7084)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7085, 7085)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7086, 7086)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7087, 7087)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7088, 7088)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7089, 7089)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7090, 7090)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7091, 7091)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7092, 7092)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7093, 7093)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7100, 7100)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7101, 7101)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7103, 7103)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7104, 7104)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7105, 7005)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7106, 7106)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7107, 7107)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7108, 7108)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7109, 7109)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7110, 7110)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7111, 7111)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7112, 7112)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7113, 7113)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7114, 7114)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7115, 7115)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7116, 7116)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7117, 7117)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7118, 7118)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7119, 7119)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7120, 7120)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7121, 7121)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7122, 7122)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7123, 7123)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7124, 7124)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7125, 7125)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7126, 7126)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7127, 7127)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7128, 7128)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7129, 7129)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7130, 7130)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7131, 7131)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7132, 7132)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7133, 7133)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7134, 7134)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7197, 7197)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7522, 7522)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7527, 7527)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7533, 7533)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7554, 7554)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7560, 7560)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7583, 7583)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7587, 7587)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7617, 7617)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7633, 7633)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7687, 7687)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7733, 7733)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7917, 7917)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7960, 7960)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7976, 7976)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7978, 7978)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7979, 7979)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7982, 7982)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7983, 7983)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7984, 7984)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7985, 7985)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7986, 7986)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7987, 7987)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7988, 7988)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7989, 7989)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7990, 7990)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7991, 7991)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7993, 7993)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7994, 7994)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 7995, 7995)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8000, 8000)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8001, 8001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8002, 8002)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8003, 8003)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8004, 8004)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8005, 8005)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8006, 8006)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8007, 8007)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8008, 8008)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8009, 8009)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8010, 8010)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8011, 8011)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8012, 8012)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8013, 8013)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8014, 8014)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8015, 8015)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8016, 8016)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8017, 8017)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8018, 8018)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8019, 8019)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8020, 8020)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8021, 8021)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8022, 8022)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8024, 8024)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8025, 8025)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8026, 8026)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8027, 8027)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8028, 8028)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8029, 8029)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8030, 8030)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8031, 8031)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8032, 8032)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8033, 8033)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8034, 8034)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8035, 8035)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8036, 8036)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8037, 8037)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8038, 8038)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8039, 8039)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8040, 8040)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8041, 8041)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8042, 8042)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8043, 8043)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8044, 8044)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8045, 8045)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8046, 8046)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8047, 8047)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8048, 8048)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8049, 8049)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8050, 8050)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8051, 8051)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8053, 8053)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8054, 8054)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8055, 8055)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8056, 8056)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8057, 8057)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8058, 8058)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8059, 8059)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8060, 8060)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8061, 8061)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8062, 8062)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8063, 8063)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8064, 8064)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8065, 8065)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8066, 8066)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8067, 8067)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8068, 8068)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8069, 8069)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8070, 8070)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8071, 8071)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8072, 8072)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8073, 8073)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8074, 8074)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8075, 8075)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8076, 8076)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8077, 8077)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8078, 8078)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8079, 8079)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8080, 8080)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8081, 8081)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8082, 8082)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8083, 8083)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8084, 8084)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8085, 8085)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 8999, 8999)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 9001, 9001)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 9901, 9901)
GO

INSERT INTO dbo.cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)
VALUES (1, 1, 9902, 9902)
GO
