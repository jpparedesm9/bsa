--Por pruebas en el caso #193221 B2B Grupal Digital, se agregan los siguientes registros en la tabla de equivalencia.
--Estos registros fueron eliminados en los scripts anteriores
--por que no se encuentran en las tablas que se usan para pintar la info desde la web.

print 'Ini script 08_REM_cs212473_ELI_COD_POSTAL_EQUIVALENCIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--------------------
use cob_conta_super
go

select * from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')

delete from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('ENT_FED', '101', '101', 'Serv. Exterior Mexicano', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('ENT_FED', '102', '102', 'Nacido en el Extranjero', 'V')
go

print 'Fin script 08_REM_cs212473_ELI_COD_POSTAL_EQUIVALENCIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--1s
GO
