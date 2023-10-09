Use cob_conta
go

IF OBJECT_ID ('dbo.cb_jerararea') IS NOT NULL
	DROP TABLE dbo.cb_jerararea
GO

CREATE TABLE dbo.cb_jerararea
	(
	ja_empresa    TINYINT NOT NULL,
	ja_area       SMALLINT NULL,
	ja_area_padre SMALLINT NULL,
	ja_nivel      TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_jerararea_Key
	ON dbo.cb_jerararea (ja_empresa,ja_area,ja_area_padre,ja_nivel)
GO

CREATE NONCLUSTERED INDEX cb_jerararea_2
	ON dbo.cb_jerararea (ja_area_padre,ja_area)
GO



INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 34, NULL, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 1, 1, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 2, 2, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 3, 3, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 4, 4, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 5, 5, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 6, 6, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 7, 7, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 8, 8, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 9, 9, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 10, 10, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 11, 11, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 12, 12, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 13, 13, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 14, 14, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 15, 15, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 16, 16, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 17, 17, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 18, 18, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 19, 19, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 20, 20, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 21, 21, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 22, 22, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 23, 23, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 24, 24, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 25, 25, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 26, 26, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 27, 27, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 28, 28, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 29, 29, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 30, 30, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 31, 31, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 32, 32, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 33, 33, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 34, 34, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 35, 35, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 36, 36, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 37, 37, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 46, 46, 3)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 1, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 2, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 3, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 4, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 5, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 6, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 7, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 8, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 9, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 10, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 11, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 12, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 13, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 14, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 15, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 16, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 17, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 18, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 19, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 20, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 21, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 22, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 23, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 24, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 25, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 26, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 27, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 28, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 29, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 30, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 31, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 32, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 33, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 34, 255, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 35, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 36, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 37, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 46, 255, 1)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 1, 1001, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 2, 1002, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 3, 1002, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 4, 1002, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 5, 1003, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 6, 1003, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 7, 1003, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 8, 1003, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 9, 1004, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 10, 1004, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 11, 1004, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 12, 1004, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 13, 1005, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 46, 1005, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 14, 1006, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 15, 1007, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 16, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 17, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 18, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 19, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 20, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 21, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 37, 1008, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 22, 1009, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 23, 1009, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 24, 1009, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 25, 1009, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 26, 1010, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 27, 1010, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 28, 1010, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 29, 1010, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 30, 1010, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 31, 1011, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 32, 1011, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 33, 1011, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 35, 1011, 2)
GO

INSERT INTO dbo.cb_jerararea (ja_empresa, ja_area, ja_area_padre, ja_nivel)
VALUES (1, 36, 1011, 2)
GO

