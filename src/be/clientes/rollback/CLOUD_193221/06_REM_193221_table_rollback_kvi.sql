-- ========= REQ 193221- B2B Grupal Digital =========
--Tabla de Registro de Verificacion Correo y Telefono
use cobis
go

if object_id ('dbo.cl_verif_co_tel') is not null
  drop table dbo.cl_verif_co_tel
go


--Tabla Log de Aceptacion
use cobis
go

if object_id ('dbo.cl_log_aceptacion') is not null
  drop table dbo.cl_log_aceptacion
go

