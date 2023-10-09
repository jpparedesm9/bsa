/************************************************************************/
/*  Archivo:                lcr_socio_comercial_log.sp                  */
/*  Stored procedure:       lcr_socio_comercial_log                     */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               credito                                     */
/*  Disenado por:           Karina Vizcaino                             */
/*  Fecha de documentacion: Octubre 2021                                */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBIS'.                                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBIS o su representante legal.            */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Registrar la actividad realizada en una transaccion.                */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    19/Oct/2021           KVI              Emision Inicial            */
/************************************************************************/

use cob_cartera 
go

if exists(select 1 from sysobjects where name ='lcr_socio_comercial_log')
	drop proc lcr_socio_comercial_log
go


create proc lcr_socio_comercial_log(
   @s_ssn                int           = null,
   @s_ofi                smallint      = null,
   @s_user               login         = null,
   @s_date               datetime      = null,
   @s_srv                varchar(30)   = null,
   @s_term               descripcion   = null,
   @s_rol                smallint      = null,
   @s_lsrv               varchar(30)   = null,
   @s_sesn               int           = null,
   @s_org                char(1)       = null,
   @s_org_err            int           = null,
   @s_error              int           = null,
   @s_sev                tinyint       = null,
   @s_msg                descripcion   = null,
   @t_rty                char(1)       = null,
   @t_trn                int           = null,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(30)   = null,
   @i_cod_autorizacion   varchar(6)    = null,
   @i_tipo_transaccion   char(1)       = null,
   @i_fecha_proceso      datetime      = null,
   @i_num_referencia     varchar(22)   = null,  
   @i_fecha_referencia   datetime      = null, 
   @i_estado             char(1)       = null, 
   @i_monto_aprobado     money         = null,
   @i_monto_compra       money         = null,
   @i_monto_total_compra money         = null,
   @i_comision           money         = null,
   @i_iva                money         = null,
   @i_error              int           = null,
   @i_mensaje_error      varchar(255)  = null

)as 
declare 
@w_msg                      varchar(255),
@w_error                    int,
@w_sp_name                  varchar(32)

select @w_sp_name = 'lcr_socio_comercial_log'

insert into cob_cartera..ca_lcr_log_socio_comercial 
(
  ls_codigo_autorizacion, 
  ls_tipo_transaccion, 
  ls_fecha_proceso, 
  ls_numero_referencia, 
  ls_fecha_referencia,
  ls_estado, 
  ls_login, 
  ls_monto_aprobado, 
  ls_monto_compra, 
  ls_monto_total_compra,
  ls_comision, 
  ls_iva,
  ls_error, 
  ls_mensaje_error
)
values
(
  @i_cod_autorizacion,
  @i_tipo_transaccion,
  @i_fecha_proceso,
  @i_num_referencia,
  @i_fecha_referencia,
  @i_estado,
  @s_user,
  @i_monto_aprobado,
  @i_monto_compra,
  @i_monto_total_compra,
  @i_comision,
  @i_iva,
  @i_error,
  @i_mensaje_error
)
 if @@error <> 0
 begin
    exec cobis..sp_cerror
       @t_debug    = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num      = 5000,
       @i_msg      = 'NO SE PUDO INSERTAR EL LOG DE TRANSACCION'
    return 5000 
 end
	

return 0

go
