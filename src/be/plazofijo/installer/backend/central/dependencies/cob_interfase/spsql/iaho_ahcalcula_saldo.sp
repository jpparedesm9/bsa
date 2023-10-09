/************************************************************************/
/*  Archivo:              iaho_ahcalcula_saldo.sp                       */
/*  Stored procedure: 	  sp_iaho_ahcalcula_saldo                       */
/*  Base de datos:  	  cob_interfase                                 */
/*  Producto:             PFIJO                                         */
/*  Disenado por:         Byron Ron                                     */
/*  Fecha de escritura:   15-Jul-2009                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                 PROPOSITO                                            */
/*  Sp interfase.                                                       */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  15-JUL-2009     B. RON          Emision Inicial                     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_iaho_ahcalcula_saldo') is not null
   drop procedure sp_iaho_ahcalcula_saldo
go

create proc dbo.sp_iaho_ahcalcula_saldo(
@t_debug             char(1)         = null,
@t_file              varchar(14)     = null,
@t_from              varchar(30)     = null,
@i_cuenta            int             = null,
@i_fecha             smalldatetime   = null,      
@o_saldo_para_girar  money           = null    out,      
@o_saldo_contable    money           = null    out)
with encryption
as
select @o_saldo_para_girar = 0
select @o_saldo_contable = 0
return 0
go
