/************************************************************************/
/*  Archivo:            consulta_trn_cb.sp                              */
/*  Stored procedure:   sp_consulta_trn_cb                              */
/*  Base de datos:      cob_remesas                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_consulta_trn_cb')
   drop proc sp_consulta_trn_cb
go
create proc sp_consulta_trn_cb(
@s_ssn            int = null,
@s_date           datetime = null,
@s_term           varchar(30) = null,
@s_user           varchar(14) = null,
@s_rol            int = null,
@s_ofi            smallint= null,
@t_trn            int = null,
@i_operacion      char(1) = null,
@i_codigo_red     smallint = null,
@i_punto_ini      varchar(30) = null,
@i_punto_fin      varchar(30) = null,
@i_tipo_tran      int = null,
@i_monto          money = null,
@i_fecha_desde    datetime = null,
@i_fecha_hasta    datetime = null,
@i_sec            int = 0

)

as
declare 
@w_sp_name              varchar(50),
@w_error                int,
@w_msg                  varchar(255)

select @w_sp_name         = 'sp_consulta_trn_cb',
       @w_error           = 0,
       @w_msg             = ''

if @i_codigo_red is null
begin
   select @w_error = 360005,
          @w_msg = 'Codigo de red no puede estar vacio'
   goto ERROR
end

if @i_punto_ini is null
begin
   select @w_error = 360005,
          @w_msg = 'Punto Inicial no puede estar vacio'
   goto ERROR
end

if @i_punto_fin is null
begin
   select @w_error = 360005,
          @w_msg = 'Punto Final no puede estar vacio'
   goto ERROR
end

if @i_fecha_desde is null
begin
   select @w_error = 360005,
          @w_msg = 'Fecha Inicial no puede estar vacia'
   goto ERROR
end

if @i_fecha_hasta is null
begin
   select @w_error = 360005,
          @w_msg = 'Fecha Final no puede estar vacia'
   goto ERROR
end

/* CONSULTA PUNTOS */
if @i_operacion = 'S' begin

   exec @w_error = cob_remesas..sp_tr_consulta_trn_cb
   @i_param1     = @i_codigo_red,
   @i_param2     = @i_fecha_desde,
   @i_param3     = @i_fecha_hasta,
   @i_param4     = 'N',
   @i_param5     = @i_punto_ini,
   @i_param6     = @i_punto_fin,
   @i_param7     = @i_tipo_tran,
   @i_param8     = @i_monto,
   @i_param9     = @i_sec

   if @w_error <> 0 begin
      select
      @w_error = 360005,
      @w_msg   = 'Error en consulta de transacciones asociadas Cuentas de Corresponsalia'
      goto ERROR
   end
end
return 0

ERROR:
set rowcount 0
exec cobis..sp_cerror
@t_from = @w_sp_name,
@i_num  = @w_error,
@i_msg  = @w_msg,
@i_sev  = 0
return @w_error




GO

