/*************************************************/
---No Bug: N/A
---Título de la Historia: REFACTOR PROCESO DE DETECCION DE OPERACIONES INUSUALES
---Fecha: 09/09/2016
--Autor: Ignacio Yupa
/*************************************************/
use cob_conta_super
go

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'sb_consulta_transacciones' and
        a.id = b.id and
        a.name = 'ct_origen')
begin
 alter table cob_conta_super..sb_consulta_transacciones add ct_origen catalogo  NULL 
 select 'DONE: se ejecuto correctamente.'
end
else
begin
 select 'FAIL: ya existe campo ct_origen.'
end

if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'sb_consulta_transacciones' and
        a.id = b.id and
        a.name = 'ct_aplicativo')
begin
 alter table cob_conta_super..sb_consulta_transacciones add ct_aplicativo smallint  NULL 
 select 'DONE: se ejecuto correctamente.'
end
else
begin
 select 'FAIL: ya existe campo ct_origen.'
end
go