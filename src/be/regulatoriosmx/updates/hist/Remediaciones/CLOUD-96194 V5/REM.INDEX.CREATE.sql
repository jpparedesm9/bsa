--Script para crear un campo adicional en la ca_corresponsal_det
--Disenado : Andy Gonzalez 
--Caso 100953

use cob_conta_super
go


if exists (select 1 from sysindexes  where name = 'idx4')
   drop index idx4 on sb_dato_operacion
go
   
create index idx4 on sb_dato_operacion (do_grupo,do_numero_ciclos)
go

update statistics sb_dato_operacion
go