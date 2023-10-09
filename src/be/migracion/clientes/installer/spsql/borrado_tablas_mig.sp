/************************************************************************/
/*    ARCHIVO:         borrado_tablas_mig.sp                            */
/*    NOMBRE LOGICO:   borrado_tablas_mig.sp                            */
/*    PRODUCTO:        CLIENTES                                         */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      "MACOSA",representantes exclusivos para el Ecuador de la       */
/*      AT&T                                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier autorizacion o agregado hecho por alguno de sus      */
/*      usuario sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante             */
/***********************************************************************/
/*                     PROPOSITO                                       */
/*   Borrado de los datos temporales de las tablas de                  */
/*   Clientes para apoyo en la migración a las tablas                  */
/*   definitivas                                                       */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/***********************************************************************/

use cob_externos
go


if exists(select * from sysobjects where name = 'borrado_tablas_mig')
   drop proc borrado_tablas_mig
go
create proc borrado_tablas_mig
as

truncate table cl_log_mig
truncate table cl_trabajo_mig
truncate table cl_ref_personal_mig
truncate table cl_telefono_mig
truncate table cl_refinh_mig
truncate table cl_direccion_mig
truncate table cl_ente_mig
truncate table cl_instancia_mig

delete cl_rango_mig where rm_modulo = 'MIS'

return 0
go
