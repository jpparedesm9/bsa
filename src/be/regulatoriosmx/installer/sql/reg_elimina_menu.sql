/************************************************************************/
/*    ARCHIVO:         reg_elimina_menu.sql                             */
/*    NOMBRE LOGICO:   reg_elimina_menu.sql                             */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de eliminacion de menu de regulatorios                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

use cobis
go

-- -------------------------------------------
-- ELIMINACIÓN
-- ----------------------------------------------

-- Dependencias
delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where md_mo_id = mo_id 
and mo_name like 'REC.%'
go

-- Modulos
delete cobis..an_role_page from cobis..an_role_page, cobis..an_page, cobis..an_label where rp_pa_id = pa_id and pa_la_id = la_id and la_prod_name = 'M-REC'
delete cobis..an_module_group where mg_name like 'REC%'
delete cobis..an_page_zone from cobis..an_page_zone, cobis..an_label where pz_la_id = la_id and la_prod_name = 'M-REC'
delete cobis..an_role_module from cobis..an_role_module, cobis..an_module, cobis..an_label where rm_mo_id = mo_id and mo_la_id = la_id and la_prod_name = 'M-REC'
delete cobis..an_navigation_zone from cobis..an_navigation_zone, cobis..an_label where nz_la_id = la_id and la_prod_name = 'M-REC'
delete cobis..an_role_component from cobis..an_role_component,cobis..an_component where rc_co_id = co_id and co_prod_name = 'M-REC'
delete cobis..an_module from cobis..an_module, cobis..an_label where mo_la_id = la_id and la_prod_name = 'M-REC'
delete cobis..an_component where co_prod_name = 'M-REC'
delete cobis..an_page  where pa_prod_name = 'M-REC'
delete cobis..an_label where la_prod_name = 'M-REC'
go


