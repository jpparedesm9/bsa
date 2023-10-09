/*************************************************/
---No Bug: N/A
---Título de la Historia: REPORTES REGULATORIO DE OPERACIONES RELEVANTES
---Fecha: 14/09/2016
--Autor: Ignacio Yupa
/*************************************************/
use cob_conta_super
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'sb_consulta_transacciones' and
        a.id = b.id and
        a.name = 'ct_secuencial_det')
begin
 alter table cob_conta_super..sb_consulta_transacciones add ct_secuencial_det int  NULL 
 select 'DONE: se ejecuto correctamente.'
end
else
begin
 select 'FAIL: ya existe campo ct_secuencial_det.'
end
