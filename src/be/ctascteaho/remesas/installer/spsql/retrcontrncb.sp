/************************************************************************/
/*  Archivo:            retrcontrncb.sp                                 */
/*  Stored procedure:   sp_tr_consulta_trn_cb                           */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Corresponsales Bancarios                        */
/*  Disenado por:       Luis Carlos Moreno C.                           */
/*  Fecha de escritura: 13-Mar-2014                                     */
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
/* Req 420. Genera insumo informe gestion cuentas de corresponsalia     */
/************************************************************************/

use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_tr_consulta_trn_cb')
   drop proc sp_tr_consulta_trn_cb
go

create proc sp_tr_consulta_trn_cb (
@i_param1            smallint,             --@w_codigo_red
@i_param2            datetime,             --@w_fecha_desde
@i_param3            datetime,             --@w_fecha_hasta
@i_param4            char(1)      = 'N',   --@w_batch
@i_param5            varchar(30)  = null,  --@w_punto_ini
@i_param6            varchar(30)  = null,  --@w_punto_fin
@i_param7            int          = null,  --@w_tipo_tran
@i_param8            money        = null,  --@w_monto
@i_param9            int          = 0      --@w_sec
)
as
declare
@w_sp_name           varchar(50),
@w_error             int,
@w_msg               varchar(255),
@w_s_app             varchar(255),
@w_sp_name_batch     varchar(255),
@w_errores           varchar(255),
@w_cmd               varchar(255),
@w_comando           varchar(500),
@w_path              varchar(255),
@w_codigo_red        int,
@w_punto_ini         varchar(10),
@w_punto_fin         varchar(10),
@w_batch             char(1),
@w_fecha_desde       datetime,
@w_fecha_hasta       datetime,
@w_tipo_tran         smallint,
@w_monto             money,
@w_sec               int

select
@w_codigo_red     = @i_param1,
@w_fecha_desde    = @i_param2,
@w_fecha_hasta    = @i_param3,
@w_batch          = @i_param4,
@w_punto_ini      = @i_param5,
@w_punto_fin      = @i_param6,
@w_tipo_tran      = @i_param7,
@w_monto          = @i_param8,
@w_sec            = @i_param9

select
@w_sp_name        = 'sp_tr_consulta_trn_cb',
@w_error          = 0,
@w_msg            = '',
@w_sp_name_batch  = 'cob_remesas..sp_tr_consulta_trn_cb'

if object_id('cob_remesas..re_consulta_trn_cb') is not null begin
    drop table cob_remesas..re_consulta_trn_cb
end

create table cob_remesas..re_consulta_trn_cb(
ct_fecha          varchar(64),
ct_hora           varchar(64),
ct_tran           varchar(64),
ct_cod_red        varchar(64),
ct_nom_red        varchar(64),
ct_cod_punto      varchar(64),
ct_nom_punto      varchar(64),
ct_estado_tran    varchar(64),
ct_causal         varchar(64),
ct_des_dec        varchar(64),
ct_valor          varchar(64),
ct_secuencial     varchar(64))

TRUNCATE TABLE cob_remesas..re_consulta_trn_cb

/*CONSULTA PUNTOS */
if @w_batch = 'N'
   set rowcount 20
else
   set rowcount 0

insert into cob_remesas..re_consulta_trn_cb(
ct_fecha,              ct_hora,                    ct_tran,         ct_cod_red,
ct_nom_red,            ct_cod_punto,               ct_nom_punto,    ct_estado_tran,
ct_causal,             ct_des_dec,                 ct_valor,        ct_secuencial)
values(
'FECHA',               'HORA',                     'TRANSACCION',   'CODIGO RED',
'NOMBRE RED',          'CODIGO PUNTO',             'NOMBRE PUNTO',  'ESTADO TRANSACCION',
'CAUSAL DECLINACION',  'DESCRIPCION DECLINACION',  'VALOR',         'SECUENCIAL')

insert into cob_remesas..re_consulta_trn_cb
select
ct_fecha        =  convert(varchar(12), ts_fecha, 103),
ct_hora         =  convert(varchar(12), ts_hora, 108),
ct_tran         =  c.valor,
ct_cod_red      =  ts_oficina,
ct_nom_red      =  '',--(Nombre de la red, cruzando por tabla re_mantenimiento_cupo)
ct_cod_punto    =  ts_terminal,
ct_nom_punto    =  isnull((select isnull(pr_nombre,'') from re_punto_red_cb where pr_codigo_cb = ts_oficina and   pr_codigo_punto = ts_terminal),''),
ct_estado_tran  =  case ts_estado when 'A' then 'EXITOSA' when 'R' then 'REVERSADA' when 'X' then 'DECLINADA' else '' end,
ct_causal       =  convert(varchar(16), ts_retorno),
ct_des_dec      =  substring(ts_campo10,1,50),
ct_valor        =  convert(varchar(16), ts_monto),
ct_secuencial   =  convert(varchar(16), ts_ssn)
from cobis..ws_tran_servicio, cobis..cl_tabla t, cobis..cl_catalogo c
where ts_fecha between @w_fecha_desde and @w_fecha_hasta
and  (ts_tipo_tran = @w_tipo_tran or @w_tipo_tran is null)
and  (ts_oficina = @w_codigo_red or @w_codigo_red is null)
and  (ts_terminal >= @w_punto_ini or @w_punto_ini is null)
and  (ts_terminal <= @w_punto_fin or @w_punto_fin is null)
and  (ts_monto = @w_monto or @w_monto is null)
and   t.tabla = 'ws_tran_canales'
and   t.codigo = c.tabla
and   ts_tipo_tran = c.codigo
and   ts_banco_orig not in (select mc_cta_banco from cob_remesas..re_mantenimiento_cb where mc_estado = 'H' and mc_cod_cb = ts_oficina)
and   ts_tipo_tran <> 26519
and   ts_ssn > @w_sec
order by ts_hora, ts_ssn

if @@error <> 0 begin
   select
   @w_error = 360005,
   @w_msg = 'NO SE ENCONTRARON MOVIMIENTOS PARA LA RED POSICIONADA'
   goto ERROR
end

set rowcount 0

update cob_remesas..re_consulta_trn_cb
set    ct_nom_red   = convert(varchar(64), ah_nombre)
from   cob_ahorros..ah_cuenta, cob_remesas..re_mantenimiento_cb
where  mc_cta_banco = ah_cta_banco
and    mc_cod_cb    = ct_cod_red
and    mc_estado    = 'H'
and    ct_fecha    <> 'FECHA'

if @@error <> 0 begin
   select
   @w_error = 360005,
   @w_msg   = 'ERROR AL ACTUALIZAR EL NOMBRE DE LA RED POSICIONADA'
   goto ERROR
end

if @w_batch = 'S' begin
   /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
   select @w_s_app = pa_char
   from   cobis..cl_parametro
   where  pa_producto = 'ADM'
   and    pa_nemonico = 'S_APP'

   select @w_path = ba_path_destino
   from   cobis..ba_batch
   where  ba_arch_fuente = @w_sp_name_batch

   select @w_errores = @w_path + 'TRAN_CB_POSICIONADA' + '.err'
   select @w_cmd     = @w_s_app + 's_app bcp cob_remesas..re_consulta_trn_cb out '
   select @w_comando = @w_cmd + @w_path + 'TRAN_CB_POSICIONADA' + convert (varchar(8),getdate(),112) + '.TXT -b5000 -c -e' +
                       @w_errores + ' -t"|" -auto -login -config ' + @w_s_app + 's_app.ini'

   exec @w_error = xp_cmdshell @w_comando

   if @w_error <> 0 begin
      print 'Error generando Archivo Plano: '
      print @w_comando
   end
end
else begin
   select
   'FECHA'                   = ct_fecha,
   'HORA'                    = ct_hora,
   'TRANSACCION'             = ct_secuencial,
   'CODIGO RED'              = ct_cod_red,
   'NOMBRE RED'              = ct_nom_red,
   'CODIGO PUNTO'            = ct_cod_punto,
   'NOMBRE PUNTO'            = ct_nom_punto,
   'TIPO TRANSACCION'        = ct_tran,
   'ESTADO TRANSACCION'      = ct_estado_tran,
   'CAUSAL DECLINACION'      = ct_causal,
   'DESCRIPCION DECLINACION' = ct_des_dec,
   'VALOR'                   = ct_valor,
   'SECUENCIAL'              = ct_secuencial
   from  cob_remesas..re_consulta_trn_cb
   where ct_fecha <> 'FECHA'
   order by ct_secuencial
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

go
