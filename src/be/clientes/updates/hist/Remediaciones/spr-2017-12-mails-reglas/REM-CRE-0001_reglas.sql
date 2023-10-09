/***********************************************************************/
--No Bug:
--Título del Bug: crear campos en tabla tramite grupal
--Fecha:2017-06-21
--Descripción del Problema:
--crear nuevo campo para control de reglas de grupales
--Descripción de la Solución: crear campos
--Autor:LGU
/***********************************************************************/

use cob_credito
go

--tg_incremento
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'cr_tramite_grupal'
          and   obj.id = col.id
          and   col.name = 'tg_incremento')
begin
alter table cob_credito..cr_tramite_grupal
   add tg_incremento numeric(8,4) NULL
end
go
--tg_monto_ult_op
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'cr_tramite_grupal'
          and   obj.id = col.id
          and   col.name = 'tg_monto_ult_op')
begin
alter table cob_credito..cr_tramite_grupal
   add tg_monto_ult_op money NULL
end
go
--tg_monto_max_calc
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'cr_tramite_grupal'
          and   obj.id = col.id
          and   col.name = 'tg_monto_max_calc')
begin
alter table cob_credito..cr_tramite_grupal
   add tg_monto_max_calc MONEY NULL
end
go



USE cob_workflow
GO

DECLARE @w_sec INT
select @w_sec = 0
select @w_sec = max(vb_codigo_variable)
from cob_workflow..wf_variable

select @w_sec = @w_sec  + 1

IF NOT EXISTS (select 1 from cob_workflow..wf_variable where vb_abrev_variable     = 'CLINROCLIN')
INSERT INTO wf_variable (vb_codigo_variable, vb_nombre_variable, vb_abrev_variable, vb_desc_variable, vb_tipo_datos, vb_val_variable, vb_id_programa, vb_type, vb_subType, vb_catalogo, vb_expresion_validacion, vb_seudo_catalogo, vb_value_min, vb_value_operator, vb_value_max)
VALUES (@w_sec, 'Cliente Nro Ciclo Individual', 'CLINROCLIN', 'Cliente Número Ciclo Individual', 'INT', '0', NULL, 'CRE', 'ORI', '', NULL, NULL, NULL, '0', NULL)
GO


