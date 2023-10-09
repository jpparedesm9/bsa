/*************************************************************************/
/*   Archivo             :       ecestprov.sp                            */
/*   Stored procedure    :       sp_estimacion_provision                 */
/*   Base de datos       :       cob_conta_super                         */
/*   Producto            :       REC                                     */
/*   Disenado por        :       Fabian de la Torre                      */
/*   Fecha de escritura  :       Julio 2017                              */
/*************************************************************************/
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      'Cobiscorp', representantes exclusivos para el Ecuador de la     */
/*      'NCR CORPORATION'.                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de Cobiscorp o su representante.           */
/*************************************************************************/
/*                             PROPOSITO                                 */
/*   Este programa genera la estimacion de provisiones individuales y    */
/*   grupales   CGS-S115717 CGS-S118721                                  */
/*************************************************************************/
/*                      MODIFICACIONES                                   */
/*  Jorge Salazar       12/Jul/2017  EMISION INICAL                      */
/*  Sandra Echeverri    01/Ago/2017  Refactorización                     */
/*  Tania Baidal        21/Sep/2017  Modificacion estructura             */
/*                                   sb_dato_operacion_rubro             */
/*  M. Taco             15/Nov/2019  Optimizacion                        */
/*  J. Sarzosa          09/Sep/2020  Optimizacion                        */ 
/*************************************************************************/
use cob_conta_super
go


IF OBJECT_ID ('dbo.sp_estimacion_provision') IS NOT NULL
	DROP PROCEDURE dbo.sp_estimacion_provision
GO

create proc sp_estimacion_provision
as

declare
@w_s_app                varchar(255),
@w_path                 varchar(255),
@w_destino              varchar(255),
@w_destino2             varchar(255),
@w_cmd                  varchar(5000),
@w_errores              varchar(255),
@w_comando              varchar(6000),
@w_lineas               varchar(10),
@w_columna              varchar(50),
@w_col_id               int,
@w_cabecera             varchar(5000),
@i_fecha                datetime,
@w_periodicidad         varchar(1),
@w_toperacion           catalogo,
@w_error                int,
@w_sp_name              varchar(32),
@w_mensaje              varchar(255),
@w_msg                  varchar(200),
@w_clase_consumo        catalogo,
@w_est_vencido          tinyint,
@w_est_vigente          tinyint,
@w_est_cancelado        tinyint,

@w_bajo                 int,
@w_medio                int,
@w_alto                 int,
@w_meses                int,
@w_mtosdo_individual    float,
@w_antiguedad_cliente   int,
@w_nciclo_atr4          int,
@w_nintegrantes_atr4    int,
@w_nciclo_atr6          int,
@w_nintegrantes_atr6    int,
@w_contador             int,
@w_key                  int,
@w_codigo_cliente       int,
@w_constante_e          float,
@w_saldo                money,
@w_mtosdo               float,
@w_banco                varchar(24),
@w_fecha_cliente        datetime,
@w_monto_pagar          money,
@w_num_integrantes      int,
@w_riesgo               catalogo,
@w_und_atraso_max       float,
@w_und_atraso           float,
@w_antiguedad           int,
@w_tipo_oper            varchar(30),
@w_gz0                  float,
@w_gz1                  float,
@w_gz2                  float,
@w_gz3                  float,
@w_gz4                  float,
@w_gz5                  float,
@w_iz0                  float,
@w_iz1                  float,
@w_iz2                  float,
@w_iz3                  float,
@w_iz4                  float,
@w_iz5                  float,
@w_iz6                  float,
@w_iz7                  float,
@w_iz8                  float,
@w_severidad            float,
@w_saldo_contable       money,
@w_atraso_max           float,
@w_sum_z0               money,
@w_sum_z1               money,
@w_sum_z2               money,
@w_sum_z3               money,
@w_sum_z4               money,
@w_sum_z5               money,
@w_sum_z6               money,
@w_sum_z7               money,
@w_sum_z8               money,
@w_sumandos             money,
@w_probabilidad         float,
@w_fecha_ini            datetime,
@w_tipo                 catalogo,
@w_valor_garantia       money,
@w_cociente_pago        float,
@w_numero_ciclos        int,
@w_decimales            char(1),
@w_num_dec              tinyint,
@w_mon_nacional         tinyint,
@w_fecha_proceso        datetime,
@w_reporte              catalogo,
@w_solicitud            char(1),
@w_fecha_inicio         datetime

select
@w_sp_name     = 'sp_estimacion_provision ',
@w_error       = 2100001,
@w_constante_e = 2.71828,
@w_reporte     = 'PROV'


declare @TablaRiesgo as table
(
	calificacion	varchar(3),
	rango_desde		float,
	rango_hasta		float
)


insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('A1', -0.1, 2.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('A2', 2.0, 3.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B1', 3.0, 4.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B2', 4.0, 5.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B3', 5.0, 6.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('C1', 6.0, 8.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('C2', 8.0, 15.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('D', 15.0, 35.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('E', 35.0, 100.0)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

exec @w_error = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte			= @w_reporte,
@o_existe_solicitud = @w_solicitud out,
@o_fin_mes_hab		= @i_fecha out

if @w_error != 0 goto ERRORFIN

if @w_solicitud = 'N' return 0

--PARAMETRO DE MTOSDO INDIVIDUAL
select @w_mtosdo_individual = pa_float
from cobis..cl_parametro
where pa_nemonico = 'MSDIND'
and   pa_producto = 'REC'

if @w_mtosdo_individual is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <MSDIND>'
   goto ERRORFIN
end

--PARAMETRO DE ANTIGUEDAD CLIENTE
select @w_antiguedad_cliente = pa_int
from cobis..cl_parametro
where pa_nemonico = 'ANTCLI'
and   pa_producto = 'REC'

if @w_antiguedad_cliente is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <ANTCLI>'
   goto ERRORFIN
end

--PARAMETRO DE NUMERO DE CICLOS ATR4
select @w_nciclo_atr4 = pa_int
from cobis..cl_parametro
where pa_nemonico = 'NCATR4'
and   pa_producto = 'REC'

if @w_nciclo_atr4 is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <NCATR4>'
   goto ERRORFIN
end

--PARAMETRO DE NUMERO DE INTEGRANTES ATR4
select @w_nintegrantes_atr4 = pa_int
from cobis..cl_parametro
where pa_nemonico = 'NIATR4'
and   pa_producto = 'REC'

if @w_nintegrantes_atr4 is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <NIATR4>'
   goto ERRORFIN
end

--PARAMETRO DE NUMERO DE CICLOS ATR6
select @w_nciclo_atr6 = pa_int
from cobis..cl_parametro
where pa_nemonico = 'NCATR6'
and   pa_producto = 'REC'

if @w_nciclo_atr6 is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <NCATR6>'
   goto ERRORFIN
end

--PARAMETRO DE NUMERO DE INTEGRANTES ATR6
select @w_nintegrantes_atr6 = pa_int
from cobis..cl_parametro
where pa_nemonico = 'NIATR6'
and   pa_producto = 'REC'

if @w_nintegrantes_atr6 is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <NIATR6>'
   goto ERRORFIN
end

--PARAMETRO DE SUBTIPO MICROCREDITO
select @w_clase_consumo = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CCCON'
and   pa_producto = 'REC'

if @w_clase_consumo is null begin
   select
   @w_error   = 2108028,
   @w_mensaje = 'No Encontro parametro <CCCON>'
   goto ERRORFIN
end

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error  = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out


if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null begin
   select
   @w_error   = 2108029,
   @w_mensaje = 'No Encontro Estado Vencido/Vigente/Cancelado para Cartera'
   goto ERRORFIN
end

select @w_mon_nacional = pa_tinyint
from   cobis..cl_parametro
where  pa_producto     = 'ADM'
and    pa_nemonico     = 'MLO'

if @@rowcount = 0
begin
   select @w_error = 101254 
   goto ERRORFIN
end

select @w_num_dec = 0
select @w_decimales = mo_decimales
from   cobis..cl_moneda
where  mo_moneda    = @w_mon_nacional

if @w_decimales = 'S'
begin
   select @w_num_dec = pa_tinyint
   from   cobis..cl_parametro
   where  pa_producto  = 'CCA'
   and    pa_nemonico  = 'NDE'

   if @@rowcount = 0
   begin
      select @w_error = 708130
      goto ERRORFIN
   end    
end

/* CARGA DE PARAMETROS GRUPALES */
select @w_gz0 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 0
select @w_gz1 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 1
select @w_gz2 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 2
select @w_gz3 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 3
select @w_gz4 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 4
select @w_gz5 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'GRUPAL' and sz_sumando = 5

/*CARGA DE PARAMETROS INDIVIDUALES */
select @w_iz0 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 0
select @w_iz1 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 1
select @w_iz2 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 2
select @w_iz3 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 3
select @w_iz4 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 4
select @w_iz5 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 5
select @w_iz6 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 6
select @w_iz7 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 7
select @w_iz8 = isnull(sz_valor,0) from sb_sumando_z where sz_toperacion = 'INDIVIDUAL' and sz_sumando = 8


/* CARGAR UNIVERSO DE PRESTAMOS A PROCESAR */
select     
tp_key                         = identity (int),
tp_fecha                       = do_fecha,
tp_fecha_ini                   = do_fecha_concesion,
tp_banco                       = do_banco,
tp_tipo_operacion              = do_tipo_operacion,
tp_clase_cartera               = do_clase_cartera,
tp_tipo_cartera                = do_tipo_cartera,
tp_subtipo_cartera             = do_clase_cartera,
tp_calificacion                = do_calificacion,
tp_codigo_cliente              = do_codigo_cliente,
tp_fecha_vencimiento           = do_fecha_vencimiento,
tp_num_cuotaven                = do_num_cuotaven,
tp_periodicidad_cuota          = do_periodicidad_cuota,
tp_antiguedad_cliente          = convert(int,0),
tp_unidad_atraso               = (select fa_atr * do_num_cuotaven from sb_factor_atr where fa_periodo_cuota = do_periodicidad_cuota),
tp_unidad_atraso_max           = convert(float, 0),
tp_pp_cuotas                   = (select pp_cuotas from sb_cuota_p_pago where pp_periodo_cuota = do_periodicidad_cuota and pp_toperacion = do_tipo_operacion),
tp_probabilidad_incumplimiento = convert(float, 0),
tp_porcentaje_pago             = convert(float, 0),
tp_cociente_pago               = isnull(do_cociente_pago, 1),
tp_numero_ciclos               = do_numero_ciclos,        --GRUPAL
tp_numero_integrantes          = do_numero_integrantes,   --GRUPAL
tp_sumando_z0                  = convert(float, 0),
tp_sumando_z1                  = convert(float, 0),
tp_sumando_z2                  = convert(float, 0),
tp_sumando_z3                  = convert(float, 0),
tp_sumando_z4                  = convert(float, 0),
tp_sumando_z5                  = convert(float, 0),
tp_sumando_z6                  = convert(float, 0),
tp_sumando_z7                  = convert(float, 0),
tp_sumando_z8                  = convert(float, 0),
tp_sumando_z                   = convert(float, 0),
tp_severidad_perdida           = convert(float, 0),
tp_saldo_cap                   = do_saldo_cap,
tp_saldo_int                   = do_saldo_int,
tp_valor_gar_liquida           = isnull((select isnull(dc_valor_uti_opera,0)
                                  from cob_conta_super..sb_dato_custodia, cob_conta_super..sb_dato_garantia
                                  where dc_fecha     = @i_fecha
                                  AND   dc_fecha     = dg_fecha
                                  and   dc_garantia  = dg_garantia
                                  and   dg_banco     = Op.do_banco
                                  and   dc_categoria = 'L'), 0),
tp_monto_expuesto              = convert(money, 0),
tp_provision                   = convert(money, 0),
tp_saldo                       = do_saldo,
tp_valor_cuota                 = do_valor_cuota,
tp_riesgo                      = convert(varchar(10),''),
tp_saldo_contable              = (SELECT isnull(sum(dr_valor),0)
                                 from  sb_dato_operacion_rubro
                                 where dr_banco = Op.do_banco
                                 and   dr_fecha = @i_fecha
                                 and   dr_concepto   not in ('COMMORA', 'IVA_CMORA', 'COMPRECAN', 'IVA_COMPRE')  --ca_concepto
                                 and   dr_estado in (@w_est_vigente, @w_est_vencido)),
tp_tipo                        = 'INDIVIDUAL'
into #tmp_provision
from cob_conta_super..sb_dato_operacion Op
where do_fecha          = @i_fecha
and   do_aplicativo     = 7
and   do_estado_cartera in (@w_est_vencido, @w_est_vigente)

if @@error <> 0 begin
   select
   @w_error = 2108030,
   @w_mensaje = 'ERROR AL INSERTAR EN TABLA <#tmp_provision>'
   goto ERRORFIN
end

create unique nonclustered index idx1 on #tmp_provision(tp_key)
create index idx2 on #tmp_provision(tp_banco)
create index idx3 on #tmp_provision(tp_codigo_cliente)

--Actualizar antiguedad del cliente
SELECT cliente = tp_codigo_cliente, antiguedad = datediff(mm, min(tp_fecha_ini), @i_fecha)
INTO #antiguedad
FROM #tmp_provision
GROUP BY tp_codigo_cliente

SELECT cliente = cl_cliente, antiguedad = datediff(mm, min(cl_fecha), @i_fecha)
INTO #antiguedad_2
FROM cobis..cl_cliente, #tmp_provision
where cl_cliente = tp_codigo_cliente
GROUP BY cl_cliente

UPDATE #antiguedad
SET #antiguedad.antiguedad = #antiguedad_2.antiguedad
FROM #antiguedad_2
WHERE #antiguedad.cliente = #antiguedad_2.cliente
AND isnull(#antiguedad_2.antiguedad, 0) > #antiguedad.antiguedad

UPDATE #tmp_provision
SET tp_antiguedad_cliente = antiguedad
FROM #antiguedad
WHERE tp_codigo_cliente = cliente

/* DETERMINAR EL MAXIMO ATRASO DEL PRÉSTAMO EN LOS ULTIMOS 4 MESES */
select @w_fecha_inicio = dateadd(mm, -4, @i_fecha)
   
SELECT
banco = tp_banco,
atraso = isnull(max(do_unidad_atraso),0) 
INTO #atraso
from sb_dato_operacion, #tmp_provision
where do_banco  = tp_banco
and   do_fecha >= @w_fecha_inicio
and   do_fecha <= @i_fecha  
and   do_aplicativo = 7
and   do_unidad_atraso is not NULL
GROUP BY tp_banco

UPDATE #tmp_provision
SET tp_unidad_atraso_max = atraso
FROM #atraso
WHERE tp_banco = banco

/* DETERMINAR SI EL CREDITO ES INDIVIDUAL O GRUPAL */
UPDATE #tmp_provision
SET tp_tipo = 'GRUPAL'
WHERE isnull(tp_numero_integrantes,0) > 1

UPDATE #tmp_provision
SET tp_severidad_perdida = sp_severidad
FROM sb_severidad_perdida 
WHERE sp_toperacion = tp_tipo
AND   sp_atr_minimo <= tp_unidad_atraso
AND   sp_atr_maximo >  tp_unidad_atraso

--BORRAR TABLA DATOS SUMANDO Z
delete sb_dato_sumando_z where ds_fecha = @i_fecha

--ACTUALIZA LOS VALORES DE PROVISION CON SUS RESPECTIVAS PROVISIONES
select @w_contador = 0

select @w_key = max(tp_key) from #tmp_provision

while @w_contador <= @w_key begin

   --INI VARIABLES
   select 
   @w_fecha_cliente   = null,
   @w_banco           = null,
   @w_codigo_cliente  = null,
   @w_saldo           = 0,
   @w_monto_pagar     = 0,
   @w_und_atraso_max  = 0,
   @w_und_atraso      = 0,
   @w_num_integrantes = 0,
   @w_antiguedad      = 0,
   @w_contador        = @w_contador +1,
   @w_tipo_oper       = null,
   @w_sum_z0          = 0,   
   @w_sum_z1          = 0,
   @w_sum_z2          = 0,
   @w_sum_z3          = 0,
   @w_sum_z4          = 0,
   @w_sum_z5          = 0,
   @w_sum_z6          = 0,
   @w_sum_z7          = 0,
   @w_sum_z8          = 0,
   @w_fecha_ini       = null,
   @w_cociente_pago   = 0,
   @w_saldo_contable  = 0,
   @w_atraso_max      = 0,
   @w_sumandos        = 0,
   @w_probabilidad    = 0,
   @w_valor_garantia  = 0
           
   --SACAR DATOS DE LA OPERACION 
   select 
   @w_banco              = tp_banco,
   @w_codigo_cliente     = tp_codigo_cliente,
   @w_saldo              = tp_saldo,
   @w_monto_pagar        = tp_valor_cuota,                 --CORRESPONDE AL VALOR DE LA CUOTA do_valor_cuota   
   @w_und_atraso         = tp_unidad_atraso,
   @w_numero_ciclos      = isnull(tp_numero_ciclos,0), 
   @w_num_integrantes    = isnull(tp_numero_integrantes,0), --PARA IDENTIFICAR LOS GRUPALES       
   @w_tipo_oper          = tp_tipo_operacion,
   @w_fecha_ini          = tp_fecha_ini,
   @w_cociente_pago      = tp_cociente_pago,
   @w_antiguedad         = tp_antiguedad_cliente,
   @w_saldo_contable     = tp_saldo_contable,
   @w_atraso_max         = tp_unidad_atraso_max,
   @w_valor_garantia     = tp_valor_gar_liquida,
   @w_tipo               = tp_tipo,
   @w_severidad          = tp_severidad_perdida
   from #tmp_provision
   where tp_key = @w_contador          

   --SI LA UNIDAD DE ATRASO < 3  REALIZAR CALCULOS PARA ENCONTRAR Porcentaje de Incumplimiento
   if @w_und_atraso >= 3
   BEGIN
      select @w_probabilidad = 100,
             @w_sumandos     = 0
   END
   ELSE
   BEGIN
      /* DETERMINAR EL NIVEL DE RIESGO */          
      exec @w_error       = sp_buro_credito
      @i_cliente          = @w_codigo_cliente,
      @i_tipo             = @w_tipo,
      @i_saldo            = @w_saldo,
      @i_monto_pagar      = @w_monto_pagar,
      @i_meses_vto        = @w_atraso_max,
      @i_fecha_proceso    = @i_fecha,
      @i_antiguedad       = @w_antiguedad,             --ANTIGUEDAD DEL CLIENTE EN MESES
      @i_param_mtosdo     = @w_mtosdo_individual,      --CORRESPONDE AL PARAMETRO DE MTOSDO INDIVIDUAL
      @i_param_antiguedad = @w_antiguedad_cliente,     --CORRESPNDE AL PARAMETRO DE ANTIGUEDAD CLIENTE
      @i_param_ncliclo4   = @w_nciclo_atr4,            --CORRESPONDE AL PARAMETRO NUM CICLOS ATR4
      @i_param_num_int4   = @w_nintegrantes_atr4,      --CORRESPONDE AL PARAMETRO NUM DE INTEGRANTES ATR4
      @i_numero_ciclos    = @w_numero_ciclos,  
      @i_num_integrantes  = @w_num_integrantes,     
      @i_param_ncliclo6   = @w_nciclo_atr6,            --CORRESPONDE AL PARAMETRO NUM CICLO ATR6       
      @i_param_num_int6   = @w_nintegrantes_atr6,      --CORRESPONDE AL PARAMETRO NUM DE INTEGRANTES ATR6   
      @o_meses            = @w_meses  out,
      @o_riesgo           = @w_riesgo out   
    
      if @w_error <> 0 begin
         select
         @w_mensaje   = 'Error Ejecutando sp_buro_credito',
         @w_error     = 2108031
         goto ERRORFIN
      end             
      
      /* CALCULAR PROBABILIDAD DE INCUMPLIMIENTO DEPENDIENDO DEL TIPO DE CREDITO */
      if @w_tipo = 'GRUPAL'
      BEGIN
         select     
         @w_sum_z0 = isnull(@w_gz0,0),
         @w_sum_z1 = isnull(@w_gz1 * @w_und_atraso,0),
         @w_sum_z2 = isnull(@w_gz2 * @w_cociente_pago,0),
         @w_sum_z3 = case when @w_riesgo = 'ALTO'  then @w_gz3 else 0 end,
         @w_sum_z4 = case when @w_riesgo = 'MEDIO' then @w_gz4 else 0 end,
         @w_sum_z5 = case when @w_riesgo = 'BAJO'  then @w_gz5 else 0 end
      
      END
      ELSE
      BEGIN -- PARA INDIVIDUALES
         select     
         @w_sum_z0 = isnull(@w_iz0,0),
         @w_sum_z1 = isnull(@w_iz1 * @w_und_atraso,0),
         @w_sum_z2 = isnull(@w_iz2 * @w_atraso_max,0),
         @w_sum_z3 = isnull(@w_iz3 * @w_cociente_pago,0),
         @w_sum_z4 = case when @w_riesgo = 'ALTO'  then @w_iz4 else 0 end,
         @w_sum_z5 = case when @w_riesgo = 'MEDIO' then @w_iz5 else 0 end,
         @w_sum_z6 = case when @w_riesgo = 'BAJO'  then @w_iz6 else 0 end,
         @w_sum_z7 = isnull(@w_iz7 * @w_meses,0),
         @w_sum_z8 = @w_iz8
      END
      
      select @w_sumandos     = @w_sum_z0 + @w_sum_z1 + @w_sum_z2 + @w_sum_z3 + 
                               @w_sum_z4 + @w_sum_z5 + @w_sum_z6 + @w_sum_z7 + 
                               @w_sum_z8
                             
      select @w_probabilidad = 1/(1 + power(@w_constante_e, -(@w_sumandos))) * 100
   END
   
   update #tmp_provision set
   tp_antiguedad_cliente          = @w_antiguedad,
   tp_monto_expuesto              = @w_saldo_contable - @w_valor_garantia,
   tp_provision                   = round((@w_probabilidad/100) * (@w_severidad/100) * (@w_saldo_contable - @w_valor_garantia), @w_num_dec),
   tp_probabilidad_incumplimiento = @w_probabilidad,
   tp_sumando_z0                  = @w_sum_z0,
   tp_sumando_z1                  = @w_sum_z1,        
   tp_sumando_z2                  = @w_sum_z2,            
   tp_sumando_z3                  = @w_sum_z3,
   tp_sumando_z4                  = @w_sum_z4,
   tp_sumando_z5                  = @w_sum_z5,
   tp_sumando_z6                  = @w_sum_z6,
   tp_sumando_z7                  = @w_sum_z7,
   tp_sumando_z8                  = @w_sum_z8,
   tp_sumando_z                   = @w_sumandos,
   tp_riesgo                      = @w_riesgo
   where tp_key = @w_contador
   
   if @@error <> 0 begin
      select
      @w_error = 2108034,
      @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <#tmp_provision>'
      goto ERRORFIN
   end           
end --Fin While                

/* Insercion tabla datos sumandos Z */
insert into sb_dato_sumando_z(
ds_fecha,          ds_banco,         ds_cliente,
ds_toperacion,     ds_sumando_z0,    ds_sumando_z1,
ds_sumando_z2,     ds_sumando_z3,    ds_sumando_z4,
ds_sumando_z5,     ds_sumando_z6,    ds_sumando_z7,
ds_sumando_z8,     ds_atr,           ds_atr_max,
ds_cociente_pago,  ds_riesgo)
select
tp_fecha,           tp_banco,         tp_codigo_cliente,
tp_tipo_operacion,  tp_sumando_z0,    tp_sumando_z1,
tp_sumando_z2,      tp_sumando_z3,    tp_sumando_z4,
tp_sumando_z5,      tp_sumando_z6,    tp_sumando_z7,
tp_sumando_z8,      tp_unidad_atraso, tp_unidad_atraso_max,
tp_cociente_pago,   tp_riesgo
from #tmp_provision

if @@error <> 0 begin
   select
   @w_error = 2108036,
   @w_mensaje = 'ERROR AL INSERTAR EN TABLA sb_dato_sumando_z'
   goto ERRORFIN
end

update #tmp_provision set tp_calificacion = (select calificacion from @TablaRiesgo 
											where (isnull(tp_provision, 0) / (isnull(tp_saldo_cap, 0) + isnull(tp_saldo_int, 0)) * 100) > rango_desde 
											and   (isnull(tp_provision, 0) / (isnull(tp_saldo_cap, 0) + isnull(tp_saldo_int, 0)) * 100) <= rango_hasta)
where isnull(tp_saldo_cap, 0)+ isnull(tp_saldo_int, 0) >0 

--ACTUALIZA LOS VALORES DE PROVISION EN EL CONSOLIDADO DE OPERACION
update cob_conta_super..sb_dato_operacion set 
do_unidad_atraso               = tp_unidad_atraso,
do_cociente_pago               = tp_cociente_pago,
do_probabilidad_incumplimiento = tp_probabilidad_incumplimiento,
do_severidad_perdida           = tp_severidad_perdida,
do_monto_expuesto              = tp_monto_expuesto,
do_provision                   = tp_provision,
do_calificacion                = tp_calificacion
from #tmp_provision
where do_banco          = tp_banco
and   do_fecha          = @i_fecha 
and   do_aplicativo     = 7
and   do_estado_cartera in (@w_est_vencido, @w_est_vigente)

if @@error <> 0 begin
   select
   @w_error = 2108045,
   @w_mensaje = 'ERROR AL ACTUALIZAR EN TABLA <cob_conta_super..sb_dato_operacion>'
   goto ERRORFIN
end

----------------------------------------
--Paso de datos a tabla formato reporte
----------------------------------------

/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
if not object_id('sb_reporte_provision') is null drop table sb_reporte_provision

select 
'FECHA'                          = convert(varchar,tp_fecha,111),
'OPERACION'                      = tp_banco,
'CLIENTE'                        = convert(varchar,tp_codigo_cliente),
'TIPO OPERACION'                 = tp_tipo_operacion,
'PERIOD.CUOTA DIAS'              = convert(varchar,tp_periodicidad_cuota),
'NUMERO CUOTAS VENCIDAS'         = convert(varchar,tp_num_cuotaven),
'UNIDAD DE ATRASO'               = cast(tp_unidad_atraso as varchar),
'PORCENTAJE PAGO(%)'             = cast(round(tp_cociente_pago,2) as numeric(10,2)),
'ANTIGUEDAD CLIENTE (MESES)'     = cast(tp_antiguedad_cliente as varchar),
'SUMANDO Z0'                     = cast(ds_sumando_z0 as numeric(10,4)),
'SUMANDO Z1'                     = cast(ds_sumando_z1 as numeric(10,4)),
'SUMANDO Z2'                     = cast(ds_sumando_z2 as numeric(10,4)),
'SUMANDO Z3'                     = cast(ds_sumando_z3 as numeric(10,4)),
'SUMANDO Z4'                     = cast(ds_sumando_z4 as numeric(10,4)),
'SUMANDO Z5'                     = cast(ds_sumando_z5 as numeric(10,4)),
'SUMANDO Z6'                     = cast(ds_sumando_z6 as numeric(10,4)),
'SUMANDO Z7'                     = cast(ds_sumando_z7 as numeric(10,4)),
'SUMANDO Z8'                     = cast(ds_sumando_z8 as numeric(10,4)),
'PROBABILIDAD INCUMPLIMIENTO(%)' = cast(round(tp_probabilidad_incumplimiento,2) as numeric(10,2)),
'SEVERIDAD PERDIDA(%)'           = cast(round(tp_severidad_perdida,2) as numeric(10,2)),
'SALDO CAPITAL'                  = cast(round(tp_saldo_cap,2) as numeric(10,2)),
'VALOR GARANTIA LIQUIDA'         = cast(round(tp_valor_gar_liquida,2) as numeric(10,2)),
'MONTO EXPUESTO'                 = cast(round(tp_monto_expuesto,2) as numeric(10,2)),
'PROVISION'                      = cast(round(tp_provision,2) as numeric(10,2))
into sb_reporte_provision
from #tmp_provision, sb_dato_sumando_z
where tp_fecha = @i_fecha
and   tp_fecha = ds_fecha
and   tp_banco = ds_banco

----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 28794

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_provision out '

select @w_destino  = @w_path + 'repprovision_' + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_destino2 = @w_path + 'lineas_'      + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_errores  = @w_path + 'repprovision_' + replace(convert(varchar, @i_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'repprovision.txt -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte de Provisiones'
   print @w_comando
   select
   @w_error = 2108046,
   @w_mensaje = 'Error generando Reporte de Provisiones'
   goto ERRORFIN
end


----------------------------------------
-- Lineas Plano
----------------------------------------

select @w_lineas = convert(varchar,isnull(count(1),0)) from cob_conta_super..sb_reporte_operativo
select @w_comando = 'echo ' + @w_lineas + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas'
   print @w_comando
   select
   @w_error = 2108047,
   @w_mensaje = 'Error generando Archivo de Lineas'
   goto ERRORFIN
end


----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
       
while 1 = 1 begin
   set rowcount 1
   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_reporte_provision'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + char(9)
end
--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_comando
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERRORFIN
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'repprovision.txt' + ' ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas mas cabeceras'
   print @w_comando
   select
   @w_error = 2108049,
   @w_mensaje = 'Error generando Archivo de Lineas mas cabeceras'
   goto ERRORFIN
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I' 

if @@error != 0
begin
	select @w_error = 710002
	goto ERRORFIN
end


return 0

ERRORFIN:

insert into sb_errorlog
(er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error)
values 
(getdate(), @w_fecha_proceso, @w_sp_name, convert(varchar, @w_error) + ' - ESTIMACION PROVISION', @w_mensaje)

return 1

GO


