/*************************************************************************************/
--No Bug					 : 85409
--Título de la Historia		 : Errores en Lavado de Dinero y R08
--Fecha					     : 09/23/2016
--Descripción del Problema	 : Errores en Lavado de Dinero y R08
--Descripción de la Solución : Alteracion tipo de dato campo in_ced_ruc
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Releases/REL_SaaSMX_4.1.0.0/Clientes/Backend/sql
/*************************************************************************************/
use cobis
go

if exists(select * from syscolumns a, sysobjects b
           where b.name = 'cl_refinh'
             and a.name = 'in_ced_ruc'
             and a.id   = b.id)
begin
   drop index cl_refinh.iin_ced_ruc
   drop index cl_refinh.iin_in_ced_ruc
   
   alter table cobis..cl_refinh
   alter column in_ced_ruc numero

   create nonclustered index iin_ced_ruc
       on cl_refinh (in_ced_ruc,in_origen)
   include (in_fecha_ref,in_nomlar,in_estado)
   
   create nonclustered index iin_in_ced_ruc
       on cl_refinh (in_ced_ruc)  
end
go


/*************************************************************************************/
--No Bug					 : 85409
--Título de la Historia		 : Errores en Lavado de Dinero y R08
--Fecha					     : 09/23/2016
--Descripción del Problema	 : Errores en Lavado de Dinero y R08
--Descripción de la Solución : Modificacion de valor parametro VAREIN
--Autor						 : Jorge Salazar Andrade
--Instalador                 : mis_param.sql
--Ruta Instalador            : $/COB/Releases/REL_SaaSMX_4.1.0.0/CtasCteAho/Dependencias/sql
/*************************************************************************************/
use cobis
go

delete from cl_parametro 
 where pa_nemonico = 'VAREIN'
   and pa_producto = 'MIS'
   
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char,  pa_producto)
values ('REF. INH. - VALIDACION DEL CLIENTE', 'VAREIN', 'C', 'N',  'MIS')
go


/*************************************************************************************/
--No Bug					 : 85409
--Título de la Historia		 : Errores en Lavado de Dinero y R08
--Fecha					     : 09/23/2016
--Descripción del Problema	 : Errores en Lavado de Dinero y R08
--Descripción de la Solución : Modificacion de la abreviatura del producto 36: REPORTES SUPER BANCARIA
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_producto.sql
--Ruta Instalador            : $/COB/Releases/REL_SaaSMX_4.1.0.0/RegulatoriosMX/BackEnd/sql
/*************************************************************************************/
use cobis
go

delete cobis..cl_producto
 where pd_producto = 36
   
INSERT INTO cobis..cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (36, 'R', 'REPORTES SUPER BANCARIA', 'REC', getdate(), 'V', 0, 0)

update cobis..cl_seqnos
set siguiente = (select case when max(pd_producto) >= 36 
                             then max(pd_producto) 
                             else 36
                        end
                   from cobis..cl_producto)
where tabla = 'cl_producto'
go

