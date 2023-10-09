/***********************************************************************/
--No Bug:
--Título del Bug: crear campos en tabla de oficiales
--Fecha:2017-06-15
--Descripción del Problema:
--crear nuevo campo para ingreso del email del oficial
--Descripción de la Solución: crear campos
--Autor:LGU
/***********************************************************************/

use cobis
go

--oc_mail
if not exists(select 1
          from cobis..sysobjects obj, cobis..syscolumns col
          where obj.name = 'cc_oficial'
          and   obj.id = col.id
          and   col.name = 'oc_mail')
begin
alter table cobis..cc_oficial
   add oc_mail varchar(254) null
end
go

go



