Use cob_conta
go

IF OBJECT_ID ('dbo.cb_jerarquia') IS NOT NULL
	DROP TABLE dbo.cb_jerarquia
GO

CREATE TABLE dbo.cb_jerarquia
	(
	je_empresa       TINYINT NOT NULL,
	je_oficina       SMALLINT NULL,
	je_oficina_padre SMALLINT NULL,
	je_nivel         TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_jerarquia_Key
	ON dbo.cb_jerarquia (je_empresa,je_oficina,je_oficina_padre,je_nivel)
GO

CREATE NONCLUSTERED INDEX cb_jerarquia_2
	ON dbo.cb_jerarquia (je_oficina_padre,je_oficina)
GO



INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 148, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 148, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 148, NULL, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3911, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3911, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3921, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3921, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3931, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3931, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4069, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4069, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4069, NULL, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5000, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5000, NULL, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7088, NULL, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 2, 2, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3, 3, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4, 4, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5, 5, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6, 6, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7, 7, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8, 8, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9, 9, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 10, 10, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 11, 11, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 12, 12, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 13, 13, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 14, 14, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 15, 15, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 16, 16, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 17, 17, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 18, 18, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 19, 19, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 20, 20, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 21, 21, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 22, 22, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 23, 23, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 24, 24, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 25, 25, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 26, 26, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 27, 27, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 28, 28, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 29, 29, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 30, 30, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 31, 31, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 32, 32, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 33, 33, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 34, 34, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 35, 35, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 36, 36, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 37, 37, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 38, 38, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 39, 39, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 40, 40, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 41, 41, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 42, 42, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 43, 43, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 44, 44, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 45, 45, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 46, 46, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 47, 47, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 48, 48, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 49, 49, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 50, 50, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 51, 51, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 52, 52, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 53, 53, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 54, 54, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 55, 55, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 56, 56, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 57, 57, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 58, 58, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 59, 59, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 60, 60, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 61, 61, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 62, 62, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 63, 63, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 64, 64, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 65, 65, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 66, 66, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 67, 67, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 68, 68, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 69, 69, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 70, 70, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 71, 71, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 72, 72, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 73, 73, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 74, 74, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 75, 75, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 76, 76, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 77, 77, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 78, 78, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 79, 79, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 80, 80, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 81, 81, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 82, 82, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 83, 83, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 84, 84, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 85, 85, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 86, 86, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 87, 87, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 88, 88, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 89, 89, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 90, 90, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 91, 91, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 92, 92, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 93, 93, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 94, 94, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 95, 95, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 96, 96, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 97, 97, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 98, 98, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 99, 99, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 100, 100, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 101, 101, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 102, 102, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 103, 103, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 104, 104, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 105, 105, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 106, 106, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 107, 107, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 108, 108, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 109, 109, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 110, 110, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 111, 111, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 112, 112, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 113, 113, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 114, 114, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 115, 115, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 116, 116, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 117, 117, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 118, 118, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 119, 119, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 120, 120, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 121, 121, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 122, 122, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 123, 123, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 124, 124, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 125, 125, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 126, 126, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 127, 127, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 128, 128, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 129, 129, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 130, 130, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 131, 131, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 132, 132, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 133, 133, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 134, 134, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 135, 135, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 136, 136, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 137, 137, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 138, 138, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 139, 139, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 140, 140, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 141, 141, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 142, 142, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 143, 143, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 144, 144, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 145, 145, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 146, 146, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 147, 147, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 148, 148, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 150, 150, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 151, 151, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 152, 152, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 153, 153, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 154, 154, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 155, 155, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 156, 156, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 158, 158, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 159, 159, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 160, 160, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 161, 161, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 162, 162, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 163, 163, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 164, 164, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 165, 165, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 166, 166, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 167, 167, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 168, 168, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 169, 169, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 170, 170, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 171, 171, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 172, 172, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 173, 173, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 174, 174, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 175, 175, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 176, 176, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 177, 177, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 178, 178, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 179, 179, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 180, 180, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 181, 181, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 182, 182, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 183, 183, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 184, 184, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 185, 185, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 186, 186, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 187, 187, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 188, 188, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 190, 190, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 191, 191, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 192, 192, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 193, 193, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 194, 194, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 195, 195, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 196, 196, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 197, 197, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 198, 198, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 199, 199, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 200, 200, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 201, 201, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 204, 204, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 205, 205, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 206, 206, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 207, 207, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 208, 208, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 209, 209, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 210, 210, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 211, 211, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 212, 212, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 213, 213, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 214, 214, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 215, 215, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 216, 216, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 217, 217, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 218, 218, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 219, 219, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 2, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 10, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 11, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 12, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 13, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 14, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 15, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 16, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 17, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 18, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 19, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 20, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 21, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 22, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 23, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 24, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 25, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 26, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 27, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 28, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 29, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 30, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 31, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 32, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 33, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 34, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 35, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 36, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 37, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 38, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 39, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 40, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 41, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 42, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 43, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 44, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 45, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 46, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 47, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 48, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 49, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 50, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 51, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 52, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 53, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 54, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 55, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 56, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 57, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 58, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 59, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 60, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 61, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 62, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 63, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 64, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 65, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 66, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 67, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 68, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 69, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 70, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 71, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 72, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 73, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 74, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 75, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 76, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 77, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 78, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 79, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 80, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 81, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 82, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 83, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 84, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 85, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 86, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 87, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 88, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 89, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 90, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 91, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 92, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 93, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 94, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 95, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 96, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 97, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 98, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 99, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 100, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 101, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 102, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 103, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 104, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 105, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 106, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 107, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 108, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 109, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 110, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 111, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 112, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 113, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 114, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 115, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 116, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 117, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 118, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 119, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 120, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 121, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 122, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 123, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 124, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 125, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 126, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 127, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 128, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 129, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 130, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 131, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 132, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 133, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 134, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 135, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 136, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 137, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 138, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 139, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 140, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 141, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 142, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 143, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 144, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 145, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 146, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 147, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 148, 255, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 150, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 151, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 152, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 153, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 154, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 155, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 156, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 158, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 159, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 160, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 161, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 162, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 163, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 164, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 165, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 166, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 167, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 168, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 169, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 170, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 171, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 172, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 173, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 174, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 175, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 176, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 177, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 178, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 179, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 180, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 181, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 182, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 183, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 184, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 185, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 186, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 187, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 188, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 190, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 191, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 192, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 193, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 194, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 195, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 196, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 197, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 198, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 199, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 200, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 201, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 204, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 205, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 206, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 207, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 208, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 209, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 210, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 211, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 212, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 213, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 214, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 215, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 216, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 217, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 218, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 219, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3911, 255, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3921, 255, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3931, 255, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4003, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4005, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4006, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4007, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4008, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4009, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4010, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4011, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4014, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4015, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4016, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4017, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4018, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4019, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4022, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4024, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4025, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4027, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4030, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4031, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4032, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4033, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4034, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4035, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4036, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4040, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4043, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4044, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4045, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4046, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4047, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4049, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4050, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4051, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4053, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4054, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4056, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4057, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4058, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4059, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4060, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4061, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4064, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4065, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4067, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4068, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4069, 255, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4070, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4071, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4072, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4073, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4074, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4075, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4076, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4077, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4078, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4079, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4080, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4081, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4082, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4086, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4087, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4088, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4089, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4096, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4097, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4098, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4099, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4100, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4101, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4102, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4103, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4104, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4105, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4106, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4107, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4108, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4109, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4110, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4111, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4112, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4113, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4114, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4115, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4116, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4117, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4525, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4551, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4564, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4570, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4571, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4670, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5000, 255, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5001, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6001, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6002, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6003, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6004, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6050, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7001, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7002, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7003, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7004, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7005, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7006, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7007, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7008, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7009, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7010, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7011, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7012, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7013, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7014, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7015, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7016, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7017, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7018, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7019, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7020, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7021, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7022, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7023, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7024, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7025, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7026, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7027, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7028, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7029, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7030, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7031, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7032, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7033, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7034, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7035, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7036, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7037, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7038, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7039, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7040, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7041, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7042, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7043, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7044, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7045, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7046, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7047, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7048, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7049, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7051, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7052, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7053, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7054, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7055, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7056, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7057, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7059, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7060, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7061, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7062, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7064, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7065, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7066, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7067, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7068, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7069, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7070, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7071, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7072, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7073, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7074, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7075, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7076, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7077, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7078, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7079, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7080, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7081, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7082, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7083, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7084, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7085, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7086, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7087, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7088, 255, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7089, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7090, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7091, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7092, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7093, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7094, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7095, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7096, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7097, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7098, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7099, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7100, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7101, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7103, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7104, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7105, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7106, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7107, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7108, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7109, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7110, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7111, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7112, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7113, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7114, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7115, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7116, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7117, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7118, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7119, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7120, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7121, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7122, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7123, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7124, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7125, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7126, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7127, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7128, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7129, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7130, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7131, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7132, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7133, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7134, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7190, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7191, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7192, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7193, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7194, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7195, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7196, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7197, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7522, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7527, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7533, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7554, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7560, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7583, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7587, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7617, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7633, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7687, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7733, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7917, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7960, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7961, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7962, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7976, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7978, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7979, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7982, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7983, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7984, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7985, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7986, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7987, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7988, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7989, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7990, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7991, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7993, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7994, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7995, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8000, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8001, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8002, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8003, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8004, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8005, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8006, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8007, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8008, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8009, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8010, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8011, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8012, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8013, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8014, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8015, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8016, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8017, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8018, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8019, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8020, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8021, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8022, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8023, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8024, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8025, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8026, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8027, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8028, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8029, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8030, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8031, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8032, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8033, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8034, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8035, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8036, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8037, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8038, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8039, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8040, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8041, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8042, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8043, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8044, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8045, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8046, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8047, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8048, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8049, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8050, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8051, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8053, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8054, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8055, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8056, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8057, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8058, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8059, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8060, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8061, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8062, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8063, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8064, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8065, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8066, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8067, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8068, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8069, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8070, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8071, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8072, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8073, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8074, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8075, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8076, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8077, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8078, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8079, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8080, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8081, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8082, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8083, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8084, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8085, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8086, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8087, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8999, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9001, 255, 1)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 40, 1001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 47, 1001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 112, 1001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 2, 1002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3, 1002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4, 1002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 38, 1002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 39, 1002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 60, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 61, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 62, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 63, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 94, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 95, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 96, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 97, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 98, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 99, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 115, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 128, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 137, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 140, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 144, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 159, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 161, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 165, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 166, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 169, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 186, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 194, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 195, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 204, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 218, 1003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9, 1004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 10, 1004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 11, 1004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 12, 1004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 163, 1004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 15, 1007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 14, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 16, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 17, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 18, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 19, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 20, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 21, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 42, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 43, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 64, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 74, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 75, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 77, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 78, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 79, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 80, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 100, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 117, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 122, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 124, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 126, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 141, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 150, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 160, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 162, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 164, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 167, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 177, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 184, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 185, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 187, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 188, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 192, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 201, 1008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 22, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 23, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 24, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 25, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 33, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 68, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 69, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 70, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 71, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 72, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 73, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 103, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 104, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 105, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 107, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 119, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 123, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 136, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 139, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 173, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 179, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 217, 1009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 26, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 27, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 28, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 29, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 44, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 65, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 66, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 67, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 101, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 102, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 108, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 111, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 116, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 130, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 132, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 143, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 147, 1010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 13, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 31, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 32, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 34, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 35, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 36, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 37, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 41, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 48, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 49, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 50, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 51, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 52, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 53, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 54, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 55, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 56, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 57, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 58, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 59, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 81, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 82, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 83, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 84, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 85, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 86, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 87, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 88, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 89, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 90, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 91, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 92, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 93, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 113, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 114, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 118, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 120, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 121, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 129, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 131, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 134, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 135, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 138, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 145, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 146, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 151, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 153, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 154, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 155, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 156, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 168, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 170, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 171, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 175, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 176, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 178, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 182, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 183, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 196, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 197, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 198, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 199, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 205, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 212, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 213, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 214, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 216, 1011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 45, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 46, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 76, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 106, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 125, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 127, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 133, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 142, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 152, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 158, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 172, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 174, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 180, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 181, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 215, 1013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 30, 1017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 190, 1017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 191, 1017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 200, 1017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 109, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 110, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 193, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 206, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 207, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 208, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 209, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 210, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 211, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 219, 1018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 2, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 10, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 11, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 12, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 30, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 38, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 39, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 40, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 47, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 60, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 61, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 62, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 63, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 94, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 95, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 96, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 97, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 98, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 99, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 109, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 110, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 112, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 115, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 128, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 137, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 140, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 144, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 159, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 161, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 163, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 165, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 166, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 169, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 186, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 190, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 191, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 193, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 194, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 195, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 200, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 204, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 206, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 207, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 208, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 209, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 210, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 211, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 218, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 219, 1901, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 13, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 14, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 15, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 16, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 17, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 18, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 19, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 20, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 21, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 22, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 23, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 24, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 25, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 26, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 27, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 28, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 29, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 31, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 32, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 33, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 34, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 35, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 36, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 37, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 41, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 42, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 43, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 44, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 45, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 46, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 48, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 49, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 50, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 51, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 52, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 53, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 54, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 55, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 56, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 57, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 58, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 59, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 64, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 65, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 66, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 67, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 68, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 69, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 70, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 71, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 72, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 73, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 74, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 75, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 76, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 77, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 78, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 79, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 80, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 81, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 82, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 83, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 84, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 85, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 86, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 87, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 88, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 89, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 90, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 91, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 92, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 93, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 100, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 101, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 102, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 103, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 104, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 105, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 106, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 107, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 108, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 111, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 113, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 114, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 116, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 117, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 118, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 119, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 120, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 121, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 122, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 123, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 124, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 125, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 126, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 127, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 129, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 130, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 131, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 132, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 133, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 134, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 135, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 136, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 138, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 139, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 141, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 142, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 143, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 145, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 146, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 147, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 150, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 151, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 152, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 153, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 154, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 155, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 156, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 158, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 160, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 162, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 164, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 167, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 168, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 170, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 171, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 172, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 173, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 174, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 175, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 176, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 177, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 178, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 179, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 180, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 181, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 182, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 183, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 184, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 185, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 187, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 188, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 192, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 196, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 197, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 198, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 199, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 201, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 205, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 212, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 213, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 214, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 215, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 216, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 217, 1902, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3921, 2001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4117, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7001, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7002, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7003, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7004, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7005, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7006, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7008, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7009, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7010, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7011, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7012, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7016, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7017, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7018, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7019, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7020, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7021, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7023, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7024, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7025, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7027, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7028, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7029, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7030, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7031, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7033, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7034, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7037, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7038, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7039, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7040, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7041, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7044, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7046, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7047, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7051, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7052, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7054, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7056, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7059, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7060, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7061, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7062, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7064, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7066, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7067, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7068, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7069, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7070, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7071, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7072, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7073, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7074, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7075, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7076, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7077, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7079, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7081, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7085, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7086, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7087, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7088, 2001, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7089, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7091, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7092, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7093, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7097, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7098, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7099, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7103, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7106, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7107, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7108, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7109, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7110, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7111, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7114, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7115, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7116, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7117, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7118, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7119, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7120, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7124, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7125, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7131, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7132, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7133, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7134, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7191, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7193, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7197, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7527, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7533, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7554, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7560, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7587, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7617, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7633, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7687, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7733, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7917, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7961, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7962, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7976, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7979, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7985, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7986, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7987, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7990, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7991, 2001, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3911, 2002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4003, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4005, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4006, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4007, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4009, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4010, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4011, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4014, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4015, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4016, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4017, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4018, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4019, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4022, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4024, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4025, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4030, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4031, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4032, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4033, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4034, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4035, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4036, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4040, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4043, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4044, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4045, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4046, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4047, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4049, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4050, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4051, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4053, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4054, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4056, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4057, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4058, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4059, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4060, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4061, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4064, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4065, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4067, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4068, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4070, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4071, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4072, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4073, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4074, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4075, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4076, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4077, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4078, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4079, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4081, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4088, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4089, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4097, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4098, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4099, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4100, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4101, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4102, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4103, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4104, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4106, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4108, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4109, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4110, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4111, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4112, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4113, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4114, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4115, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4116, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4525, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4551, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4564, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4570, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4571, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4670, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5000, 2002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7013, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7014, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7022, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7048, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7049, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7057, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7065, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7078, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7082, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7083, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7084, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7090, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7095, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7101, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7104, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7113, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7126, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7127, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7192, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7195, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7978, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7982, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7983, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7984, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7993, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7994, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7995, 2002, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5001, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6001, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6002, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6003, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6004, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6050, 2004, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9001, 2005, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7043, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7053, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7055, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8000, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8001, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8002, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8003, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8004, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8005, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8006, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8007, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8008, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8009, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8010, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8011, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8012, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8013, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8014, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8015, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8016, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8017, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8018, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8019, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8020, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8021, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8022, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8023, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8024, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8025, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8026, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8027, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8028, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8029, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8030, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8031, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8032, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8033, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8034, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8035, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8036, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8037, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8038, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8039, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8040, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8041, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8042, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8043, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8044, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8045, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8046, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8047, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8048, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8049, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8050, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8051, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8053, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8054, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8055, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8056, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8057, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8058, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8059, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8060, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8061, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8062, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8063, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8064, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8065, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8066, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8067, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8068, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8069, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8070, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8071, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8072, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8073, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8074, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8075, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8076, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8077, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8078, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8079, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8081, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8082, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8083, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8084, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8085, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8086, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8087, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8999, 2007, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3931, 2008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4008, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4027, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4080, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4082, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4086, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4087, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4096, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4105, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4107, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7007, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7015, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7026, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7032, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7035, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7036, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7042, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7045, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7080, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7094, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7096, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7100, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7105, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7112, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7121, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7122, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7123, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7128, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7129, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7130, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7190, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7194, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7196, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7522, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7583, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7960, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7988, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7989, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8080, 2008, 2)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4003, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4017, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4019, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4022, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4043, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4045, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4049, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4051, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4054, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4056, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4057, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4058, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4068, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4075, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4099, 3001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4005, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4015, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4030, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4031, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4032, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4033, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4035, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4040, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4044, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4046, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4047, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4050, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4061, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4065, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4074, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4098, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4103, 3002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4010, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4018, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4024, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4025, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4034, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4060, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4064, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4067, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4097, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4111, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4116, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4525, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4551, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4564, 3003, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4071, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4096, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4105, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4112, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4113, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4571, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7022, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7036, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7078, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7082, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7083, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7084, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7522, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7583, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7978, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7982, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7983, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7984, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7989, 3004, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7003, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7016, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7040, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7064, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7087, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7103, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7120, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7125, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7191, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7687, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7733, 3005, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4007, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4009, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4079, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4081, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4088, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4100, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4101, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4102, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4108, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4109, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4115, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7014, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7192, 3006, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4117, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7020, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7027, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7046, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7086, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7099, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7132, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7133, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7134, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7527, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7587, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7986, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7987, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7991, 3007, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7190, 3008, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7001, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7008, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7019, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7021, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7025, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7038, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7041, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7044, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7052, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7056, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7059, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7066, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7067, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7070, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7098, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7108, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7109, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7124, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7131, 3009, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7002, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7004, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7006, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7010, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7012, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7028, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7029, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7030, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7031, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7039, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7047, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7051, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7068, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7069, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7085, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7097, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7110, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7111, 3010, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7011, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7023, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7024, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7032, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7037, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7071, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7072, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7073, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7074, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7075, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7080, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7081, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7091, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7092, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7093, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7096, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7100, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7107, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7118, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7119, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7121, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7123, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7129, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7130, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8080, 3011, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4011, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4014, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4036, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4053, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4059, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4070, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4072, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4089, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4106, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4110, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4570, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4670, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7095, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7995, 3012, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7005, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7007, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7009, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7042, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7061, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7076, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7079, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7089, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7094, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7105, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7115, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7116, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7122, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7128, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7917, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7960, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7961, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7962, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7976, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7979, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7988, 3013, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8000, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8011, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8015, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8019, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8038, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8058, 3014, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8001, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8002, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8003, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8004, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8010, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8018, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8021, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8024, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8032, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8033, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8057, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8061, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8062, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8068, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8069, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8070, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8073, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8074, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8087, 3015, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8005, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8017, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8029, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8030, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8042, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8048, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8081, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8082, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8084, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8085, 3016, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8006, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8008, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8009, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8012, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8025, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8027, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8037, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8049, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8051, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8059, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8071, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8077, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8079, 3017, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8007, 3018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8039, 3018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8067, 3018, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8013, 3019, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8014, 3020, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8999, 3020, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8016, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8022, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8026, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8031, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8036, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8045, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8047, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8054, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8083, 3021, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8020, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8060, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8064, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8065, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8066, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8076, 3022, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7017, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7018, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7034, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7077, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7106, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7114, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7193, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7617, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7990, 3023, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4086, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7013, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7015, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7026, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7035, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7065, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7090, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7101, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7104, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7113, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7126, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7127, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7194, 3024, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7053, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7055, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8023, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8050, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8063, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8075, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8078, 3025, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8028, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8040, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8041, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8043, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8044, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8046, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8072, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8086, 3026, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7043, 3027, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8034, 3027, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8035, 3028, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8055, 3028, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8056, 3028, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8053, 3029, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4006, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4016, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4073, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4076, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4077, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4078, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4104, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4114, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7048, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7049, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7057, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7195, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7993, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7994, 3031, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4008, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4027, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4080, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4082, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4087, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4107, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7045, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7112, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7196, 3032, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7033, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7054, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7060, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7062, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7117, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7197, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7533, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7554, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7560, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7633, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7985, 3033, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3911, 3911, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3921, 3921, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3931, 3931, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4003, 4003, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4005, 4005, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4006, 4006, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4007, 4007, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4008, 4008, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4009, 4009, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4010, 4010, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4011, 4011, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4014, 4014, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4015, 4015, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4016, 4016, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4017, 4017, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4018, 4018, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4019, 4019, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4022, 4022, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4024, 4024, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4025, 4025, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4027, 4027, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4030, 4030, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4031, 4031, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4032, 4032, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4033, 4033, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4034, 4034, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4035, 4035, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4036, 4036, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4040, 4040, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4043, 4043, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4044, 4044, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4045, 4045, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4046, 4046, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4047, 4047, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4049, 4049, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4050, 4050, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4051, 4051, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4053, 4053, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4054, 4054, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4056, 4056, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4057, 4057, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4058, 4058, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4059, 4059, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4060, 4060, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4061, 4061, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4064, 4064, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4065, 4065, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4067, 4067, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4068, 4068, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4069, 4069, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4070, 4070, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4071, 4071, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4072, 4072, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4073, 4073, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4074, 4074, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4075, 4075, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4076, 4076, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4077, 4077, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4078, 4078, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4079, 4079, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4080, 4080, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4081, 4081, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4082, 4082, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4086, 4086, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4087, 4087, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4088, 4088, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4089, 4089, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4096, 4096, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4097, 4097, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4098, 4098, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4099, 4099, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4100, 4100, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4101, 4101, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4102, 4102, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4103, 4103, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4104, 4104, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4105, 4105, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4106, 4106, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4107, 4107, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4108, 4108, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4109, 4109, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4110, 4110, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4111, 4111, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4112, 4112, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4113, 4113, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4114, 4114, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4115, 4115, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4116, 4116, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4117, 4117, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4525, 4525, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4551, 4551, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4564, 4564, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4570, 4570, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4571, 4571, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4670, 4670, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5000, 5000, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5001, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6001, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6002, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6003, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6004, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6050, 5001, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9001, 5002, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6001, 6001, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6002, 6002, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6003, 6003, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6004, 6004, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6050, 6050, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7001, 7001, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7002, 7002, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7003, 7003, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7004, 7004, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7005, 7005, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7006, 7006, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7007, 7007, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7008, 7008, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7009, 7009, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7010, 7010, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7011, 7011, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7012, 7012, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7013, 7013, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7014, 7014, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7015, 7015, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7016, 7016, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7017, 7017, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7018, 7018, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7019, 7019, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7020, 7020, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7021, 7021, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7022, 7022, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7023, 7023, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7024, 7024, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7025, 7025, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7026, 7026, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7027, 7027, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7028, 7028, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7029, 7029, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7030, 7030, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7031, 7031, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7032, 7032, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7033, 7033, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7034, 7034, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7035, 7035, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7036, 7036, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7037, 7037, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7038, 7038, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7039, 7039, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7040, 7040, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7041, 7041, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7042, 7042, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7043, 7043, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7044, 7044, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7045, 7045, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7046, 7046, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7047, 7047, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7048, 7048, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7049, 7049, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7051, 7051, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7052, 7052, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7053, 7053, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7054, 7054, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7055, 7055, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7056, 7056, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7057, 7057, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7059, 7059, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7060, 7060, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7061, 7061, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7062, 7062, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7064, 7064, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7065, 7065, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7066, 7066, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7067, 7067, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7068, 7068, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7069, 7069, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7070, 7070, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7071, 7071, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7072, 7072, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7073, 7073, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7074, 7074, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7075, 7075, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7076, 7076, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7077, 7077, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7078, 7078, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7079, 7079, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7080, 7080, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7081, 7081, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7082, 7082, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7083, 7083, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7084, 7084, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7085, 7085, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7086, 7086, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7087, 7087, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7088, 7088, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7089, 7089, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7090, 7090, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7091, 7091, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7092, 7092, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7093, 7093, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7094, 7094, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7095, 7095, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7096, 7096, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7097, 7097, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7098, 7098, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7099, 7099, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7100, 7100, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7101, 7101, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7103, 7103, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7104, 7104, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7105, 7105, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7106, 7106, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7107, 7107, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7108, 7108, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7109, 7109, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7110, 7110, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7111, 7111, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7112, 7112, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7113, 7113, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7114, 7114, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7115, 7115, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7116, 7116, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7117, 7117, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7118, 7118, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7119, 7119, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7120, 7120, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7121, 7121, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7122, 7122, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7123, 7123, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7124, 7124, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7125, 7125, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7126, 7126, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7127, 7127, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7128, 7128, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7129, 7129, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7130, 7130, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7131, 7131, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7132, 7132, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7133, 7133, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7134, 7134, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7190, 7190, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7191, 7191, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7192, 7192, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7193, 7193, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7194, 7194, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7195, 7195, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7196, 7196, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7197, 7197, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7522, 7522, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7527, 7527, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7533, 7533, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7554, 7554, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7560, 7560, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7583, 7583, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7587, 7587, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7617, 7617, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7633, 7633, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7687, 7687, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7733, 7733, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7917, 7917, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7960, 7960, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7961, 7961, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7962, 7962, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7976, 7976, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7978, 7978, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7979, 7979, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7982, 7982, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7983, 7983, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7984, 7984, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7985, 7985, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7986, 7986, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7987, 7987, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7988, 7988, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7989, 7989, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7990, 7990, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7991, 7991, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7993, 7993, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7994, 7994, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7995, 7995, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8000, 8000, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8001, 8001, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8002, 8002, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8003, 8003, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8004, 8004, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8005, 8005, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8006, 8006, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8007, 8007, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8008, 8008, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8009, 8009, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8010, 8010, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8011, 8011, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8012, 8012, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8013, 8013, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8014, 8014, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8015, 8015, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8016, 8016, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8017, 8017, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8018, 8018, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8019, 8019, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8020, 8020, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8021, 8021, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8022, 8022, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8023, 8023, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8024, 8024, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8025, 8025, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8026, 8026, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8027, 8027, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8028, 8028, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8029, 8029, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8030, 8030, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8031, 8031, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8032, 8032, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8033, 8033, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8034, 8034, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8035, 8035, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8036, 8036, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8037, 8037, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8038, 8038, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8039, 8039, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8040, 8040, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8041, 8041, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8042, 8042, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8043, 8043, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8044, 8044, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8045, 8045, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8046, 8046, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8047, 8047, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8048, 8048, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8049, 8049, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8050, 8050, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8051, 8051, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8053, 8053, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8054, 8054, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8055, 8055, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8056, 8056, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8057, 8057, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8058, 8058, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8059, 8059, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8060, 8060, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8061, 8061, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8062, 8062, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8063, 8063, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8064, 8064, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8065, 8065, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8066, 8066, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8067, 8067, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8068, 8068, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8069, 8069, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8070, 8070, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8071, 8071, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8072, 8072, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8073, 8073, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8074, 8074, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8075, 8075, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8076, 8076, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8077, 8077, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8078, 8078, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8079, 8079, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8080, 8080, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8081, 8081, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8082, 8082, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8083, 8083, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8084, 8084, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8085, 8085, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8086, 8086, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8087, 8087, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8999, 8999, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9001, 9001, 5)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7043, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7053, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7055, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8000, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8001, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8002, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8003, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8004, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8005, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8006, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8007, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8008, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8009, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8010, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8011, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8012, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8013, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8014, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8015, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8016, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8017, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8018, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8019, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8020, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8021, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8022, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8023, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8024, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8025, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8026, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8027, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8028, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8029, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8030, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8031, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8032, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8033, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8034, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8035, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8036, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8037, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8038, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8039, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8040, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8041, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8042, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8043, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8044, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8045, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8046, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8047, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8048, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8049, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8050, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8051, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8053, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8054, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8055, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8056, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8057, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8058, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8059, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8060, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8061, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8062, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8063, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8064, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8065, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8066, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8067, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8068, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8069, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8070, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8071, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8072, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8073, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8074, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8075, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8076, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8077, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8078, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8079, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8081, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8082, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8083, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8084, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8085, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8086, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8087, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8999, 9007, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 2, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 3, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 10, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 11, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 12, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 30, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 38, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 39, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 40, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 47, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 60, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 61, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 62, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 63, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 94, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 95, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 96, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 97, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 98, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 99, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 109, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 110, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 112, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 115, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 128, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 137, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 140, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 144, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 159, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 161, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 163, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 165, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 166, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 169, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 186, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 190, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 191, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 193, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 194, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 195, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 200, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 204, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 206, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 207, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 208, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 209, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 210, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 211, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 218, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 219, 9801, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 13, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 14, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 15, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 16, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 17, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 18, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 19, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 20, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 21, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 22, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 23, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 24, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 25, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 26, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 27, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 28, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 29, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 31, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 32, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 33, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 34, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 35, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 36, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 37, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 41, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 42, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 43, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 44, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 45, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 46, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 48, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 49, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 50, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 51, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 52, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 53, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 54, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 55, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 56, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 57, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 58, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 59, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 64, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 65, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 66, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 67, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 68, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 69, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 70, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 71, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 72, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 73, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 74, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 75, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 76, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 77, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 78, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 79, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 80, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 81, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 82, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 83, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 84, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 85, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 86, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 87, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 88, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 89, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 90, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 91, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 92, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 93, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 100, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 101, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 102, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 103, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 104, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 105, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 106, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 107, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 108, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 111, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 113, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 114, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 116, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 117, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 118, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 119, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 120, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 121, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 122, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 123, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 124, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 125, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 126, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 127, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 129, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 130, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 131, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 132, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 133, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 134, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 135, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 136, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 138, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 139, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 141, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 142, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 143, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 145, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 146, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 147, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 150, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 151, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 152, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 153, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 154, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 155, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 156, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 158, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 160, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 162, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 164, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 167, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 168, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 170, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 171, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 172, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 173, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 174, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 175, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 176, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 177, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 178, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 179, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 180, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 181, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 182, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 183, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 184, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 185, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 187, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 188, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 192, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 196, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 197, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 198, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 199, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 201, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 205, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 212, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 213, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 214, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 215, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 216, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 217, 9802, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4117, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7001, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7002, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7003, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7004, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7005, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7006, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7008, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7009, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7010, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7011, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7012, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7016, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7017, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7018, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7019, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7020, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7021, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7023, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7024, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7025, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7027, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7028, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7029, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7030, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7031, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7033, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7034, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7037, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7038, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7039, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7040, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7041, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7044, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7046, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7047, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7051, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7052, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7054, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7056, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7059, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7060, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7061, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7062, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7064, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7066, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7067, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7068, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7069, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7070, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7071, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7072, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7073, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7074, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7075, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7076, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7077, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7079, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7081, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7085, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7086, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7087, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7088, 9901, 4)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7089, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7091, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7092, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7093, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7097, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7098, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7099, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7103, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7106, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7107, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7108, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7109, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7110, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7111, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7114, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7115, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7116, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7117, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7118, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7119, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7120, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7124, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7125, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7131, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7132, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7133, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7134, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7191, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7193, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7197, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7527, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7533, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7554, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7560, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7587, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7617, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7633, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7687, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7733, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7917, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7961, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7962, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7976, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7979, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7985, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7986, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7987, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7990, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7991, 9901, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4003, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4005, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4006, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4007, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4009, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4010, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4011, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4014, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4015, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4016, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4017, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4018, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4019, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4022, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4024, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4025, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4030, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4031, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4032, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4033, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4034, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4035, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4036, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4040, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4043, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4044, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4045, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4046, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4047, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4049, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4050, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4051, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4053, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4054, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4056, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4057, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4058, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4059, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4060, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4061, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4064, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4065, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4067, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4068, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4070, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4071, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4072, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4073, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4074, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4075, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4076, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4077, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4078, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4079, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4081, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4088, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4089, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4097, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4098, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4099, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4100, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4101, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4102, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4103, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4104, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4106, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4108, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4109, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4110, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4111, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4112, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4113, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4114, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4115, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4116, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4525, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4551, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4564, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4570, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4571, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4670, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7013, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7014, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7022, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7048, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7049, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7057, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7065, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7078, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7082, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7083, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7084, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7090, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7095, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7101, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7104, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7113, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7126, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7127, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7192, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7195, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7978, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7982, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7983, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7984, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7993, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7994, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7995, 9902, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 5001, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6001, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6002, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6003, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6004, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 6050, 9904, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 9001, 9905, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4008, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4027, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4080, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4082, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4086, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4087, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4096, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4105, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 4107, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7007, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7015, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7026, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7032, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7035, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7036, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7042, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7045, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7080, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7094, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7096, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7100, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7105, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7112, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7121, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7122, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7123, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7128, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7129, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7130, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7190, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7194, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7196, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7522, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7583, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7960, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7988, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 7989, 9907, 3)
GO

INSERT INTO dbo.cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)
VALUES (1, 8080, 9907, 3)
GO

