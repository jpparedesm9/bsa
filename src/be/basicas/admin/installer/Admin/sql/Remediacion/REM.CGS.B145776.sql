/*************************************************************************************/
--No Historia                : CGS-B145776 
--Titulo de la Historia      : Consulta de Filiales
--Fecha                      : 24/11/2017
--Descripcion del Problema   : Consulta de Filiales
--Descripcion de la Solucion : Visualizar la oficina
--Autor                      : Francisco Vargas
/*************************************************************************************/
use cobis
go



declare @w_actividad varchar(10)

select  top 1 @w_actividad = b.codigo
from    cl_tabla a, cl_catalogo b
where   a.tabla='cl_actividad'
  and   a.codigo=b.tabla


update  cobis..cl_filial
set fi_actividad = @w_actividad
where fi_filial=1

go

