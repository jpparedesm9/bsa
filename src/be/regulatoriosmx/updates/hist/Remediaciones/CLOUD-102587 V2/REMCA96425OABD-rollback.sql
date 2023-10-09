
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 96425: Mejoras al kit de crédito
--Fecha                      : 12/07/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ACTUALIZA CATALOGO
--------------------------------------------------------------------------------------------

use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CRE'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')                                              
and cl_tabla.codigo = cl_catalogo.tabla

go                                       
delete cl_tabla                          
 where cl_tabla.tabla in ('cr_doc_digitalizado_ind', 'cr_doc_digitalizado')                                    
go

