/************************************************************************/
/*  Archivo:        an_parametro.sql                                    */
/*  Base de datos:  cobis                                               */
/*  Producto:       COBIS Explorer .Net                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Creacion de parametros que podr¡a personalizarse por cliente        */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*    FECHA        AUTOR            RAZON                               */
/* 04/Feb/2011     A. Duque         Emision Inicial                     */
/* 13/Ene/2014     M. Cabay         Se agrega parametro para distribución*/
/*                                  de servidores  web                   */
/************************************************************************/

use cobis
go

if exists (select 1 from cl_parametro where pa_nemonico = 'RACEN' and pa_producto = 'ADM')
    delete from cl_parametro where pa_nemonico = 'RACEN' and pa_producto = 'ADM'
go
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('RACEN', 'ROL ADMINISTRADOR CEN', 'T', 1, 'ADM')
go

if exists (select 1 from cl_parametro where pa_nemonico = 'PICEN' and pa_producto = 'ADM')
    delete from cl_parametro where pa_nemonico = 'PICEN' and pa_producto = 'ADM'
go
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('PICEN', 'PATH INSTALACION CEN', 'T', 'http://127.0.0.1', 'ADM')
go
if exists (select 1 from cl_parametro where pa_nemonico = 'CTDSW' and pa_producto='ADM')
	delete from cl_parametro where pa_nemonico = 'CTDSW' and pa_producto='ADM'
go
insert into cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto) 
values ('CEN-TIPO DE DISTRIBUCION DE SERVIDORES WEB','CTDSW','C','OF','ADM')
go


