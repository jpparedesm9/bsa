
--cob_externos
use cob_externos
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_externos..ex_dato_operacion'))
begin
   ALTER TABLE cob_externos..ex_dato_operacion
   DROP do_banco_padre 
end
go


--cob_conta_super
use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion'))
begin
   ALTER TABLE cob_conta_super..sb_dato_operacion
   DROP do_banco_padre 
end
go

use cob_conta_super
go

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion_tmp'))
begin
   ALTER TABLE cob_conta_super..sb_dato_operacion_tmp
   drop do_banco_padre 
end
go


use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'INDICADOR DE REUNION'
                  AND object_id = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin

   ALTER TABLE cob_conta_super..sb_reporte_operativo
   drop [INDICADOR DE REUNION] 
end
go


use cob_conta_super
go

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'COORDENADAS NEGOCIO'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin
   ALTER TABLE cob_conta_super..sb_reporte_operativo
   drop [COORDENADAS NEGOCIO] 
end
go


use cob_conta_super
go

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'NRO OPERACION GRUPAL'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin
   ALTER TABLE cob_conta_super..sb_reporte_operativo
   drop [NRO OPERACION GRUPAL]  
end
go


use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go

use cobis
go

delete from cobis..ba_batch 
where ba_batch = 287931

go

use cobis
go
delete from cobis..cl_parametro
where  pa_nemonico='MECMC' and    pa_producto='REC'

delete  from cobis..cl_errores
where numero in (3600002,3600003)

go