/*sp_cons_xml.sp*********************************************************/
/*   Archivo:             sp_cons_xml.sp                                */
/*   Stored procedure:    sp_consultar_xml                              */
/*   Base de datos:  	  cobis                                         */
/*   Producto:            Web Services                                  */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  25 de Julio de 2016                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA". Su uso no autorizado queda expresamente prohibido asi    */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Creacion Stored Procedure Cascara para instalacion de Plazo Fijo   */
/*   Version Davivienda                                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_consultar_xml')
   drop proc sp_consultar_xml
go

create proc sp_consultar_xml(
@i_ente            int          = null,
@i_num_doc         varchar(20)  = null,
@i_type_doc        varchar(10)  = null,
@i_tservice        varchar(10)  = '01',
@i_tquery          varchar(10)  = '01',
@i_id_block        int          = null,
@i_xml             xml          = null,
@i_central         varchar(10)  = null,
@i_tramite         int          = null,
@o_est_consulta    varchar(10)  = null out,
@o_est_id          varchar(50)  = null out,
@o_trama_error     char(1)      = null out,
@o_sec_error       int          = null out )
as
select @o_est_consulta  = 'XX'
select @o_est_id        = 'XX'
select @o_trama_error   = 'N'
select @o_sec_error     = 0 
return 0
go
