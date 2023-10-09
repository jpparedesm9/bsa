use cobis
go


/* CREAR CATALOGO PARA OPERACIONES DE RENOVACION */
declare @w_codigo SMALLINT


delete cobis..cl_catalogo_pro 
from   cobis..cl_tabla a, cobis..cl_catalogo_pro b
where  a.codigo = b.cp_tabla and a.tabla = 'ca_toper_ren' and cp_producto = 'CCA'

delete cobis..cl_catalogo 
from   cobis..cl_tabla a, cobis..cl_catalogo b
where  a.codigo = b.tabla and a.tabla = 'ca_toper_ren' 

delete cobis..cl_tabla  where tabla = 'ca_toper_ren' 

select @w_codigo = max(codigo) + 1 from cl_tabla

print 'Tabla de operaciones para renovacion'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_toper_ren', 'Tipo de operaciones para renovacion')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'CREDVEHI', 'CREDVEHI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'SINCO'   , 'SINCO'   , 'V')

select @w_codigo = @w_codigo + 1

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'


/* ACTUALIZACION DEL MENU  DE PAGOS DE PRESTAMOS */
update cobis..cew_menu 
set    me_url   = 'views/ASSTS/TRNSC/T_REFINANCELISS_781/1.0.0/VC_REFINANCSL_902781_TASK.html?menu=9'
where  me_name  = 'MNU_ASSETS_RENOVACIONES'


update cobis..cew_menu 
set    me_url   = 'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=8'
where  me_name  = 'MNU_ASSETS_PAYMENTS'

go







