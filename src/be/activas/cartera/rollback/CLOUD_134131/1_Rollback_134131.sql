USE cob_cartera
GO

if object_id ('dbo.ca_cobranza_batch') is not null
	drop table dbo.ca_cobranza_batch
go

USE cob_credito
go

if object_id ('dbo.cr_buro_diario') is not null
	drop table dbo.cr_buro_diario
go

USE cobis
GO

if object_id ('dbo.cl_ingresos_sistema') is not null
	drop table dbo.cl_ingresos_sistema
go

---------------------
--CREACION DEL BATCH
---------------------
USE cobis
GO

declare @w_server           varchar(24),
        @w_path_fuente_CCA  varchar(255),
        @w_path_destino_CCA varchar(255),
        @w_path_fuente_CLI  varchar(255),
        @w_path_destino_CLI varchar(255),
        @w_path_fuente_CRE  varchar(255),
        @w_path_destino_CRE varchar(255)

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_CCA  = pp_path_fuente, 
       @w_path_destino_CCA = pp_path_destino
from ba_path_pro
where pp_producto = 7

select @w_path_fuente_CLI  = pp_path_fuente, 
       @w_path_destino_CLI = pp_path_destino
from ba_path_pro
where pp_producto = 2

select @w_path_fuente_CRE  = pp_path_fuente, 
       @w_path_destino_CRE = pp_path_destino
from ba_path_pro
where pp_producto = 21


--BATCH
--7592
if exists (select 1 from ba_batch where ba_batch =  7592 and ba_nombre = 'REPORTE COBRANZAS DIARIO' )
begin
   delete ba_batch where ba_batch =  7592 and ba_nombre = 'REPORTE COBRANZAS DIARIO'
end

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 7592)
begin
   delete  ba_parametro where pa_batch = 7592
end


--21008
if exists (select 1 from ba_batch where ba_batch =  21008 and ba_nombre = 'REPORTE DE BURO DIARIO' )
begin
   delete ba_batch where ba_batch =  21008 and ba_nombre = 'REPORTE DE BURO DIARIO'
end

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 21008)
begin
   delete  ba_parametro where pa_batch = 21008
end


--2044
if exists (select 1 from ba_batch where ba_batch =  2044 and ba_nombre = 'REPORTE INGRESOS AL SISTEMA' )
begin
   delete ba_batch where ba_batch =  2044 and ba_nombre = 'REPORTE INGRESOS AL SISTEMA'
end

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 2044)
begin
   delete  ba_parametro where pa_batch = 2044
end
 
go


--ERRORES
if exists (select 1 from cl_errores where numero =  17048 )
begin
   delete cl_errores where numero =  17048
END

if exists (select 1 from cl_errores where numero =  17049)
begin
   delete cl_errores where numero =  17049
END

if exists (select 1 from cl_errores where numero =  17050)
begin
   delete cl_errores where numero =  17050
END
GO


