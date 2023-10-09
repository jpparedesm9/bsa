/************************************************************************/
/*   Archivo:             ahndcaut.sp                                   */
/*   Stored procedure:    sp_ahndc_automatica                           */
/*   Base de datos:  	  cob_ahorros                                   */
/*   Producto:            Ahorros                                       */
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
use cob_ahorros
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_ahndc_automatica')
   drop proc sp_ahndc_automatica
go

create proc sp_ahndc_automatica(
@s_srv                                   varchar(30),
@s_ofi                                   smallint,
@s_ssn                                   int,
@s_ssn_branch                            int                = null,
@s_user                                  varchar(30)        = null,
@s_term                                  varchar(10)        = 'consola',
@s_org                                   char(1)            = 'C',
@s_rol                                   smallint           = null,
@t_trn                                   int,
@t_corr                                  char(1)            = 'N',
@t_ssn_corr                              int                = null,
@t_debug                                 char(1)            = 'N',
@t_file                                  varchar(14)        = null,
@t_from                                  varchar(32)        = null,
@i_cta                                   cuenta,
@i_val                                   money,
@i_cau                                   char(3),
@i_mon                                   tinyint,
@i_fecha                                 smalldatetime      = null,
@i_alt                                   int                = 0,
@i_change_ofi                            char(1)            = 'N',
@i_cobsus                                char(1)            = 'N',
@i_inmovi                                char(1)            = 'N',
@i_imp                                   char(1)            = 'N',
@i_devolucion_imp                        money              = 0,
@i_atm_server                            char(1)            = 'N',
@i_srvorg                                varchar(8)         = ' ',
@i_comision                              money              = 0,
@i_num_trans                             int                = 0,
@i_cliente                               int                = null,
@i_verificar_blq                         char (1)           = 'S',
@i_activar_cta                           char (1)           = 'N',
@i_serial                                varchar(20)        = null,
@i_nomtrn                                varchar(10)        = null,
@i_referencia                            varchar(17)        = null,
@i_turno                                 smallint           = null,
@i_canal                                 smallint           = 4,
@i_cotiz_atm                             float              = null,
@i_codope_tes                            int                = 0,
@t_ejec                                  char(1)            = 'N',
@i_fecha_valor_a                         datetime           = null,
@i_sld_caja                              money              = 0,
@i_idcierre                              int                = 0,
@i_filial                                smallint           = 1,
@i_idcaja                                int                = 0,
@i_stand_in                              char(1)            = 'N',
@i_is_batch                              char(1)            = 'N',
@i_cheque                                int                = null,
@i_concepto                              varchar(40)        = null,
@i_cau_comi                              char(3)            = null,
@i_cobiva                                char(1)            = 'N',
@i_clase_clte                            char(1)            = 'P',
@i_valida_saldo                          char(1)            = 'S',
@i_alt_corr                              int                = null,
@i_titular_prods                         int                = null,
@i_titularidad_prods                     char(1)            = null,
@i_reintegro                             char(1)            = 'N', 
@i_posteo                                char(1)            = 'S', 
@i_tran_ext                              char(1)            = 'N',
@i_corresponsal                          char(1)            = 'N',
@o_monto_imp                             money              = 0    OUT,
@o_saldo_para_girar                      money              = null OUT,
@o_ssn                                   int                = null OUT,
@o_tipocta_super                         char(1)            = null OUT,
@o_val_2x1000                            money              = 0    OUT,
@o_valiva                                money              = null OUT)
as
select @o_monto_imp        = 0
select @o_saldo_para_girar = 0
select @o_ssn              = 1
select @o_tipocta_super    = 1
select @o_val_2x1000       = 0
select @o_valiva           = 0
return 0
go
