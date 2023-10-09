/************************************************************************/
/*      Archivo:                sp_b2c_consulta_transacciones.sp        */
/*      Stored procedure:       sp_b2c_consulta_transacciones           */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Santander                               */
/*      Disenado por:           Brayan Batista                          */
/*      Fecha de escritura:     04-Oct-2019                             */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                          PROPOSITO                                   */
/*      Consultar transacciones que permiten generar un reporte         */
/*      actividad del cliente en la B2C.                                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*         FECHA               AUTOR               RAZON                */
/*      04/Oct/2019       Brayan Batista       Emision Inicial          */
/************************************************************************/
use cob_bvirtual
GO

if exists (select * from sysobjects where name = 'sp_b2c_consulta_transacciones')
      drop proc sp_b2c_consulta_transacciones
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_b2c_consulta_transacciones]   (
    @i_flag_test            char(1)         = 'N',
    @i_cliente              int             ,
    @i_fecha_desde          datetime        = null,
    @i_fecha_hasta          datetime        = null
)
as  
declare
    @w_error                int             ,
    @w_msg                  varchar(300)    ,
    @w_fecha_proceso        datetime        ,
    @w_sp_name              varchar(32)     ,
    @w_fecha_desde          datetime        ,
    @w_fecha_hasta          datetime        ,
    @w_nombre_reporte       varchar(64)     ,
    @w_errores              varchar(255)    ,
    @w_cmd                  varchar(5000)   ,
    @w_batch                int             ,
    @w_buc                int             ,
    @w_comando              varchar(6000)   ,
    @w_s_app                varchar(255)    ,
    @w_path                 varchar(255)    ,
    @w_destino              varchar(255)    ,
    @w_destino2             varchar(255)    ,
    @w_fecha                datetime        ,
    @w_cabecera             varchar(5000)   ,
    @w_lineas               varchar(10)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select  @w_sp_name = 'sp_b2c_consulta_transacciones', 
        @w_batch = 3

select @w_fecha_hasta = isnull(@i_fecha_hasta, convert(varchar(10), @w_fecha_proceso, 23))

select @w_fecha_desde = isnull(@i_fecha_desde, convert(DATE, dateadd(mm,-1, convert(datetime, @w_fecha_hasta))))

select @w_fecha_hasta = convert(DATE, dateadd(dd,+1, @w_fecha_hasta))

if(@i_cliente is not null) 
    select @w_buc = en_banco from cobis..cl_ente where en_ente = @i_cliente

if(exists(select 1 from cob_bvirtual..bv_temp_tran_servicio))
    truncate table bv_temp_tran_servicio

insert into cob_bvirtual..bv_temp_tran_servicio
values('SECUENCIAL','ID CLIENTE','BUC',
'FECHA','HORA','TIPO DE TRANSACCION',
'MONTO','REFERENCIA INTERNA','REFERENCIA EXTERNA',
'IP ORIGEN')

insert into cob_bvirtual..bv_temp_tran_servicio
select
ts_secuencial as ts_secuencial,      
ts_int01 as ts_cliente,
(select en_banco from cobis..cl_ente where en_ente = @i_cliente) as ts_buc, --ts_descripcion01,
ts_fecha,
ts_hora,
(case ts_tipo_transaccion 
    when 1890023 then 'REGISTRO B2C.'
    when 1500 then 'INICIO DE SESION.'
    when 1502 then 'CIERRE DE SESION.'
    when 17006 then 'CAMBIO DE CLAVE.'
    when 1800266 then 'CAMBIO DE FRASE Y/O IMAGEN DE BIENVENIDA.'
    when 1890030 then 'BLOQUEO APP.'
    when 1890031 then 'DESBLOQUEO APP.'
    when 7297 then 'SOLICITUD DE DISPERSION.'
    when 7299 then 'AUTORIZAR INCREMENTO DE CUPO.'
    --when 11111 then 'SOLICITUD DE PAGO.'
END) as ts_tipo_transaccion,
ts_money01 as ts_monto,
ts_descripcion03 as ts_ref_interna,
ts_descripcion04 as ts_ref_externa,
ts_varchar1 as ts_ip_origen
from cob_bvirtual..bv_tran_servicio
where ts_fecha between @w_fecha_desde and @w_fecha_hasta
and ts_int01 = @i_cliente

if(@@rowcount = 0) begin
    select  @w_error = 1,
            @w_msg  = 'No existen registros para realizar la transacción'
    goto ERROR_FIN
end
----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'S_APP'

select 
@w_path = ba_path_destino,
@w_nombre_reporte = ba_arch_resultado + '_' + convert(varchar, @i_cliente) + '_' 
    + FORMAT(@w_fecha_desde, 'ddMMyyyyhhmm') + '_a_' 
    + FORMAT(@w_fecha_hasta, 'ddMMyyyyhhmm')
from cobis..ba_batch
where ba_batch = 36433

if (@@error <> 0 or @@rowcount = 0) begin
   select   @w_msg = 'NO EXISTE RUTA PATH DESTINO',
            @w_error    = 1
   goto ERROR_FIN
end

if(@i_flag_test = 'N') begin 
    select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_bvirtual..bv_temp_tran_servicio out '
    
    select @w_destino  = @w_nombre_reporte + '.txt',--'replogb2c_' + @w_nombre_reporte + '.txt',
           @w_errores  = @w_path + @w_nombre_reporte + '.err'--'replogb2c_' + @w_nombre_reporte + '.err'
    select @w_comando = @w_cmd + @w_path + @w_destino + '  -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'
    print @w_comando
    exec @w_error = xp_cmdshell @w_comando, no_output

    if @w_error <> 0 begin
        select  @w_error = 1,
                @w_msg  = 'Error generando Reporte Log B2C'
        goto ERROR_FIN
    end
end
else begin 
    SET @w_comando = 
    'exec xp_cmdshell ' + CHAR(39)
    + 'bcp "select 

    CONCAT(ts_secuencial, char(9)),
    CONCAT(ts_cliente, char(9)),
    CONCAT(ts_buc, char(9)),
    CONCAT(ts_fecha, char(9)),
    CONCAT(ts_hora, char(9)),
    CONCAT(ts_tipo_transaccion, char(9)),
    CONCAT(ts_monto, char(9)),
    CONCAT(ts_ref_interna, char(9)),
    CONCAT(ts_ref_externa, char(9)),
    CONCAT(ts_ip_origen, char(9))
    
    from cob_bvirtual..bv_temp_tran_servicio" queryout "'
    + @w_path
    + 'replogb2c_' + @w_nombre_reporte + '.txt"' + ' -b5000 -c -T -e,' 
    + CHAR(39) 
    + ', no_output'
    EXEC (@w_comando)

    if @w_error <> 0 begin
        select  @w_error = 1,
                @w_msg  = 'Error generando Reporte Log B2C'
        goto ERROR_FIN
    end
end
return 0

ERROR_FIN:
    exec cobis..sp_cerror
        @i_num = @w_error,
        @i_msg = @w_msg
    return @w_error
GO