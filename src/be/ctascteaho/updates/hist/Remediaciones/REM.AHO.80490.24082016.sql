/***********************************************************************************************************/

---Fecha					: 24/08/2016 
--Descripción               : script para la Historia 80490 
--Descripción de la Solución: Remediacion para la Historia 80490
--Autor						: Jorge Baque
/***********************************************************************************************************/

/* $/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Dependencias/sql/cc_catlgo.sql */
use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cc_tipos_cheque')
  and codigo = cp_tabla
go
delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('cc_tipos_cheque')
  and  cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where  cl_tabla.tabla in ('cc_tipos_cheque')
go


declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

print 'cc_tipos_cheque'
insert into cobis..cl_tabla (codigo,tabla,descripcion) 
values (@w_codigo,'cc_tipos_cheque','Tipos de Cheque')

insert into cobis..cl_catalogo (tabla,codigo,valor,estado)
values(@w_codigo, '1', 'Cheque Local', 'V')

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

 go
/******************************************************* ERRORES **********************************************/
use cobis
go

delete from cl_errores 
 where numero in (201008)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (201008, 0, 'Cuenta Bloqueada')