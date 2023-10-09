
use cob_cartera
go

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

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso
 
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


insert into seguros_funeral_net_bajas_tmp
select
'IDENTIFICADOR',
'FECHA DE BAJA'


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
	op_banco,
	convert(varchar(10),@w_fecha_proc,103)
FROM cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
WHERE op_estado          =  1
and op_banco             =  tg_prestamo
and tg_monto             >  0
and tg_participa_ciclo   =  'S'
and tg_prestamo          <> tg_referencia_grupal
and op_toperacion        <> 'REVOLVENTE'

insert into seguros_funeral_net_bajas_tmp
select 
op_banco,
convert(varchar(10),@w_fecha_proc,103)
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'
and   op_fecha_fin > @w_fecha_proc

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

select * 
from cob_cartera..seguros_funeral_net_bajas_tmp