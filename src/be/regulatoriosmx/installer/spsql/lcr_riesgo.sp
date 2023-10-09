
/************************************************************************/
/*   Archivo:              riesgo_provision.sp                          */
/*   Stored procedure:     sp_riesgo_provision                          */
/*   Base de datos:        cob_ccnta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:                                                      */
/*   Fecha de escritura:   Marzo 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Genera archivo de interface para operaciones en mora diarias       */
/*   banco SANTANDER MX.                                                */
/*                              CAMBIOS                                 */
/*   02/01/2019         MTA            Ajustes de la sp_riesgo_provision*/
/*                                     para que se ejecute como lrc     */
/*   14/06/2019         SMO            Requerimiento 116513             */
/*   09/10/2019         DCU            Revision errores 116513          */
/*   02/03/2020         DCU            Revision errores 136138          */
/*   23/12/2020         JCASTRO        REQ#150106                       */
/*   18/03/2021         DCU            Inc#154894                       */
/*   27/12/2021         JEOM           Caso #172727                     */
/*   08/02/2022         KVI            Req.#177295-Cambio Formula       */
/*   09/03/2022         DCU            Caso #179643                     */
/*   25/08/2022         KVI            Sop.189747                       */
/************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_lcr_riesgo_prov')
   drop proc sp_lcr_riesgo_prov
go

create proc sp_lcr_riesgo_prov
(
   @i_param1   datetime = null   --FECHA REPROCESO
)

as

declare
        @w_error                int,
        @w_return               int,
        @w_mensaje              varchar(255),
        @w_sql                  varchar(8000),
        @w_msg_error            varchar(150),
        @w_comando              varchar(5000),
        @w_ruta_arch            varchar(255),
        @w_nombre_arch          varchar(150),
        @w_sp_name              varchar(30),
        @w_fecha_proceso        datetime,
        @w_msg                  varchar(255),
        @w_batch                int,
        @w_s_app                varchar(30),
        @w_destino              varchar(1000),
        @w_errores              varchar(1000),
        @w_est_no_vigente       tinyint,
        @w_est_vigente          tinyint,
        @w_est_vencido          tinyint,
        @w_est_cancelado        tinyint,
        @w_ciudad_nacional      int,
        @w_fecha_ini            datetime,
        @w_fecha_fin            datetime,
        @w_fecha_fin_ult_dia_h  datetime,
        @w_fecha_corte          datetime,
        @w_ffecha_data          smallint,
        @w_ffecha_reporte       smallint,
        @w_columna              varchar(50),
        @w_col_id               int,
        @w_cabecera             varchar(8000),
        @w_nom_cabecera         varchar(8000),
        @w_nom_columnas         varchar(8000),
        @w_cont_columnas        int,
        @w_fecha                datetime,
        @w_operacion            cuenta, --para barrerse las operaciones
        @w_fecha_prim_cuota     datetime,
        @w_fecha_ult_cuota      datetime,
        @w_ult_cuota      		  int,
        @w_fecha_siguiente      datetime,
        @w_num_cuota            int,
        @w_max_cuota            int,
        @w_banco                cuenta,
		  @w_ini_lcr              datetime,
	     @w_meses_apertura       int,  
	     @w_fecha_exig           varchar(20),  
		  @w_cmd                  varchar(8000),
		  @w_path                 varchar(255),
        @w_arch_contenido       varchar(255),
        @w_arch_cabecera        varchar(255),
        @w_arch_completo        varchar(255),
        @w_arch_errores         varchar(255),
		  @w_nombre_archivo       varchar(255),
        @w_count                int,
        @w_mes 					  int,
        @w_anio                 int,
        @w_ini_mes              datetime,
        @w_primer_dia_habil     datetime,
        @w_dia_semana_corte     int,
        @w_ultimo_corte         datetime,
        @w_num_semanal          int,
        @w_cont_semanal         int,
        @w_aprobado             money,
        @w_limite_t1            money,
        @w_limite_t2            money,
        @w_limite_t3            money,
        @w_limite_t4            money,
        @w_limite_t5            money,
        @w_limite_t6            money,
  		@w_limite_t7            money,
  		@w_limite_t8            money,
  		@w_saldo                money,
  		@w_num_dias_vencimiento int,
        @w_est_castigado        int,
        @w_est_diferido         int,
        @w_est_suspenso         int,
        @w_fecha_ini_mes_ant    datetime,
        @w_monto_exigible       money,
        @w_pago                 money,
        @w_numero_dividendo     int,
        @w_sumatoria            money,
        @w_exigible             char(1),
        @w_flag_sumar           char(1),
        @w_fecha_exig_min       datetime,
        @w_fin_mes              datetime,
        @w_fecha_aux            datetime,
		@w_est_etapa2           int
        

select @w_sp_name = 'sp_lcr_riesgo_prov'

declare @resultadobcp table (linea varchar(max))

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_ffecha_data = 111, @w_ffecha_reporte = 112, @w_batch = 36423

select @w_fecha = @i_param1

if @w_fecha is null
   select @w_fecha = @w_fecha_proceso

exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_castigado = @w_est_castigado out,
@o_est_diferido  = @w_est_diferido  out,
@o_est_suspenso  = @w_est_suspenso  out, 
@o_est_cancelado = @w_est_cancelado out,
@o_est_etapa2    = @w_est_etapa2    out 

select 
@w_mes              = MONTH (@w_fecha),  
@w_anio             = YEAR (@w_fecha), 
@w_ini_mes          = datefromparts(@w_anio, @w_mes, 1),
@w_dia_semana_corte = 3, --martes
@w_primer_dia_habil = @w_ini_mes

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_num_dias_vencimiento = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DVLCR'
and   pa_producto = 'CCA'

while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_primer_dia_habil ) begin
	select @w_primer_dia_habil = dateadd(day,1,@w_primer_dia_habil)
end

select @w_fecha_fin = dateadd(dd,0-datepart(dd,@w_fecha),@w_fecha)

if @w_fecha <> @w_primer_dia_habil
	return 0
select @w_fecha_ini_mes_ant= convert(datetime,convert(varchar(2),month(@w_fecha_fin))+'/01/'+convert(varchar(4),year(@w_fecha_fin)))
select @w_ultimo_corte = @w_fecha_fin

while (datepart(dw,@w_ultimo_corte) <> @w_dia_semana_corte) begin
	select @w_ultimo_corte = dateadd(dd,-1,@w_ultimo_corte)
end

if @w_error <> 0 goto ERROR_PROCESO

select @w_fecha_fin_ult_dia_h = @w_fecha_fin
while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_fecha_fin_ult_dia_h ) begin
	select @w_fecha_fin_ult_dia_h = dateadd(day,-1,@w_fecha_fin_ult_dia_h)
end


/* Fecha */
print '@w_fecha_fin:' + convert(varchar,@w_fecha_fin )
print '@w_fecha: ' + convert(varchar,@w_fecha)
print '@w_primer_dia_habil: ' + convert(varchar,@w_primer_dia_habil)
print '@w_ultimo_corte: ' + convert(varchar,@w_ultimo_corte)
print '@w_fecha_fin_ult_dia_h: ' + convert(varchar,@w_fecha_fin_ult_dia_h)

create table #fechas_semanal( 
   _num_cuota int,
	_fecha datetime,
	_fecha_ini datetime
)


create table #fechas_catorcenal_1( 
   _num_cuota int,
	_fecha datetime,
	_fecha_ini datetime
)


create table #fechas_catorcenal_2( 
   _num_cuota int,
	_fecha datetime,
	_fecha_ini datetime	
)


create table #fechas_mensual( 
   _num_cuota int,
   _fecha datetime,
   _fecha_ini datetime	
)

if object_id('tempdb..#prestamos_dividendos') is not null
   drop table #prestamos_dividendos

create table #prestamos_dividendos(
secuencial      int IDENTITY(1,1),
operacion       int, 
banco           cuenta,
cliente         int,
monto_aprobado  money,
id_inst_proceso int,
fecha_ini       datetime null,
fecha_fin       datetime null,
fecha_des       datetime null,
utilizacion     money,
pagos           money,
diferencia      money,
numero_cuota    int
)
exec cob_cartera..sp_lcr_gen_dividendos 
@i_cortes = 52, 
@i_fecha  = @w_ultimo_corte

/***LLENAR FECHAS ***/

select @w_cont_semanal = 1
select @w_fecha_siguiente = @w_ultimo_corte

truncate table sb_lcr_riesgo_provision

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = 'COBIS_PROV_LCR' + '_' + convert(varchar(8), @w_fecha_fin, 112)
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte  = @w_fecha_fin

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
   select @w_fecha_corte = dateadd(dd,-1,@w_fecha_corte)


create table #universo_provisiones( 
   _up_banco               cuenta,
   _up_codigo_cliente      int, 
	_up_fecha_concesion     datetime,
	_up_periodicidad_cuota  datetime,
	_up_saldo_capital       money,
	_up_saldo_interes       money,
	_up_dias_mora_365       int,
	_up_flag_mora           int,
	_up_catorcenal          int, --1 o 2
    _up_monto               money,
	_up_tramite             int,
	_up_folio_buro          varchar(64)
)

create table #prestamos_cliente(
	pc_cliente          int,
	pc_banco            cuenta,
	pc_dias_mora_365    int,
	pc_saldo_capital    money,
	pc_saldo_interes    money
)

create table #operaciones_sin_utilizacion
(su_banco           cuenta)

--OBTENER TODAS LAS OPERACIONES REVOLVENTES
insert into #universo_provisiones
select 
_up_banco                    = ltrim(rtrim(do_banco)),
_up_codigo_cliente           = convert(varchar(20), isnull(do_codigo_cliente,'')),
_up_fecha_concesion          = do_fecha_concesion,
_up_periodicidad_cuota       = do_periodicidad_cuota,
_up_saldo_capital            = do_saldo_cap,
_up_saldo_interes            = do_saldo_int,
_up_dias_mora_365            = do_dias_mora_365,
_up_flag_mora                = 0,
_up_catorcenal               = 0,
_up_monto                    = do_monto,
_up_tramite                  = do_tramite,
_up_folio_buro               = null
from  cob_conta_super..sb_dato_operacion
where do_fecha      = @w_fecha_corte
and   do_aplicativo = 7
and   do_tipo_operacion  in ('REVOLVENTE')
and   (do_estado_cartera in (@w_est_vigente, @w_est_etapa2, @w_est_vencido) or   (do_estado_cartera = @w_est_cancelado and do_fecha_vencimiento >= @w_fecha ))

insert into #operaciones_sin_utilizacion(su_banco)
select _up_banco
from #universo_provisiones
where _up_monto = 0

update #universo_provisiones
--JEOM 27/12/2021
--set _up_flag_mora = 1
--where _up_dias_mora_365 >= @w_num_dias_vencimiento
set _up_flag_mora = CASE WHEN _up_dias_mora_365 <= 30 THEN '0' 
	                      WHEN _up_dias_mora_365 >= 31 AND _up_dias_mora_365 <= 89 THEN '1'
	                      WHEN _up_dias_mora_365 >= 90 THEN '2'
                     END  
--JEOM 27/12/2021 FIN

--Folio Consulta Buro -- Sop.189747
--Datos Credito
update #universo_provisiones
set   _up_folio_buro = tr_folio_buro
from  cob_credito..cr_tramite
where tr_tramite = _up_tramite

update #universo_provisiones 
set _up_folio_buro = ib_folio
from cob_credito..cr_interface_buro
where _up_codigo_cliente = ib_cliente
and   ib_estado  = 'V'
and   ib_folio is not null
and   _up_folio_buro is null  

--OBTENER TODOS LOS PRESTAMOS DEL CLIENTE 
insert into #prestamos_cliente
select 
pc_cliente         = do_codigo_cliente,
pc_banco           = do_banco,
pc_dias_mora_365   = do_dias_mora_365,
pc_saldo_capital   = do_saldo_cap,
pc_saldo_interes   = do_saldo_int
from cob_conta_super..sb_dato_operacion
where do_codigo_cliente in (select _up_codigo_cliente from #universo_provisiones)
and do_fecha = @w_fecha_corte

select ex_banco   = pc_banco,
       ex_cap_ex  = case when (dc_estado = @w_est_vencido) or (dc_estado = @w_est_vigente and dc_fecha_vto = @w_fecha_fin_ult_dia_h) then
                       isnull(sum(dc_cap_cuota),0) - isnull(sum(dc_cap_pag),0)
                    else 0 end,
       ex_int_ex  = case when (dc_estado = @w_est_vencido) or (dc_estado = @w_est_vigente and dc_fecha_vto = @w_fecha_fin_ult_dia_h) then
                       isnull(sum(dc_int_cuota),0) - isnull(sum(dc_int_pag),0)
                    else 0 end
into #operacion_exigibles                    
from cob_conta_super..sb_dato_cuota_pry, 
     #prestamos_cliente
where dc_fecha     = @w_fecha_corte
and   dc_banco     = pc_banco
group by pc_banco, dc_estado, dc_fecha_vto

select ex_banco    ,
       ex_cap_ex = sum(ex_cap_ex),
       ex_int_ex = sum(ex_int_ex)
into #opera_exigible       
from #operacion_exigibles
group by ex_banco

update #prestamos_cliente set
pc_saldo_capital = ex_cap_ex,
pc_saldo_interes = ex_int_ex
from #opera_exigible
where pc_banco   = ex_banco    

--CARGA INICIAL DE LA TABLA
insert into sb_lcr_riesgo_provision
select 
Num_cred              = ltrim(rtrim(_up_banco)),
Num_cliente           = convert(varchar(20), isnull(_up_codigo_cliente,'')),
Cod_producto          = '96',
Cod_subproducto       =  '0002',
Cod_periodo_capital   = case _up_periodicidad_cuota
                             when 1  then 'D'
                             when 7  then 'W'
							 when 14 then 'Q'
                             when 15 then 'Q'
                             when 30 then 'M'
                             when 90 then 'T'
                        end,
Cod_periodo_intereses = case _up_periodicidad_cuota
                             when 1  then 'D'
                             when 7  then 'W'
							 when 14 then 'Q'
                             when 15 then 'Q'
                             when 30 then 'M'
                             when 90 then 'T'
                        end,
Exig_T1               = convert(varchar(20), 0.00),
Pago_T1               = convert(varchar(20), 0.00),
Fec_Exig_T1           = convert(varchar(20), ''),
Fec_Pago_T1           = convert(varchar(20), ''),
Exig_T2               = convert(varchar(20), 0.00),
Pago_T2               = convert(varchar(20), 0.00),
Fec_Exig_T2           = convert(varchar(20), ''),
Fec_Pago_T2           = convert(varchar(20), ''),
Exig_T3               = convert(varchar(20), 0.00),
Pago_T3               = convert(varchar(20), 0.00),
Fec_Exig_T3           = convert(varchar(20), ''),
Fec_Pago_T3           = convert(varchar(20), ''),
Exig_T4               = convert(varchar(20), 0.00),
Pago_T4               = convert(varchar(20), 0.00),
Fec_Exig_T4           = convert(varchar(20), ''),
Fec_Pago_T4           = convert(varchar(20), ''),
Exig_T5               = convert(varchar(20), 0.00),
Pago_T5               = convert(varchar(20), 0.00),
Fec_Exig_T5           = convert(varchar(20), ''),
Fec_Pago_T5           = convert(varchar(20), ''),
Exig_T6               = convert(varchar(20), 0.00),
Pago_T6               = convert(varchar(20), 0.00),
Fec_Exig_T6           = convert(varchar(20), ''),
Fec_Pago_T6           = convert(varchar(20), ''),
Exig_T7               = convert(varchar(20), 0.00),
Pago_T7               = convert(varchar(20), 0.00),
Fec_Exig_T7           = convert(varchar(20), ''),
Fec_Pago_T7           = convert(varchar(20), ''),
Exig_T8               = convert(varchar(20), 0.00),
Pago_T8               = convert(varchar(20), 0.00),
Fec_Exig_T8           = convert(varchar(20), ''),
Fec_Pago_T8           = convert(varchar(20), ''),
Exig_T9               = convert(varchar(20), 0.00),
Pago_T9               = convert(varchar(20), 0.00),
Fec_Exig_T9           = convert(varchar(20), ''),
Fec_Pago_T9           = convert(varchar(20), ''),
Exig_T10              = convert(varchar(20), 0.00),
Pago_T10              = convert(varchar(20), 0.00),
Fec_Exig_T10          = convert(varchar(20), ''),
Fec_Pago_T10          = convert(varchar(20), ''),
Exig_T11              = convert(varchar(20), 0.00),
Pago_T11              = convert(varchar(20), 0.00),
Fec_Exig_T11          = convert(varchar(20), ''),
Fec_Pago_T11          = convert(varchar(20), ''),
Exig_T12              = convert(varchar(20), 0.00),
Pago_T12              = convert(varchar(20), 0.00),
Fec_Exig_T12          = convert(varchar(20), ''),
Fec_Pago_T12          = convert(varchar(20), ''),
Exig_T13              = convert(varchar(20), 0.00),
Pago_T13              = convert(varchar(20), 0.00),
Fec_Exig_T13          = convert(varchar(20), ''),
Fec_Pago_T13          = convert(varchar(20), ''),
Exig_T14              = convert(varchar(20), 0.00),
Pago_T14              = convert(varchar(20), 0.00),
Fec_Exig_T14          = convert(varchar(20), ''),
Fec_Pago_T14          = convert(varchar(20), ''),
Exig_T15              = convert(varchar(20), 0.00),
Pago_T15              = convert(varchar(20), 0.00),
Fec_Exig_T15          = convert(varchar(20), ''),
Fec_Pago_T15          = convert(varchar(20), ''),
Exig_T16              = convert(varchar(20), 0.00),
Pago_T16              = convert(varchar(20), 0.00),
Fec_Exig_T16          = convert(varchar(20), ''),
Fec_Pago_T16          = convert(varchar(20), ''),
Exig_T17			  =convert(varchar(20),0.00),
Pago_T17			  =convert(varchar(20),0.00),
Fec_Exig_T17		  =convert(varchar(20),''),
Fec_Pago_T17		  =convert(varchar(20),''),
Exig_T18			  =convert(varchar(20),0.00),
Pago_T18			  =convert(varchar(20),0.00),
Fec_Exig_T18		  =convert(varchar(20),''),
Fec_Pago_T18		  =convert(varchar(20),''),
Exig_T19			  =convert(varchar(20),0.00),
Pago_T19			  =convert(varchar(20),0.00),
Fec_Exig_T19		  =convert(varchar(20),''),
Fec_Pago_T19		  =convert(varchar(20),''),
Exig_T20			  =convert(varchar(20),0.00),
Pago_T20			  =convert(varchar(20),0.00),
Fec_Exig_T20		  =convert(varchar(20),''),
Fec_Pago_T20		  =convert(varchar(20),''),
Exig_T21			  =convert(varchar(20),0.00),
Pago_T21			  =convert(varchar(20),0.00),
Fec_Exig_T21		  =convert(varchar(20),''),
Fec_Pago_T21		  =convert(varchar(20),''),
Exig_T22			  =convert(varchar(20),0.00),
Pago_T22			  =convert(varchar(20),0.00),
Fec_Exig_T22		  =convert(varchar(20),''),
Fec_Pago_T22		  =convert(varchar(20),''),
Exig_T23			  =convert(varchar(20),0.00),
Pago_T23			  =convert(varchar(20),0.00),
Fec_Exig_T23		  =convert(varchar(20),''),
Fec_Pago_T23		  =convert(varchar(20),''),
Exig_T24			  =convert(varchar(20),0.00),
Pago_T24			  =convert(varchar(20),0.00),
Fec_Exig_T24		  =convert(varchar(20),''),
Fec_Pago_T24		  =convert(varchar(20),''),
Exig_T25			  =convert(varchar(20),0.00),
Pago_T25			  =convert(varchar(20),0.00),
Fec_Exig_T25		  =convert(varchar(20),''),
Fec_Pago_T25		  =convert(varchar(20),''),
Exig_T26			  =convert(varchar(20),0.00),
Pago_T26			  =convert(varchar(20),0.00),
Fec_Exig_T26		  =convert(varchar(20),''),
Fec_Pago_T26		  =convert(varchar(20),''),
Exig_T27			  =convert(varchar(20),0.00),
Pago_T27			  =convert(varchar(20),0.00),
Fec_Exig_T27		  =convert(varchar(20),''),
Fec_Pago_T27		  =convert(varchar(20),''),
Exig_T28			  =convert(varchar(20),0.00),
Pago_T28			  =convert(varchar(20),0.00),
Fec_Exig_T28		  =convert(varchar(20),''),
Fec_Pago_T28		  =convert(varchar(20),''),
Exig_T29			  =convert(varchar(20),0.00),
Pago_T29			  =convert(varchar(20),0.00),
Fec_Exig_T29		  =convert(varchar(20),''),
Fec_Pago_T29		  =convert(varchar(20),''),
Exig_T30			  =convert(varchar(20),0.00),
Pago_T30			  =convert(varchar(20),0.00),
Fec_Exig_T30		  =convert(varchar(20),''),
Fec_Pago_T30		  =convert(varchar(20),''),

Exig_T31			  =convert(varchar(20),0.00),
Pago_T31			  =convert(varchar(20),0.00),
Fec_Exig_T31		  =convert(varchar(20),''),
Fec_Pago_T31		  =convert(varchar(20),''),
Exig_T32			  =convert(varchar(20),0.00),
Pago_T32			  =convert(varchar(20),0.00),
Fec_Exig_T32		  =convert(varchar(20),''),
Fec_Pago_T32		  =convert(varchar(20),''),
Exig_T33			  =convert(varchar(20),0.00),
Pago_T33			  =convert(varchar(20),0.00),
Fec_Exig_T33		  =convert(varchar(20),''),
Fec_Pago_T33		  =convert(varchar(20),''),
Exig_T34			  =convert(varchar(20),0.00),
Pago_T34			  =convert(varchar(20),0.00),
Fec_Exig_T34		  =convert(varchar(20),''),
Fec_Pago_T34		  =convert(varchar(20),''),
Exig_T35			  =convert(varchar(20),0.00),
Pago_T35			  =convert(varchar(20),0.00),
Fec_Exig_T35		  =convert(varchar(20),''),
Fec_Pago_T35		  =convert(varchar(20),''),
Exig_T36			  =convert(varchar(20),0.00),
Pago_T36			  =convert(varchar(20),0.00),
Fec_Exig_T36		  =convert(varchar(20),''),
Fec_Pago_T36		  =convert(varchar(20),''),
Exig_T37			  =convert(varchar(20),0.00),
Pago_T37			  =convert(varchar(20),0.00),
Fec_Exig_T37		  =convert(varchar(20),''),
Fec_Pago_T37		  =convert(varchar(20),''),
Exig_T38			  =convert(varchar(20),0.00),
Pago_T38			  =convert(varchar(20),0.00),
Fec_Exig_T38		  =convert(varchar(20),''),
Fec_Pago_T38		  =convert(varchar(20),''),
Exig_T39			  =convert(varchar(20),0.00),
Pago_T39			  =convert(varchar(20),0.00),
Fec_Exig_T39		  =convert(varchar(20),''),
Fec_Pago_T39		  =convert(varchar(20),''),
Exig_T40			  =convert(varchar(20),0.00),
Pago_T40			  =convert(varchar(20),0.00),
Fec_Exig_T40		  =convert(varchar(20),''),
Fec_Pago_T40		  =convert(varchar(20),''),
Exig_T41			  =convert(varchar(20),0.00),
Pago_T41			  =convert(varchar(20),0.00),
Fec_Exig_T41		  =convert(varchar(20),''),
Fec_Pago_T41		  =convert(varchar(20),''),
Exig_T42			  =convert(varchar(20),0.00),
Pago_T42			  =convert(varchar(20),0.00),
Fec_Exig_T42		  =convert(varchar(20),''),
Fec_Pago_T42		  =convert(varchar(20),''),
Exig_T43			  =convert(varchar(20),0.00),
Pago_T43			  =convert(varchar(20),0.00),
Fec_Exig_T43		  =convert(varchar(20),''),
Fec_Pago_T43		  =convert(varchar(20),''),
Exig_T44			  =convert(varchar(20),0.00),
Pago_T44			  =convert(varchar(20),0.00),
Fec_Exig_T44		  =convert(varchar(20),''),
Fec_Pago_T44		  =convert(varchar(20),''),
Exig_T45			  =convert(varchar(20),0.00),
Pago_T45			  =convert(varchar(20),0.00),
Fec_Exig_T45		  =convert(varchar(20),''),
Fec_Pago_T45		  =convert(varchar(20),''),
Exig_T46			  =convert(varchar(20),0.00),
Pago_T46			  =convert(varchar(20),0.00),
Fec_Exig_T46		  =convert(varchar(20),''),
Fec_Pago_T46		  =convert(varchar(20),''),
Exig_T47			  =convert(varchar(20),0.00),
Pago_T47			  =convert(varchar(20),0.00),
Fec_Exig_T47		  =convert(varchar(20),''),
Fec_Pago_T47		  =convert(varchar(20),''),
Exig_T48			  =convert(varchar(20),0.00),
Pago_T48			  =convert(varchar(20),0.00),
Fec_Exig_T48		  =convert(varchar(20),''),
Fec_Pago_T48		  =convert(varchar(20),''),
Exig_T49			  =convert(varchar(20),0.00),
Pago_T49			  =convert(varchar(20),0.00),
Fec_Exig_T49		  =convert(varchar(20),''),
Fec_Pago_T49		  =convert(varchar(20),''),
Exig_T50			  =convert(varchar(20),0.00),
Pago_T50			  =convert(varchar(20),0.00),
Fec_Exig_T50		  =convert(varchar(20),''),
Fec_Pago_T50		  =convert(varchar(20),''),
Exig_T51			  =convert(varchar(20),0.00),
Pago_T51			  =convert(varchar(20),0.00),
Fec_Exig_T51		  =convert(varchar(20),''),
Fec_Pago_T51		  =convert(varchar(20),''),
Exig_T52			  =convert(varchar(20),0.00),
Pago_T52			  =convert(varchar(20),0.00),
Fec_Exig_T52		  =convert(varchar(20),''),
Fec_Pago_T52		  =convert(varchar(20),''),
Imp_total_riesgo      = convert(varchar(20), isnull(_up_saldo_capital,0.00) + isnull(_up_saldo_interes, 0.00)),
Saldo_T1              = convert(varchar(20), 0.00),
Saldo_T2              = convert(varchar(20), 0.00),
Saldo_T3              = convert(varchar(20), 0.00),
Saldo_T4              = convert(varchar(20), 0.00),
Saldo_T5              = convert(varchar(20), 0.00),
Saldo_T6              = convert(varchar(20), 0.00),
Saldo_T7              = convert(varchar(20), 0.00),
Saldo_T8              = convert(varchar(20), 0.00),
Pago_SIC              = convert(varchar(10), 0.00),
Monto_SIC             = convert(varchar(10), 0.00),
Antig_SIC             = convert(varchar(10), 0.00),
Meses                 = convert(varchar(10), 0),
Imp_limite_corte      = convert(varchar(20),0.00),
Imp_limite_t1        = null,
Imp_limite_t2         = null,
Imp_limite_t3         = null,
Imp_limite_t4         = null,
Imp_limite_t5         = null,
Imp_limite_t6        	= null,
Imp_limite_t7        	= null,
Imp_limite_t8         = null,
Imp_pago_minimo_corte = convert(varchar(20),0.00),
meses_apertura        = convert(varchar,floor(datediff(day,_up_fecha_concesion,@w_fecha_fin)/30)),---convert(varchar,ceiling(datediff(day,_up_fecha_concesion,@w_fecha_fin)/30)),
Imp_limite_fch_calculo= convert(varchar(20),0.00),
Flg_Disp              = convert(varchar(1),0),
Flg_Mora              = convert(varchar(1),_up_flag_mora),
Flag_Buro             = convert(varchar(1),0),
Flag_Adviser          = convert(varchar(1),0),
Flag_Atr_Ins          = convert(varchar(1),0),
Monto_Pagar_Ins       = convert(varchar(20), 0.00),
Fec_Prim_Des          = '00010101',
Folio_Consulta_Buro   = _up_folio_buro
from #universo_provisiones
if @@error != 0
begin
   print 'Error en la carga inicial de Operaciones'
   select
   @w_error   = 724617,
   @w_mensaje = 'Error en la carga inicial de Operaciones'
   goto ERROR_PROCESO
end


-- Inicio Req.#177295 ------------------------------------------------

/* Capitales e intereses*/
select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vigente, @w_est_vencido, @w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vigente,@w_est_vencido)  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),
--SEGUROS
dr_seg_saldo     = sum(case when dr_categoria  = 'S' then  isnull(dr_valor, 0) else 0 end)
into #rubros
from sb_lcr_riesgo_provision, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_corte
and   dr_aplicativo = 7
and   dr_banco      = Num_cred
group by dr_banco

create table #rubros_hrc(
  imp_cap_noexig        money        null,
  imp_cap_exig          money        null,
  imp_int_noexig        money        null,
  imp_int_exig          money        null,
  imp_int_suspen        money        null,
  imp_seguro_vida       money        null,
  imp_total_riesgo      money        null,
  num_cred              varchar(24)  null
)

insert into #rubros_hrc
select
imp_cap_noexig           = dr_cap_vig_ne,
imp_cap_exig             = dr_cap_vig_ex,
imp_int_noexig           = dr_int_vig_ne + dr_int_ven_ne,
imp_int_exig             = dr_int_vig_ex + dr_int_ven_ex,
imp_int_suspen           = dr_int_sus_ex + dr_int_sus_ne,
imp_seguro_vida          = dr_seg_saldo,
imp_total_riesgo         = null,
num_cred                 = dr_banco  
from #rubros

update #rubros_hrc set 
imp_total_riesgo         = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0)

update sb_lcr_riesgo_provision
set Imp_total_riesgo = convert(varchar(20), isnull(imp_total_riesgo,0.00))
from #rubros_hrc
where num_cred       = Num_cred

-- Fin Req.#177295 --------------------------------------------------------------


update sb_lcr_riesgo_provision set
Flg_Disp = convert(varchar(1),1)
from sb_dato_transaccion
where Num_cred = dt_banco
and dt_fecha_trans >= @w_fecha_ini_mes_ant
and dt_fecha_trans <= @w_fecha_corte
and dt_tipo_trans = 'DES' 

update sb_lcr_riesgo_provision
set Flag_Atr_Ins  = convert(varchar,1)
from #prestamos_cliente
where Num_cliente =  convert(varchar,pc_cliente)
and pc_dias_mora_365 > 0


create table #saldos(
	sa_cliente  int,
   sa_saldo    money	
)

--SALDOS DE LOS PRESTAMOS DEL CIENTE
insert into #saldos
select
pc_cliente,
sum(pc_saldo_capital)+sum(pc_saldo_interes)
from #prestamos_cliente 
group by pc_cliente

--REQ#150106
/*update sb_lcr_riesgo_provision
set    Monto_Pagar_Ins  = convert(varchar,do_valor_mora)
from   cob_conta_super..sb_dato_operacion
where  Num_cred = do_banco 
and    do_fecha = @w_fecha_corte*/

/* REQ#150106
update sb_lcr_riesgo_provision set
Num_cliente = isnull(en_banco,'')
from  cobis..cl_ente
where en_ente = convert(int,Num_cliente)
 */

if @@error != 0
begin
   print 'Error al actualizar informacion referencial de Clientes'
   select
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion referencial de Clientes'
   goto ERROR_PROCESO
end


--VALORES EXIGIBLES DE LAS CUOTAS DE LAS OPERACIONES 
select 
ex_banco     = dc_banco,
ex_num_cuota = dc_num_cuota,
ex_max_cuota = max(dc_num_cuota),
ex_Cuota     = isnull(sum(dc_cap_cuota + dc_int_acum),0),
ex_Pago      = isnull(sum(dc_cap_pag + dc_int_pag),0),
ex_Exigible  = case when (dc_estado = @w_est_vencido) or (dc_estado = @w_est_vigente and dc_fecha_vto = @w_fecha_fin_ult_dia_h) then
               isnull(sum(dc_cap_cuota + dc_int_cuota + dc_iva_int_cuota),0) - isnull(sum(dc_cap_pag + dc_int_pag + dc_iva_int_pag),0) -- Suma de IVA Sop.189747
               else 0 end,
ex_Fec_Exig  = isnull(max(dc_fecha_vto),'01/01/1900'),
ex_Fec_Pago  = '01/01/1900',
ex_total_Ex  = convert(money,0),
ex_Exig_B52  = isnull(sum(dc_cap_cuota + dc_int_cuota + dc_iva_int_cuota),0), -- Suma de IVA Sop.189747
ex_fecha_can = dc_fecha_can
into  #exigibles
from  cob_conta_super..sb_dato_cuota_pry,
      cob_conta_super..sb_lcr_riesgo_provision
where dc_fecha      = @w_fecha_corte
and   dc_aplicativo = 7
and   dc_fecha_vto  <= @w_fecha_fin
and dc_banco        = Num_cred
group by dc_banco, dc_num_cuota, dc_estado, dc_fecha_vto, dc_fecha_can
order by dc_banco, dc_num_cuota, dc_estado, dc_fecha_vto

if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end



update #universo_provisiones
set _up_catorcenal = 1
from #exigibles
where _up_periodicidad_cuota = 14
and ex_Fec_Exig in (select _fecha from #fechas_catorcenal_1)

update #universo_provisiones
set _up_catorcenal = 2
from #exigibles
where _up_periodicidad_cuota = 14
and ex_Fec_Exig in (select _fecha from #fechas_catorcenal_2)

create table #exigible_cuotas(
	banco           cuenta,
	num_cuota       int,
    max_cuota       int,
	Exig            money,
	Pago            money,
	Fec_Exig        datetime null,
	Fec_Pago    	datetime null,
	Fec_Exig_Tmp    datetime null,
	Fec_Exig_Ini    datetime null,
	ExigTotal       money  null,
   	exigible        char(1)
)


--LLENAR LA TABLA CON CADA UNA DE LAS FECHAS DE CORTE DE LAS OPERACIONES

insert into #exigible_cuotas
select banco,numero_cuota,numero_cuota,0,0,fecha_fin,null,fecha_fin, fecha_ini,0, 'N'
from #prestamos_dividendos




select @w_fecha_exig_min = min(Fec_Exig_Ini) from #exigible_cuotas

select 
@w_mes = MONTH (@w_fecha_exig_min),  
@w_anio= YEAR (@w_fecha_exig_min)
select @w_fecha_aux = convert(datetime,convert(varchar(2),@w_mes)+'/01/'+convert(varchar(4),@w_anio))  

create table #fechas(
fecha_ini_mes  datetime,
fecha_fin_mes  datetime)

create table #totales(
banco        varchar(24) ,
num_cuota    int,
fecha_exig   datetime,
monto_sumado money
)


create table #p_total(
banco_p        varchar(24) ,
--num_cuota      int,
monto_pagado   money,
fecha_cancela  datetime
)

create table #pagos_fechas_t(
banco_p      varchar(24) ,
monto_pagado money,
ex_fecha_can datetime
)

select * into #exigibles_f from #exigibles where 1 = 2
select * into #exigibles_t from #exigibles where 1 = 2

truncate table #exigibles_t

while @w_fecha_aux < @w_fecha
begin
   truncate table #exigibles_f
   truncate table #totales
   truncate table #p_total
   truncate table #pagos_fechas_t
   
   exec cob_conta..sp_calcula_ultima_fecha_habil
         @i_reporte			= 'NINGUN',
         @i_fecha           = @w_fecha_aux,
         @o_fin_mes_hab		= @w_fin_mes out
   
   
   insert into #fechas values(@w_fecha_aux, @w_fin_mes)
   select @w_fin_mes
   
   insert into #exigibles_f
   select 
   ex_banco     = dc_banco,
   ex_num_cuota = dc_num_cuota,
   ex_max_cuota = max(dc_num_cuota),
   ex_Cuota     = isnull(sum(dc_cap_cuota + dc_int_acum),0),
   ex_Pago      = isnull(sum(dc_cap_pag + dc_int_pag),0),
   ex_Exigible  = case 
                  when (dc_estado = @w_est_vencido) or (dc_estado = @w_est_vigente and dc_fecha_vto = @w_fecha_fin_ult_dia_h) then
                        isnull(sum(dc_cap_cuota + dc_int_cuota + dc_iva_int_cuota),0) - isnull(sum(dc_cap_pag + dc_int_pag + dc_iva_int_pag),0) -- Suma de IVA Sop.189747 
                  else 0 end,
   ex_Fec_Exig  = isnull(max(dc_fecha_vto),'01/01/1900'),
   ex_Fec_Pago  = '01/01/1900',
   ex_total_Ex  = convert(money,0),
   ex_Exig_B52  = isnull(sum(dc_cap_cuota + dc_int_cuota + dc_iva_int_cuota),0), -- Suma de IVA Sop.189747 
   ex_fecha_can = dc_fecha_can
   from  cob_conta_super..sb_dato_cuota_pry,
         cob_conta_super..sb_lcr_riesgo_provision
   where dc_fecha      = @w_fin_mes
   and   dc_aplicativo = 7
   and dc_banco        = Num_cred
   group by dc_banco, dc_num_cuota, dc_estado, dc_fecha_vto, dc_fecha_can
   order by dc_banco, dc_num_cuota, dc_estado, dc_fecha_vto
   
   
       
   insert into #totales
   select banco        = ex_banco,
       num_cuota    = ex_num_cuota,
       ex_Fec_Exig,
       monto_sumado = (select sum(case
                       when ex_Exigible > 0 then ex_Exigible
                       when ex_Exigible = 0 and  ex_fecha_can between @w_fecha_aux and @w_fin_mes then ex_Exig_B52
                       end
                       )
                       from #exigibles_f t
                       where t.ex_banco      = d.ex_banco
                       and   t.ex_num_cuota <= d.ex_num_cuota)
   from #exigibles_f d
   

   insert into #pagos_fechas_t
   select 
   banco        = ex_banco,
   monto_pagado = sum(ex_Pago), 
   ex_fecha_can
   from #exigibles_f d
   where ex_Exigible = 0 
   and   ex_Pago  <> 0
   and ex_Fec_Exig >= @w_fecha_aux
   and ex_Fec_Exig <= @w_fin_mes 
   group by ex_banco, ex_fecha_can
   
   
   
   insert into #p_total
   select 
   banco     = banco_p,
   monto_sumado = (select sum(monto_pagado)
                       from #pagos_fechas_t t
                       where t.banco_p      = d.banco_p
                       and   t.ex_fecha_can <= d.ex_fecha_can),
    ex_fecha_can
   from #pagos_fechas_t d
   
   --select '#totales-1', * from #totales where banco ='291030000255' and monto_sumado <> 0
 
   update #totales set
   monto_sumado = monto_sumado - monto_pagado
   from  #p_total
   where  banco_p = banco
   and    fecha_exig > fecha_cancela
   
   insert into #exigibles_t
   select 
    ex_banco    ,
    ex_num_cuota,
    ex_max_cuota,
    ex_Cuota    ,
    ex_Pago     ,
    monto_sumado,
    ex_Fec_Exig,
    ex_Fec_Pago,
    ex_total_Ex,
    ex_Exig_B52,
    ex_fecha_can    
   from #exigibles_f,
    #totales
    where banco   = ex_banco
    and num_cuota = ex_num_cuota
    and ex_Fec_Exig >= @w_fecha_aux
    and ex_Fec_Exig <= @w_fin_mes 
    
    
    
   
    /*select '#exigibles_f', * from #exigibles_f where ex_banco = '291030000255'--   order by ex_banco, ex_num_cuota 
    select '#totales - 2', * from #totales where banco= '291030000255' and monto_sumado <> 0
    select '#pagos', * from #p_total where banco_p = '291030000255'
    select '#pagos_fechas', * from #pagos_fechas_t where banco_p = '291030000255'
    select '#exigibles_t',* from #exigibles_t where ex_banco= '291030000255'
    */
   
   
   select @w_mes = @w_mes + 1
   if @w_mes> 12
   begin
      select 
      @w_mes = 1,
      @w_anio = @w_anio + 1
   end 
   
   select @w_fecha_aux = convert(datetime,convert(varchar(2),@w_mes)+'/01/'+convert(varchar(4),@w_anio))     
end

--select * from #fechas


--VALORES EXIGIBLES DE LAS CUOTAS DE LAS OPERACIONES 



--ActualizacionPagos
select 
fecha      = dt_fecha,
banco      = dt_banco,
secuencial = dt_secuencial,
fecha_trans= dt_fecha_trans 
into #pagos_total
from sb_dato_transaccion 
where  dt_banco in ( select Num_cred from sb_lcr_riesgo_provision)
and dt_reversa    = 'N'
and dt_tipo_trans = 'PAG'
and dt_fecha_trans   <= @w_fecha_corte

delete #pagos_total  from sb_dato_transaccion 
where banco     =  dt_banco  
and  secuencial = -1*dt_secuencial 
and  dt_reversa = 'S'

select dt_banco = banco, dt_fecha_trans = fecha_trans, valor_pago= sum(dd_monto)
into #pagos
from #pagos_total,
     cob_conta_super..sb_dato_transaccion_det
where banco          = dd_banco
and   secuencial     = dd_secuencial
and   fecha          = dd_fecha
and   dd_concepto    in ('CAP', 'INT', 'IVA_INT') -- Suma de IVA Sop.189747
group by banco, fecha_trans

if @@error != 0
begin
   print 'Error al consultar pagos realizados'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar pagos realizados'
   goto ERROR_PROCESO
end

select  banco_p = banco            , 
        num_cuota_p = num_cuota    , 
        valor_pago_p = sum(valor_pago),
        fecha_pago_p = max(dt_fecha_trans) 
into #pagos_operaciones
from #exigible_cuotas,
     #pagos
where banco        = dt_banco
and   dt_fecha_trans  > Fec_Exig_Ini
and   dt_fecha_trans <= Fec_Exig
group by banco, num_cuota
order by banco, num_cuota


if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

--CONSULTAR LA ULTIMA CUOTA DE LA OPERACION
select
banco_max     = banco,
num_cuota_max = max(num_cuota)
into #exigibles_max
from #exigible_cuotas --#exigibles 
group by banco

if @@error != 0
begin
   print 'Error al consultar saldos exigibles maximos'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles maximos'
   goto ERROR_PROCESO
end
	
update #exigible_cuotas--#exigibles 
set
max_cuota = num_cuota_max
from #exigibles_max
where banco = banco_max

if @@error != 0
begin
   print 'Error al actualizar saldos exigibles maximos'
   select
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar saldos exigibles maximos'
   goto ERROR_PROCESO
end

--LLENAR LAS CUOTAS QUE TIENEN VALORES EN LA TABLA #exigible_cuotas
update #exigible_cuotas
set Fec_Pago = ex_Fec_Pago
from #exigibles
where banco = ex_banco
and Fec_Exig = ex_Fec_Exig


update #exigible_cuotas
set Exig = ex_Exigible
from #exigibles_t
where banco = ex_banco
and Fec_Exig = ex_Fec_Exig

update #exigible_cuotas
set exigible = 'S'
where Exig <> 0

--Actualizacion Pagos

update #exigible_cuotas set 
Pago     = valor_pago_p,
Fec_Pago = fecha_pago_p
from  #pagos_operaciones
where banco_p     = banco
and   num_cuota_p = num_cuota

update #exigible_cuotas set
Fec_Pago = '01/01/1900'
from #exigibles
where banco = ex_banco
and Pago is null 

update #exigible_cuotas set 
Fec_Exig = '01/01/1900'
from #operaciones_sin_utilizacion
where banco = su_banco 

--REQ#150106
/*
update #exigible_cuotas
set    Exig = (dc_cap_cuota + dc_int_acum + dc_imo_cuota + dc_iva_int_cuota + dc_iva_imo_cuota) 
from   cob_conta_super..sb_dato_cuota_pry
where  banco    = dc_banco 
and    Fec_Exig = dc_fecha_vto
and    Exig     = 0
and    Pago     = 0
and    Fec_Pago = '01/01/1900'

update #exigible_cuotas
set    Exig = ex_Exig_B52
from   #exigibles
where  banco    = ex_banco 
and    Fec_Exig = ex_Fec_Exig 
and    Exig     = 0*/

/*update #exigible_cuotas
set    Exig = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00))
from   sb_dato_operacion
where  do_banco = banco
and    do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = do_banco and num_cuota = 1)
and    Exig = 0
and    Fec_Pago is null*/

select banco
into #operaciones
from #exigible_cuotas
group by banco

select @w_banco = '0'
--(I) Inc#154894
update #exigible_cuotas set
Exig = cob_cartera.dbo.Lcr_Calcular_Cuota_Tmp(banco, Fec_Exig)
where Exig = 0 
and   Pago <> 0


select banco
into #operaciones_lcr
from #exigible_cuotas
group by banco

select banco, codigo_cliente = do_codigo_cliente
into #clientes
from cob_conta_super..sb_dato_operacion,
#operaciones_lcr
where do_fecha = @w_fecha
and do_banco = banco

select do_codigo_cliente, banco, fecha= do_fecha, banco_grupal = do_banco
into #operacion_grupales
from cob_conta_super..sb_dato_operacion,
#clientes
where do_fecha        = @w_fecha
and do_tipo_operacion = 'GRUPAL'
and do_codigo_cliente = codigo_cliente

select banco, dr_banco, valor_grupal = sum(dr_valor)
into #valores_grupales
from sb_dato_operacion_rubro,
#operacion_grupales
where dr_fecha = @w_fecha
and dr_banco = banco_grupal
and dr_exigible = 1
and dr_categoria in ('C', 'I')
group by banco, dr_banco

--(F) Inc#154894

--COPIAR LOS DATOS DE las filas #exigle_cuotas a la respectiva columna en #exigibles_h
select
ex_Num_cred      = banco,
ex_Exig_T1       = isnull(sum(case num_cuota when 1 then Exig else 0 end),0),
ex_Pago_T1       = isnull(sum(case num_cuota when 1 then Pago else 0 end),0),
ex_Fec_Exig_T1   = max(case num_cuota        when 1 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T1   = max(case num_cuota        when 1 then Fec_Pago else '01/01/1900' end),
ex_Exig_T2       = isnull(sum(case num_cuota when 2 then Exig else 0 end),0),
ex_Pago_T2       = isnull(sum(case num_cuota when 2 then Pago else 0 end),0),
ex_Fec_Exig_T2   = max(case num_cuota        when 2 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T2   = max(case num_cuota        when 2 then Fec_Pago else '01/01/1900' end),
ex_Exig_T3       = isnull(sum(case num_cuota when 3 then Exig else 0 end),0),
ex_Pago_T3       = isnull(sum(case num_cuota when 3 then Pago else 0 end),0),
ex_Fec_Exig_T3   = max(case num_cuota        when 3 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T3   = max(case num_cuota        when 3 then Fec_Pago else '01/01/1900' end),
ex_Exig_T4       = isnull(sum(case num_cuota when 4 then Exig else 0 end),0),
ex_Pago_T4       = isnull(sum(case num_cuota when 4 then Pago else 0 end),0),
ex_Fec_Exig_T4   = max(case num_cuota        when 4 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T4   = max(case num_cuota        when 4 then Fec_Pago else '01/01/1900' end),
ex_Exig_T5       = isnull(sum(case num_cuota when 5 then Exig else 0 end),0),
ex_Pago_T5       = isnull(sum(case num_cuota when 5 then Pago else 0 end),0),
ex_Fec_Exig_T5   = max(case num_cuota        when 5 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T5   = max(case num_cuota        when 5 then Fec_Pago else '01/01/1900' end),
ex_Exig_T6       = isnull(sum(case num_cuota when 6 then Exig else 0 end),0),
ex_Pago_T6       = isnull(sum(case num_cuota when 6 then Pago else 0 end),0),
ex_Fec_Exig_T6   = max(case num_cuota        when 6 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T6   = max(case num_cuota        when 6 then Fec_Pago else '01/01/1900' end),
ex_Exig_T7       = isnull(sum(case num_cuota when 7 then Exig else 0 end),0),
ex_Pago_T7       = isnull(sum(case num_cuota when 7 then Pago else 0 end),0),
ex_Fec_Exig_T7   = max(case num_cuota        when 7 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T7   = max(case num_cuota        when 7 then Fec_Pago else '01/01/1900' end),
ex_Exig_T8       = isnull(sum(case num_cuota when 8 then Exig else 0 end),0),
ex_Pago_T8       = isnull(sum(case num_cuota when 8 then Pago else 0 end),0),
ex_Fec_Exig_T8   = max(case num_cuota        when 8 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T8   = max(case num_cuota        when 8 then Fec_Pago else '01/01/1900' end),
ex_Exig_T9       = isnull(sum(case num_cuota when 9 then Exig else 0 end),0),
ex_Pago_T9       = isnull(sum(case num_cuota when 9 then Pago else 0 end),0),
ex_Fec_Exig_T9   = max(case num_cuota        when 9 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T9   = max(case num_cuota        when 9 then Fec_Pago else '01/01/1900' end),
ex_Exig_T10      = isnull(sum(case num_cuota when 10 then Exig else 0 end),0),
ex_Pago_T10      = isnull(sum(case num_cuota when 10 then Pago else 0 end),0),
ex_Fec_Exig_T10  = max(case num_cuota        when 10 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T10  = max(case num_cuota        when 10 then Fec_Pago else '01/01/1900' end),
ex_Exig_T11      = isnull(sum(case num_cuota when 11 then Exig else 0 end),0),
ex_Pago_T11      = isnull(sum(case num_cuota when 11 then Pago else 0 end),0),
ex_Fec_Exig_T11  = max(case num_cuota        when 11 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T11  = max(case num_cuota        when 11 then Fec_Pago else '01/01/1900' end),
ex_Exig_T12      = isnull(sum(case num_cuota when 12 then Exig else 0 end),0),
ex_Pago_T12      = isnull(sum(case num_cuota when 12 then Pago else 0 end),0),
ex_Fec_Exig_T12  = max(case num_cuota        when 12 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T12  = max(case num_cuota        when 12 then Fec_Pago else '01/01/1900' end),
ex_Exig_T13      = isnull(sum(case num_cuota when 13 then Exig else 0 end),0),
ex_Pago_T13      = isnull(sum(case num_cuota when 13 then Pago else 0 end),0),
ex_Fec_Exig_T13  = max(case num_cuota        when 13 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T13  = max(case num_cuota        when 13 then Fec_Pago else '01/01/1900' end),
ex_Exig_T14      = isnull(sum(case num_cuota when 14 then Exig else 0 end),0),
ex_Pago_T14      = isnull(sum(case num_cuota when 14 then Pago else 0 end),0),
ex_Fec_Exig_T14  = max(case num_cuota        when 14 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T14  = max(case num_cuota        when 14 then Fec_Pago else '01/01/1900' end),
ex_Exig_T15      = isnull(sum(case num_cuota when 15 then Exig else 0 end),0),
ex_Pago_T15      = isnull(sum(case num_cuota when 15 then Pago else 0 end),0),
ex_Fec_Exig_T15  = max(case num_cuota        when 15 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T15  = max(case num_cuota        when 15 then Fec_Pago else '01/01/1900' end),
ex_Exig_T16      = isnull(sum(case num_cuota when 16 then Exig else 0 end),0),
ex_Pago_T16      = isnull(sum(case num_cuota when 16 then Pago else 0 end),0),
ex_Fec_Exig_T16  = max(case num_cuota        when 16 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T16  = max(case num_cuota        when 16 then Fec_Pago else '01/01/1900' end),

ex_Exig_T17      = isnull(sum(case num_cuota when 17 then Exig else 0 end),0),
ex_Pago_T17      = isnull(sum(case num_cuota when 17 then Pago else 0 end),0),
ex_Fec_Exig_T17  = max(case num_cuota        when 17 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T17  = max(case num_cuota        when 17 then Fec_Pago else '01/01/1900' end),

ex_Exig_T18      = isnull(sum(case num_cuota when 18 then Exig else 0 end),0),
ex_Pago_T18      = isnull(sum(case num_cuota when 18 then Pago else 0 end),0),
ex_Fec_Exig_T18  = max(case num_cuota        when 18 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T18  = max(case num_cuota        when 18 then Fec_Pago else '01/01/1900' end),

ex_Exig_T19      = isnull(sum(case num_cuota when 19 then Exig else 0 end),0),
ex_Pago_T19      = isnull(sum(case num_cuota when 19 then Pago else 0 end),0),
ex_Fec_Exig_T19  = max(case num_cuota        when 19 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T19  = max(case num_cuota        when 19 then Fec_Pago else '01/01/1900' end),

ex_Exig_T20      = isnull(sum(case num_cuota when 20 then Exig else 0 end),0),
ex_Pago_T20      = isnull(sum(case num_cuota when 20 then Pago else 0 end),0),
ex_Fec_Exig_T20  = max(case num_cuota        when 20 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T20  = max(case num_cuota        when 20 then Fec_Pago else '01/01/1900' end),

ex_Exig_T21      = isnull(sum(case num_cuota when 21 then Exig else 0 end),0),
ex_Pago_T21      = isnull(sum(case num_cuota when 21 then Pago else 0 end),0),
ex_Fec_Exig_T21  = max(case num_cuota        when 21 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T21  = max(case num_cuota        when 21 then Fec_Pago else '01/01/1900' end),

ex_Exig_T22      = isnull(sum(case num_cuota when 22 then Exig else 0 end),0),
ex_Pago_T22      = isnull(sum(case num_cuota when 22 then Pago else 0 end),0),
ex_Fec_Exig_T22  = max(case num_cuota        when 22 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T22  = max(case num_cuota        when 22 then Fec_Pago else '01/01/1900' end),

ex_Exig_T23      = isnull(sum(case num_cuota when 23 then Exig else 0 end),0),
ex_Pago_T23      = isnull(sum(case num_cuota when 23 then Pago else 0 end),0),
ex_Fec_Exig_T23  = max(case num_cuota        when 23 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T23  = max(case num_cuota        when 23 then Fec_Pago else '01/01/1900' end),

ex_Exig_T24      = isnull(sum(case num_cuota when 24 then Exig else 0 end),0),
ex_Pago_T24      = isnull(sum(case num_cuota when 24 then Pago else 0 end),0),
ex_Fec_Exig_T24  = max(case num_cuota        when 24 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T24  = max(case num_cuota        when 24 then Fec_Pago else '01/01/1900' end),

ex_Exig_T25      = isnull(sum(case num_cuota when 25 then Exig else 0 end),0),
ex_Pago_T25      = isnull(sum(case num_cuota when 25 then Pago else 0 end),0),
ex_Fec_Exig_T25  = max(case num_cuota        when 25 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T25  = max(case num_cuota        when 25 then Fec_Pago else '01/01/1900' end),

ex_Exig_T26      = isnull(sum(case num_cuota when 26 then Exig else 0 end),0),
ex_Pago_T26      = isnull(sum(case num_cuota when 26 then Pago else 0 end),0),
ex_Fec_Exig_T26  = max(case num_cuota        when 26 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T26  = max(case num_cuota        when 26 then Fec_Pago else '01/01/1900' end),

ex_Exig_T27      = isnull(sum(case num_cuota when 27 then Exig else 0 end),0),
ex_Pago_T27      = isnull(sum(case num_cuota when 27 then Pago else 0 end),0),
ex_Fec_Exig_T27  = max(case num_cuota        when 27 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T27  = max(case num_cuota        when 27 then Fec_Pago else '01/01/1900' end),

ex_Exig_T28      = isnull(sum(case num_cuota when 28 then Exig else 0 end),0),
ex_Pago_T28      = isnull(sum(case num_cuota when 28 then Pago else 0 end),0),
ex_Fec_Exig_T28  = max(case num_cuota        when 28 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T28  = max(case num_cuota        when 28 then Fec_Pago else '01/01/1900' end),

ex_Exig_T29      = isnull(sum(case num_cuota when 29 then Exig else 0 end),0),
ex_Pago_T29      = isnull(sum(case num_cuota when 29 then Pago else 0 end),0),
ex_Fec_Exig_T29  = max(case num_cuota        when 29 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T29  = max(case num_cuota        when 29 then Fec_Pago else '01/01/1900' end),

ex_Exig_T30      = isnull(sum(case num_cuota when 30 then Exig else 0 end),0),
ex_Pago_T30      = isnull(sum(case num_cuota when 30 then Pago else 0 end),0),
ex_Fec_Exig_T30  = max(case num_cuota        when 30 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T30  = max(case num_cuota        when 30 then Fec_Pago else '01/01/1900' end),

ex_Exig_T31      = isnull(sum(case num_cuota when 31 then Exig else 0 end),0),
ex_Pago_T31      = isnull(sum(case num_cuota when 31 then Pago else 0 end),0),
ex_Fec_Exig_T31  = max(case num_cuota        when 31 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T31  = max(case num_cuota        when 31 then Fec_Pago else '01/01/1900' end),

ex_Exig_T32      = isnull(sum(case num_cuota when 32 then Exig else 0 end),0),
ex_Pago_T32      = isnull(sum(case num_cuota when 32 then Pago else 0 end),0),
ex_Fec_Exig_T32  = max(case num_cuota        when 32 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T32  = max(case num_cuota        when 32 then Fec_Pago else '01/01/1900' end),

ex_Exig_T33      = isnull(sum(case num_cuota when 33 then Exig else 0 end),0),
ex_Pago_T33      = isnull(sum(case num_cuota when 33 then Pago else 0 end),0),
ex_Fec_Exig_T33  = max(case num_cuota        when 33 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T33  = max(case num_cuota        when 33 then Fec_Pago else '01/01/1900' end),

ex_Exig_T34      = isnull(sum(case num_cuota when 34 then Exig else 0 end),0),
ex_Pago_T34      = isnull(sum(case num_cuota when 34 then Pago else 0 end),0),
ex_Fec_Exig_T34  = max(case num_cuota        when 34 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T34  = max(case num_cuota        when 34 then Fec_Pago else '01/01/1900' end),

ex_Exig_T35      = isnull(sum(case num_cuota when 35 then Exig else 0 end),0),
ex_Pago_T35      = isnull(sum(case num_cuota when 35 then Pago else 0 end),0),
ex_Fec_Exig_T35  = max(case num_cuota        when 35 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T35  = max(case num_cuota        when 35 then Fec_Pago else '01/01/1900' end),

ex_Exig_T36      = isnull(sum(case num_cuota when 36 then Exig else 0 end),0),
ex_Pago_T36      = isnull(sum(case num_cuota when 36 then Pago else 0 end),0),
ex_Fec_Exig_T36  = max(case num_cuota        when 36 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T36  = max(case num_cuota        when 36 then Fec_Pago else '01/01/1900' end),

ex_Exig_T37      = isnull(sum(case num_cuota when 37 then Exig else 0 end),0),
ex_Pago_T37      = isnull(sum(case num_cuota when 37 then Pago else 0 end),0),
ex_Fec_Exig_T37  = max(case num_cuota        when 37 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T37  = max(case num_cuota        when 37 then Fec_Pago else '01/01/1900' end),

ex_Exig_T38      = isnull(sum(case num_cuota when 38 then Exig else 0 end),0),
ex_Pago_T38      = isnull(sum(case num_cuota when 38 then Pago else 0 end),0),
ex_Fec_Exig_T38  = max(case num_cuota        when 38 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T38  = max(case num_cuota        when 38 then Fec_Pago else '01/01/1900' end),

ex_Exig_T39      = isnull(sum(case num_cuota when 39 then Exig else 0 end),0),
ex_Pago_T39      = isnull(sum(case num_cuota when 39 then Pago else 0 end),0),
ex_Fec_Exig_T39  = max(case num_cuota        when 39 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T39  = max(case num_cuota        when 39 then Fec_Pago else '01/01/1900' end),

ex_Exig_T40      = isnull(sum(case num_cuota when 40 then Exig else 0 end),0),
ex_Pago_T40      = isnull(sum(case num_cuota when 40 then Pago else 0 end),0),
ex_Fec_Exig_T40  = max(case num_cuota        when 40 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T40  = max(case num_cuota        when 40 then Fec_Pago else '01/01/1900' end),

ex_Exig_T41      = isnull(sum(case num_cuota when 41 then Exig else 0 end),0),
ex_Pago_T41      = isnull(sum(case num_cuota when 41 then Pago else 0 end),0),
ex_Fec_Exig_T41  = max(case num_cuota        when 41 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T41  = max(case num_cuota        when 41 then Fec_Pago else '01/01/1900' end),

ex_Exig_T42      = isnull(sum(case num_cuota when 42 then Exig else 0 end),0),
ex_Pago_T42      = isnull(sum(case num_cuota when 42 then Pago else 0 end),0),
ex_Fec_Exig_T42  = max(case num_cuota        when 42 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T42  = max(case num_cuota        when 42 then Fec_Pago else '01/01/1900' end),

ex_Exig_T43      = isnull(sum(case num_cuota when 43 then Exig else 0 end),0),
ex_Pago_T43      = isnull(sum(case num_cuota when 43 then Pago else 0 end),0),
ex_Fec_Exig_T43  = max(case num_cuota        when 43 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T43  = max(case num_cuota        when 43 then Fec_Pago else '01/01/1900' end),

ex_Exig_T44      = isnull(sum(case num_cuota when 44 then Exig else 0 end),0),
ex_Pago_T44      = isnull(sum(case num_cuota when 44 then Pago else 0 end),0),
ex_Fec_Exig_T44  = max(case num_cuota        when 44 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T44  = max(case num_cuota        when 44 then Fec_Pago else '01/01/1900' end),

ex_Exig_T45      = isnull(sum(case num_cuota when 45 then Exig else 0 end),0),
ex_Pago_T45      = isnull(sum(case num_cuota when 45 then Pago else 0 end),0),
ex_Fec_Exig_T45  = max(case num_cuota        when 45 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T45  = max(case num_cuota        when 45 then Fec_Pago else '01/01/1900' end),

ex_Exig_T46      = isnull(sum(case num_cuota when 46 then Exig else 0 end),0),
ex_Pago_T46      = isnull(sum(case num_cuota when 46 then Pago else 0 end),0),
ex_Fec_Exig_T46  = max(case num_cuota        when 46 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T46  = max(case num_cuota        when 46 then Fec_Pago else '01/01/1900' end),

ex_Exig_T47      = isnull(sum(case num_cuota when 47 then Exig else 0 end),0),
ex_Pago_T47      = isnull(sum(case num_cuota when 47 then Pago else 0 end),0),
ex_Fec_Exig_T47  = max(case num_cuota        when 47 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T47  = max(case num_cuota        when 47 then Fec_Pago else '01/01/1900' end),

ex_Exig_T48      = isnull(sum(case num_cuota when 48 then Exig else 0 end),0),
ex_Pago_T48      = isnull(sum(case num_cuota when 48 then Pago else 0 end),0),
ex_Fec_Exig_T48  = max(case num_cuota        when 48 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T48  = max(case num_cuota        when 48 then Fec_Pago else '01/01/1900' end),

ex_Exig_T49      = isnull(sum(case num_cuota when 49 then Exig else 0 end),0),
ex_Pago_T49      = isnull(sum(case num_cuota when 49 then Pago else 0 end),0),
ex_Fec_Exig_T49  = max(case num_cuota        when 49 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T49  = max(case num_cuota        when 49 then Fec_Pago else '01/01/1900' end),

ex_Exig_T50      = isnull(sum(case num_cuota when 50 then Exig else 0 end),0),
ex_Pago_T50      = isnull(sum(case num_cuota when 50 then Pago else 0 end),0),
ex_Fec_Exig_T50  = max(case num_cuota        when 50 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T50  = max(case num_cuota        when 50 then Fec_Pago else '01/01/1900' end),

ex_Exig_T51      = isnull(sum(case num_cuota when 51 then Exig else 0 end),0),
ex_Pago_T51      = isnull(sum(case num_cuota when 51 then Pago else 0 end),0),
ex_Fec_Exig_T51  = max(case num_cuota        when 51 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T51  = max(case num_cuota        when 51 then Fec_Pago else '01/01/1900' end),

ex_Exig_T52      = isnull(sum(case num_cuota when 52 then Exig else 0 end),0),
ex_Pago_T52      = isnull(sum(case num_cuota when 52 then Pago else 0 end),0),
ex_Fec_Exig_T52  = max(case num_cuota        when 52 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T52  = max(case num_cuota        when 52 then Fec_Pago else '01/01/1900' end)

into  #exigibles_h
from #exigible_cuotas
group by banco

if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end


create table #uso_linea
(
	banco cuenta,
	fecha datetime
)

--USO DE LA LINEA DE CREDITO
insert into #uso_linea
select
banco = Num_cred,
fecha = min(tr_fecha_ref)
from cob_cartera..ca_transaccion, sb_lcr_riesgo_provision
where tr_banco = Num_cred
  and tr_tran = 'DES'
  group by Num_cred

update sb_lcr_riesgo_provision set
Fec_Prim_Des = convert(varchar, fecha, @w_ffecha_reporte) 
from #uso_linea
where Num_cred = banco

--COPIAR LOS DATOS A LA TABLA sb_lcr_riesgo_provision, cambiando las fechas al formato del reporte 
update sb_lcr_riesgo_provision set
Exig_T1       = convert(varchar, ex_Exig_T1),
Pago_T1       = convert(varchar, ex_Pago_T1),
Fec_Exig_T1   = case when ex_Fec_Exig_T1 = '01/01/1900' or isnull(ex_Exig_T1,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T1, @w_ffecha_reporte) end,
Fec_Pago_T1   = case ex_Fec_Pago_T1 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T1, @w_ffecha_reporte) end,


Exig_T2       = convert(varchar, ex_Exig_T2),
Pago_T2       = convert(varchar, ex_Pago_T2),
Fec_Exig_T2   = case when ex_Fec_Exig_T2 = '01/01/1900' or isnull(ex_Exig_T2,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T2, @w_ffecha_reporte) end,
Fec_Pago_T2   = case ex_Fec_Pago_T2 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T2, @w_ffecha_reporte) end,

Exig_T3       = convert(varchar, ex_Exig_T3),
Pago_T3       = convert(varchar, ex_Pago_T3),
Fec_Exig_T3   = case when ex_Fec_Exig_T3 = '01/01/1900' or isnull(ex_Exig_T3,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T3, @w_ffecha_reporte) end,
Fec_Pago_T3   = case ex_Fec_Pago_T3 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T3, @w_ffecha_reporte) end,

Exig_T4       = convert(varchar, ex_Exig_T4),
Pago_T4       = convert(varchar, ex_Pago_T4),
Fec_Exig_T4   = case when ex_Fec_Exig_T4 = '01/01/1900' or isnull(ex_Exig_T4,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T4, @w_ffecha_reporte) end,
Fec_Pago_T4   = case ex_Fec_Pago_T4 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T4, @w_ffecha_reporte) end,

Exig_T5       = convert(varchar, ex_Exig_T5),
Pago_T5       = convert(varchar, ex_Pago_T5),
Fec_Exig_T5   = case when ex_Fec_Exig_T5 = '01/01/1900' or isnull(ex_Exig_T5,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T5, @w_ffecha_reporte) end,
Fec_Pago_T5   = case ex_Fec_Pago_T5 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T5, @w_ffecha_reporte) end,

Exig_T6       = convert(varchar, ex_Exig_T6),
Pago_T6       = convert(varchar, ex_Pago_T6),
Fec_Exig_T6   = case when ex_Fec_Exig_T6 = '01/01/1900' or isnull(ex_Exig_T6,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T6, @w_ffecha_reporte) end,
Fec_Pago_T6   = case ex_Fec_Pago_T6 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T6, @w_ffecha_reporte) end,

Exig_T7       = convert(varchar, ex_Exig_T7),
Pago_T7       = convert(varchar, ex_Pago_T7),
Fec_Exig_T7   = case when ex_Fec_Exig_T7 = '01/01/1900' or isnull(ex_Exig_T7,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T7, @w_ffecha_reporte) end,
Fec_Pago_T7   = case ex_Fec_Pago_T7 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T7, @w_ffecha_reporte) end,

Exig_T8       = convert(varchar, ex_Exig_T8),
Pago_T8       = convert(varchar, ex_Pago_T8),
Fec_Exig_T8   = case when ex_Fec_Exig_T8 = '01/01/1900' or isnull(ex_Exig_T8,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T8, @w_ffecha_reporte) end,
Fec_Pago_T8   = case ex_Fec_Pago_T8 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T8, @w_ffecha_reporte) end,

Exig_T9       = convert(varchar, ex_Exig_T9),
Pago_T9       = convert(varchar, ex_Pago_T9),
Fec_Exig_T9   = case when ex_Fec_Exig_T9  = '01/01/1900' or isnull(ex_Exig_T9,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T9, @w_ffecha_reporte) end,
Fec_Pago_T9   = case ex_Fec_Pago_T9 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T9, @w_ffecha_reporte) end,

Exig_T10      = convert(varchar, ex_Exig_T10),
Pago_T10      = convert(varchar, ex_Pago_T10),
Fec_Exig_T10  = case when ex_Fec_Exig_T10 = '01/01/1900' or isnull(ex_Exig_T10,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T10, @w_ffecha_reporte) end,
Fec_Pago_T10  = case ex_Fec_Pago_T10 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T10, @w_ffecha_reporte) end,

Exig_T11      = convert(varchar, ex_Exig_T11),
Pago_T11      = convert(varchar, ex_Pago_T11),
Fec_Exig_T11  = case when ex_Fec_Exig_T11 = '01/01/1900' or isnull(ex_Exig_T11,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T11, @w_ffecha_reporte) end,
Fec_Pago_T11  = case ex_Fec_Pago_T11 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T11, @w_ffecha_reporte) end,

Exig_T12      = convert(varchar, ex_Exig_T12),
Pago_T12      = convert(varchar, ex_Pago_T12),
Fec_Exig_T12  = case when ex_Fec_Exig_T12 = '01/01/1900' or isnull(ex_Exig_T12,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T12, @w_ffecha_reporte) end,
Fec_Pago_T12  = case ex_Fec_Pago_T12 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T12, @w_ffecha_reporte) end,

Exig_T13      = convert(varchar, ex_Exig_T13),
Pago_T13      = convert(varchar, ex_Pago_T13),
Fec_Exig_T13  = case when ex_Fec_Exig_T13 = '01/01/1900' or isnull(ex_Exig_T13,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T13, @w_ffecha_reporte) end,
Fec_Pago_T13  = case ex_Fec_Pago_T13 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T13, @w_ffecha_reporte) end,

Exig_T14      = convert(varchar, ex_Exig_T14),
Pago_T14      = convert(varchar, ex_Pago_T14),
Fec_Exig_T14  = case when ex_Fec_Exig_T14 = '01/01/1900' or isnull(ex_Exig_T14,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T14, @w_ffecha_reporte) end,
Fec_Pago_T14  = case ex_Fec_Pago_T14 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T14, @w_ffecha_reporte) end,

Exig_T15      = convert(varchar, ex_Exig_T15),
Pago_T15      = convert(varchar, ex_Pago_T15),
Fec_Exig_T15  = case when ex_Fec_Exig_T15 = '01/01/1900' or isnull(ex_Exig_T15,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T15, @w_ffecha_reporte) end,
Fec_Pago_T15  = case ex_Fec_Pago_T15 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T15, @w_ffecha_reporte) end,

Exig_T16      = convert(varchar, ex_Exig_T16),
Pago_T16      = convert(varchar, ex_Pago_T16),
Fec_Exig_T16  = case when ex_Fec_Exig_T16 = '01/01/1900' or isnull(ex_Exig_T16,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T16, @w_ffecha_reporte) end,
Fec_Pago_T16  = case ex_Fec_Pago_T16 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T16, @w_ffecha_reporte) end,


Exig_T17     = convert(varchar, ex_Exig_T17),
Pago_T17     = convert(varchar, ex_Pago_T17),
Fec_Exig_T17 = case when ex_Fec_Exig_T17 = '01/01/1900' or isnull(ex_Exig_T17,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T17, @w_ffecha_reporte) end,
Fec_Pago_T17 = case ex_Fec_Pago_T17 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T17, @w_ffecha_reporte) end,

Exig_T18    = convert(varchar, ex_Exig_T18),
Pago_T18    = convert(varchar, ex_Pago_T18),
Fec_Exig_T18= case when ex_Fec_Exig_T18 = '01/01/1900' or isnull(ex_Exig_T18,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T18, @w_ffecha_reporte) end,
Fec_Pago_T18= case ex_Fec_Pago_T18 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T18, @w_ffecha_reporte) end,

Exig_T19    = convert(varchar, ex_Exig_T19),
Pago_T19    = convert(varchar, ex_Pago_T19),
Fec_Exig_T19= case when ex_Fec_Exig_T19 = '01/01/1900' or isnull(ex_Exig_T19,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T19, @w_ffecha_reporte) end,
Fec_Pago_T19= case ex_Fec_Pago_T19 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T19, @w_ffecha_reporte) end,

Exig_T20    = convert(varchar, ex_Exig_T20),
Pago_T20    = convert(varchar, ex_Pago_T20),
Fec_Exig_T20= case when ex_Fec_Exig_T20 = '01/01/1900' or isnull(ex_Exig_T20,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T20, @w_ffecha_reporte) end,
Fec_Pago_T20= case ex_Fec_Pago_T20 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T20, @w_ffecha_reporte) end,

Exig_T21    = convert(varchar, ex_Exig_T21),
Pago_T21    = convert(varchar, ex_Pago_T21),
Fec_Exig_T21= case when ex_Fec_Exig_T21 = '01/01/1900' or isnull(ex_Exig_T21,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T21, @w_ffecha_reporte) end,
Fec_Pago_T21= case ex_Fec_Pago_T21 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T21, @w_ffecha_reporte) end,

Exig_T22    = convert(varchar, ex_Exig_T22),
Pago_T22    = convert(varchar, ex_Pago_T22),
Fec_Exig_T22= case when ex_Fec_Exig_T22 = '01/01/1900' or isnull(ex_Exig_T22,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T22, @w_ffecha_reporte) end,
Fec_Pago_T22= case ex_Fec_Pago_T22 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T22, @w_ffecha_reporte) end,

Exig_T23    = convert(varchar, ex_Exig_T23),
Pago_T23    = convert(varchar, ex_Pago_T23),
Fec_Exig_T23= case when ex_Fec_Exig_T23 = '01/01/1900' or isnull(ex_Exig_T23,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T23, @w_ffecha_reporte) end,
Fec_Pago_T23= case ex_Fec_Pago_T23 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T23, @w_ffecha_reporte) end,

Exig_T24    = convert(varchar, ex_Exig_T24),
Pago_T24    = convert(varchar, ex_Pago_T24),
Fec_Exig_T24= case when ex_Fec_Exig_T24 = '01/01/1900' or isnull(ex_Exig_T24,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T24, @w_ffecha_reporte) end,
Fec_Pago_T24= case ex_Fec_Pago_T24 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T24, @w_ffecha_reporte) end,

Exig_T25    = convert(varchar, ex_Exig_T25),
Pago_T25    = convert(varchar, ex_Pago_T25),
Fec_Exig_T25= case when ex_Fec_Exig_T25 = '01/01/1900' or isnull(ex_Exig_T25,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T25, @w_ffecha_reporte) end,
Fec_Pago_T25= case ex_Fec_Pago_T25 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T25, @w_ffecha_reporte) end,

Exig_T26    = convert(varchar, ex_Exig_T26),
Pago_T26    = convert(varchar, ex_Pago_T26),
Fec_Exig_T26= case when ex_Fec_Exig_T26 = '01/01/1900' or isnull(ex_Exig_T26,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T26, @w_ffecha_reporte) end,
Fec_Pago_T26= case ex_Fec_Pago_T26 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T26, @w_ffecha_reporte) end,

Exig_T27    = convert(varchar, ex_Exig_T27),
Pago_T27    = convert(varchar, ex_Pago_T27),
Fec_Exig_T27= case when ex_Fec_Exig_T27 = '01/01/1900' or isnull(ex_Exig_T27,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T27, @w_ffecha_reporte) end,
Fec_Pago_T27= case ex_Fec_Pago_T27 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T27, @w_ffecha_reporte) end,

Exig_T28    = convert(varchar, ex_Exig_T28),
Pago_T28    = convert(varchar, ex_Pago_T28),
Fec_Exig_T28= case when ex_Fec_Exig_T28 = '01/01/1900' or isnull(ex_Exig_T28,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T28, @w_ffecha_reporte) end,
Fec_Pago_T28= case ex_Fec_Pago_T28 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T28, @w_ffecha_reporte) end,

Exig_T29    = convert(varchar, ex_Exig_T29),
Pago_T29    = convert(varchar, ex_Pago_T29),
Fec_Exig_T29= case when ex_Fec_Exig_T29 = '01/01/1900' or isnull(ex_Exig_T29,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T29, @w_ffecha_reporte) end,
Fec_Pago_T29= case ex_Fec_Pago_T29 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T29, @w_ffecha_reporte) end,

Exig_T30    = convert(varchar, ex_Exig_T30),
Pago_T30    = convert(varchar, ex_Pago_T30),
Fec_Exig_T30= case when ex_Fec_Exig_T30 = '01/01/1900' or isnull(ex_Exig_T30,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T30, @w_ffecha_reporte) end,
Fec_Pago_T30= case ex_Fec_Pago_T30 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T30, @w_ffecha_reporte) end,

Exig_T31    = convert(varchar, ex_Exig_T31),
Pago_T31    = convert(varchar, ex_Pago_T31),
Fec_Exig_T31= case when ex_Fec_Exig_T31 = '01/01/1900' or isnull(ex_Exig_T31,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T31, @w_ffecha_reporte) end,
Fec_Pago_T31= case ex_Fec_Pago_T31 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T31, @w_ffecha_reporte) end,

Exig_T32    = convert(varchar, ex_Exig_T32),
Pago_T32    = convert(varchar, ex_Pago_T32),
Fec_Exig_T32= case when ex_Fec_Exig_T32 = '01/01/1900' or isnull(ex_Exig_T32,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T32, @w_ffecha_reporte) end,
Fec_Pago_T32= case ex_Fec_Pago_T32 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T32, @w_ffecha_reporte) end,

Exig_T33    = convert(varchar, ex_Exig_T33),
Pago_T33    = convert(varchar, ex_Pago_T33),
Fec_Exig_T33= case when ex_Fec_Exig_T33 = '01/01/1900' or isnull(ex_Exig_T33,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T33, @w_ffecha_reporte) end,
Fec_Pago_T33= case ex_Fec_Pago_T33 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T33, @w_ffecha_reporte) end,

Exig_T34    = convert(varchar, ex_Exig_T34),
Pago_T34    = convert(varchar, ex_Pago_T34),
Fec_Exig_T34= case when ex_Fec_Exig_T34 = '01/01/1900' or isnull(ex_Exig_T34,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T34, @w_ffecha_reporte) end,
Fec_Pago_T34= case ex_Fec_Pago_T34 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T34, @w_ffecha_reporte) end,

Exig_T35    = convert(varchar, ex_Exig_T35),
Pago_T35    = convert(varchar, ex_Pago_T35),
Fec_Exig_T35= case when ex_Fec_Exig_T35 = '01/01/1900' or isnull(ex_Exig_T35,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T35, @w_ffecha_reporte) end,
Fec_Pago_T35= case ex_Fec_Pago_T35 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T35, @w_ffecha_reporte) end,

Exig_T36    = convert(varchar, ex_Exig_T36),
Pago_T36    = convert(varchar, ex_Pago_T36),
Fec_Exig_T36= case when ex_Fec_Exig_T36 = '01/01/1900' or isnull(ex_Exig_T36,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T36, @w_ffecha_reporte) end,
Fec_Pago_T36= case ex_Fec_Pago_T36 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T36, @w_ffecha_reporte) end,

Exig_T37    = convert(varchar, ex_Exig_T37),
Pago_T37    = convert(varchar, ex_Pago_T37),
Fec_Exig_T37= case when ex_Fec_Exig_T37 = '01/01/1900' or isnull(ex_Exig_T37,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T37, @w_ffecha_reporte) end,
Fec_Pago_T37= case ex_Fec_Pago_T37 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T37, @w_ffecha_reporte) end,

Exig_T38    = convert(varchar, ex_Exig_T38),
Pago_T38    = convert(varchar, ex_Pago_T38),
Fec_Exig_T38= case when ex_Fec_Exig_T38 = '01/01/1900' or isnull(ex_Exig_T38,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T38, @w_ffecha_reporte) end,
Fec_Pago_T38= case ex_Fec_Pago_T38 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T38, @w_ffecha_reporte) end,

Exig_T39    = convert(varchar, ex_Exig_T39),
Pago_T39    = convert(varchar, ex_Pago_T39),
Fec_Exig_T39= case when ex_Fec_Exig_T39 = '01/01/1900' or isnull(ex_Exig_T39,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T39, @w_ffecha_reporte) end,
Fec_Pago_T39= case ex_Fec_Pago_T39 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T39, @w_ffecha_reporte) end,

Exig_T40    = convert(varchar, ex_Exig_T40),
Pago_T40    = convert(varchar, ex_Pago_T40),
Fec_Exig_T40= case when ex_Fec_Exig_T40 = '01/01/1900' or isnull(ex_Exig_T40,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T40, @w_ffecha_reporte) end,
Fec_Pago_T40= case ex_Fec_Pago_T40 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T40, @w_ffecha_reporte) end,

Exig_T41    = convert(varchar, ex_Exig_T41),
Pago_T41    = convert(varchar, ex_Pago_T41),
Fec_Exig_T41= case when ex_Fec_Exig_T41 = '01/01/1900' or isnull(ex_Exig_T41,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T41, @w_ffecha_reporte) end,
Fec_Pago_T41= case ex_Fec_Pago_T41 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T41, @w_ffecha_reporte) end,

Exig_T42    = convert(varchar, ex_Exig_T42),
Pago_T42    = convert(varchar, ex_Pago_T42),
Fec_Exig_T42= case when ex_Fec_Exig_T42 = '01/01/1900' or isnull(ex_Exig_T42,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T42, @w_ffecha_reporte) end,
Fec_Pago_T42= case ex_Fec_Pago_T42 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T42, @w_ffecha_reporte) end,

Exig_T43    = convert(varchar, ex_Exig_T43),
Pago_T43    = convert(varchar, ex_Pago_T43),
Fec_Exig_T43= case when ex_Fec_Exig_T43 = '01/01/1900' or isnull(ex_Exig_T43,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T43, @w_ffecha_reporte) end,
Fec_Pago_T43= case ex_Fec_Pago_T43 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T43, @w_ffecha_reporte) end,

Exig_T44    = convert(varchar, ex_Exig_T44),
Pago_T44    = convert(varchar, ex_Pago_T44),
Fec_Exig_T44= case when ex_Fec_Exig_T44 = '01/01/1900' or isnull(ex_Exig_T44,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T44, @w_ffecha_reporte) end,
Fec_Pago_T44= case ex_Fec_Pago_T44 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T44, @w_ffecha_reporte) end,

Exig_T45    = convert(varchar, ex_Exig_T45),
Pago_T45    = convert(varchar, ex_Pago_T45),
Fec_Exig_T45= case when ex_Fec_Exig_T45 = '01/01/1900' or isnull(ex_Exig_T45,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T45, @w_ffecha_reporte) end,
Fec_Pago_T45= case ex_Fec_Pago_T45 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T45, @w_ffecha_reporte) end,

Exig_T46    = convert(varchar, ex_Exig_T46),
Pago_T46    = convert(varchar, ex_Pago_T46),
Fec_Exig_T46= case when ex_Fec_Exig_T46 = '01/01/1900' or isnull(ex_Exig_T46,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T46, @w_ffecha_reporte) end,
Fec_Pago_T46= case ex_Fec_Pago_T46 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T46, @w_ffecha_reporte) end,

Exig_T47    = convert(varchar, ex_Exig_T47),
Pago_T47    = convert(varchar, ex_Pago_T47),
Fec_Exig_T47= case when ex_Fec_Exig_T47 = '01/01/1900' or isnull(ex_Exig_T47,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T47, @w_ffecha_reporte) end,
Fec_Pago_T47= case ex_Fec_Pago_T47 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T47, @w_ffecha_reporte) end,

Exig_T48    = convert(varchar, ex_Exig_T48),
Pago_T48    = convert(varchar, ex_Pago_T48),
Fec_Exig_T48= case when ex_Fec_Exig_T48 = '01/01/1900' or isnull(ex_Exig_T48,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T48, @w_ffecha_reporte) end,
Fec_Pago_T48= case ex_Fec_Pago_T48 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T48, @w_ffecha_reporte) end,

Exig_T49    = convert(varchar, ex_Exig_T49),
Pago_T49    = convert(varchar, ex_Pago_T49),
Fec_Exig_T49= case when ex_Fec_Exig_T49 = '01/01/1900' or isnull(ex_Exig_T49,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T49, @w_ffecha_reporte) end,
Fec_Pago_T49= case ex_Fec_Pago_T49 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T49, @w_ffecha_reporte) end,

Exig_T50    = convert(varchar, ex_Exig_T50),
Pago_T50    = convert(varchar, ex_Pago_T50),
Fec_Exig_T50= case when ex_Fec_Exig_T50 = '01/01/1900' or isnull(ex_Exig_T50,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T50, @w_ffecha_reporte) end,
Fec_Pago_T50= case ex_Fec_Pago_T50 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T50, @w_ffecha_reporte) end,

Exig_T51    = convert(varchar, ex_Exig_T51),
Pago_T51    = convert(varchar, ex_Pago_T51),
Fec_Exig_T51= case when ex_Fec_Exig_T51 = '01/01/1900' or isnull(ex_Exig_T51,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T51, @w_ffecha_reporte) end,
Fec_Pago_T51= case ex_Fec_Pago_T51 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T51, @w_ffecha_reporte) end,

Exig_T52    = convert(varchar, ex_Exig_T52),
Pago_T52    = convert(varchar, ex_Pago_T52),
Fec_Exig_T52= case when ex_Fec_Exig_T52 = '01/01/1900' or isnull(ex_Exig_T52,0) = 0 then '' else convert(varchar, ex_Fec_Exig_T52, @w_ffecha_reporte) end,
Fec_Pago_T52= case ex_Fec_Pago_T52 when '01/01/1900' then '' else convert(varchar, ex_Fec_Pago_T52, @w_ffecha_reporte) end,

Imp_pago_minimo_corte = convert(varchar, case when ex_Exig_T1 - ex_Pago_T1 <= 0 then 0 else ex_Exig_T1 end),
Monto_Pagar_Ins = convert(varchar, case when ex_Exig_T1 - ex_Pago_T1 <= 0 then 0 else ex_Exig_T1 end)
from  #exigibles_h
where Num_cred = ex_Num_cred


if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

update sb_lcr_riesgo_provision
set    Monto_Pagar_Ins  = convert(varchar,convert(money,isnull(Imp_pago_minimo_corte,0)) + convert(money,isnull(valor_grupal,0)))
from #valores_grupales
where Num_cred = banco



update sb_lcr_riesgo_provision set
Imp_limite_corte = convert(varchar(20),isnull(do_monto_aprobado,00)),
Imp_limite_fch_calculo = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and do_fecha = @w_fecha_fin_ult_dia_h

--INGRESA VALORES DE SALDOS
update sb_lcr_riesgo_provision set
Saldo_T1 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t1 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 1)
  
update sb_lcr_riesgo_provision set
Saldo_T2 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t2 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 2)

update sb_lcr_riesgo_provision set
Saldo_T3 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t3 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 3)

update sb_lcr_riesgo_provision set
Saldo_T4 = convert(varchar(20), do_saldo_cap + do_saldo_int),
Imp_limite_t4 = convert(varchar(20),do_monto_aprobado)
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 4)

update sb_lcr_riesgo_provision set
Saldo_T5 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t5 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 5)

update sb_lcr_riesgo_provision set
Saldo_T6 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t6 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 6)
  
update sb_lcr_riesgo_provision set
Saldo_T7 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t7 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 7)
  
update sb_lcr_riesgo_provision set
Saldo_T8 = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Imp_limite_t8 = convert(varchar(20),isnull(do_monto_aprobado,00))
from  sb_dato_operacion
where do_banco = Num_cred
and   do_fecha in (select Fec_Exig_Tmp from #exigible_cuotas where banco = Num_cred and num_cuota = 8)


create table #limite(
	banco cuenta,
	limite_t1  money,
	limite_t2  money,
	limite_t3  money,
	limite_t4  money,
	limite_t5  money,
	limite_t6  money,
	limite_t7  money,
	limite_t8  money	
)

--CORREGIR LAS OPERACIONES QUE TUVIERON LIMITE NULL
insert into #limite
select Num_cred,Imp_limite_t1,Imp_limite_t2,Imp_limite_t3,Imp_limite_t4,Imp_limite_t5,Imp_limite_t6,Imp_limite_t7,Imp_limite_t8 
from sb_lcr_riesgo_provision 
where 
Imp_limite_t1 is null
or Imp_limite_t2 is null
or Imp_limite_t3 is null
or Imp_limite_t4 is null
or Imp_limite_t5 is null
or Imp_limite_t6 is null
or Imp_limite_t7 is null
or Imp_limite_t8 is null
     
select @w_banco = '0'

while(1=1) begin
       select top 1 
    @w_banco = banco, 
    @w_limite_t1 = limite_t1,
    @w_limite_t2 = limite_t2,
    @w_limite_t3 = limite_t3,
    @w_limite_t4 = limite_t4,
    @w_limite_t5 = limite_t5,
    @w_limite_t6 = limite_t6,
    @w_limite_t7 = limite_t7,
    @w_limite_t8 = limite_t8 
    from #limite
    where banco > @w_banco
    order by banco
    
    if @@rowcount = 0
    	break
    
    select @w_aprobado = null,@w_saldo = null
    
	if @w_limite_t1 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    	@w_saldo = do_saldo_cap + do_saldo_int
    	 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 1)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t1 = @w_aprobado,
		Saldo_T1 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t1 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t2 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 2)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t2 = @w_aprobado,
		Saldo_T2 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t2 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t3 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 3)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t3 = @w_aprobado,
		Saldo_T3 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t3 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t4 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 4)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t4 = @w_aprobado,
		Saldo_T4 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t4 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t5 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 5)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t5 = @w_aprobado,
		Saldo_T5 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t5 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t6 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 6)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t6 = @w_aprobado,
		Saldo_T6 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t6 = @w_aprobado where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t7 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 7)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision set Imp_limite_t7 = isnull(@w_aprobado,0),
			Saldo_T7 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t7 = isnull(@w_aprobado,0) where banco = @w_banco
	end
	
    select @w_aprobado = null,@w_saldo = null
	if @w_limite_t8 is null begin
    	select top 1 @w_aprobado = do_monto_aprobado,
    		@w_saldo = do_saldo_cap + do_saldo_int
    		 from sb_dato_operacion 
		where do_banco = @w_banco
		and   do_fecha <=            
		(select Fec_Exig_Tmp from #exigible_cuotas where banco = @w_banco and num_cuota = 8)
		order by do_fecha desc              

		update sb_lcr_riesgo_provision 
		set Imp_limite_t8 = isnull(@w_aprobado,0),
		Saldo_T8 = isnull(@w_saldo,0)
		where Num_cred = @w_banco
	
		update #limite set limite_t8 = isnull(@w_aprobado,0) where banco = @w_banco
	end
	
	    
end

select Num_cred,meses_apertura,Flg_Mora,Fec_Prim_Des,Monto_Pagar_Ins,Flag_Atr_Ins from sb_lcr_riesgo_provision
----------------------------------------
--	Generar Archivo 
----------------------------------------

---------CONTENIDO----------------
select @w_s_app = pa_char
from cobis..cl_parametro	
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
	
select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 36 --REGULATORIOS 

select @w_nombre_archivo = 'COBIS_PROV_LCR_'+convert(varchar(10),@w_fecha_fin,112)

--print '@w_nombre_archivo '+@w_nombre_archivo
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_lcr_riesgo_provision out '

select @w_arch_contenido = @w_path + @w_nombre_archivo+ '_cont.txt',
	    @w_arch_cabecera  = @w_path + @w_nombre_archivo+ '_cab.txt',
		 @w_arch_completo  = @w_path + @w_nombre_archivo+ '.txt',
	    @w_arch_errores   = @w_path + @w_nombre_archivo+ '.err'

select @w_cmd = @w_cmd + @w_arch_contenido+ ' -b5000 -c -T -e ' + @w_arch_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

--print '@w_comando 1>> ' +@w_cmd

exec @w_error = xp_cmdshell @w_cmd
if @w_error <> 0 
	return @w_error


---------CABECERA----------------
select @w_col_id   = 0,
	    @w_columna  = '',
	    @w_cabecera = ''
	      
	      
select @w_count=0 
while 1 = 1 begin
	select top 1 
		@w_columna = c.name,
	   @w_col_id  = c.colid
	from cob_conta_super..sysobjects o, cob_conta_super..syscolumns c
	where o.id    = c.id
  	and   o.name  = 'sb_lcr_riesgo_provision'
 	and   c.colid > @w_col_id
  	order by c.colid
	    
	if @@rowcount = 0 
	 	break

	   select @w_cabecera = @w_cabecera + @w_columna+'^|'-- + char(9)
end
	
	select @w_cmd= 'echo ' + @w_cabecera + ' > ' + @w_arch_cabecera
 --PRINT '@w_comando2>> '+ convert(VARCHAR(300),@w_cmd)
	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error

--------- UNIR CABECERA CON CONTENIDO ----------------
	select @w_cmd = 'copy ' + @w_arch_cabecera + ' + ' + @w_arch_contenido + ' ' + @w_arch_completo
  --PRINT '@w_comando3>> '+ convert(VARCHAR(300),@w_cmd)
	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error
	   
------ ELIMINAR ARCHIVOS TEMPORALES
	select @w_cmd = 'del ' + @w_arch_cabecera 
 	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error
 
	select @w_cmd = 'del ' + @w_arch_contenido
 	
	exec @w_error = xp_cmdshell @w_cmd
	if @w_error <> 0 
	   return @w_error


/**********************/


--print @w_mensaje

SALIDA_PROCESO:
   return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error
go

