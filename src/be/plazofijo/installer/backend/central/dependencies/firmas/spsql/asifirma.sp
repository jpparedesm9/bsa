/************************************************************************/
/*   Archivo:             asifirma.sp                                   */
/*   Stored Procedure:    sp_firmantes                                  */
/*   Base de datos:  	  firmas                                        */
/*   Producto:            Firmas                                        */
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
use firmas
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_firmantes')
   drop proc sp_firmantes
go

create proc sp_firmantes(
@s_ssn                                   int,
@s_srv                                   varchar(30),
@s_lsrv                                  varchar(30),
@s_user                                  varchar(30),
@s_sesn                                  int,
@s_term                                  varchar(10),
@s_date                                  datetime,
@s_ofi                                   smallint,
@s_rol                                   smallint,
@s_org_err                               char(1)            = null,
@s_error                                 int                = null,
@s_sev                                   tinyint            = null,
@s_msg                                   varchar(255)       = null,
@s_org                                   char(1),           
@t_debug                                 char(1)            = 'N',
@t_file                                  varchar(14)        = null,
@t_from                                  varchar(32)        = null,
@t_trn                                   smallint,          
@p_lssn                                  int                = null,
@p_rssn                                  int                = null,
@i_cuenta                                varchar(24)        = null,
@i_producto                              char(3)            = null,
@i_moneda                                smallint           = null,
@i_ente                                  int                = null,
@i_cedula                                varchar(20)        = null,
@i_operacion                             char(1),           
@i_rol                                   char(1)            = 'F')
as
return 0
go
