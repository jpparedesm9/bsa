/********************************************************************************/
/* Archivo:     update_recursos.sql                                             */
/* Producto:    ADMINISTRACION                                                  */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                                PROPOSITO                                     */
/* actualizar tablas sin afectar la data para que se disparen los tiggers       */
/********************************************************************************/
/*                                MODIFICACIONES                                */
/********************************************************************************/
/* FECHA            AUTOR              RAZON                                    */
/********************************************************************************/
/* 04-May-2016    ELizabeth Lopez     Migracion de Sybase a SQLServer           */
/********************************************************************************/

use cobis 

go

print 'update cl_catalogo'
update cl_catalogo
set valor = valor

go

print 'update cl_errores'
update cl_errores
set mensaje = mensaje

go

print 'update cl_ttransaccion'
update cl_ttransaccion
set tn_descripcion  = tn_descripcion 

go

print 'update cl_default'
update cl_default
set valor = valor

go
