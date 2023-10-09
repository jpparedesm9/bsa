
/*************************************************/
---No Bug: 78445
---Título del Bug: ATC - Transacciones de Servicios - FUN
---Fecha: 20/07/2016
--Descripción del Problema: Falta de Catalogo re_pro_banc_cb
--Descripción de la Solución: Insertar catalogo re_pro_banc_cb
--Autor: Walther Toledo
/*************************************************/

-- 


use cobis
go
/*************/
/*   TABLA   */
/*************/
delete cl_catalogo_pro from cl_tabla
where  cl_tabla.tabla in ('re_pro_banc_cb')
  and  codigo = cp_tabla

delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('re_pro_banc_cb')
  and  cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where  cl_tabla.tabla in ('re_pro_banc_cb')
go

---------------------------------------------------------------------------------------------------
declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
  from cl_tabla

update cl_seqnos
   set siguiente = @w_maxtabla
 where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
---------------------------------------re_catlgo.sql------------------------------------------------------------ 
print 'Transacciones propia de la Oficina'
insert into cl_tabla values (@w_codigo, 're_pro_banc_cb', 'Catalogo de Productos bancarios Cuenta Corresponsalia')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '5', 'CUENTA CORRESPONSALIA','V')

update cl_seqnos set siguiente = @w_codigo
    where tabla='cl_tabla'
go


