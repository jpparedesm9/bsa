/************************************************************************/
/*      Archivo:                bt_cdint.sp                             */
/*      Stored procedure:       sp_batch_cdint                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las Actualizaciones    */
/*      de inicio de dia del modulo de Plazo Fijo.                      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      25-Nov-94  Juan Lam           Creacion                          */
/*      04-Oct-95  Carolina Alvarado  XXXX                              */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_batch_cdint' and type = 'P')
   drop proc sp_batch_cdint
go

create proc sp_batch_cdint (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = NULL,
@t_file                 varchar(10) = NULL,
@t_trn                  int         = NULL,
@i_fecha_proceso        datetime,
@i_oficina		        catalogo    = '%',
@i_ciudad		        catalogo    = '%')
with encryption
as
declare 
  @w_sp_name              descripcion,
  @w_return               int,
  @w_error                int,
  @w_secuencial           int,
	@w_fecha_hoy            datetime,
	@w_rc_fecha_inicio_dia  datetime,
	@w_rc_fecha_final_dia   datetime,
	@w_fecha_proceso        datetime

/** DEBUG **/

select @w_sp_name = 'sp_batch_cdint',
       @s_user    = isnull(@s_user,'SYSTEM'),
       @s_term    = isnull(@s_term,'CONSOLA'),
       @s_date    = isnull(@s_date,@i_fecha_proceso),
       @s_srv     = isnull(@s_srv,@@servername),
       @s_lsrv    = isnull(@s_lsrv,@@servername),
       @s_ofi     = isnull(@s_ofi,1),
       @s_rol     = isnull(@s_rol,1),
       @t_debug   = isnull(@t_debug,'N'),
       @t_file    = isnull(@t_file,'SQR'),
       @t_trn     = isnull(@t_trn,14926)

select @w_rc_fecha_final_dia   =  rc_fecha_final_dia,
       @w_rc_fecha_inicio_dia  =  rc_fecha_inicio_dia
from pf_reg_control

select @w_rc_fecha_final_dia    = 
       convert(datetime,convert(varchar,@w_rc_fecha_final_dia,101)),
       @w_rc_fecha_inicio_dia = 
       convert(datetime,convert(varchar,@w_rc_fecha_inicio_dia,101)),
       @w_fecha_proceso = convert(datetime,convert(varchar,@i_fecha_proceso,101))

if @w_rc_fecha_inicio_dia  <> @w_fecha_proceso
begin
  select @w_error = 149027
  goto ERROR
end

if @w_rc_fecha_final_dia  >= @w_fecha_proceso
begin
  select @w_error = 149028
  goto ERROR
end

if @w_rc_fecha_inicio_dia  = @w_rc_fecha_final_dia
begin
  select @w_error = 149029
  goto ERROR
end

exec @w_secuencial=sp_gen_sec

exec @w_return=sp_calc_diario_int @s_ssn = @w_secuencial, @s_user = @s_user,
     @s_term = @s_term, @s_date = @s_date, @s_srv = @s_srv, 
     @s_lsrv = @s_lsrv, @s_ofi = @s_ofi, @s_rol = @s_rol,
     @t_debug = @t_debug, @t_file = @t_file, @t_from = @w_sp_name,
     @t_trn = 14926 , @i_fecha_proceso = @w_fecha_proceso,
     @i_oficina = @i_oficina,@i_ciudad=@i_ciudad
if @w_return <> 0
begin
  select @w_error = @w_return
  goto ERROR
end      

update pf_reg_control 
set rc_fecha_final_dia = @w_fecha_proceso

return 0
ERROR:
exec sp_errorlog @i_fecha = @s_date,
                 @i_error = @w_error, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '
return @w_error
go

