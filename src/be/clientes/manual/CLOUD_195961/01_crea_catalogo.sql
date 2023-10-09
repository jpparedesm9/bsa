/************************************************************************/
/*    ARCHIVO:         01_crea_conciliador.sql                          */
/*    NOMBRE LOGICO:   crea_conciliador.sql                             */
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
/*   Script de creacion de tablas para conciliador contable             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      05/04/2022      Daniel Berrio           Emision Inicial         */
/************************************************************************/

use cob_cartera
GO

if exists(select 1 from sysobjects
           where name = 'cl_catalogo_motv')
   drop table cl_catalogo_motv
go


create table cl_catalogo_motv
(
	cm_codigo           varchar(6),
	cm_descripcion      varchar(150)
)
go
