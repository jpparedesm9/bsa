/***********************************************************************/
/*  Archivo:                                 rubrocal.sp               */
/*  Stored procedure:                        sp_rubro_calculado        */
/*  Base de Datos:                           cob_cartera               */
/*  Producto:                                Cartera                   */
/*  Disenado por:                            LCA                       */
/***********************************************************************/
/*                          IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de      */
/*  'MACOSA'                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como         */
/*  cualquier autorizacion o agregado hecho por alguno de sus          */
/*  usuario sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante                 */
/***********************************************************************/
/*                            PROPOSITO                                */
/*  Este stored procedure permite calcular los valores para rubros     */
/*  calculados                                                         */
/***********************************************************************/
/*                           MODIFICACIONES                            */
/*      FECHA          AUTOR                   RAZON                   */
/*      13/Feb/97       LCA                    Emision Inicial         */
/*      02/Jun/2014     Elcira Pelaez          NR392 Tablas Flexibles  */
/*      14/Abr/2015     Luis Carlos Moreno     NR509 Finagro Fase 2    */
/***********************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_rubro_calculado')
   drop proc sp_rubro_calculado
go
---NR 3925 Vp. 34

create proc sp_rubro_calculado (
   @i_tipo                  char(1)     = null,
   @i_monto                 money       = 0,
   @i_concepto              catalogo    = null,
   @i_modo                  char(1)     = 'A', 
   @i_operacion             int         = null,   
   @i_saldo_op              char(1)     = 'N',
   @i_saldo_por_desem       char(1)     = 'N',
   @i_porcentaje            float       = 0,  
   @i_usar_tmp              char(1)     = 'S',
   @i_monto_aprobado        char(1)     = 'N',
   @i_op_monto_aprobado     money       = 0,
   @i_porcentaje_cobertura  char(1)     = 'N',
   @i_valor_garantia        char(1)     = 'N',
   @i_tipo_garantia         varchar(64) = null,
   @i_parametro_fag         catalogo    = null,
   @i_tabla_tasa            varchar(30) = null,
   @i_categoria_rubro       char(1)     = null,
   @i_fpago                 char(1)     = null,
   @i_saldo_insoluto        char(1)     = NULL,
   @i_tasa_matriz           char(1)     = 'N',
   @o_valor_rubro           money       = 0 out,
   @o_tasa_calculo          float       = 0 out,
   @o_nro_garantia          varchar(64) = null out,
   @o_base_calculo          money       = null out
   )
as declare
   @w_sp_name               varchar(32),    
   @w_return                int,
   @w_monto                 money, 
   @w_valor                 money,
   @w_sector                catalogo,
   @w_moneda                tinyint,
   @w_toperacion            catalogo,
   @w_monto_aprobado        money,
   @w_referencial           catalogo,
   @w_signo                 char(1),
   @w_factor                float,
   @w_tipo_val              catalogo,
   @w_clase                 char(1),
   @w_fecha                 datetime,
   @w_secuencial_ref        int,
   @w_vr_valor              float,
   @w_porcentaje            float,
   @w_est_novigente         tinyint,
   @w_est_vigente           tinyint,
   @w_producto              tinyint,
   @w_tramite               int,
   @w_valor_act_garantia    money,
   @w_porcen_cobertura      float,
   @w_tplazo                catalogo,
   @w_plazo                 smallint,
   @w_tdividendo            catalogo,
   @w_periodo_int           smallint,
   @w_gracia_cap            smallint,
   @w_error                 int,
   @w_tipo_productor        catalogo,
   @w_dias_plazo            int,
   @w_gracia_en_meses       int,
   @w_cliente               int,
   @w_parametro_fag         catalogo, 
   @w_parametro_fng_des     catalogo,
   @w_plazo_en_meses        float,
   @w_dias_div              int,
   @w_tasa_comision         float,
   @w_nro_garantia          varchar(64),
   @w_otra_tasa_rubro       float,
   @w_modalidad_d           char(1),
   @w_base_calculo          char(1),
   @w_num_periodo_d         int,
   @w_dias_anio             smallint,
   @w_periodo_d             catalogo,
   @w_tasa_nom              float,
   @w_num_dec_tapl          smallint,
   @w_tabla_tasa            varchar(30),
   @w_categoria_rubro       char(1),
   @w_estado                tinyint,
   @w_forma_pago            char(1),
   @w_fecha_max             datetime,
   @w_moneda_local          smallint,
   @w_cotizacion            float,
   @w_num_dec               smallint,
   @w_num_dec_mn            smallint,
   @w_fecha_ult_proceso     datetime,
   @w_parametro_item        char(64),
   @w_tipogar_hipo          catalogo,
   @w_item                  tinyint,
   @w_base_calc             money,
   @w_op_base_calculo       char(1),
   @w_tipo_superior         char(64),
   @w_fecha_fin             datetime,
   @w_saldo1                money,
   @w_saldo2                money,
   @w_div_vigente           int,
   @w_parametro_segvida     catalogo,
   @w_parametro_segdeuant   catalogo,
   @w_parametro_apecr       catalogo,
   @w_parametro_microseg    catalogo,
   @w_parametro_exequial    catalogo,
   @w_numero_deudores       int,
   @w_can_deu               int,
   @w_porc_des              float,     -- JAR REQ 197
   @w_par_usaid_des         catalogo,
   @w_par_pagare            catalogo,
   @w_porcentaje_apecr      float,
   @w_parametro_fga_uni     varchar(30),
   @w_param_tasadefecto     char(1),
   @w_can_codeu             int,
   @w_val_aper_codeu        money,
   --REQ379
   @w_parametro_fgu           catalogo,
   @w_colateral               catalogo,
   @w_tipo_garantia           varchar(10),
   @w_garantia                varchar(10),
   @w_cod_garantia            varchar(10),
   @w_rubro                   char(1),
   @w_tabla_rubro             varchar(30),
   @w_concepto_des            varchar(10),
   @w_cod_gar_usaid           catalogo,
   @w_cod_gar_fag             catalogo,
   @w_cod_gar_fng             catalogo,
   @w_cod_gar_fga             catalogo,
   @w_op_tipo_amortizacion    catalogo
   

select  
@w_sp_name            = 'sp_rubro_calculado',
@w_est_novigente      = 0,  
@w_est_vigente        = 1,    
@w_valor              = 0,
@w_valor_act_garantia = 0,
@w_otra_tasa_rubro    = 0,
@w_modalidad_d        = 'V',
@w_num_dec_tapl       = 2,
@w_dias_div           = 0,
@o_valor_rubro        = 0,
@w_saldo1             = 0,
@w_saldo2             = 0,
@w_div_vigente        = 0

create table #conceptos_gen (
codigo    varchar(10),
tipo_gar  varchar(64)
)

create table #rubros_gen (
garantia      varchar(10),
rre_concepto  varchar(64),
tipo_concepto varchar(10),
iva           varchar(5),
)
---print '@i_concepto' + cast(@i_concepto as varchar(20))
---print 'rubrocal.sp  @i_concepto  ' + cast(@i_concepto as varchar(20)) + '@i_porcentaje   ' + cast(@i_porcentaje as varchar(20))  
--- INI JAR REQ 197
--- PARAMETRO PORCENTAJE COBRO USAID PERIODICO 
select @w_porc_des = pa_smallint/100.0
  from cobis..cl_parametro 
 where pa_nemonico = 'PRUSAD'
   and pa_producto = 'CCA'

--- PARAMETRO DE LA GARANTIA DE USAID DESEMBOLSO 
select @w_par_usaid_des = pa_char
  from cobis..cl_parametro 
 where pa_nemonico = 'CMUSAD'
   and pa_producto = 'CCA'

--- PARAMETRO DE LA GARANTIA TIPOPAGARE
select @w_par_pagare = pa_char
  from cobis..cl_parametro 
 where pa_nemonico = 'CODPAC'
   and pa_producto = 'GAR'

/*CODIGO PADRE GARANTIA DE FNG*/
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'
set transaction isolation level read uncommitted

/*CODIGO PADRE GARANTIA DE USAID*/
select @w_cod_gar_usaid = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODUSA'
set transaction isolation level read uncommitted

/*CODIGO PADRE GARANTIA DE FAG*/
select @w_cod_gar_fag = pa_char
  from cobis..cl_parametro with (nolock)
 where pa_producto = 'GAR'
   and pa_nemonico = 'CODFAG'
set transaction isolation level read uncommitted

/*CODIGO PADRE GARANTIA DE FGA*/
select @w_cod_gar_fga = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFGA'
set transaction isolation level read uncommitted

--CODIGO DEL RUBRO SEGVIDA
select @w_parametro_segvida = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'SEGURO'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION FNG 
select @w_parametro_fng_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COFNGD'
set transaction isolation level read uncommitted

--LECTURA DEL PARAMETRO CODIGO DEL RUBRO SEGURO DEUDORES ANTICIPADO
select @w_parametro_segdeuant = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'SEDEAN'
set transaction isolation level read uncommitted

--LECTURA DEL PARAMETRO CODIGO APERTURA DE CREDITO
select @w_parametro_apecr = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'APECR'
set transaction isolation level read uncommitted


--LECTURA DEL PARAMETRO SEGURO MICROSEGURO
select @w_parametro_microseg = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'MICSEG'
set transaction isolation level read uncommitted

--LECTURA DEL PARAMETRO SEGURO EXEQUIAL
select @w_parametro_exequial = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'EXEQUI'
set transaction isolation level read uncommitted

-- CONSULTA CODIGO DE MONEDA LOCAL
select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro
WHERE  pa_nemonico = 'MLO'
AND    pa_producto = 'ADM'
set transaction isolation level read uncommitted

select @w_producto = pd_producto
from cobis..cl_producto
where pd_abreviatura = 'CCA'

---CODIGO DEL RUBRO COMISION FAG 
select @w_parametro_fag = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'COMFAG'
set transaction isolation level read uncommitted

-- Tipo Garantia Padre FGA
select @w_parametro_fga_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFGA'

--PARAMETRO PARA IDENTIFICAR EL ITEM DE VALOR CONSTRUCCION
select @w_parametro_item = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'ITEMVC'
set transaction isolation level read uncommitted

--PARAMETRO TIPO GARANTIA HIPOTECARIA
select @w_tipogar_hipo = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'GARHIP'
set transaction isolation level read uncommitted

--PARAMETRO QUE INDICARA QUE SI SE TOME O NO LA TASA POR DEFECTO EN UNOS CASOS

select @w_param_tasadefecto = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'TASADE' 
set transaction isolation level read uncommitted

--REQ379 TIPO GARANTIA
select @w_parametro_fgu = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMGAR'


if @w_param_tasadefecto is null
   select @w_param_tasadefecto  = 'N'


--ITEM DONDE ESTA EL VALOR DE LA CONSTRUCCION
select @w_parametro_item = rtrim(ltrim(@w_parametro_item))

select @w_item = it_item  
from cob_custodia..cu_item
where it_tipo_custodia = @i_tipo_garantia  
and it_nombre = @w_parametro_item ---VALOR CONSTRUCCION


---FECHA CIERRE
select @w_fecha = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = @w_producto

---PARAMETRO TIPO SUPERIOR DE LA GARANTIA
select @w_tipo_superior = tc_tipo_superior
from cob_custodia..cu_tipo_custodia
where tc_tipo = @i_tipo_garantia

if @i_categoria_rubro is null
begin
   select @w_categoria_rubro = co_categoria
   from ca_concepto
   where co_concepto = @i_concepto

   select @i_categoria_rubro = @w_categoria_rubro
end



---PARA SEGUROS VEHICULARES CON TASAS PARAMETRIZADAS EN LA TABLA  @i_tabla_tasa = ca_otras_tasas
---SI EL CONCEPTO DE SEGUROS NO TIENE PARAMETRIZADA  OTRAS TASAS en ca_otras_tasas SE CALCULA
---COMUN Y CORRIENTE ASUMIENDO QUE EXISTE UNPORCENTAJE PARA SU CALCULO
---PERO NO DEBE TENER TIPO DE GARANTIA ASOCIADA
---PRINT 'rubrocal.sp RUBRO QUE LLEGA ' +   cast (@i_concepto as varchar) +  'TIPO GARANTIA ' + cast (@i_tipo_garantia as varchar)



if @i_tipo_garantia is not null  
begin
   if exists ( select 1 from cob_custodia..cu_clase_vehiculo 
            where cv_tipo = @i_tipo_garantia) 
   begin
      if @i_usar_tmp = 'S'  
      select  @w_tramite           = opt_tramite,
              @w_tdividendo        = opt_tdividendo,
              @w_periodo_int       = opt_periodo_int,
              @w_moneda            = opt_moneda,
              @w_op_base_calculo   = opt_base_calculo,
              @w_dias_anio         = opt_dias_anio,
              @w_fecha_ult_proceso = opt_fecha_ult_proceso,
              @w_op_tipo_amortizacion = opt_tipo_amortizacion
      from ca_operacion_tmp
      where opt_operacion = @i_operacion
      else
      select  @w_tramite           = op_tramite,
              @w_tdividendo        = op_tdividendo,
              @w_periodo_int       = op_periodo_int,
              @w_moneda            = op_moneda,
              @w_op_base_calculo   = op_base_calculo,
              @w_dias_anio         = op_dias_anio,
              @w_fecha_ult_proceso = op_fecha_ult_proceso,
              @w_op_tipo_amortizacion = op_tipo_amortizacion
      from ca_operacion
      where op_operacion = @i_operacion
          
      exec @w_return      = sp_seguros_vehiculares
      @i_tramite          = @w_tramite,
      @i_tipo_garantia    = @i_tipo_garantia,
      @i_operacionca      = @i_operacion,
      @i_concepto         = @i_concepto,
      @i_op_tdividendo    = @w_tdividendo,
      @i_op_periodo_int   = @w_periodo_int,
      @i_moneda           = @w_moneda,
      @i_op_base_calculo  = @w_op_base_calculo,
      @i_dias_anio        = @w_dias_anio,
      @i_categoria_rubro  = @i_categoria_rubro,
      @i_fpago            = @i_fpago,
      @o_tasa_calculo     = @w_porcentaje out,
      @o_nro_garantia     = @w_nro_garantia out,
      @o_base_calculo     = @w_base_calc out,
      @o_valor_rubro      = @w_valor out

      if @w_return <> 0 
         return @w_return

      select @o_valor_rubro        = @w_valor
      select @o_nro_garantia       = @w_nro_garantia
      select @o_tasa_calculo       = @w_porcentaje
      select @o_base_calculo       = @w_base_calc 
 
      return 0
   end
end




if @i_usar_tmp = 'S' 
begin
   select
   @w_monto_aprobado    = opt_monto_aprobado,
   @w_monto             = opt_monto,
   @w_sector            = opt_sector,
   @w_moneda            = opt_moneda,
   @w_toperacion        = opt_toperacion,
   @w_tramite           = opt_tramite,
   @w_tplazo            = opt_tplazo,
   @w_plazo             = opt_plazo,
   @w_tdividendo        = opt_tdividendo,
   @w_periodo_int       = opt_periodo_int,
   @w_gracia_cap        = opt_gracia_cap,
   @w_cliente           = opt_cliente,
   @w_num_periodo_d     = opt_periodo_int,
   @w_periodo_d         = opt_tdividendo,
   @w_sector            = opt_sector,
   @w_dias_anio         = opt_dias_anio,
   @w_base_calculo      = opt_base_calculo,
   @w_estado            = opt_estado,
   @w_fecha_ult_proceso = opt_fecha_ult_proceso,
   @w_op_tipo_amortizacion = opt_tipo_amortizacion
   from ca_operacion_tmp
   where opt_operacion = @i_operacion
end
else
begin
   select
   @w_monto_aprobado    = op_monto_aprobado,
   @w_monto             = op_monto,
   @w_sector            = op_sector,
   @w_moneda            = op_moneda,
   @w_toperacion        = op_toperacion,
   @w_tramite           = op_tramite,
   @w_tplazo            = op_tplazo,
   @w_plazo             = op_plazo,
   @w_tdividendo        = op_tdividendo,
   @w_periodo_int       = op_periodo_int,
   @w_gracia_cap        = op_gracia_cap,
   @w_cliente           = op_cliente,
   @w_num_periodo_d     = op_periodo_int,
   @w_periodo_d         = op_tdividendo,
   @w_sector            = op_sector,
   @w_dias_anio         = op_dias_anio,
   @w_base_calculo      = op_base_calculo,
   @w_estado            = op_estado,
   @w_fecha_ult_proceso = op_fecha_ult_proceso,
   @w_fecha_fin         = op_fecha_fin,
   @w_op_tipo_amortizacion = op_tipo_amortizacion
   from ca_operacion
   where op_operacion = @i_operacion
end


if @i_porcentaje_cobertura = 'S' and  @i_tipo_garantia  is  null
begin
   print 'En rubro calcula sobre % de cobertura pero la linea no tien el tipo asociado' + cast (@i_concepto as varchar)
   return 710371
end


-- Inicio IFJ 27/DIC/2005  - REQ 433
select @w_dias_plazo = td_factor 
from   ca_tdividendo
where  td_tdividendo = @w_tplazo
   
select @w_plazo_en_meses = isnull((@w_plazo * @w_dias_plazo)/30,0)
-- Fin IFJ 27/DIC/2005  - REQ 433


if @i_usar_tmp = 'S' 
begin   
   select @w_valor = @w_monto  ---MONTO A DESEMBOLSAR

   -- DETERMINAR EL VALOR DE COTIZACION DEL DIA
   if @w_moneda = @w_moneda_local
      select @w_cotizacion = 1.0
   else
   begin
      exec sp_buscar_cotizacion
      @i_moneda     = @w_moneda,
      @i_fecha      = @w_fecha_ult_proceso,
      @o_cotizacion = @w_cotizacion output
   end

   ---MANEJO DE DECIMALES
   exec @w_return = sp_decimales
   @i_moneda       = @w_moneda,
   @o_decimales    = @w_num_dec out,
   @o_mon_nacional = @w_moneda_local out,
   @o_dec_nacional = @w_num_dec_mn out


   ---CUANTOS DIAS TIENE UNA CUOTA DE INTERES
   select @w_dias_div = td_factor *  @w_periodo_int
   from   ca_tdividendo
   where  td_tdividendo = @w_tdividendo

   ---EN ESTA SECCION SE SACAN LOS VALORES DE LA GARANTIA SI ESTA TIENE UN VALOR
   if @i_tipo_garantia is not null 
   begin
      ---VALIDAR QUE LAS GARANTIAS DEL TRAMITE ESTEN EN FUTUROS CREDITOS PARA EL CALCULO DEL SEGURO
      ----NOAPLCIA PARA BANCAMIA
      
        set rowcount 1
        select 
          @w_porcen_cobertura   = isnull(gp_porcentaje,0.0),
         @w_nro_garantia       = gp_garantia
         from cob_credito..cr_gar_propuesta, 
         cob_custodia..cu_custodia,
         cob_custodia..cu_tipo_custodia
         where gp_tramite  =  @w_tramite
         and gp_garantia   =  cu_codigo_externo
         and cu_tipo       =  tc_tipo
         and cu_tipo       <>    @w_par_pagare ---pagare
         and (cu_tipo      =  @i_tipo_garantia or cu_tipo = tc_tipo_superior)
         and cu_estado    in ('V','F','P')
          set rowcount 0
      
      if (@w_porcen_cobertura =   0.0) or (@w_porcen_cobertura > 100.00)
      begin  
         PRINT 'EL PORCENTAJE INGRESADO POR RESPALDO DE GARANTIA SUPERA EL 100%, POR FAVOR VALIDAR'
         select
         @w_porcen_cobertura   = 100,
         @w_valor_act_garantia = 0,
         @w_nro_garantia       = 'NO DEFINIDO'
      end

                     
      if @w_tipo_superior = @w_tipogar_hipo
      begin
         --EJECUTAR EL SP QUE RETORNA EL VALOR DE RESPALDO SEGUN PRORRATEO
         select @w_valor_act_garantia = 0
         exec sp_prorrateo_seguros 
         @i_tramite           = @w_tramite,
         @i_operacion         = @i_operacion,
         @i_tipo_garantia     = @w_tipo_superior, --Para SEGTORVIVI se toman todas las hipotecarias
         @i_item              = @w_item,
         @o_base_calculo_seg  = @w_valor_act_garantia  output
                    
         ---PRINT 'rubrocal.sp RUBRO GAR-HIPOTECARIA  Base val construccion %1!',@w_valor_act_garantia 
      end ---TIPO HIPOTECARIO
      else  ---OTROS TIPOS
      begin
         --EJECUTAR EL SP QUE RETORNA EL VALOR DE RESPALDO SEGUR PRORRATEO
         select @w_valor_act_garantia = 0
         exec sp_prorrateo_seguros 
         @i_tramite           = @w_tramite,
         @i_operacion         = @i_operacion,
         @i_tipo_garantia     = @i_tipo_garantia,
         @o_base_calculo_seg  = @w_valor_act_garantia  output
      end

      ---PARA RUBROS CALCULADOS TENIENDO EN CUENTA EL VALOR  DE RESPALDO  LA GARANTIA
      if @i_valor_garantia = 'S' and  @w_valor_act_garantia > 0
         select @w_valor  = round(@w_valor_act_garantia,@w_num_dec) 
         
      else
         select @w_valor = 0
   end ---TIPO DE GARANTIA  VALIDO 

   --- CALCULO SOBRE EL SALDO DE LA OPERACION 
   if @i_saldo_op = 'S'
   begin
      if exists(select 1 from ca_amortizacion_tmp 
                where amt_operacion = @i_operacion)
      select @w_valor = sum(amt_acumulado-amt_pagado+amt_gracia)
      from ca_amortizacion_tmp, ca_dividendo_tmp, ca_rubro_op_tmp
      where dit_operacion = @i_operacion
      and   amt_operacion = @i_operacion
      and   rot_operacion = @i_operacion
      and   dit_estado in (@w_est_novigente, @w_est_vigente)
      and   amt_dividendo = dit_dividendo
      and   rot_tipo_rubro = 'C'
      and   rot_fpago = 'P'   --PERIODICO AL VENCIMIENTO
      and   amt_concepto = rot_concepto
   end

   --- CALCULO SOBRE EL SALDO EL MONTO APROBADO 
   if @i_monto_aprobado = 'S'
      select @w_valor = @i_op_monto_aprobado
   --- CALCULO SOBRE EL SALDO POR DESEMBOLSAR 
   if @i_saldo_por_desem = 'S'
      select @w_valor = @w_monto
   --- PARA RUBROS CALCULADOS TENIENDO EN CUENTA EL PORCENTAJE DE COBERTURA DE LA GARANTIA
   if @i_porcentaje_cobertura = 'S' 
   begin
      if @w_porcen_cobertura = 0.0
         select @w_porcen_cobertura = 100

         if exists(select 1 from ca_amortizacion_tmp 
                where amt_operacion = @i_operacion)
         select @w_valor = sum(amt_acumulado-amt_pagado+amt_gracia)
         from ca_amortizacion_tmp, ca_dividendo_tmp, ca_rubro_op_tmp
         where dit_operacion = @i_operacion
         and   amt_operacion = @i_operacion
         and   rot_operacion = @i_operacion
         and   dit_estado in (@w_est_novigente, @w_est_vigente)
         and   amt_dividendo = dit_dividendo
         and   rot_tipo_rubro = 'C'
         and   rot_fpago = 'P'   --PERIODICO AL VENCIMIENTO
         and   amt_concepto = rot_concepto
         
         select @w_valor  = isnull((@w_valor * @w_porcen_cobertura)/100,0)  
   end
end    --- Fin de Trabajo en temporales
else   
begin
   select @w_valor = @w_monto  ---MONTO A DESEMBOLSAR

   ---MANEJO DE DECIMALES
   exec @w_return = sp_decimales
   @i_moneda       = @w_moneda,
   @o_decimales    = @w_num_dec out,
   @o_mon_nacional = @w_moneda_local out,
   @o_dec_nacional = @w_num_dec_mn out


   -- DETERMINAR EL VALOR DE COTIZACION DEL DIA
   if @w_moneda = @w_moneda_local
      select @w_cotizacion = 1.0
   else
   begin
      exec sp_buscar_cotizacion
           @i_moneda     = @w_moneda,
           @i_fecha      = @w_fecha_ult_proceso,
           @o_cotizacion = @w_cotizacion output
   end
   
   ---PRINT'rubrocal.sp Cotizacion %1!'+cast(@w_cotizacion as varchar)
   ---CUANTOS DIAS TIENE UNA CUOTA DE INTERES
   select @w_dias_div = td_factor *  @w_periodo_int
   from   ca_tdividendo
   where  td_tdividendo = @w_tdividendo


   if @i_saldo_op = 'S' 
   begin ---(abre 1)
 
      if exists (select 1 from ca_amortizacion
                 where am_operacion = @i_operacion)
         select @w_valor = sum(am_acumulado-am_pagado+am_gracia)
         from ca_amortizacion, ca_dividendo, ca_rubro_op
         where di_operacion = @i_operacion
         and   am_operacion = @i_operacion
         and   ro_operacion = @i_operacion
         and   di_estado in (@w_est_novigente, @w_est_vigente)
         and   am_dividendo = di_dividendo
         and   ro_tipo_rubro = 'C'
         and   ro_fpago = 'P'   --PERIODICO AL VENCIMIENTO
         and   am_concepto = ro_concepto
      else
         select @w_valor = @w_monto
   end ---(cierra 1)
   
   ELSE
     if @i_monto_aprobado = 'S'
        begin --- (abre 3)

          if @i_op_monto_aprobado > 0
          BEGIN
             select @w_valor = @i_op_monto_aprobado
  
          END
          else
          BEGIN
             select @w_valor = @w_monto_aprobado
  
          END
            
        end --- (cierra 3)
      ELSE
        if @i_saldo_por_desem = 'S'
           select @w_valor = @w_monto
         ELSE
            ---POR TIPO DE GARANTIA
            ---EN ESTA SECCION SE SACAN LOS VALORES DE LA GARANTIA SI ESTA TIENE UN VALOR
            if @i_tipo_garantia is not null 
               begin ---(abre 6)
                  set rowcount 1
                  select @w_porcen_cobertura   = isnull(gp_porcentaje,0.0),
                         @w_nro_garantia       = gp_garantia
                  from cob_credito..cr_gar_propuesta, 
                  cob_custodia..cu_custodia,
                  cob_custodia..cu_tipo_custodia
                  where gp_tramite  =  @w_tramite
                  and gp_garantia   =  cu_codigo_externo
                  and cu_tipo       =  tc_tipo
                  and cu_tipo       <>    @w_par_pagare ---pagare
                  and (cu_tipo      =  @i_tipo_garantia or cu_tipo = tc_tipo_superior)
                  and cu_estado    in ('V','F','P')
                  set rowcount 0

                 if (@w_porcen_cobertura =   0.0 ) or (@w_porcen_cobertura  > 100.0) 
                 begin  
                    ---PRINT 'rubrocal.sp No hay datos en las tablas de gar_propuesta y cu_custodia para el tipo %1! @w_tramite %2!'+@i_tipo_garantia+@w_tramite
                    select @w_porcen_cobertura   = 100,
                           @w_valor_act_garantia = 0,
                           @w_nro_garantia       = 'NO DEFINIDO'
                 end
                 
                 ---PRINT 'rubrocal.sp No @w_tipo_superior %1! @w_tipogar_hipo %2!'+@w_tipo_superior+@w_tipogar_hipo
                 
               ---EL VALOR BASE PARA HIPOTECAS DEBE SER CALCULADO DEPENDIENDO DEL VALOR DE LA CONSTRUCCION
               if @w_tipo_superior = @w_tipogar_hipo
                  begin --- (abre 8)
                        
                        --- VALOR DE RESPALDO
                        --- SI EL TRAMITE ES RESPALDADO POR MAS DE UNA GARANTIA DEL MISMO TIPO
                        --- SE SUMAN LOS VALORES DE RESPALDO DE TODAS EN UNO SOLO PARA EL CALCULO
                        
                                  --EJECUTAR EL SP QUE RETORNA EL VALOR DE RESPALDO SEGUN PRORRATEO
                         select @w_valor_act_garantia = 0
                         exec sp_prorrateo_seguros 
                           @i_tramite           = @w_tramite,
                           @i_operacion         = @i_operacion,
                           @i_tipo_garantia     = @w_tipo_superior,
                           @i_item              = @w_item,
                           @o_base_calculo_seg  = @w_valor_act_garantia  output
                      
           ---PRINT 'rubrocal.sp RUBRO GAR-HIPOTECARIA  Base val construccion %1!'+@w_valor_act_garantia 

                   end --- (cierra 8)
                   ELSE
                   begin
                      --EJECUTAR EL SP QUE RETORNA EL VALOR DE RESPALDO SEGUR PRORRATEO
                      select @w_valor_act_garantia = 0
                      exec sp_prorrateo_seguros 
                        @i_tramite           = @w_tramite,
                        @i_operacion         = @i_operacion,
                        @i_tipo_garantia     = @i_tipo_garantia,
                        @o_base_calculo_seg  = @w_valor_act_garantia  output
                   end 

                  ---TODOS LOS RUBROS DEBEN ESTAR EN LA MONEDA DE LA OPERACION 
                     select @w_valor  = isnull(@w_valor_act_garantia ,0)

                     if @i_porcentaje_cobertura = 'S' 
                     begin
                        
                        if @w_porcen_cobertura = 0.0
                           select @w_porcen_cobertura = 100
                           
                           select @w_valor  = isnull((@w_monto * @w_porcen_cobertura)/100,0) 
       
                     end

                      ---PRINT 'rubrocal.sp @w_valor_act_garantia %1! @w_porcen_cobertura %2!'+@w_valor_act_garantia+@w_porcen_cobertura
                  

            end ---(cierra 6) FIN TIPO DE GARANTIA
            ELSE
               select @w_valor  = @i_monto
end  ---No temporales


if @i_saldo_insoluto = 'S' and @w_fecha_ult_proceso >=  @w_fecha_fin
begin
   ---LA BASE PARA EL CALULO DEL SEGURO SOBRE SALDO INSOLUTO SE HACE SOBRE LO QUE DEBE A LA FECHA
   ---INCLUIDO EL MISMO RUBRO
   select @w_div_vigente = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @i_operacion
   and di_estado  in (1,2)
   
   select @w_saldo1 = isnull(sum(am_acumulado - am_pagado),0)
   from ca_amortizacion,
        ca_concepto
   where  am_operacion   = @i_operacion
   and    am_concepto    = co_concepto
   and    co_categoria in ('C','I','M')
   and    am_estado <> 3

   select @w_saldo2 = isnull(sum(am_acumulado - am_pagado),0)
   from ca_amortizacion,
        ca_concepto
   where  am_operacion   = @i_operacion
   and    am_concepto    = co_concepto
   and    am_dividendo <= @w_div_vigente
   and    co_categoria  not in  ('C','I','M')
   and    am_estado <> 3

   select @w_valor = isnull(sum(@w_saldo1 + @w_saldo2 ),0)

end

if @w_param_tasadefecto ='S'
   select @i_tasa_matriz = 'N' 

if (@i_porcentaje = 0 ) and (@i_tasa_matriz = 'N') and (@w_param_tasadefecto ='S') 
begin

   select @w_referencial = ru_referencial
   from ca_rubro
   where ru_toperacion = @w_toperacion
   and   ru_moneda     = @w_moneda
   and   ru_estado     = 'V'
   and   ru_concepto   = @i_concepto

   ---Determinacion de la tasa a aplicar 
   select
   @w_signo        = isnull(vd_signo_default, ''),
   @w_factor       = isnull(vd_valor_default, 0),
   @w_tipo_val     = vd_referencia,
   @w_clase = va_clase
   from ca_valor, ca_valor_det
   where va_tipo   = @w_referencial
   and   vd_tipo   = @w_referencial
   and   vd_sector = @w_sector

   --- Determinacion del maximo secuencial para la tasa encontrada 

   select @w_fecha_max = max(vr_fecha_vig)
   from ca_valor_referencial
   where vr_tipo = @w_tipo_val
   and   vr_fecha_vig <= @w_fecha

   select @w_secuencial_ref = max(vr_secuencial)
   from ca_valor_referencial
   where vr_tipo = @w_tipo_val
   and   vr_fecha_vig = @w_fecha_max

   ---Determinacion del valor de tasa aplicar  
   select @w_vr_valor = vr_valor
   from ca_valor_referencial
   where vr_tipo = @w_tipo_val
   and   vr_secuencial = @w_secuencial_ref


   if @w_clase = 'V'  
      select @i_porcentaje = @w_factor,
      @w_factor = 0
   else begin
      if @w_signo = '+'
     select @i_porcentaje = @w_vr_valor + @w_factor
      
      if @w_signo = '-'
     select @i_porcentaje = @w_vr_valor - @w_factor
      
      if @w_signo = '/'
     select @i_porcentaje = @w_vr_valor / @w_factor
      
      if @w_signo = '*'
     select @i_porcentaje = @w_vr_valor * @w_factor
   end  
end  --- @i_porcentaje = 0  


if @i_concepto = @w_parametro_segvida  
begin
    if exists(select 1 from ca_deudores_tmp
              where dt_operacion  = @i_operacion
              and   dt_segvida = 'S')
    begin
       select @w_numero_deudores  =  count(1)
       from ca_deu_segvida
       where dt_operacion  = @i_operacion
       and   dt_segvida    = 'S'
       select @w_valor  = @w_valor * @w_numero_deudores

    end
end


--- LLAMADO AL SP PARA CALCULO CONSULTA CENTRAL DE RIESGO 
if @i_concepto = @w_parametro_apecr
begin
   --- OBTENER CANTIDAD DE DEUDORES UTILIZANDO TABLA CR_DEUDORES
   select @w_can_deu = isnull(count(*),0)
   from   cob_credito..cr_deudores with (nolock)
   where  de_tramite     = @w_tramite
   and    de_rol         = 'D'
   and    de_cobro_cen   = 'S'
   
   -- Apertura de crédito por Alianza
   
   select @w_porcentaje_apecr = 0
   select @w_porcentaje_apecr = al_porcentaje_exonera
   from cobis..cl_alianza, cob_credito..cr_tramite 
   where al_exonera_estudio = 'S'
   and   al_alianza = tr_alianza
   and   @w_tramite = tr_tramite
   
   --- VALOR DE COBCENRIE
   select @o_valor_rubro = round((@w_can_deu * @i_porcentaje), @w_num_dec)
   
   select @w_can_codeu = isnull(count(*),0)
   from   cob_credito..cr_deudores with (nolock)
   where  de_tramite     = @w_tramite
   and    de_rol         = 'C'
   and    de_cobro_cen   = 'S'
   
   select @w_val_aper_codeu = pa_money
   from cobis..cl_parametro with (nolock)
   where pa_producto = 'CRE' 
     and pa_nemonico = 'APEDEU'
   
   select @o_valor_rubro = @o_valor_rubro + round((@w_can_codeu * @w_val_aper_codeu), @w_num_dec)
   
   if @w_porcentaje_apecr > 0
      select @o_valor_rubro = @o_valor_rubro - round((@o_valor_rubro * @w_porcentaje_apecr / 100.0), @w_num_dec)
           
   select    
   @o_tasa_calculo     = @i_porcentaje,
   @o_nro_garantia     = '',
   @o_base_calculo     = 0.00,
   @o_valor_rubro      = @o_valor_rubro
   

   return 0
end


---MRoa: LLAMADO AL SP PARA CALCULO MICROSEGUROS 
if @i_concepto = @w_parametro_microseg
begin
--   PRINT 'RUBROCAL: Calculando Microseguro'
   exec @w_error = sp_microseguro_exequial
   @i_operacion     = @i_operacion,
   @i_rubro         = @w_parametro_microseg,
   @o_valor_rubro   = @o_valor_rubro out

   if @w_error <> 0  return @w_error
  return 0
end

---MRoa: LLAMADO AL SP PARA CALCULO SEGURO EXEQUIAL 
if @i_concepto = @w_parametro_exequial
begin
--   PRINT 'RUBROCAL: Calculando Seguro exequial'
   exec @w_error = sp_microseguro_exequial
   @i_operacion     = @i_operacion,
   @i_rubro         = @w_parametro_exequial,
   @o_valor_rubro   = @o_valor_rubro out

   if @w_error <> 0  return @w_error
   return 0
end

--print 'RUBROCAL: @w_valor 7 ' + cast(@w_valor as varchar)

--REQ 402
select @w_colateral = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'GARESP'

select tc_tipo as tipo_sub 
into #colateral
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior = @w_colateral

select w_tipo_garantia   = tc_tipo_superior,
       w_tipo            = tc_tipo,
       estado            = 'I',
       w_garantia        = cu_codigo_externo
into #garantias_operacion_rcal
from cob_custodia..cu_custodia, #colateral, cob_credito..cr_gar_propuesta, cob_custodia..cu_tipo_custodia
Where cu_tipo = tc_tipo
and   tc_tipo_superior = tipo_sub
and   gp_tramite  = @w_tramite
and   gp_garantia = cu_codigo_externo
and   cu_estado  in ('V','F','P')

select @w_garantia        = w_tipo,
       @w_tipo_garantia   = w_tipo_garantia
from #garantias_operacion_rcal
  
select @w_rubro = valor 
from  cobis..cl_tabla t, cobis..cl_catalogo c
where t.tabla  = 'ca_conceptos_rubros'
and   c.tabla  = t.codigo
and   c.codigo = convert(bigint, @w_garantia)  

if @w_rubro = 'S' begin
     
   select @w_tabla_rubro = 'ca_conceptos_rubros_' + cast(@w_garantia as varchar)

   insert into #conceptos_gen
   select 
   codigo = c.codigo, 
   tipo_gar = @w_garantia
   from cobis..cl_tabla t, cobis..cl_catalogo c
   where t.tabla  = @w_tabla_rubro
   and   c.tabla  = t.codigo
   and   c.estado = 'V'

end
     
/*COMICION DESEMBOLSO*/
insert into #rubros_gen
select tipo_gar, ru_concepto, 'DES', 'N'
from cob_cartera..ca_rubro, #conceptos_gen
where ru_fpago = 'L'
and   codigo   = ru_concepto
and   ru_concepto_asociado is null

/*COMICION PERIODICO*/
insert into #rubros_gen
select tipo_gar, ru_concepto, 'PER', 'N'
from cob_cartera..ca_rubro, #conceptos_gen
where ru_fpago = 'P'
and   codigo   = ru_concepto
and   ru_concepto_asociado is null

/*IVA DESEMBOLSO*/
insert into #rubros_gen
select tipo_gar, ru_concepto, 'DES', 'S'
from cob_cartera..ca_rubro, #conceptos_gen
where ru_fpago = 'L'
and   codigo   = ru_concepto
and   ru_concepto_asociado is not null
   
/*IVA PERIODICO*/
insert into #rubros_gen
select tipo_gar, ru_concepto, 'PER', 'S'
from cob_cartera..ca_rubro, #conceptos_gen
where ru_fpago = 'P'
and   codigo   = ru_concepto
and   ru_concepto_asociado is not null

select @w_concepto_des = rre_concepto
from #rubros_gen
where tipo_concepto = 'DES' 
and iva = 'N'


if @w_valor > 0
begin
    --print '@i_concepto' + cast(@i_concepto as varchar(20))
    --print '@w_valor' + cast(@w_valor as varchar(20))
    --print '@w_dias_div' + cast(@w_dias_div as varchar(20))
    --print '@i_porcentaje' + cast(@i_porcentaje as varchar(20))
   
    --- CAMBIO REALIZADO PARA EL MANEJO DE SEGURO DEUDORES ANTICIPADO Y VENCIDO 
    if @i_categoria_rubro = 'S'
    begin
        if @i_concepto = @w_parametro_segdeuant
        begin
            select @o_valor_rubro        = (@w_valor * @w_dias_div * (@i_porcentaje /100.0)) /360.0 * @w_plazo_en_meses
        end
        else
        begin
            select @o_valor_rubro        = ((@w_valor * @w_dias_div * (@i_porcentaje /100.0)) /360.0)
        end
    end
    else
    --- Inicio IFJ 09/DIC/2005  - REQ 433 
    begin
       
       
        if (@i_concepto = @w_parametro_fag or @i_concepto = @w_concepto_des) and (@w_tipo_garantia = @w_cod_gar_fag)
        begin
           ---la bae ya debe venir ok
            select @o_valor_rubro  = (@w_valor * @i_porcentaje/100)
        end
        else
        begin
           if (@i_concepto = @w_parametro_fng_des or @i_concepto = @w_concepto_des)
           and (@w_tipo_garantia = @w_cod_gar_fng)
           and ((@w_dias_div * @w_plazo / 30) < 12)
           begin

              if exists(select 1
                        from cobis..cl_parametro with (nolock)
                        where pa_producto = 'CCA'
                        and   pa_nemonico = 'TFLEXI'
                        and   pa_char = @w_op_tipo_amortizacion)
              begin
                 select @o_valor_rubro = (@w_valor * @i_porcentaje/100.0)
                 if @w_plazo < 360
                    select @o_valor_rubro = @o_valor_rubro * @w_plazo / 360.0
              end
              else
                 select @o_valor_rubro = (@w_valor * @i_porcentaje/100.0) / (12.0 / ((@w_dias_div*@w_plazo)/30.0))
           end
           else
           begin

              if (@i_concepto = @w_parametro_fga_uni or @i_concepto = @w_concepto_des)and (@w_tipo_garantia = @w_cod_gar_fga)
              begin -- FGA Antioquia
                 select @o_valor_rubro = @i_porcentaje * ((@w_dias_div*@w_plazo)/30.0) * @w_valor 
              end
              else
              begin

                 if @i_concepto = @w_parametro_fgu and ((@w_dias_div * @w_plazo / 30.0) < 12)
                 begin -- REQ 379
                    select @o_valor_rubro = (@w_valor * @i_porcentaje/100) / (12.0 / ((@w_dias_div*@w_plazo)/30.0))
                 end
                 else
                 begin
                    select @o_valor_rubro = case when @i_concepto = @w_par_usaid_des then
                                               @w_valor * @w_porc_des * @i_porcentaje/100.0
                                            else
                                               @w_valor * @i_porcentaje/100.0
                                            end
                 end        
              end                    
           end
        end
    end


    --- Fin IFJ 09/DIC/2005  - REQ 433 

    select @o_nro_garantia       = @w_nro_garantia
    select @o_tasa_calculo       = isnull(@i_porcentaje,0)
    select @o_base_calculo       = isnull(@w_valor,0)
  
end
else
begin
    select @o_valor_rubro        = 0
    select @o_nro_garantia       = @w_nro_garantia
    select @o_tasa_calculo       = isnull(@i_porcentaje,0)
    select @o_base_calculo       = isnull(@w_valor,0)
end

return 0 

go

