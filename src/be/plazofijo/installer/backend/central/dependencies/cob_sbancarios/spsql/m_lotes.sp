/************************************************************************/
/*   Archivo:             m_lotes.sp                                    */
/*   Nombre Logico:       sp_actualizar_lotes                           */
/*   Base de datos:  	  cob_sbancarios                                */
/*   Producto:            Servicios Bancarios                           */
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
use cob_sbancarios
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_actualizar_lotes')
   drop proc sp_actualizar_lotes
go

create proc sp_actualizar_lotes(
@s_ssn                                   int                = null,
@t_from                                  varchar(32)        = null,
@t_rty                                   char(1)            = null,
@t_ssn_corr                              int                = null,
@p_rssn_corr                             int                = null,
@p_lssn                                  int                = null,
@s_sev                                   tinyint            = null,
@s_date                                  datetime           = null,
@s_term                                  varchar(30)        = null,
@s_sesn                                  int                = null,
@s_srv                                   varchar(30)        = null,
@s_lsrv                                  varchar(30)        = null,
@s_user                                  varchar(14),       
@s_ofi                                   smallint           = null,
@s_rol                                   smallint           = null,
@s_org                                   char(1)            = null,
@t_debug                                 char(1)            = 'N',
@t_file                                  varchar(14)        = null,
@t_trn                                   smallint           = null,
@i_alterno                               int                = null,
@i_idlote                                int                = null,
@i_enlace_cc                             char(1)            = null,
@i_producto                              tinyint,
@i_instrumento                           smallint,
@i_causa_anul                            varchar(64)        = null,
@i_subtipo                               int,
@i_grupo1                                varchar(30)        = null,
@i_grupo2                                varchar(30)        = null,
@i_grupo3                                varchar(30)        = null,
@i_grupo4                                varchar(30)        = null,
@i_grupo5                                varchar(30)        = null,
@i_grupo6                                varchar(30)        = null,
@i_grupo7                                varchar(30)        = null,
@i_grupo8                                varchar(30)        = null,
@i_grupo9                                varchar(30)        = null,
@i_grupo10                               varchar(30)        = null,
@i_grupo11                               varchar(30)        = null,
@i_grupo12                               varchar(30)        = null,
@i_grupo13                               varchar(30)        = null,
@i_grupo14                               varchar(30)        = null,
@i_grupo15                               varchar(30)        = null,
@i_llamada_ext                           char(1)            = 'N')
as
return 0
go
