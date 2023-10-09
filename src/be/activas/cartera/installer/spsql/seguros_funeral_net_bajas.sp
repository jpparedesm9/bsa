/************************************************************************/
/*   Archivo:              seguros_funeral_net_bajas.sp                 */
/*   Stored procedure:     sp_seguro_funeral_net_bajas                  */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Nolberto Vite                                */
/*   Fecha de escritura:   25 Junio 2018                                */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera el reporte de los clientes identificados con la cuenta N2   */
/*    “Superdigital” con el Producto 01 y Sub-Producto 25.              */
/*                                                                      */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      25/06/2018     NVI             Emision Inicial                  */
/*      21/05/2019     DCU             Cambio req. 114570               */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_seguro_funeral_net_bajas')
   drop proc sp_seguro_funeral_net_bajas
go

create proc sp_seguro_funeral_net_bajas
(
@i_param1  datetime = null
)
as

declare
@w_sp_name             varchar(32),         
@w_path_destino        varchar(200),
@w_s_app               varchar(40),
@w_cmd                 varchar(5000),
@w_destino             varchar(255),
@w_errores             varchar(255),
@w_comando             varchar(6000),
@w_error               int,
@w_path                varchar(255),
@w_mensaje             varchar(100),
@w_fecha_proc          datetime,
@w_ffecha              int,
@w_col_id              int,
@w_columna             varchar(50),
@w_cabecera            varchar(5000),
@w_destino_cabecera    varchar(255),
@w_destino_lineas      varchar(255),
@w_ultimo_dia          int,
@w_fecha_inicio        datetime,
@w_ciudad_nacional     int,
@w_dia_generar         int,
@w_fecha_final         int,
@w_dia_restar          int,
@w_fecha_hasta         datetime,
@w_est_anulado         int,
@w_est_novigente       int,
@w_est_cancelado       int,
@w_est_castigado       int,
@w_est_vencido         int,
@w_est_vigente         int

TRUNCATE TABLE seguros_funeral_net_bajas_tmp

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_anulado    = @w_est_anulado    out,
@o_est_novigente  = @w_est_novigente  out,
@o_est_cancelado  = @w_est_cancelado  out,
@o_est_castigado  = @w_est_castigado  out,
@o_est_vencido    = @w_est_vencido    out,
@o_est_vigente    = @w_est_vigente    out 

if (@i_param1 is null)
begin
   select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso
end
else
begin
   select @w_fecha_proc = @i_param1
end

select @w_ffecha = 103

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--Dia de generacion de reporte (25)
select @w_dia_generar = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'DGRFNB'
and    pa_producto = 'CCA'

/*******************************************************/
/*                 Validacion Baja                     */
/*******************************************************/
select op_operacion, op_cliente, op_fecha_ult_proceso
into #cliente_cancelado_castigado
from ca_vigencia_funeral_net,
     ca_operacion
where vfn_fecha_baja is null
and   vfn_ente      = op_cliente
and   vfn_operacion = op_operacion
and   op_estado    in (@w_est_cancelado, @w_est_castigado)
and   op_toperacion <> 'REVOLVENTE'

insert into #cliente_cancelado_castigado
select op_operacion, op_cliente, op_fecha_ult_proceso
from ca_vigencia_funeral_net, ca_operacion
where vfn_fecha_baja is null
and   vfn_ente      = op_cliente
and   vfn_operacion = op_operacion
and   op_estado     = @w_est_cancelado
and   op_toperacion = 'REVOLVENTE'
and   op_fecha_fin  < @w_fecha_proc

insert into #cliente_cancelado_castigado
select op_operacion, op_cliente, op_fecha_ult_proceso
from ca_vigencia_funeral_net, ca_operacion
where vfn_fecha_baja is null
and   vfn_ente      = op_cliente
and   vfn_operacion = op_operacion
and   op_estado     = @w_est_castigado
and   op_toperacion = 'REVOLVENTE'

update ca_vigencia_funeral_net
set vfn_fecha_baja     = op_fecha_ult_proceso,
    vfn_fecha_pro_baja = @w_fecha_proc
from  #cliente_cancelado_castigado
where vfn_operacion = op_operacion

/*******************************************************/
/*******************************************************/


insert into seguros_funeral_net_bajas_tmp
select
'IDENTIFICADOR',
'FECHA DE BAJA'

/*
--Determinar si el dia es feriado
if exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_proc )
                begin
                               -- HASTA ENCONTRAR EL SIGUIENTE DIA HABIL
                               select  @w_fecha_hasta  = dateadd(DAY,1,@w_fecha_proc)

                               while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_hasta)
                               select @w_fecha_hasta= dateadd(DAY,1,@w_fecha_hasta) 

                               select  @w_fecha_hasta  = dateadd(DAY,-1,@w_fecha_hasta)
                end
else      
                select  @w_fecha_hasta = @w_fecha_proc
*/

SELECT @w_fecha_final = DATENAME(DAY,@w_fecha_hasta)

--Obtener Fecha de inicio del mes
/*SELECT @w_dia_restar = DATENAME(DAY,@w_fecha_hasta)
SELECT @w_dia_restar = @w_dia_restar - 1
select @w_fecha_inicio = dateadd(DAY,-@w_dia_restar,@w_fecha_hasta)*/
select @w_fecha_inicio = dateadd(mm,-1,@w_fecha_hasta) --Se resta un mes
select @w_fecha_inicio = dateadd(dd,1,@w_fecha_inicio) --Se agrega el dia que se calculo en el mes passado
print 'Fecha Inicio' + convert(varchar,@w_fecha_inicio)
print 'Fecha hasta' + convert(varchar,@w_fecha_hasta)

--Datos de Credito para tipo 01 y subtipo 0025
insert into seguros_funeral_net_bajas_tmp
SELECT 
	vfn_buc,
	convert(varchar(10),vfn_fecha_baja,103)
from ca_vigencia_funeral_net
where vfn_fecha_pro_baja =  @w_fecha_proc

if not exists (select 1 from seguros_funeral_net_bajas_tmp) return 0

 ----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..seguros_funeral_net_bajas_tmp out '

select @w_destino= @w_path + 'FUNERAL_NET_BAJAS_' +  replace(CONVERT(varchar(10), @w_fecha_proc, @w_ffecha),'/', '')+ '.txt',
                    @w_errores  = @w_path + 'FUNERAL_NET_BAJAS_' +  replace(CONVERT(varchar(10), @w_fecha_proc, @w_ffecha),'/', '')+ '.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

 PRINT ' CMD: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724681,
   @w_mensaje = 'Error generando Archivo de Seguros Funeral Net Bajas'
   goto ERROR
end

return 0

ERROR:
exec cobis..sp_errorlog
                @i_fecha        = @w_fecha_proc,
                @i_error        = @w_error,
                @i_usuario      = 'usrbatch',
                @i_tran         = 26004,
                @i_descripcion  = @w_mensaje,
                @i_tran_name    =null,
                @i_rollback     ='S'
return @w_error

go