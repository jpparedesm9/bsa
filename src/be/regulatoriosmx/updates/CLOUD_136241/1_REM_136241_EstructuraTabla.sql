use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_ods01_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tti
GO
CREATE TABLE dbo.sb_ods01_tti
	(
	campo01 VARCHAR (50) NULL,
	campo02 VARCHAR (50) NULL,
	campo03 VARCHAR (50) NULL,
	campo04 VARCHAR (50) NULL,
	campo05 VARCHAR (50) NULL,
	campo06 VARCHAR (50) NULL,
	campo07 VARCHAR (50) NULL,
	campo08 VARCHAR (50) NULL,
	campo09 VARCHAR (50) NULL,
	campo10 VARCHAR (50) NULL,
	campo11 VARCHAR (50) NULL,
	campo12 VARCHAR (50) NULL,
	campo13 VARCHAR (50) NULL,
	campo14 VARCHAR (50) NULL,
	campo15 VARCHAR (50) NULL,
	campo16 VARCHAR (50) NULL,
	campo17 VARCHAR (50) NULL,
	campo18 VARCHAR (50) NULL,
	campo19 VARCHAR (50) NULL,
	campo20 VARCHAR (50) NULL,
	campo21 VARCHAR (50) NULL,
	campo22 VARCHAR (50) NULL,
	campo23 VARCHAR (50) NULL,
	campo24 VARCHAR (50) NULL,
	campo25 VARCHAR (50) NULL,
	campo26 VARCHAR (50) NULL,
	campo27 VARCHAR (50) NULL,
	campo28 VARCHAR (50) NULL,
	campo29 VARCHAR (50) NULL,
    campo30 VARCHAR (50) NULL,
	campo31 VARCHAR (50) NULL,
	campo32 VARCHAR (50) NULL,
	campo33 VARCHAR (50) NULL,
	campo34 VARCHAR (50) NULL,
	campo35 VARCHAR (50) NULL,
	campo36 VARCHAR (50) NULL,
	campo37 VARCHAR (50) NULL,
	campo38 VARCHAR (50) NULL,
	campo39 VARCHAR (50) NULL,
	campo40 VARCHAR (50) NULL
	)
GO