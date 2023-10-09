use 
cobis
go
delete from cobis..cl_errores 
where numero in (208916,208917,208918,208919,208920,208921,208922)
GO

insert into cobis..cl_errores values (208916, 0, 'VALIDAR NÚMERO MÍNIMO Y MÁXIMO DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208917, 0, 'VALIDAR PARENTESCO DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208918, 0, 'VALIDAR CRÉDITOS VIGENTES DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208919, 0, 'VALIDAR INTEGRANTES COMO CÓNYUGES.')
go
insert into cobis..cl_errores values (208920, 0, 'VALIDAR NÚMERO DE MUJERES.')
go
insert into cobis..cl_errores values (208921, 0, 'EL GRUPO DEBE TENER UN PRESIDENTE')
go
insert into cobis..cl_errores values (208922, 0, 'EL GRUPO DEBE TENER UN TESORERO')
GO
-------------


use cobis
go

declare @w_new_table        int, 
        @w_current_table    int

select @w_new_table = siguiente 
from cl_seqnos 
where bdatos = 'cobis'
  and tabla = 'cl_tabla' 
  and pkey = 'codigo'
------------------------------------
-- catalogo: cl_parentesco_1er
------------------------------------ 
print 'cl_parentesco_1er'
select @w_current_table = codigo 
from cl_tabla
where tabla = 'cl_parentesco_1er'

delete from cl_tabla
where codigo = @w_current_table

delete from cl_catalogo
where tabla = @w_current_table

delete from cl_catalogo_pro
where cp_tabla = @w_current_table

select @w_new_table=@w_new_table + 1


insert into cl_tabla values (@w_new_table,'cl_parentesco_1er','Parentesco Primer Grado')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'209','CONYUGUE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'210','HIJO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'211','PADRE','V')

insert into cl_catalogo_pro(cp_producto,cp_tabla) 
values ('CLI',@w_new_table)


------------------------------------
-- catalogo: cl_parentesco_2er
------------------------------------ 
print 'cl_parentesco_2er'
select @w_current_table = codigo 
from cl_tabla
where tabla = 'cl_parentesco_2er'

delete from cl_tabla
where codigo = @w_current_table

delete from cl_catalogo
where tabla = @w_current_table

delete from cl_catalogo_pro
where cp_tabla = @w_current_table

select @w_new_table=@w_new_table + 1

insert into cl_tabla values (@w_new_table,'cl_parentesco_2er','Parentesco Segundo Grado')


insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'212','HERMANO','V')

insert into cl_catalogo_pro(cp_producto,cp_tabla) 
values ('CLI',@w_new_table)



------------------------------------------------
-- Actualizacion secuencial tabla de catalogos
------------------------------------------------
update cobis..cl_seqnos 
set siguiente = @w_new_table 
where bdatos = 'cobis' 
  and tabla  = 'cl_tabla' 
  and pkey   = 'codigo'
go

-------
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


