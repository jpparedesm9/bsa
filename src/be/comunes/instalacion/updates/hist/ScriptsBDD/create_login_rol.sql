--NOMBRE BASE DEL LOGIN CLOUDSRVC

USE [cob_ahorros]
GO

/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO

/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO



--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

USE  cob_cuentas
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO


--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_conta 
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_remesas 
go 

/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO


use cob_contable 
go
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO


use cob_compensacion
go 

/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO


use cob_conta_his 
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_conta_historico
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO


use cob_conta_super
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_ccontable
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_ahorros_his
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO


use cob_cuentas_his
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_externos 
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_interfase 
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_pfijo 
go 
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_remesas_his 
go 

/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO

use cob_sbancarios 
go 

/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC0] FOR LOGIN [CLOUDSRVC0] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC1] FOR LOGIN [CLOUDSRVC1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC2] FOR LOGIN [CLOUDSRVC2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC3] FOR LOGIN [CLOUDSRVC3] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC4] FOR LOGIN [CLOUDSRVC4] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [CLOUDSRVC0]    Script Date: 02/09/2016 15:29:01 ******/
CREATE USER [CLOUDSRVC5] FOR LOGIN [CLOUDSRVC5] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [REENTRY]    Script Date: 02/09/2016 15:48:05 ******/
CREATE USER [REENTRY] FOR LOGIN [REENTRY] WITH DEFAULT_SCHEMA=[REENTRY]
GO

--Roles 
exec sp_addrolemember  'db_owner',  'CLOUDSRVC0'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC1'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC2'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC3'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC4'
GO
exec sp_addrolemember  'db_owner',  'CLOUDSRVC5'
GO
exec sp_addrolemember  'db_owner',  'REENTRY'
GO






