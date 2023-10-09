use cob_credito
GO

PRINT 'Drop table cr_prelacion_cuenta'
IF OBJECT_ID ('dbo.cr_prelacion_cuenta') IS NOT NULL
	DROP TABLE dbo.cr_prelacion_cuenta
GO

PRINT 'Drop table cr_prelacion_nivel'
IF OBJECT_ID ('dbo.cr_prelacion_nivel') IS NOT NULL
	DROP TABLE dbo.cr_prelacion_nivel
GO

PRINT 'Create table cr_prelacion_nivel'
CREATE TABLE dbo.cr_prelacion_nivel
	(
	pn_nivel     CHAR (2) NOT NULL,
	pn_prioridad TINYINT NOT NULL,
	CONSTRAINT PK_cr_prelacion_nivel PRIMARY KEY (pn_nivel),
	CONSTRAINT IX_cr_prelacion_nivel UNIQUE (pn_prioridad)
	)
GO

PRINT 'Create table cr_prelacion_cuenta'
CREATE TABLE dbo.cr_prelacion_cuenta
	(
	pc_producto    CHAR (2) NOT NULL,
	pc_subproducto CHAR (4) NOT NULL,
	pc_nivel       CHAR (2) NOT NULL,
	CONSTRAINT PK_cr_prelacion_cuenta PRIMARY KEY (pc_producto, pc_subproducto),
	CONSTRAINT FK_cr_prelacion_cuenta_cr_prelacion_nivel FOREIGN KEY (pc_nivel) REFERENCES dbo.cr_prelacion_nivel (pn_nivel)
	)
GO



PRINT 'Inserting data cr_prelacion_nivel'
INSERT INTO cob_credito..cr_prelacion_nivel (pn_prioridad, pn_nivel)
VALUES (10, 'N4')
go

INSERT INTO cob_credito..cr_prelacion_nivel (pn_prioridad, pn_nivel)
VALUES (20, 'N3')
go

INSERT INTO cob_credito..cr_prelacion_nivel (pn_prioridad, pn_nivel)
VALUES (30, 'N2')
go

PRINT 'Inserting data cr_prelacion_cuenta'
INSERT INTO cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel)
VALUES ('01', '0056', 'N4')
go

INSERT INTO cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel)
VALUES ('01', '0055', 'N3')
go

INSERT INTO cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel)
VALUES ('01', '0025', 'N2')
go
