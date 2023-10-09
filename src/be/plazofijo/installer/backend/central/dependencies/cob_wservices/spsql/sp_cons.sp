/************************************************************************/
/*   Archivo:             sp_cons.sp                                    */
/*   Stored procedure:    sp_consultar                                  */
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

if exists (select 1 from sysobjects where name = 'sp_consultar')
   drop proc sp_consultar
go

create proc sp_consultar(
@i_tipoid                                nvarchar(255)      = null,
@i_id                                    nvarchar(255)      = null,
@i_papelido                              nvarchar(255)      = null,
@o_xml                                   xml                OUT)
as
select @o_xml = ''
return 0
go
