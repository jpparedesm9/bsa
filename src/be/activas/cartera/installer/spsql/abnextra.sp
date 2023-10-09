/************************************************************************/
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Archivo:                abnextra.sp                             */
/*      Procedimiento:          sp_abono_extraordinario                 */
/*      Disenado por:           Fabian de la Torre                      */
/*      Fecha de escritura:     12 de Febrero 1999                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Aplica el abono. Este procedimiento considera la aplicacion por */
/*      concepto.                                                       */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA                   AUTOR         CAMBIO                    */
/*      MAR-27-2001             EPB           Correcciones para pagos   */
/*                                            Extraordinarios y red. T  */
/*      JUN-17-2005             FQ.           defecto No.3869 BAC       */
/*      MAR-16-2006             EP.           NR.433 BAC                */
/*      SEP 2006                FQ            Optimizacion 152          */
/*      NOV-03-2006             FQ            def 7394                  */
/*      FEB-15-2012             LCM           Req 293-Recono. Garantias */
/*      JUN-06-2014             LCM           Req 433-Pagos Anticipados */
/*      05/12/2016          R. S�nchez            Modif. Apropiaci�n    */
/*      15/05/2020              DCU           Req. 138837 desplazamiento*/
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_abono_extraordinario')
   drop proc sp_abono_extraordinario
go

create proc sp_abono_extraordinario
@s_sesn                 int          = NULL,
@s_user                 login        = NULL,
@s_term                 varchar (30) = NULL,
@s_date                 datetime     = NULL,
@s_ofi                  smallint     = NULL,
@s_ssn                  int,
@s_srv                  varchar(30),
@s_lsrv                 varchar(30),
@i_secuencial_ing       int,
@i_secuencial_pag       int,
@i_fecha_proceso        datetime,
@i_operacion            int,
@i_en_linea             char(1),
@i_tipo_reduccion       char(1),
@i_monto_pago           money,
@i_cotizacion           money,
@i_tcotizacion          char(1),
@i_num_dec              smallint,
@i_dividendo            int,
@i_tipo_tabla           catalogo,
@i_acciones             char(1) = 'N',
@i_valores              char(1) = 'N',
@i_tipo_aplicacion      char(1),
@i_prepago              char(1) = 'N',
@i_tiene_reco           char(1) = 'N',
@i_pago_especial        char(1) = 'N',
@i_tipo_amortizacion    catalogo = null , ---NR 392 TAblas Flexibles
@i_rubro_cap            catalogo = 'CAP', ---NR 392 TAblas Flexibles
@o_monto_sobrante       money out

as 
declare
   @w_error                   int,
   @w_secuencia               int,
   @w_ap_prioridad            int,
   @w_ap_concepto             catalogo,
   @w_est_cancelado           tinyint,
   @w_est_novigente           tinyint,
   @w_est_vigente             tinyint,
   @w_di_dividendo            int,
   @w_di_fecha_ven            datetime,
   @w_monto_prioridad         money,
   @w_am_concepto             catalogo,
   @w_monto_concepto          money,
   @w_saldo_final             money,
   @w_sobrante_pago           money,
   @w_monto_total             money,
   @w_banco                   cuenta,
   @w_dividendos_tmp          int,
   @w_div_vigente             int,
   @w_div_vencido             int,   
   @w_de_interes              char(1),
   @w_primer_vigente          int,
   @w_ult_vigente             int,
   @w_saldo_cap               money,
   @w_di_fecha_ini            datetime,
   @w_fecha_ini_calc          datetime,
   @w_di_num_dias             int, 
   @w_dias_anio               int,
   @w_porcentaje              float,
   @w_float                   money,
   @w_cuota                   money,
   @w_pago                    money,
   @w_concepto                catalogo,
   @w_concepto_aux            catalogo,
   @w_valor_rubro             money,
   @w_num_dividendos          int,
   @w_offset                  int,
   @w_fecha_fin               datetime,
   @w_valor_prioridad         float,
   @w_ro_valor                float,
   @w_dividendo_ant           smallint,
   @w_op_monto                money,
   @w_fpago                   catalogo,
   @w_cuenta                  cuenta,
   @w_moneda                  smallint,
   @w_tramite                 int,
   @w_causacion               char(1),
   @w_dias_int                int,
   @w_sp_name                 descripcion,
   @w_periodo_int             smallint,
   @w_plazo_operacion         int,
   @w_tipo_cobro              char(1),
   @w_gracia                  smallint,
   @w_dividendos_gracia_cap   int, 
   @w_dividendos_gracia_int   int, 
   @w_dividendo               int,
   @w_cap_proporcional        money,
   @w_tipo_tabla              catalogo,
   @w_num_div                 smallint,
   @w_fecha_vencimiento       datetime,
   @w_fecha_ult_proceso       datetime,
   @w_bandera_be              char(1), --Para enviarla a Garantias
   @w_vlr_despreciable        float,
   @w_pagado_fut              money,
   @w_cuota_fut               money,
   @w_acumulado_fut           money,
   @w_periodo_cap             smallint,
   @w_cuota_desde_cap         int,
   @w_di_de_capital           int,
   @w_saldo_div_1             money,
   @w_saldo_vig_cap           money,
   @w_num_div_cap             int,
   @w_paga_int                char(1),
   @w_paga_cap                char(1),
   @w_ti_cuota_dest           smallint,   -- Para Traslado de Intereses IFJ REQ 379 25/Nov/2005
   @w_parametro_fag           catalogo,
   @w_aso_fag                 catalogo,
   @w_sector                  catalogo,
   @w_tiene_fag               char(1),
   @w_parametro_fng           catalogo,
   @w_parametro_Ivafng        catalogo,
   @w_aso_fng                 catalogo,
   @w_tiene_fng               char(1),
   @w_dias_360                int,
   @w_fecha                   datetime,
   @w_monto_acumulado         money,
   @w_valor_vencido           money,
   @w_est_castigado           tinyint,
   @w_estado_op               tinyint,
   @w_am_estado               tinyint,
   @w_vlr_x_amort             money,   --LCM - 293
   @w_porc_cubrim             float,   --LCM - 293
   @w_vlr_cap                 money,   --LCM - 293
   @w_concepto_rec            char(1), --LCM - 293
   @w_sob_rec                 money,   --LCM - 293
   @w_ult_div_canc            int,      --LCM - 293
   @w_operacion               int,
   @w_dif                     money,
   @w_div                     smallint,
   @w_sec                     int,
   @w_reg                     tinyint, 
   @w_upd                     int,
   @w_int_pagado              money,
   @w_sobro                   money,
   @w_fecha_pag               datetime,
   @w_am_esta_div_vig         smallint,
   @w_int                     catalogo,
   @w_vigenteMipyme           smallint,
   @w_MIPYME                  catalogo,
   @w_IVAMIPYME               catalogo,
   @w_saldo_oper              money
--LGU
DECLARE  
   @w_div_tmp                 SMALLINT,
   @w_debug                   char(1),
   @w_rubro_iva               VARCHAR(10),
   @w_float_iva               money,
   @w_tasa_iva                float,
   @w_secuencia_iva           SMALLINT,
   @w_pagado_iva              MONEY,
   @w_acumulado_iva           MONEY,
   @w_oficina_op              int  ,
   -----------------------------------
   @w_rubro                   catalogo,
   @w_dividendo_aux           int,
   @w_acumulado_div           money,
   @w_pagado_div              money,
   @w_estado_amort            int,
   @w_dividendo_max           int,
   @w_acumulado               money,
   @w_pagado                  money,
   @w_dividendo_vig           int ,
   @w_div_rubro               int,
   @w_div_cancelada           int,
   @w_div_act                 int
   
        
select  @w_debug = 'N'

IF  @i_operacion  = 0
	select  @w_debug = 'S'


--- INICIALIZACION DE VARIABLES
select 
@w_num_div_cap     = 0,
@w_div_vencido     = 2,
@w_ult_div_canc    = 0

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_novigente  = @w_est_novigente out

if @w_error <> 0 return @w_error

/*********************************************************************************************/
/* Ini Rubros desplazamiento                                                                 */
/*********************************************************************************************/   
select @w_dividendo_vig = di_dividendo
from ca_dividendo
where di_operacion = @i_operacion
and di_estado      = @w_est_vigente

select 
operacion_a = am_operacion,
dividendo_a = am_dividendo, 
concepto_a  = am_concepto , 
estado_a    = am_estado   ,
cuota_a     = am_cuota    ,
gracia_a    = am_gracia   ,
pagado_a    = am_pagado   ,
acumulado_a = am_acumulado 
into #rubros_desplazamiento_pagos
from ca_amortizacion
where am_operacion = @i_operacion
and am_dividendo   > @w_dividendo_vig
and am_concepto   in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
and am_pagado     = am_cuota

select operacion_a, concepto_a, pagado = sum(pagado_a)
into #pagos_rubros_desplazamiento
from #rubros_desplazamiento_pagos
group by operacion_a, concepto_a

update ca_amortizacion set
am_cuota     = am_cuota     + pagado,
am_acumulado = am_acumulado + pagado,
am_pagado    = am_pagado    + pagado
from #pagos_rubros_desplazamiento
where am_operacion  = operacion_a
and   am_concepto   = concepto_a
and   am_dividendo  = @w_dividendo_vig

update ca_amortizacion set
am_acumulado   = am_acumulado - am_pagado,
am_pagado      = 0,
am_estado      = 1,
am_cuota       = am_cuota - am_pagado
from #rubros_desplazamiento_pagos
where am_operacion  = operacion_a
and   am_concepto   = concepto_a
and   am_dividendo  = dividendo_a
and   am_dividendo  > @w_dividendo_vig

-------------------------------------------
select *
into #rubros_pendientes_pago
from ca_amortizacion
where am_operacion = @i_operacion
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD')
and   am_dividendo  > @w_dividendo_vig
and   am_cuota     <> 0

select @w_div_rubro    = min(am_dividendo)
from #rubros_pendientes_pago  

select @w_div_cancelada =  min(am_dividendo)
from ca_amortizacion
where am_operacion = @i_operacion
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD')
and   am_dividendo  > @w_dividendo_vig
and   am_cuota      = 0

delete ca_amortizacion
where am_operacion = @i_operacion
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD')
and   am_dividendo >= @w_div_cancelada

select @w_div_act = @w_div_rubro - @w_div_cancelada

insert into ca_amortizacion (
am_operacion, am_dividendo             , am_concepto, am_estado   , am_periodo, 
am_cuota    , am_gracia                , am_pagado  , am_acumulado, am_secuencia)
select 
am_operacion, am_dividendo - @w_div_act, am_concepto, am_estado   , am_periodo, 
am_cuota    , am_gracia                , am_pagado  , am_acumulado, am_secuencia
from #rubros_pendientes_pago

select 
operacion_a =  am_operacion, 
concepto_a  = am_concepto, 
acumulado_a = sum(am_acumulado), 
cuota_a     = sum(am_cuota),
pagado_a   = sum(am_pagado)
into #rubros_desplazamiento_ant
from ca_amortizacion
where am_operacion = @i_operacion
and am_concepto in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
group by am_operacion, am_concepto

/*********************************************************************************************/
/* Fin Rubros desplazamiento                                                                 */
/*********************************************************************************************/   


select @w_int = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'INT'
if @@rowcount = 0   
   return 710256

select 
	@w_vlr_despreciable = 1.0 / power(10, isnull(@i_num_dec, 4)),
	@w_sp_name = 'sp_abono_extraordinario',
	@w_rubro_iva = 'IVA_INT'

select @w_gracia = 0

delete ca_total_prioridad_tmp
where  operacion = @i_operacion

-- SALVO EL VALOR INICIAL
select @w_monto_total = @i_monto_pago


--- PARAMETRO DE LA GARANTIA DE FNG
select @w_parametro_fng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'

select @w_parametro_Ivafng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAFNG'

-- DATOS DE LA OPERACION
select @w_cuota      = op_cuota,
@w_banco      = op_banco,
@w_dias_anio  = op_dias_anio,
@w_op_monto   = op_monto,
@w_moneda     = op_moneda,
@w_causacion  = op_causacion,
@w_tramite    = op_tramite,
@w_sector     = op_sector,
@w_tipo_tabla = op_tipo_amortizacion,
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_estado_op         = op_estado,
@w_oficina_op        = op_oficina
from   ca_operacion
where  op_operacion = @i_operacion

---NR 392 Tablas Felxibles
if (@i_tipo_tabla  =  @i_tipo_amortizacion ) 
begin
   exec @w_error = sp_ca_pagflex_reduce_Plazo
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_date              = @s_date,
   @s_ofi               = @s_ofi,
   @i_operacionca       = @i_operacion,
   @i_dividendo         = @i_dividendo,
   @i_monto_pago        = @i_monto_pago,
   @i_secuencial_pag    = @i_secuencial_pag,
   @i_rubro_cap         = @i_rubro_cap,
   @i_cotizacion        = @i_cotizacion,
   @i_tcotizacion       = @i_tcotizacion,
   @i_en_linea          = @i_en_linea,
   @i_num_dec           = @i_num_dec,
   @i_tiene_reco        = @i_tiene_reco,
   @o_monto_sobrante    = @w_sobro out
   
   if @w_error <> 0
      return @w_error

      select @o_monto_sobrante = @w_sobro 
  return 0 
end
---FIN NR 392 Tablas Felxibles


select @w_tipo_cobro = 'A', --en Abono Extra debe ser Cobro Acumulado para el Interes
       @w_fecha_pag  = ab_fecha_pag
from   ca_abono
where  ab_operacion = @i_operacion
and    ab_secuencial_ing = @i_secuencial_ing

---Solo cuando hay reduccion de Cuota y APlicacion por Concepto es que se 
---recalculan las cuotas ya acumuladas
if @i_tipo_reduccion in ('C','T')  or @i_tipo_aplicacion = 'C'
   select @i_pago_especial   = 'S',
          @i_tipo_aplicacion = 'C'

if @i_pago_especial ='S'
BEGIN
	select ro_operacion,ro_concepto,am_acumulado,di_dividendo
	into #oper_cuota_vigente
	from ca_amortizacion,ca_dividendo,ca_rubro_op
	where am_operacion = @i_operacion
	and am_operacion  = di_operacion
	and am_dividendo  = di_dividendo
	and am_concepto   = ro_concepto
	and ro_operacion  = am_operacion
	and ro_tipo_rubro = 'Q'
	and di_estado     = 1
	and am_acumulado  > 0
union
	select ro_operacion,ro_concepto,am_acumulado,di_dividendo
	from ca_amortizacion,ca_dividendo,ca_rubro_op
	where am_operacion = @i_operacion
	and am_operacion  = di_operacion
	and am_dividendo  = di_dividendo
	and am_concepto   = ro_concepto
	and ro_operacion  = am_operacion
	and di_estado     = 1
	and am_acumulado  > 0
	and am_concepto  =	@w_parametro_Ivafng 
end
-- DIVIDENDO VIGENTE
select @w_div_vigente = di_dividendo
from   ca_dividendo
where  di_operacion   = @i_operacion
and    di_estado      = @w_est_vigente
if @@rowcount > 1   
   return 710139

/* DETERMINAR EL DIV. VIGENTE REAL */
/*
-- LGU-VIG
if exists(SELECT 1 FROM ca_dividendo 
	WHERE di_operacion   = @i_operacion
	AND di_fecha_ini     < @w_fecha_ult_proceso
	AND @w_fecha_ult_proceso <= di_fecha_ven 
	AND di_estado            <> @w_est_cancelado) and
	@w_div_vigente <> (SELECT di_dividendo FROM ca_dividendo 
	WHERE di_operacion   = @i_operacion
	AND di_fecha_ini     < @w_fecha_ult_proceso
	AND @w_fecha_ult_proceso <= di_fecha_ven 
	AND di_estado            <> @w_est_cancelado) 
BEGIN
	PRINT '---------------------------------------xxxxxxxxxxxxxxxxxx  1  xxxxxxxxxxxxxxxxx---------------------- '+ convert(varchar, @w_div_vigente)
	SELECT @w_div_vigente = max(di_dividendo) 
	FROM ca_dividendo 
	WHERE di_operacion   = @i_operacion
	AND di_fecha_ini     < @w_fecha_ult_proceso
	AND @w_fecha_ult_proceso <= di_fecha_ven 
	AND di_estado            <> @w_est_cancelado
	if @@rowcount <> 0
	BEGIN
	
	PRINT '---------------------------------------xxxxxxxxxxxxxxxxxx  2  xxxxxxxxxxxxxxxxx----------------------'+ convert(varchar, @w_div_vigente)
		UPDATE ca_dividendo SET di_estado = @w_est_vigente
		where  di_operacion   = @i_operacion
		and    di_dividendo   = @w_div_vigente
		UPDATE ca_dividendo SET di_estado = @w_est_novigente
		where  di_operacion   = @i_operacion
		and    di_dividendo   > @w_div_vigente
		SELECT @i_dividendo = @w_div_vigente
	END
	else
	   return 710139
END
*/
-- ES POSIBLE QUE LA TABLA TENGA UN DIVIDENDO DE CAPITAL CADA
-- N DIVIDENDOS DE INTERES
-- POR LO TANTO SE DEBE OBTENER EL DIVIDENDO INICIAL Y FINAL DE LA SERIE

-- PRIMER DIVIDENDO VIGENTE EN LA SERIE
select @w_primer_vigente = @w_div_vigente

-- ULTIMO DIVIDENDO VIGENTE EN LA SERIE
select @w_ult_vigente  = @w_div_vigente,
       @w_vigenteMipyme  = @w_div_vigente

-- DIVIDENDO ANTERIOR AL VIGENTE
if @i_dividendo = 1
   select @w_dividendo_ant = @i_dividendo
else
   select @w_dividendo_ant = @i_dividendo - 1

---ERVISION DE LA OBLIGACION
select @w_num_div_cap = count(1)
from ca_dividendo
where di_operacion  = @i_operacion
and   di_de_capital = 'S'

if @w_num_div_cap <= 0
begin
   --SE ARREGLA LA TABLA DE DIVIDENDOS PARA PODER APLICAR EL
   --ABONO
   update ca_dividendo
   set    di_de_capital = 'S'
   from   ca_amortizacion,ca_dividendo
   where  am_operacion = @i_operacion
   and    am_concepto = 'CAP'
   and    am_cuota > 0
   and    am_operacion = di_operacion
   and    am_dividendo = di_dividendo
   and    di_estado <> 3
   
   update ca_dividendo
   set    di_de_capital = 'N'
   from   ca_amortizacion,ca_dividendo
   where  am_operacion = @i_operacion
   and    am_concepto = 'CAP'
   and    am_cuota = 0
   and    am_operacion = di_operacion
   and    am_dividendo = di_dividendo
   and    di_estado <> 3
   
   --SE INSERTA EL ERROR PARA QUE LOS ESPECIALISTAS LOS REVICEN POSTERIORMENTE
   insert into ca_errorlog
   (er_fecha_proc,      er_error,      er_usuario,
   er_tran,            er_cuenta,     er_descripcion,
   er_anexo)
   values(@i_fecha_proceso,   710005,        @s_user,
   7269,               @w_banco,      'ERROR PARA LOS ESPECIALISTAS TECNICOS',
   'APLICANDO ABONO EXTRAORDINARIO')
end

select @w_parametro_fag = pa_char
from  cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'COMFAG'

select @w_tiene_fag = 'N',
       @w_tiene_fng = 'N'
       
if exists (select 1 from ca_amortizacion
           where am_operacion = @i_operacion
           and   am_concepto  = @w_parametro_fag
           and   am_estado   <> 3)
begin
   select @w_tiene_fag = 'S'
end
       
if exists (select 1 from ca_amortizacion
           where am_operacion = @i_operacion
           and   am_concepto   = @w_parametro_fng
           and   am_estado   <> 3)
begin
   select  @w_tiene_fng = 'S'
end   


if (@w_tiene_fag = 'S') 
begin   
   delete ca_base_rubros_p
   where rp_operacion = @i_operacion
   
   --LA TABLA ca_base_rubros_p SE CARGA POR CADA OEPRACION QUE TENGA ABONO EXTRAORDINARIO
   --PARA ALMACENAR COMO ESTABA LA TABLA ANTES DEL PAGO EXTRAORDINARIO  Y RESPETAR 
   --ESTAS FECHAS UNA VEZ SE REGENERE LA TABLA
   
   insert into ca_base_rubros_p
   select di_operacion,am_concepto,di_dividendo
   from ca_amortizacion,ca_dividendo
   where am_operacion = @i_operacion
   and am_operacion = di_operacion
   and am_dividendo = di_dividendo
   and am_concepto = @w_parametro_fag
   and am_cuota > 0   
   
   select @w_aso_fag = ro_concepto
   from   ca_rubro_op
   where  ro_operacion = @i_operacion
   and    ro_concepto_asociado = @w_parametro_fag   
end 

-- PASO DE LA OPERACION A TEMPORALES
exec @w_error = sp_pasotmp
@s_user            = @s_user,
@s_term            = @s_term,
@i_banco           = @w_banco,
@i_operacionca     = 'S',
@i_dividendo       = 'N',
@i_amortizacion    = 'N',
@i_cuota_adicional = 'S',
@i_rubro_op        = 'S',
@i_valores         = 'S', 
@i_acciones        = 'N'  

if @w_error <> 0
   return @w_error

delete ca_valores_tmp
where  vat_operacion = @i_operacion
and    vat_dividendo < @w_div_vigente

if @@error <> 0
begin
   select @w_error = 710003
   goto ERROR
end

update ca_valores_tmp 
set   vat_dividendo = vat_dividendo - @w_ult_vigente + 1
where vat_operacion = @i_operacion

if @@error <> 0
begin
   select @w_error = 710002
   goto ERROR
end

select @w_vlr_x_amort = 0,
       @w_porc_cubrim = 0,
       @w_concepto_rec = 'N'

--- SI LA OBLIGACION TIENE RECONOCIMIENTO SE CONSULTAN DATOS ASOCIADOS AL PAGO 
if @i_tiene_reco = 'S'
begin

   exec @w_error = sp_pagxreco
        @i_tipo_oper      = 'Q',
        @i_operacionca    = @i_operacion,
        @i_secuencial_pag = @i_secuencial_pag,
        @o_porc_cubrim    = @w_porc_cubrim out,
        @o_vlr_x_amort    = @w_vlr_x_amort out,
        @o_concepto_rec   = @w_concepto_rec out

   if @w_error <> 0 
      return @w_error
end

insert into ca_total_prioridad_tmp
select ap_prioridad,
sum(am_cuota+am_gracia-am_pagado)+@w_vlr_x_amort,
@i_operacion
from   ca_abono_prioridad, ca_rubro_op, ca_amortizacion
where  ap_secuencial_ing = @i_secuencial_ing
and    ap_operacion      = @i_operacion
and    ro_operacion      = @i_operacion
and    am_operacion      = @i_operacion
and    am_estado        <> @w_est_cancelado
and    ro_tipo_rubro     = 'C'
and    ro_fpago          in ('P','A')
and    am_concepto       = ap_concepto
and    ro_concepto       = ap_concepto
group  by ap_prioridad

-- CURSOR DE PRIORIDADES SOBRE LOS RUBROS TIPO CAPITAL
-- PARA APLICAR EL MONTO EXTRAORDINARIO
declare
   cursor_prioridades cursor
   for select ap_prioridad, ap_concepto,
              sum(am_cuota+am_gracia-am_pagado)+@w_vlr_x_amort
      from   ca_abono_prioridad,ca_rubro_op,ca_amortizacion
      where  ap_secuencial_ing =  @i_secuencial_ing
      and    ap_operacion      =  @i_operacion
      and    ro_operacion      =  @i_operacion
      and    am_operacion      =  @i_operacion
      and    am_estado        <>  @w_est_cancelado
      and    ro_tipo_rubro     =  'C'
      and    ro_fpago          in ('P', 'A')
      and    am_concepto       =  ap_concepto
      and    ro_concepto       =  ap_concepto
      group  by ap_prioridad,ap_concepto
      order  by ap_prioridad desc,ap_concepto
      for read only

open  cursor_prioridades
fetch cursor_prioridades
into  @w_ap_prioridad, @w_ap_concepto, @w_monto_concepto

while @@fetch_status = 0
begin
   if (@@fetch_status = -1)
     return 710004

   select @w_monto_prioridad = total
   from   ca_total_prioridad_tmp  
   where  prioridad = @w_ap_prioridad
   and    operacion = @i_operacion
   
   select @w_pago = @w_monto_total * (@w_monto_concepto / @w_monto_prioridad)
   
   if @w_pago > @w_monto_concepto
      select @w_pago = @w_monto_concepto
   
   select @w_monto_total = @w_monto_total - @w_pago
   
   --EPB CUANDO LA TABLA DE AMORTIZACION ESTA TODA COMPLETA EL abonoru.sp GENERA UN CURSOR
   --DESDE EL DIVIDENDO ENVIADO - 1
   
   if @w_primer_vigente = 1
   begin
      select @w_saldo_div_1 = sum(am_acumulado - am_pagado)
      from   ca_amortizacion
      where  am_operacion = @i_operacion
      and    am_dividendo = 1
      and    am_concepto  = @w_ap_concepto
      
      select @w_ult_vigente = @w_ult_vigente + 1,
             @w_saldo_vig_cap = @w_saldo_div_1
   end
   ELSE
   begin
      select @w_saldo_vig_cap = sum(am_acumulado - am_pagado)
      from   ca_amortizacion
      where  am_operacion = @i_operacion
      and    am_dividendo = @w_div_vigente
      and    am_concepto  = @w_ap_concepto
   end
   
      --LCM - 293 - Si tiene reconocimiento y el concepto de pago es diferente al de reconocimiento
   if @i_tiene_reco = 'S' and @w_concepto_rec = 'N'
      begin
      select @w_vlr_cap = 0
      select @w_vlr_cap = round(@w_pago * @w_porc_cubrim / 100, @i_num_dec)

      select @w_pago = @w_pago - @w_vlr_cap

   --Amortiza reconocimiento realizando abono extraordinario
      select @w_sob_rec = 0
      exec @w_error = sp_pagxreco
      @s_user             = @s_user,
      @s_term             = @s_term,
      @s_date             = @s_date,
      @i_tipo_oper        = 'P',
      @i_secuencial_pag   = @i_secuencial_pag,
      @i_operacionca      = @i_operacion,
      @i_en_linea         = @i_en_linea,
      @i_oficina_orig     = @s_ofi,
      @i_num_dec          = @i_num_dec,
      @i_monto_pago       = @w_vlr_cap,
      @o_sobrante         = @w_sob_rec out

      if @w_error <> 0 return @w_error

      select @w_pago = @w_pago + @w_sob_rec
   end
      
   exec @w_error = sp_abona_rubro
   @s_ofi               = @s_ofi,
   @s_sesn              = @s_sesn,
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_date              = @s_date,
   @i_secuencial_pag    = @i_secuencial_pag,
   @i_operacionca       = @i_operacion,
   @i_dividendo         = @w_ult_vigente, 
   @i_concepto          = @w_ap_concepto,
   @i_monto_pago        = @w_pago,
   @i_monto_prioridad   = @w_pago,
   @i_monto_rubro       = @w_pago,
   @i_tipo_cobro        = 'A', -- ACUMULADO,
   @i_en_linea          = 'S',
   @i_tipo_rubro        = 'C',
   @i_fecha_pago        = @i_fecha_proceso,
   @i_condonacion       = 'N',     
   @i_cotizacion        = @i_cotizacion,
   @i_tcotizacion       = @i_tcotizacion,
   @i_inicial_prioridad = 1,
   @i_inicial_rubro     = 1,
   @i_extraordinario    = 1,
   @i_fpago             = 'P',
   @o_sobrante_pago     = @w_sobrante_pago  out ---@w_monto_total 
   
   if @w_error <> 0
      return @w_error
   
   select @w_saldo_final = sum(am_cuota + am_gracia - am_pagado)
   from   ca_amortizacion
   where  am_operacion = @i_operacion
   and    am_estado    <> @w_est_cancelado
   and    am_concepto  = @w_ap_concepto
   
   select @w_saldo_final = @w_saldo_final - @w_pago
      
   update ca_rubro_op_tmp 
   set    rot_valor     = @w_saldo_final
   where  rot_operacion = @i_operacion
   and    rot_concepto  = @w_ap_concepto
   
   if @w_primer_vigente = 1   
   begin
      if @w_saldo_div_1 >= @w_pago
         update ca_amortizacion
         set    am_acumulado = am_acumulado - @w_pago,
                am_cuota     = am_cuota     - @w_pago
         where  am_operacion = @i_operacion
         and    am_dividendo = 1
         and    am_concepto  = @w_ap_concepto
      else
         update ca_amortizacion
         set    am_acumulado = am_pagado,
                am_cuota     = am_pagado
         where  am_operacion = @i_operacion
         and    am_dividendo = 1
         and    am_concepto  = @w_ap_concepto
   end
   
   if @w_sobrante_pago <= 0
      break
   
   update ca_total_prioridad_tmp
   set    total = total - @w_pago
   where  prioridad = @w_ap_prioridad
   and    operacion = @i_operacion
   
   fetch cursor_prioridades
   into  @w_ap_prioridad, @w_ap_concepto, @w_monto_concepto
end -- WHILE CURSOR PRINCIPAL

close cursor_prioridades
deallocate cursor_prioridades

-- SI TODAVIA EXISTE SOBRANTE ENTONCES ERROR, O ENVIAR AL SOBRANTE
select @o_monto_sobrante = @w_monto_total

-- DETERMINACION DEL SALDO DE CAPITAL DE LA OPERACION
select @w_saldo_cap   = isnull(sum(rot_valor),0)
from   ca_rubro_op_tmp 
where  rot_operacion  = @i_operacion
and    rot_tipo_rubro = 'C'


--- PROCESO PARA CANCELAR TOTALMENTE LA OPERACION
exec  sp_calcula_saldo
     @i_operacion = @i_operacion,
     @i_tipo_pago = 'A',
     @o_saldo     = @w_saldo_oper out
     
--- VERIFICAR SI EL PAGO EXTRAORIDINARIO CANCELO EL PRESTAMO

if @w_saldo_oper < @w_vlr_despreciable
begin
   --GENERACION DE LA COMISION DIFERIDA
   exec @w_error     = sp_comision_diferida
   @s_date           = @s_date,
   @i_operacion      = 'A',
   @i_operacionca    = @i_operacion,
   @i_secuencial_ref = @i_secuencial_pag 
   
   if @w_error <> 0 begin
      select  @w_error = 724589  
      goto ERROR
   end
   
   update ca_operacion
   set    op_estado = @w_est_cancelado
   where  op_operacion = @i_operacion
   
   if @@error <> 0
      return 710002
   
   update ca_amortizacion
   set    am_cuota = 0,
          am_acumulado = 0
   from   ca_dividendo
   where  am_operacion = @i_operacion
   and    am_concepto  = 'CAP'
   and    am_pagado = 0
   and    di_operacion = @i_operacion
   and    di_dividendo = am_dividendo
   and    di_estado  <> 3
   
   update ca_dividendo
   set    di_estado    = @w_est_cancelado,
          di_fecha_can = @w_fecha_ult_proceso
   where  di_operacion = @i_operacion
   and    di_dividendo >= @i_dividendo
   
   if @@error <> 0
     return 710002
   
   update ca_amortizacion
   set    am_estado    = @w_est_cancelado
   where  am_operacion = @i_operacion
   and    am_dividendo >= @i_dividendo
   
   if @@error <> 0
   begin
      return 710002
   end

   if @i_en_linea = 'N'
      select @w_bandera_be = 'S'
   else
      select @w_bandera_be = 'N'

   exec @w_error = cob_custodia..sp_activar_garantia
   @i_opcion      = 'C',
   @i_tramite     = @w_tramite,
   @i_modo        = 2,
   @i_operacion   = 'I',
   @s_date        = @s_date,
   @s_user        = @s_user,
   @s_term        = @s_term,
   @s_ofi         = @s_ofi,
   @i_bandera_be  = @w_bandera_be
   
   if @w_error <> 0
   begin
      PRINT 'abnextra.sp  salio por error de cob_custodia..sp_activar_garantia ' +CAST(@w_error AS VARCHAR)
      while @@trancount > 1 rollback
      select @w_error = @w_error
      goto ERROR
   end
   
   -- ELIMINACION DE LAS TABLAS TEMPORALES
   exec @w_error = sp_borrar_tmp_int
   @i_operacionca = @i_operacion
   
   return 0
end


--- GENERACION DE LA TABLA TEMPORAL 

select @w_num_dividendos = count(1)
from   ca_dividendo
where  di_operacion  = @i_operacion
and    di_dividendo >= @w_primer_vigente

select @w_dividendos_gracia_cap = op_gracia_cap 
from   ca_operacion
where  op_operacion = @i_operacion

select @w_dividendos_gracia_int = op_gracia_int
from   ca_operacion
where  op_operacion = @i_operacion

if @w_dividendos_gracia_cap < 0 select @w_dividendos_gracia_cap = 0
if @w_dividendos_gracia_int < 0 select @w_dividendos_gracia_int = 0

select @w_di_fecha_ini = di_fecha_ini,
@w_paga_int   = di_de_interes,
@w_paga_cap   = di_de_capital
from   ca_dividendo
where  di_operacion = @i_operacion
and    di_dividendo = @w_primer_vigente

if @i_tipo_reduccion = 'C'
   select @w_cuota = 0

if @w_paga_int = 'S'
   select @w_dividendos_gracia_int = 0

if @w_paga_cap = 'S'
   select @w_dividendos_gracia_cap = 0

select @w_periodo_int = opt_periodo_int,
       @w_periodo_cap = opt_periodo_cap
from   ca_operacion_tmp
where  opt_operacion =  @i_operacion

select @w_plazo_operacion = @w_periodo_int * @w_num_dividendos

-- DETERMINACION DEL SALDO DE CAPITAL DE LA OPERACION

if @w_num_dividendos > 1 
begin  
   update ca_operacion_tmp
   set    opt_cuota      = @w_cuota,
          opt_tplazo     = opt_tdividendo,
          opt_plazo      = @w_plazo_operacion,
          opt_fecha_ini  = @w_di_fecha_ini,
          opt_monto      = @w_saldo_cap,           ---EPB:MAR-27-2002@w_saldo_final,
          opt_gracia_cap = @w_dividendos_gracia_cap,
          opt_gracia_int = @w_dividendos_gracia_int,
          opt_fecha_pri_cuot = null                ---EPB:ABR-16-2002
   where  opt_operacion = @i_operacion
   
   if @@error <> 0
      return 710002
end
else  --LA PERIODICIDAD DE PAGO DE INT-CAP DEBE SER MAXIMO 1
begin
   update ca_operacion_tmp
   set    opt_cuota      = @w_cuota,
          opt_tplazo     = opt_tdividendo,
          opt_plazo      = @w_plazo_operacion,
          opt_fecha_ini  = @w_di_fecha_ini,
          opt_monto      = @w_saldo_cap,           ---EPB:MAR-27-2002@w_saldo_final,
          opt_gracia_cap = 0,
          opt_gracia_int = 0,
          opt_periodo_int = 1,
          opt_periodo_cap = 1,
          opt_fecha_pri_cuot = null                ---EPB:ABR-16-2002
   where  opt_operacion = @i_operacion
   
   if @@error <> 0
      return 710002
end

if @i_tipo_aplicacion = 'P'
begin
   -- GENERAR TABLA DE AMORTIZACION UNICAMENTE CON EL CAPITAL NO VIGENTE
   select @w_cap_proporcional = sum(am_acumulado + am_gracia - am_pagado)
   from   ca_rubro_op, ca_amortizacion
   where  ro_operacion  = @i_operacion
   and    ro_tipo_rubro = 'C'
   and    am_operacion  = @i_operacion
   and    ro_concepto   = am_concepto
   and    am_dividendo  < @w_div_vigente
   
   select @w_cap_proporcional = isnull(@w_cap_proporcional, 0)
   
   update ca_rubro_op_tmp 
   set    rot_valor = rot_valor - @w_cap_proporcional
   where  rot_operacion  = @i_operacion
   and    rot_tipo_rubro = 'C'
   
   if @@error <> 0
      return 710002
end

-- FQ - Marzo 2003, Reducci�n de tabla de amortizaci�n MANUAL para (C)uota o (T)iempo
if (@w_tipo_tabla = 'MANUAL') and (@i_tipo_reduccion in ('C', 'T', 'N'))
begin
   if @w_primer_vigente > 1
   begin
      select @i_monto_pago = @i_monto_pago -- @w_saldo_vig_cap
   end
   exec @w_error = sp_reduccion_manual
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_date           = @s_date,
   @s_ofi            = @s_ofi,
   @i_secuencial     = @i_secuencial_pag,
   @i_operacionca    = @i_operacion,
   @i_fecha_proceso  = @i_fecha_proceso,
   @i_monto_extra    = @i_monto_pago,
   @i_tipo_reduccion = @i_tipo_reduccion,
   @i_decimales      = @i_num_dec,
   @i_periodo_int    = @w_periodo_int,
   @i_dias_anio      = @w_dias_anio
   
   if @w_error <> 0
      return @w_error
   
   -- ELIMINACION DE LAS TABLAS TEMPORALES
   exec @w_error = sp_borrar_tmp_int
   @i_operacionca = @i_operacion
   
   return 0
end

-- PRIMERO TRATAR LAS CUOTAS NO VIGENTES
select @w_pagado_fut =  isnull(sum(am_pagado),0)
from   ca_amortizacion
where  am_operacion = @i_operacion
and    am_dividendo > @w_ult_vigente
and    am_concepto  = 'CAP'

--EL VALOR PAGADO A CUOTAS FUTURAS DE CAP, DEBE SER RESPETADO, SE ALMACENA
--EN LA MISMA CUOTA DONDE SE COLOCA EL VALOR EXTRA DEL ABONO
if @w_estado_op = @w_est_castigado
   select @w_am_estado = @w_est_castigado
else
   select @w_am_estado = 1
      
if @w_pagado_fut > 0
begin
   update ca_rubro_op
   set    ro_gracia = isnull(ro_gracia, 0) + isnull(@w_pagado_fut, 0)
   where  ro_operacion = @i_operacion
   and    ro_concepto  = 'CAP'
   
   update ca_amortizacion ---ESTE UPDATE SE HACE SOLO PARA EL VALOR DEL CONCEPTO CAP EN LA CUOTA EXTRA
   set    am_pagado     = 0,
          am_acumulado  = 0,
          am_cuota      = 0,
          am_estado     = @w_am_estado
   where  am_operacion = @i_operacion
   and    am_dividendo > @w_ult_vigente
   and    am_concepto  = 'CAP'
   
end

-- AHORA LA CUOTA VIGENTE
select @w_pagado_fut    =  isnull(sum(am_pagado),0),
   @w_cuota_fut     =  isnull(sum(am_pagado),0),
   @w_acumulado_fut =  isnull(sum(am_pagado),0)
from   ca_amortizacion
where  am_operacion = @i_operacion
and    am_dividendo = @w_ult_vigente
and    am_concepto  = 'CAP'
              
--EL VALOR PAGADO A CUOTAS FUTURAS DE CAP, DEBE SER RESPETADO, SE ALMACENA
--EN LA MISMA CUOTA DONDE SE COLOCA EL VALOR EXTRA DEL ABONO

if @w_pagado_fut > 0
begin
   update ca_amortizacion ---ESTE UPDATE SE HACE SOLO PARA EL VALOR DEL CONCEPTO CAP EN LA CUOTA EXTRA
   set   am_pagado     = 0,
         am_acumulado  = 0,
         am_cuota      = 0,
         am_estado     = @w_am_estado
   where am_operacion = @i_operacion
   and   am_dividendo = @w_ult_vigente
   and   am_concepto  = 'CAP'
   
   -- SIMILAR A ABONO_RUBRO SE MANDA A GRABAR EN ro_gracia
   if exists(select 1
             from   ca_dividendo
             where  di_operacion = @i_operacion
             and    di_dividendo = @w_ult_vigente - 1
             and    di_estado    = 3)
   BEGIN
      update ca_rubro_op
      set    ro_gracia = isnull(ro_gracia, 0) + @w_pagado_fut
      where  ro_operacion = @i_operacion
      and    ro_concepto  = 'CAP'
   end
   ELSE
   begin
      if @w_concepto_rec = 'N'
         update ca_amortizacion 
         set    am_pagado          = am_pagado + @w_pagado_fut,
                am_cuota           = am_cuota  + @w_cuota_fut,
                am_acumulado       = am_acumulado + @w_acumulado_fut
         where am_operacion = @i_operacion
         and   am_dividendo = (@w_ult_vigente - 1)
         and   am_concepto  = 'CAP'
      else
      begin
         /* LCM - 293 - BUSCA ULTIMA CUOTA CANCELADA PARA ALMACENAR EL VALOR DE CUOTAS FUTURAS SOLAMENTE PARA CUANDO ES UN PAGO POR RECONOCIMIENTO */
         select @w_ult_div_canc = max(di_dividendo)
         from   ca_dividendo
         where  di_operacion   = @i_operacion
         and    di_estado      = @w_est_cancelado

         if @w_ult_div_canc is not null
         begin
            /* GUARDA HISTORICO DEL DIVIDENDO CANCELADO PARA REVERSOS */
            insert ca_amortizacion_his with (rowlock)
            select @i_secuencial_pag, *
            from   ca_amortizacion (nolock)
            where  am_operacion  = @i_operacion
            and    am_dividendo = @w_ult_div_canc

            insert ca_dividendo_his with (rowlock)
            select @i_secuencial_pag, *
            from   ca_dividendo (nolock)
            where  di_operacion   = @i_operacion
            and    di_dividendo = @w_ult_div_canc

         end
         else
            select @w_ult_div_canc = @w_ult_vigente - 1
         
         update ca_amortizacion 
         set    am_pagado          = am_pagado + @w_pagado_fut,
                am_cuota           = am_cuota  + @w_cuota_fut,
                am_acumulado       = am_acumulado + @w_acumulado_fut
         where am_operacion = @i_operacion
         and   am_dividendo = @w_ult_div_canc
         and   am_concepto  = 'CAP'
      end
   end
end

if @i_prepago <> 'S'
begin
   -- FQ
   -- ESTA ACTUALIZACION SE HACE NECESARIO, PORQUE AVECES EL PAGO NO ALCANZA A PAGAR TODO
   -- EL VALOR DE LA CUOTA VIGENTE, POR LO TANTO EL SALDO DE ESTA CUOTA YA ESTA DISTRIBUIDO
   update ca_rubro_op_tmp
   set    rot_valor = rot_valor - (am_acumulado - am_pagado)
   from   ca_amortizacion
   where  am_operacion = @i_operacion
   and    am_dividendo = 1
   and    am_concepto  = 'CAP'
   and    rot_operacion = @i_operacion
   and    rot_concepto  = 'CAP'
end

if @w_periodo_cap  = @w_periodo_int
   select @w_cuota_desde_cap = null
else
begin
   select @w_di_de_capital = min(di_dividendo)
   from   ca_dividendo
   where  di_operacion =   @i_operacion
   and    di_dividendo >= @i_dividendo
   and    di_de_capital = 'S'
   
   select @w_cuota_desde_cap = @w_di_de_capital - @i_dividendo + 1
end
   
IF @w_debug = 'S'
	SELECT 'tab0', *
	FROM ca_amortizacion where      am_operacion = @i_operacion
	--AND am_concepto = 'CAP'
   --AND am_dividendo > 12

exec @w_error = sp_gentabla
     @i_operacionca     = @i_operacion,
     @i_tabla_nueva     = 'S',
     @i_cuota_desde_cap = @w_cuota_desde_cap,
     @i_cuota_abnextra  = @w_ult_vigente,
     @i_desde_abnextra  = 'S',
     @o_fecha_fin       = @w_fecha_fin out

if @w_error <> 0
   return @w_error
  
IF @w_debug = 'S'
begin
	SELECT 'tab1', *
	FROM ca_amortizacion where      am_operacion = @i_operacion
	--AND am_concepto = 'CAP'
   --AND am_dividendo > 12

	SELECT 'tab_tmp1', *
	FROM ca_amortizacion_tmp where      amt_operacion = @i_operacion
	--AND amt_concepto = 'CAP'
   ORDER BY  amt_dividendo, amt_concepto

	SELECT 'div_tmp1', *
	FROM ca_dividendo_tmp where      dit_operacion = @i_operacion
end
   
if @i_tipo_aplicacion = 'P'
begin
   update ca_rubro_op_tmp 
   set    rot_valor = rot_valor + @w_cap_proporcional
   where  rot_operacion  = @i_operacion
   and    rot_tipo_rubro = 'C'
   
   if @@error <> 0
     return 710002
end

-- PASAR VALORES DE TABLA TEMPORAL A DEFINITIVA
select @w_offset = @w_ult_vigente - @w_primer_vigente + 1

if @i_prepago = 'S' and @i_dividendo = 1
BEGIN
  select @w_gracia = -1
   declare
      cursor_dividendo cursor
      for select di_dividendo
         from   ca_dividendo
         where  di_operacion   = @i_operacion
         and    di_dividendo   > @i_dividendo
         order  by di_dividendo
      for read only
   
   open  cursor_dividendo

   select @w_dividendo = @i_dividendo + 1                         -- REQ 175: PEQUE�A EMPRESA
end
ELSE
begin
   if @i_dividendo = 1
      select @i_dividendo = @i_dividendo + 1

		IF @w_debug = 'S'
		begin
			select 'NO PREPAGO', di_dividendo
		          from   ca_dividendo
		          where  di_operacion   = @i_operacion
		          and    di_dividendo   >= @i_dividendo
		          order  by di_dividendo
		END

   declare
      cursor_dividendo cursor
      for select di_dividendo
          from   ca_dividendo
          where  di_operacion   = @i_operacion
          and    di_dividendo   >= @i_dividendo
          order  by di_dividendo
      for read only
   
   open  cursor_dividendo
   
   select @w_dividendo = @i_dividendo                             -- REQ 175: PEQUE�A EMPRESA
end

IF @w_debug = 'S'
begin
	select 'ofset' = @w_offset , '@w_ult_vigente ' = @w_ult_vigente , 
	       '@w_primer_vigente  + 1' = @w_primer_vigente , '@i_dividendo' = @i_dividendo, '@w_dividendo' = @w_dividendo,
	       '@w_gracia' = @w_gracia
end
-- REQ 175: PEQUE�A EMPRESA - DETERMINACION DE CONCEPTOS DE INTERES CON GRACIA POSITIVA
select distinct
am_concepto as concepto
into #conc_int_gr
from ca_amortizacion, ca_rubro_op
where am_operacion   = @i_operacion
and   am_dividendo   > @w_dividendo
and   am_gracia      > 0
and   am_cuota       = 0
and   ro_operacion   = am_operacion
and   ro_concepto    = am_concepto
and   ro_tipo_rubro  = 'I'


fetch cursor_dividendo
into  @w_dividendo

SELECT @w_div_tmp = 0

while   @@fetch_status = 0
begin 
   if (@@fetch_status = -1)
      return 710004

	SELECT @w_div_tmp = @w_div_tmp  + 1

   -- INI - REQ 175: PEQUE�A EMPRESA - ELIMINACION DE REGISTROS CREADOS POR GRACIA
   update ca_amortizacion
   set am_secuencia = am_secuencia - 1
   from #conc_int_gr
   where am_operacion   = @i_operacion
   and   am_dividendo   = @w_dividendo 
   and   am_concepto    = concepto
   
   if @@error <> 0
      return 710002
   
   delete ca_amortizacion
   from #conc_int_gr
   where am_operacion   = @i_operacion
   and   am_dividendo   = @w_dividendo 
   and   am_concepto    = concepto
   and   am_secuencia   = 0
   
   if @@error <> 0
      return 710003   
   -- FIN - REQ 175: PEQUE�A EMPRESA
      
   if @i_tipo_aplicacion  not in  ('P','C') or @w_primer_vigente <> @w_dividendo 
   BEGIN
   
			IF @w_debug = 'S'
			begin
			   SELECT ' update ', @w_dividendo , @i_dividendo, @w_primer_vigente 
			end   
			
         update ca_amortizacion
         set    am_cuota     = am_pagado + amt_cuota,
                am_gracia    = amt_gracia,
                am_acumulado = am_pagado + amt_acumulado
         from   ca_amortizacion_tmp
         where  amt_operacion = @i_operacion
         and    amt_dividendo = @w_div_tmp -- LGU:  @w_dividendo - @i_dividendo + 1 + @w_gracia
         and    am_operacion  = @i_operacion
         and    am_dividendo  = @w_dividendo
         and    am_concepto   = amt_concepto
         and    am_estado <> @w_est_cancelado
         
         if @@error <> 0
            return 710002
   end 
   ELSE
   begin

		IF @w_debug = 'S'
		begin
		   SELECT ' else update ', '@w_dividendo' = @w_dividendo , '@w_div_tmp' = @w_div_tmp, '@i_dividendo' = @i_dividendo, '@w_primer_vigente ' = @w_primer_vigente 
	      SELECT am_concepto, am_dividendo, @w_div_tmp,
	      		 am_cuota     , amt_cuota,
	             am_acumulado , amt_acumulado,
	             am_pagado    , amt_pagado
	      from   ca_amortizacion_tmp, ca_rubro_op_tmp, ca_amortizacion
	      where  amt_operacion   = @i_operacion
	      and    amt_dividendo   = @w_div_tmp --   @w_dividendo - @i_dividendo + 1 ------------LGU: + 1 + @w_gracia
	      and    am_operacion    = @i_operacion
	      and    am_dividendo    = @w_dividendo
	      and    am_concepto     = amt_concepto
	      and    am_secuencia    = amt_secuencia                            -- REQ 175: PEQUE�A EMPRESA
	      and    amt_operacion   = rot_operacion
	      and    amt_concepto    = rot_concepto
	      and    rot_tipo_rubro <> 'I'
	      and    am_estado <> @w_est_cancelado
		end   

      update ca_amortizacion
      set    am_cuota     = amt_cuota,
             am_acumulado = amt_acumulado
      from   ca_amortizacion_tmp, ca_rubro_op_tmp
      where  amt_operacion   = @i_operacion
      and    amt_dividendo   = @w_div_tmp -- LGU:   @w_dividendo - @i_dividendo + 1 + @w_gracia
      and    am_operacion    = @i_operacion
      and    am_dividendo    = @w_dividendo
      and    am_concepto     = amt_concepto
      and    am_secuencia    = amt_secuencia                            -- REQ 175: PEQUE�A EMPRESA
      and    amt_operacion   = rot_operacion
      and    amt_concepto    = rot_concepto
      and    rot_tipo_rubro NOT IN ('O', 'I') --<> 'I'
      and    am_estado <> @w_est_cancelado
      
      if @@error <> 0
         return 710002
   end
   
   fetch cursor_dividendo
   into  @w_dividendo
end
               
close cursor_dividendo
deallocate cursor_dividendo 




select 
@w_di_fecha_ini    = di_fecha_ini,
@w_di_fecha_ven     = di_fecha_ven,
@w_de_interes       = di_de_interes,
@w_di_num_dias      = di_dias_cuota,
@w_am_esta_div_vig  = am_estado
from   ca_dividendo,
       ca_amortizacion
where  di_operacion  = @i_operacion
and  am_operacion  = @i_operacion
and  am_operacion = di_operacion
and  am_dividendo = di_dividendo
and  di_dividendo = @w_primer_vigente
and  am_concepto  = @w_int 

----------///////////////////////////////////////////////////////////////
IF @w_debug = 'S'
	SELECT 'tab2', *
	FROM ca_amortizacion where      am_operacion = @i_operacion
	--AND am_concepto = 'CAP'
   --AND am_dividendo > 12
	
declare cursor_rubros cursor
for select ro_concepto, ro_porcentaje
    from   ca_rubro_op
    where  ro_operacion  = @i_operacion
    and    ro_fpago      in ('P','A') -- PERIODICO VENCIDO O ANTICIPADO
    and    ro_tipo_rubro in ('I')     -- INTERES
    and    @w_di_fecha_ven > @w_fecha_pag   --PRO QUE SI ES EL DIA DEL PAGO NO HAY QUE HACER NINGUN RECALCULO
    for read only

open cursor_rubros

fetch cursor_rubros
into  @w_concepto, @w_porcentaje

SELECT @w_tasa_iva = ro_porcentaje
FROM ca_rubro_op
WHERE ro_operacion = @i_operacion
AND ro_concepto = @w_rubro_iva

SELECT @w_tasa_iva = isnull(@w_tasa_iva,16)



while   @@fetch_status = 0
begin
   if (@@fetch_status = -1)
      return 710004             
   
   if @w_tipo_cobro = 'A' and @i_prepago = 'N' ---Por que en prepago de pasivas debe recalcular todos los di_dias_cutoa
   begin
     
      if @w_di_fecha_ini > @w_fecha_ult_proceso
        select @w_fecha_ini_calc = @w_di_fecha_ini
      else  
        select @w_fecha_ini_calc = @w_fecha_ult_proceso
      
      exec sp_dias_cuota_360
      @i_fecha_ini = @w_fecha_ini_calc,
      @i_fecha_fin = @w_di_fecha_ven,
      @o_dias      = @w_di_num_dias out
      
   end
     
   select @w_valor_vencido = sum(am_acumulado + am_gracia - am_pagado) 
   from ca_amortizacion, ca_rubro_op, ca_dividendo
   where am_operacion  = @i_operacion
   and   am_dividendo  < @w_primer_vigente
   and   am_operacion  = di_operacion
   and   am_dividendo  = di_dividendo
   and   di_estado     = @w_div_vencido
   and   am_operacion  = ro_operacion
   and   am_concepto   = ro_concepto
   and   ro_tipo_rubro = 'C'   
   
   select @w_saldo_cap = @w_saldo_cap - isnull(@w_valor_vencido,0)
   
   exec @w_error   = sp_calc_intereses
   @tasa           = @w_porcentaje,
   @monto          = @w_saldo_cap,
   @dias_anio      = 360,
   @num_dias       = @w_di_num_dias,
   @causacion      = 'L', 
   @causacion_acum = 0, 
   @intereses      = @w_float out
      
   if @w_error <> 0
      return @w_error
   
   select @w_float = round(@w_float, @i_num_dec)
   select @w_float_iva = round(@w_float*@w_tasa_iva/100.0, @i_num_dec)
   
   select @w_secuencia = isnull(max(am_secuencia),0)
   from   ca_amortizacion
   where  am_operacion = @i_operacion
   and    am_dividendo = @w_primer_vigente
   and    am_concepto  = @w_concepto
   
   select @w_secuencia_iva = isnull(max(am_secuencia),0)
   from   ca_amortizacion
   where  am_operacion = @i_operacion
   and    am_dividendo = @w_primer_vigente
   and    am_concepto  = @w_rubro_iva
   
   if  (@i_tipo_aplicacion = 'P' and  @i_prepago = 'S') --el or para prepago de ICR pasiva
   begin
		IF @w_debug = 'S' SELECT ' aplicacion P y prepago = S'
      if @w_concepto = @w_int 
      begin
         select @w_int_pagado = am_pagado
         from cob_cartera..ca_amortizacion 
         where am_operacion = @i_operacion
         and   am_concepto = @w_int
         and   am_dividendo = @w_primer_vigente
         
         select @w_int_pagado = ISNULL(@w_int_pagado,0)
         
         if @w_int_pagado > 0
         begin
            select @w_float = @w_float + @w_int_pagado
         end

			--//////////////////// iva int
         select @w_pagado_iva = am_pagado
         from cob_cartera..ca_amortizacion 
         where am_operacion = @i_operacion
         and   am_concepto = @w_rubro_iva
         and   am_dividendo = @w_primer_vigente
         
         select @w_pagado_iva = ISNULL(@w_pagado_iva,0)
         
         if @w_pagado_iva > 0
         begin
            select @w_float_iva = @w_float_iva + @w_pagado_iva
         end
			--//////////////////// iva int
      end

      IF @w_debug = 'S'  PRINT ' UPD.0  concepto ' + @w_concepto + ' DIV: ' + convert(VARCHAR, @w_primer_vigente) +
                               ' am_cuota = w_float: ' + convert(VARCHAR, @w_float)
      update ca_amortizacion
      set    am_cuota = @w_float
      where  am_operacion = @i_operacion
      and    am_dividendo = @w_primer_vigente
      and    am_concepto  = @w_concepto
      and    am_secuencia = @w_secuencia
      
      update ca_amortizacion
      set    am_cuota = @w_float_iva
      where  am_operacion = @i_operacion
      and    am_dividendo = @w_primer_vigente
      and    am_concepto  = @w_rubro_iva
      and    am_secuencia = @w_secuencia_iva
      
   end
   ELSE
   begin
      --PARA APLICACION POR CONCEPTO, SE ACTUALIZA EL VALOR DE INTERES DE LA VIGENTE COLOCANDO
      --EL ACUMULADO + EL RECALCULO QUE LLEVAVA A LA FECHA
      if @i_tipo_aplicacion  in ('P','C') and @i_prepago = 'N'  
      begin
           
         select @w_monto_acumulado = am_acumulado 
         from ca_amortizacion
         where  am_operacion = @i_operacion
         and    am_dividendo = @w_primer_vigente
         and    am_concepto  = @w_concepto
         and    am_secuencia = @w_secuencia
         
                
         if @w_di_fecha_ven > @w_fecha_ult_proceso and   @w_monto_acumulado > @w_float
         begin
            select  @w_float = @w_monto_acumulado + @w_float
         end
         ELSE
         begin
         
            if @w_monto_acumulado > @w_float
                select @w_float = @w_monto_acumulado
         END

         IF @w_debug = 'S'  PRINT ' UPD.2  concepto ' + @w_concepto + ' DIV: ' + convert(VARCHAR, @w_primer_vigente)+
         							' am_cuota = w_float: ' + convert(VARCHAR, @w_float)
         
         update ca_amortizacion
         set    am_cuota = @w_float
         where  am_operacion = @i_operacion
         and    am_dividendo = @w_primer_vigente
         and    am_concepto  = @w_concepto
         and    am_secuencia = @w_secuencia

			--////////////////////// iva int
         select @w_acumulado_iva = am_acumulado 
         from ca_amortizacion
         where  am_operacion = @i_operacion
         and    am_dividendo = @w_primer_vigente
         and    am_concepto  = @w_rubro_iva
         and    am_secuencia = @w_secuencia_iva
         
         if @w_di_fecha_ven > @w_fecha_ult_proceso and   @w_acumulado_iva > @w_float_iva
         begin
            select  @w_float_iva = @w_acumulado_iva + @w_float_iva
         end
         ELSE
         begin
            if @w_acumulado_iva > @w_float_iva
                select @w_float_iva = @w_acumulado_iva
         END


         update ca_amortizacion
         set    am_cuota = @w_float_iva
         where  am_operacion = @i_operacion
         and    am_dividendo = @w_primer_vigente
         and    am_concepto  = @w_rubro_iva
         and    am_secuencia = @w_secuencia_iva

         IF @w_debug = 'S'  PRINT ' UPD.2  concepto ' + @w_concepto + ' DIV: ' + convert(VARCHAR, @w_primer_vigente)+
         							' am_cuota = w_float: ' + convert(VARCHAR, @w_float)
			--////////////////////// iva int
         
      end

   end
   
   if (@@error <> 0)
      return 710003
   
   fetch cursor_rubros
   into  @w_concepto, @w_porcentaje
end

close cursor_rubros
deallocate cursor_rubros  

IF @w_debug = 'S'
	SELECT 'tab22 antes ', *
	FROM ca_amortizacion where      am_operacion = @i_operacion

--ELIMINACION DE LOS DIVIDENDOS SI EL PLAZO ES MENOR 
select @w_dividendos_tmp = count(*)
from   ca_dividendo_tmp
where  dit_operacion     = @i_operacion

SELECT  'BORRAR div_tmp ' , '@w_dividendos_tmp = ' , @w_dividendos_tmp , '@w_ult_vigente = ' = @w_ult_vigente

delete ca_dividendo
where  di_operacion = @i_operacion
and    di_dividendo >= @w_dividendos_tmp + @w_ult_vigente

if @@error <> 0
   return 710003

delete ca_cuota_adicional
where  ca_operacion = @i_operacion
and    ca_dividendo >= @w_dividendos_tmp + @w_ult_vigente

if @@error <> 0
   return 710003

if @i_tipo_reduccion = 'T'
begin
   select @w_num_div = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @i_operacion
   
   --- INICIO REQ 379 IFJ 25/Nov/2005 
   select @w_ti_cuota_dest = min(ti_cuota_dest)
   from  ca_traslado_interes
   where ti_operacion = @i_operacion
   and   ti_estado     = 'P'
   
   if @@rowcount > 0
   begin
      if @w_ti_cuota_dest <= @w_num_div
      begin
         select @w_error = 711007
         goto ERROR
      end
   end
   --- FIN REQ 379 IFJ 25/Nov/2005 
   
   select @w_fecha_vencimiento = di_fecha_ven
   from   ca_dividendo
   where  di_operacion = @i_operacion
   and    di_dividendo = @w_num_div
   
   update ca_operacion
   set    op_fecha_fin = @w_fecha_vencimiento
   where  op_operacion = @i_operacion
   
   if @@error <> 0
      return 710002
end 

IF @w_debug = 'S'
	SELECT 'tab23 antes ', *
	FROM ca_amortizacion where      am_operacion = @i_operacion
	--AND am_concepto = 'CAP'
   --AND am_dividendo > 12

delete ca_amortizacion
where  am_operacion = @i_operacion
and    am_dividendo >= @w_dividendos_tmp + @w_ult_vigente

if @@error <> 0
   return 710003

IF @w_debug = 'S'
	SELECT 'tab23 despues ',@w_dividendos_tmp , @w_ult_vigente,*
	FROM ca_amortizacion where      am_operacion = @i_operacion
	--AND am_concepto = 'CAP'
   --AND am_dividendo > 12

-- ELIMINACION DE LAS TABLAS TEMPORALES
exec @w_error = sp_borrar_tmp_int
     @i_operacionca = @i_operacion

if @w_error <> 0
   return @w_error

-- Actualizar nueva cuota pactada   
exec @w_error = sp_cuota
@i_operacion  = @i_operacion,
@i_actualizar = 'S'
   
if @w_error <> 0
   return @w_error

---CODIGO DEL RUBRO COMISION FAG
 if @w_tiene_fag = 'S'
begin 
   --UNA VEZ SE REALICE EL PAGO EXTRAORDINARIO
   --SE REGENERAN LOS VALORES DE COMISIONES
   
   exec @w_error = sp_recalculo_fag
   @i_operacionca    = @i_operacion,
   @i_tramite        = @w_tramite,
   @i_sector         = @w_sector,
   @i_num_dec        = @i_num_dec
   
   if @w_error <> 0
      return @w_error
   
   ---SE DEBEN COLOCAR EN LA TABLA DE AMORTIZACION NUEVA
   --LAS MISMAS CUOTAS QUE ORIGINALMENTE SE COBRABAN EN COMISION FAG 
   declare
      cursor_act_amo cursor
      for select am_dividendo
          from   ca_amortizacion
          where  am_operacion   = @i_operacion
          and    am_concepto  = @w_parametro_fag
          order  by am_dividendo
      for read only
   
   open  cursor_act_amo
   
   fetch cursor_act_amo
   into  @w_dividendo
   
   while   @@fetch_status = 0
   begin 
      if not exists (select 1
                     from   ca_base_rubros_p
                     where  rp_operacion = @i_operacion
                     and    rp_dividendo = @w_dividendo
                     and    rp_concepto = @w_parametro_fag)
      begin
         if exists(select 1
                   from   ca_dividendo
                   where  di_operacion = @i_operacion
                   and    di_dividendo = @w_dividendo
                   and    di_estado   <> 3)
         begin
            update ca_amortizacion
            set    am_cuota     = 0,
                   am_acumulado = 0
            where  am_operacion = @i_operacion
            and    am_dividendo = @w_dividendo
            and    am_concepto in (@w_parametro_fag, @w_aso_fag)
            and    am_estado    <> 3
            and    am_cuota     <> 0
            and    am_acumulado <> 0
         end
      end
      
      fetch cursor_act_amo
      into  @w_dividendo
   end  --WHILE
   
   close cursor_act_amo
   deallocate cursor_act_amo
   
end  --tiene fag

if (@w_tiene_fng = 'S') 
begin
   
    exec @w_error =  sp_calulo_fng_vigentes
    @i_operacionca = @i_operacion ,
    @i_concepto    = @w_parametro_fng

    if @w_error <> 0
       return @w_error  
end

update cob_cartera..ca_abono
set ab_extraordinario = 'S'
where ab_secuencial_ing = @i_secuencial_ing 
and ab_operacion = @i_operacion
and ab_extraordinario <> 'K'

if @i_pago_especial ='S'
BEGIN

IF @w_debug = 'S'
 PRINT ' ===> CAP x.4 = '

	select 'oper' = ro_operacion,'concepto'= ro_concepto,'acum'=am_acumulado,'div'= di_dividendo
	into #oper_cuota_vigenteD
	from ca_amortizacion,ca_dividendo,ca_rubro_op
	where am_operacion = @i_operacion
	and am_operacion = di_operacion
	and am_dividendo = di_dividendo
	and am_concepto    = ro_concepto
	and ro_operacion = am_operacion
	and ro_tipo_rubro = 'Q'
	and di_estado = 1
	and am_acumulado > 0
union
	select 'oper' = ro_operacion,'concepto'= ro_concepto,'acum'=am_acumulado,'div'= di_dividendo
	from ca_amortizacion,ca_dividendo,ca_rubro_op
	where am_operacion = @i_operacion
	and am_operacion = di_operacion
	and am_dividendo = di_dividendo
	and am_concepto    = ro_concepto
	and ro_operacion = am_operacion
	and di_estado = 1
	and am_acumulado > 0
	and am_concepto  =	@w_parametro_Ivafng 	                                                

	
	---PONER EL ACUMULADO DE ESTOS RUBROS = AL PAGADO SI EL EFECTO DE EL ABONO EXTRA
	---PUSO UN ACUMULADO MENOR POR QUE EL CAPITAL ES MUCHO MENOR, ESTO APLICA EN ESTE CASO
	---SOLO PARA LA CUOTA VIGENTE
	
	update ca_amortizacion
	set am_acumulado = am_pagado,
	    am_cuota     = am_pagado
	from #oper_cuota_vigenteD,ca_amortizacion
	where am_operacion = oper
	and   am_dividendo = div
	and   am_concepto = concepto
	and   am_acumulado < am_pagado
  if @@error <> 0
     return 705050
	
	 
	select 'sec' = 0,oper,concepto,div,'val'= acum - am_acumulado 
	into #diferencias
	from #oper_cuota_vigente,#oper_cuota_vigenteD
	where ro_operacion = oper
	and   ro_concepto  = concepto
	and   di_dividendo = div
	and   (am_acumulado - acum) <> 0
	
	select @w_reg = count(1)
    from #diferencias

    select @w_upd =1
	while 1 = 1
	begin
	 set rowcount 1
	 
	 update #diferencias
	 set sec = @w_upd 
	 where sec = 0
	 and @w_reg  > @w_upd 
	
	 select  @w_upd  = @w_upd  + 1
	 
	 if @w_upd >@w_reg
	   break
	
	end

   set rowcount 0
    
    select @w_upd = -1
	while 1 = 1 begin
	
	      set rowcount 1
	
	      select @w_operacion    = oper,
	             @w_div          = div,
	             @w_concepto     = concepto,
	             @w_dif          = round(val,0),
	             @w_upd          = sec
	      from #diferencias
	      where sec > @w_upd
	      order by sec
	
	      if @@rowcount = 0 begin
	         set rowcount 0
	         break
	      end
	
	      set rowcount 0
	      
	      if not exists (select 1 from ca_transaccion_prv
				      where tp_operacion    = @w_operacion
				      and   tp_fecha_mov    = @i_fecha_proceso
				      and   tp_dividendo    = @w_div
				      and   tp_monto        = @w_dif
				      and   tp_concepto     = @w_concepto
				      and   tp_estado       = 'ING')
	      begin
		      if @w_dif > 0
		         select @w_sec = @i_secuencial_pag
		      else   
		         select @w_sec = -999
	
	         	 insert into ca_transaccion_prv with (rowlock)
				(
				tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
				tp_secuencial_ref,   tp_estado,           tp_dividendo,
				tp_concepto,         tp_codvalor,         tp_monto,
				tp_secuencia,        tp_comprobante,      tp_ofi_oper)
				select 
				@i_fecha_proceso,    @w_operacion,        @i_fecha_proceso,
				@w_sec,              'ING',               @w_div,
				@w_concepto,        co_codigo * 1000 + @w_estado_op * 10 + 0,@w_dif,
				1,                   0,                   @w_oficina_op
				from ca_concepto
				where co_concepto = @w_concepto
				
		        if @@error <> 0
		           return 708165		
	      end
	
	end               
end --if @i_pago_especial ='S'

IF @w_debug = 'S'
 SELECT *
 FROM ca_amortizacion where      am_operacion = @i_operacion
 --AND am_dividendo > 12


/*********************************************************************************************/
/*Rubros desplazamiento                                                                      */
/*********************************************************************************************/   

select 
operacion_d =  am_operacion, 
concepto_d  = am_concepto, 
acumulado_d = sum(am_acumulado), 
cuota_d     = sum(am_cuota),
pagado_d    = sum(am_pagado)
into #rubros_desplazamiento_desp
from ca_amortizacion
where am_operacion = @i_operacion
and am_concepto in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
group by am_operacion, am_concepto


select operacion_d,
       concepto_d ,
       acumulado = isnull(acumulado_a,0) - isnull(acumulado_d,0),
       cuota     = isnull(cuota_a,0)     - isnull(cuota_d,0)    ,
       pagado    = isnull(pagado_a,0)    - isnull(pagado_d,0) 
into #diferencia    
from #rubros_desplazamiento_ant a,
     #rubros_desplazamiento_desp d
where operacion_a= operacion_d
and   concepto_a = concepto_d
and   (acumulado_a <> acumulado_d or cuota_a <> cuota_d or pagado_a <> pagado_d)


update ca_amortizacion set
am_acumulado = case when acumulado > 0 then am_acumulado + acumulado else am_acumulado end,
am_cuota     = case when cuota > 0 then am_cuota     + cuota else am_cuota end,
am_pagado    = case when pagado > 0 then am_pagado    + pagado else am_pagado end
from #diferencia,
     ca_dividendo
where am_operacion = operacion_d
and   di_operacion = operacion_d
and   am_dividendo = di_dividendo
and   di_estado    = @w_est_vigente
and   am_concepto  = concepto_d

select @w_estado_op = op_estado
from ca_operacion
where op_operacion = @i_operacion

update ca_amortizacion set
am_estado          = @w_estado_op
where am_operacion = @i_operacion
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
and   am_acumulado <> 0
and   am_cuota     <> am_pagado

update ca_amortizacion set
am_estado          = 0
where am_operacion = @i_operacion
and   am_concepto  in ('INT_ESPERA', 'IVA_ESPERA', 'SEGAD') 
and   am_acumulado = 0


/*********************************************************************************************/
/*Rubros desplazamiento                                                                      */
/*********************************************************************************************/   
 
return 0

ERROR:
if @i_en_linea = 'S'
begin
   exec cobis..sp_cerror
        @t_debug = 'N',
        @t_file  = null, 
        @t_from  = @w_sp_name,
        @i_num   = @w_error
return @w_error 
end
ELSE
begin
  return @w_error 
end

go

