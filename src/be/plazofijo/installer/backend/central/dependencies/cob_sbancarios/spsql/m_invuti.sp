/************************************************************************/
/*   Archivo:             m_invuti.sp                                   */
/*   Nombre Logico:       sp_invent_utl		                            */
/*   Base de datos:  	  cob_remesas                                   */
/*   Producto:            Plazo Fijo                                    */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  19 de Julio de 2016                           */
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
use cob_sbancarios
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_invent_utl')
   drop proc sp_invent_utl
go

create proc sp_invent_utl(
@s_date	                                   datetime         = null,
@s_user	                                   login            = null,
@s_ssn	                                   int              = null,
@s_term	                                   varchar(30)      = null,
@s_srv	                                   varchar(30)      = null,
@s_lsrv	                                   varchar(30)      = null,
@s_ofi	                                   smallint         = null,
@t_debug                                   char(1)          = 'N',
@t_file	                                   varchar(14)      = null,
@t_trn	                                   smallint         = null, 
@i_instrumento                             smallint,          
@i_subtipo                                 int,               
@i_serie_lit		                       varchar(10)      = '',
@i_serie_desde		                       money, 
@i_serie_hasta		                       money, 
@i_prod_destino		                       tinyint)
as
return 0
go