/************************************************************************/
/*      Archivo:                creaopin.sp                             */
/*      Stored procedure:       sp_crear_operacion_int                  */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Fabian de la Torre, Rodrigo Garces      */
/*      Fecha de escritura:     Ene. 1998                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                           */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Crea una operacion de Cartera con sus rubros asociados y su     */
/*      tabla de amortizacion sp interno llamado por otros sp           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      24/jul/98      A. Ramirez       El numero op_banco se genera en */
/*                                      la liquidacion  ALR B.ESTADO    */
/*      11/May/99   Ramiro Buitrn (CONTEXT) Personalizacion  CORFINSURA */
/*      EPB: ABR-12-2002                                                */
/*      MRoa:Abr-11-2008                Validacion monto del prestamo   */
/*      EPB: JUL-06-2010                Inc. 00129 Dia Pago             */
/*      EPB: MAR-12-2015                 NR.436 BAncamia                */
/*      LRE  05/Ene/2017                Incluir concepto de Agrupamiento*/
/*                                      de Operaciones                  */
/*      LGU  12/Abr/2017                Incluir concepto de Agrupamiento*/
/*      JSA  22/May/2017                CGS-S112643                     */
/*      JSA  13/May2017                 Parametros de entrada           */
/*                                      @i_tdividendo                   */
/*                                      @i_periodo_cap                  */
/*                                      @i_periodo_int                  */
/*     SRO   17/09/2020                 Req #140073                     */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_crear_operacion_int')
    drop proc sp_crear_operacion_int
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
---NR.436 MAR.04.2015
create proc sp_crear_operacion_int
   @s_user              login        = null,
   @s_date              datetime     = null,
   @s_term              varchar(30)  = null,
   @s_ofi               smallint     = null,
   @i_anterior          cuenta       = null,
   @i_migrada           cuenta       = null,
   @i_tramite           int          = null,
   @i_cliente           int          = null,
   @i_nombre            descripcion  = null,
   @i_sector            catalogo     = null,
   @i_toperacion        catalogo     = null,
   @i_oficina           smallint     = null,
   @i_moneda            tinyint      = null,
   @i_comentario        varchar(255) = null,
   @i_oficial           smallint     = null,
   @i_fecha_ini         datetime     = null,
   @i_monto             money        = null,
   @i_monto_aprobado    money        = null,
   @i_destino           catalogo     = null,
   @i_lin_credito       cuenta       = null,
   @i_ciudad            int          = null,
   @i_forma_pago        catalogo     = null,
   @i_cuenta            cuenta       = null,
   @i_formato_fecha     int          = 101,
   @i_salida            char(1)      = 'S',
   @i_crear_pasiva      char(1)      = 'N',
   @i_toperacion_pasiva catalogo     = null,
   @i_operacion_activa  int          = null,
   @i_periodo_crecimiento smallint   = 0,
   @i_tasa_crecimiento  float        = 0,
   @i_direccion         tinyint      = 1,
   @i_clase_cartera     catalogo     = null,
   @i_origen_fondos     catalogo,
   @i_tipo_empresa      catalogo     = null,
   @i_validacion        catalogo     = null,
   @i_ult_dia_habil     char(1)      = 'N',
   @i_fondos_propios    char(1)      = 'N',
   @i_ref_exterior      cuenta       = null,
   @i_sujeta_nego       char(1)      = null ,
   @i_ref_red           varchar(24)  = null ,
   @i_convierte_tasa    char(1)      = null ,
   @i_tasa_equivalente  char(1)      = null ,
   @i_reestructuracion  char(1)      = null ,
   @i_subtipo           char(1)      = null ,
   @i_fec_embarque      datetime     = null,
   @i_fec_dex           datetime     = null,
   @i_num_deuda_ext     cuenta       = null,
   @i_num_comex         cuenta       = null,
   @i_no_banco          char(1)      = null,
   @i_batch_dd          char(1)      = null,
   @i_tramite_hijo      int          = null,
   @i_numero_reest      int          = null,    -- RRB Feb 21 - 2002 Circular 50
   @i_oper_pas_ext      varchar(64)  = null,
   @i_banca             catalogo     = null,    --XMA
   @s_sesn              int          = null,
   @i_tplazo            catalogo     = null,   --MRoa Parametro nuevo para crear la operacion y validar el plazo desde tramites
   @i_plazo             smallint     = null,    --MRoa Parametro nuevo para crear la operacion y validar el plazo desde tramites
   @i_fecha_fija        char(1)      = null,
   @i_dia_pago          tinyint      = null,
   @i_tdividendo        catalogo     = null,
   @i_periodo_cap       int          = null,
   @i_periodo_int       int          = null,
   @i_simulacion        char(1)      = null,
   @i_signo             char(1)      = null,
   @i_factor            float        = null,
   @i_crea_ext          char(1)      = null,
   @i_tipo_tramite      char(1)      = null,     -- Req. 436 Normalizacion
   @i_grupal            char(1)      = null,     --LRE 05/Ene/2017
   @i_promocion         char(1)      = null, --LPO Santander
   @i_acepta_ren        char(1)      = null, --LPO Santander
   @i_no_acepta         char(1000)   = null, --LPO Santander
   @i_emprendimiento    char(1)      = null, --LPO Santander
   @i_tasa              float        = null, --JSA Santander
   @i_desplazamiento    int          = 0,    --SRO 140073
   @o_banco             cuenta       = null output,
   @o_msg_msv           varchar(255) = null output


as
declare
@w_sp_name                    descripcion,
@w_return                     int,
@w_error                      int,
@w_msg                        mensaje,
@w_anterior                   cuenta ,
@w_migrada                    cuenta,
@w_tramite                    int,
@w_cliente                    int,
@w_nombre                     descripcion,
@w_sector                     catalogo,
@w_toperacion                 catalogo,
@w_oficina                    smallint,
@w_moneda                     tinyint,
@w_comentario                 varchar(255),
@w_oficial                    smallint,
@w_fecha_ini                  datetime,
@w_fecha_f                    varchar(10),
@w_fecha_fin                  datetime,
@w_fecha_ult_proceso          datetime,
@w_fecha_liq                  datetime,
@w_fecha_reajuste             datetime,
@w_monto                      money,
@w_monto_aprobado             money,
@w_destino                    catalogo,
@w_lin_credito                cuenta,
@w_ciudad                     smallint,
@w_estado                     tinyint,
@w_periodo_reajuste           smallint,
@w_reajuste_especial          char(1),
@w_tipo                       char(1),
@w_forma_pago                 catalogo,
@w_cuenta                     cuenta,
@w_dias_anio                  smallint,
@w_tipo_amortizacion          varchar(30),
@w_cuota_completa             char(1),
@w_tipo_cobro                 char(1),
@w_tipo_reduccion             char(1),
@w_aceptar_anticipos          char(1),
@w_precancelacion             char(1),
@w_num_dec                    tinyint,
@w_tplazo                     catalogo,
@w_plazo                      smallint,
@w_tdividendo                 catalogo,
@w_periodo_cap                smallint,
@w_periodo_int                smallint,
@w_gracia_cap                 smallint,
@w_gracia_int                 smallint,
@w_dist_gracia                char(1),
@w_fecha_fija                 char(1),
@w_dia_pago                   tinyint,
@w_cuota_fija                 char(1),
@w_evitar_feriados            char(1),
@w_tipo_producto              char(1),
@w_renovacion                 char(1),
@w_mes_gracia                 tinyint,
@w_tipo_aplicacion            char(1),
@w_reajustable                char(1),
@w_est_novigente              tinyint,
@w_est_credito                tinyint,
@w_dias_dividendo             int,
@w_dias_aplicar               int,
@w_operacionca                int,
@w_banco                      cuenta,
@w_sal_min_cla_car            int,
@w_sal_min_vig                money,
@w_base_calculo               char(1),
@w_ult_dia_habil              char(1),
@w_recalcular                 char(1),
@w_prd_cobis                  tinyint,
@w_tipo_redondeo              tinyint,
@w_causacion                  char(1),
@w_convierte_tasa             char(1),
@w_tasa_equivalente           char(1),
@w_tipo_linea                 catalogo,
@w_subtipo_linea              catalogo,
@w_bvirtual                   char(1),
@w_extracto                   char(1),
@w_reestructuracion           char(1),
@w_subtipo                    char(1),
@w_naturaleza                 char(1),
@w_pago_caja                  char(1),
@w_nace_vencida               char(1),
@w_valor_rubro                money,
@w_calcula_devolucion         char(1),
@w_concepto_interes           catalogo,
@w_est_cancelado              tinyint,
@w_clase_cartera              catalogo,
@w_dias_gracia                smallint,
@w_tasa_referencial           catalogo,
@w_porcentaje                 float,
@w_modalidad                  char(1),
@w_periodicidad               char(1),
@w_tasa_aplicar               catalogo,
@w_entidad_convenio           catalogo,
@w_mora_retroactiva           char(1),
@w_prepago_desde_lavigente    char(1),
@w_rowcount                   int,
@w_control_dia_pago           char(1),
@w_pa_dimive                  tinyint,
@w_pa_dimave                  tinyint,
@w_tr_tipo                    char(1),
@w_monto_seguros              money,                      -- Req. 366 Seguros
-- LGU-INI 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO
@w_fecha_pri_cuot             datetime,
@w_operacionca_grp            int,
-- LGU-FIN 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO
@w_fondos_propios             char(1),
@w_origen_fondos              catalogo,
@w_porcen_colateral           float,
@w_desplazamiento             int,
@w_param_oferta_producto      char(1)

/* CARGAR VALORES INICIALES */
select
@w_sp_name       = 'sp_crear_operacion_int',
@w_est_novigente = 0,
@w_est_credito   = 99,
@w_valor_rubro   = 0,
@w_est_cancelado = 3,
@w_dias_aplicar  = 0

/* CONTROLAR DIA MINIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimive = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMIVE'
and   pa_producto = 'CCA'


/* CONTROLAR DIA MAXIMO DEL MES PARA FECHAS DE VENCIMIENTO */
select @w_pa_dimave = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'DIMAVE'
and   pa_producto = 'CCA'

select @w_concepto_interes = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'INT'
and    pa_producto = 'CCA'

if @i_moneda is null begin
   select @i_moneda = pa_tinyint
   from cobis..cl_parametro 
   where pa_nemonico='CMNAC'
end

select @w_param_oferta_producto = isnull(pa_char, 'N')
from cobis..cl_parametro 
where pa_nemonico = 'OFEPRO'

/* VERIFICAR QUE EXISTAN LOS RUBROS NECESARIOS */
if not exists (select 1 from ca_rubro
where  ru_toperacion = @i_toperacion
and    ru_moneda     = @i_moneda
and    ru_tipo_rubro = 'C'
and    ru_crear_siempre = 'S'
and    ru_estado     = 'V')
begin
   if @i_crea_ext is null
      PRINT 'creaopin.sp entro a este error @i_toperacion ' + cast(@i_toperacion as varchar) + ', @i_moneda ' + cast(@i_moneda as varchar)
   else
      select @o_msg_msv = 'creaopin.sp entro a este error @i_toperacion ' + cast(@i_toperacion as varchar) + ', @i_moneda ' + cast(@i_moneda as varchar)
   return 710016
end

-- REQ. 366 GENERA MONTO BASE DE LA OPERACION
-- Validacion Seguros asociados

if exists (select 1 from cob_credito..cr_seguros_tramite
           where st_tramite = @i_tramite)

begin

   select @w_monto_seguros = 0
   select @w_monto_seguros = isnull(sum(sed_cuota_cap - sed_pago_cap),0)
   from ca_seguros_det, ca_seguros
   where sed_sec_seguro = se_sec_seguro
   and se_tramite = @i_tramite

   select @i_monto = @i_monto - @w_monto_seguros

end  -- Fin Generar monto base de la operaci+?n Req 366


/* DETERMINAR LOS VALORES POR DEFECTO PARA EL TIPO DE OPERACION */
select
@w_periodo_reajuste          = dt_periodo_reaj,
@w_reajuste_especial         = dt_reajuste_especial,
@w_precancelacion            = dt_precancelacion,
@w_tipo                      = dt_tipo,
@w_cuota_completa            = dt_cuota_completa,
@w_tipo_reduccion            = dt_tipo_reduccion,
@w_aceptar_anticipos         = dt_aceptar_anticipos,
--xma @w_tipo_reduccion     = dt_tipo_reduccion,
@w_tplazo                    = dt_tplazo,
@w_plazo                     = dt_plazo,
@w_tdividendo                = dt_tdividendo,
@w_periodo_cap               = isnull(@i_periodo_cap, dt_periodo_cap),
@w_periodo_int               = isnull(@i_periodo_int, dt_periodo_int),
@w_gracia_cap                = dt_gracia_cap,
@w_gracia_int                = dt_gracia_int,
@w_dist_gracia               = dt_dist_gracia,
@w_dias_anio                 = dt_dias_anio,
@w_tipo_amortizacion         = dt_tipo_amortizacion,
@w_fecha_fija                = dt_fecha_fija,
@w_dia_pago                  = isnull(@i_dia_pago,dt_dia_pago),
@w_cuota_fija                = dt_cuota_fija,
@w_evitar_feriados           = dt_evitar_feriados,
@w_renovacion                = dt_renovacion,
@w_mes_gracia                = dt_mes_gracia,
@w_tipo_aplicacion           = dt_tipo_aplicacion,
@w_tipo_cobro                = dt_tipo_cobro,
@w_reajustable               = dt_reajustable,
@w_base_calculo              = dt_base_calculo,
@w_ult_dia_habil             = dt_dia_habil,
@w_recalcular                = dt_recalcular_plazo,
@w_prd_cobis                 = dt_prd_cobis,
@w_tipo_redondeo             = dt_tipo_redondeo,
@w_causacion                 = dt_causacion,
@w_convierte_tasa            = isnull(dt_convertir_tasa, 'S'),
@w_tipo_linea                = dt_tipo_linea,
@w_subtipo_linea             = dt_subtipo_linea,
@w_bvirtual                  = dt_bvirtual,
@w_extracto                  = dt_extracto,
@w_naturaleza                = dt_naturaleza,
@w_pago_caja                 = dt_pago_caja,
@w_nace_vencida              = dt_nace_vencida,
@w_calcula_devolucion        = dt_calcula_devolucion,
@w_dias_gracia               = dt_dias_gracia,
@w_entidad_convenio          = dt_entidad_convenio,
@w_mora_retroactiva          = dt_mora_retroactiva,
@w_prepago_desde_lavigente   = isnull(dt_prepago_desde_lavigente,'N'),
@w_control_dia_pago          = dt_control_dia_pago,
@w_sector                    = dt_clase_sector,
@w_clase_cartera             = dt_clase_cartera,
@w_origen_fondos             = dt_categoria,
@w_fondos_propios            = isnull(dt_fondos_propios,'S'),
@w_porcen_colateral          = dt_porcen_colateral,
@w_desplazamiento            = dt_desplazamiento --SRO #140073
from ca_default_toperacion
where dt_toperacion = @i_toperacion
and   dt_moneda     = @i_moneda

if @@rowcount = 0 return 710072

select
@w_tplazo           = isnull(@i_tplazo, @w_tplazo),
@w_plazo            = case when @i_toperacion <> 'GRUPAL' then isnull(@i_plazo, @w_plazo)
                           when @w_param_oferta_producto = 'S' and @i_toperacion = 'GRUPAL' then isnull(@i_plazo, @w_plazo)
						   when @w_param_oferta_producto = 'N' and @i_toperacion = 'GRUPAL' then @w_plazo
				      end,
@w_desplazamiento   = case when @i_toperacion <> 'GRUPAL' then isnull(@i_desplazamiento,  @w_desplazamiento)
                           when @w_param_oferta_producto = 'S' and @i_toperacion = 'GRUPAL' then isnull(isnull(@i_desplazamiento, @w_desplazamiento),0)
						   when @w_param_oferta_producto = 'N' and @i_toperacion = 'GRUPAL' then @w_desplazamiento
				      end,
@w_tasa_equivalente = isnull(@i_tasa_equivalente, 'N'),
@w_tdividendo       = isnull(@i_tdividendo, @w_tdividendo),
@i_sector           = isnull(@i_sector,@w_sector),
@i_clase_cartera    = isnull(@i_clase_cartera,@w_clase_cartera ),
@i_fondos_propios   = isnull(@i_fondos_propios,@w_fondos_propios),
@i_origen_fondos    = isnull(@i_origen_fondos,@w_origen_fondos)


if  @i_ciudad is null begin
   select @i_ciudad = of_ciudad 
   from cobis..cl_oficina 
   where of_oficina = @w_oficina
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- LGU-ini 10/abr/2017 calcular plazo y fecha de una interciclo
exec @w_return         = sp_emergente_fecha
     @i_toperacion     = @i_toperacion,
     @i_cliente        = @i_cliente,
     @i_fecha_ini      = @i_fecha_ini,
     @i_plazo          = @w_plazo,
     @i_fecha_pri_cuot = null,
     @o_plazo          = @w_plazo           output,
     @o_fecha_pri_cuot = @w_fecha_pri_cuot  output,
     @o_operacionca    = @w_operacionca_grp output

if @w_return <> 0
begin
   print 'creopin.sp: sp_emergente_fecha.sp ... No existen Dividendoa para crear un Emergente ' + cast(@w_error as varchar)
   return @w_return
end
-- LGU-INI: controlar que se creen los interciclos con la parametrizacion del padre
if exists(select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla = 'ca_interciclo' and t.codigo = c.tabla and c.codigo = @i_toperacion)
begin
   select
      @w_periodo_reajuste        = op_periodo_reajuste,
      @w_reajuste_especial       = op_reajuste_especial,
      @w_precancelacion          = op_precancelacion,
      @w_tipo                    = op_tipo,
      @w_cuota_completa          = op_cuota_completa,
      @w_tipo_reduccion          = op_tipo_reduccion,
      @w_aceptar_anticipos       = op_aceptar_anticipos,
      @w_tdividendo              = op_tdividendo,
      @w_periodo_cap             = op_periodo_cap,
      @w_periodo_int             = op_periodo_int,
      @w_gracia_cap              = op_gracia_cap,
      @w_gracia_int              = op_gracia_int,
      @w_dist_gracia             = op_dist_gracia,
      @w_dias_anio               = op_dias_anio,
      @w_tipo_amortizacion       = op_tipo_amortizacion,
      @w_dia_pago                = op_dia_fijo,
      @w_evitar_feriados         = op_evitar_feriados,
      @w_renovacion              = op_renovacion,
      @w_mes_gracia              = op_mes_gracia,
      @w_tipo_aplicacion         = op_tipo_aplicacion,
      @w_tipo_cobro              = op_tipo_cobro,
      @w_reajustable             = op_reajustable,
      @w_base_calculo            = op_base_calculo,
      @w_ult_dia_habil           = op_dia_habil,
      @w_recalcular              = op_recalcular_plazo,
      @w_prd_cobis               = op_prd_cobis,
      @w_tipo_redondeo           = op_tipo_redondeo,
      @w_causacion               = op_causacion,
      @w_convierte_tasa          = op_convierte_tasa,
      @w_tipo_linea              = op_tipo_linea,
      @w_subtipo_linea           = op_subtipo_linea,
      @w_bvirtual                = op_bvirtual,
      @w_extracto                = op_extracto,
      @w_naturaleza              = op_naturaleza,
      @w_pago_caja               = op_pago_caja,
      @w_nace_vencida            = op_nace_vencida,
      @w_calcula_devolucion      = op_calcula_devolucion,
      @w_entidad_convenio        = op_entidad_convenio,
      @w_mora_retroactiva        = op_mora_retroactiva,
      @w_prepago_desde_lavigente = op_prepago_desde_lavigente,

      @i_lin_credito             = op_lin_credito,
      @i_forma_pago              = op_forma_pago,
      @w_dias_aplicar            = op_dias_clausula,
      @i_periodo_crecimiento     = op_periodo_crecimiento,
      @i_tasa_crecimiento        = op_tasa_crecimiento,
      @i_clase_cartera           = op_clase,
      @i_origen_fondos           = op_origen_fondos,
      @i_tipo_empresa            = op_tipo_empresa,
      @i_validacion              = op_validacion,
      @i_fondos_propios          = op_fondos_propios,
      @i_ref_exterior            = op_ref_exterior,
      @i_sujeta_nego             = op_sujeta_nego,
      @i_ref_red                 = op_nro_red,
      @i_reestructuracion        = op_reestructuracion,
      @i_subtipo                 = op_tipo_cambio,
      @i_num_deuda_ext           = op_num_deuda_ext,
      @i_num_comex               = op_num_comex,
      @i_oper_pas_ext            = op_codigo_externo,
      @i_numero_reest            = op_numero_reest,
--      'A'                        = op_tipo_crecimiento,
      @i_banca                   = op_banca,
      @w_tasa_equivalente        = op_usar_tequivalente
   from ca_operacion
   where op_operacion = @w_operacionca_grp
   if @@rowcount = 0 return 710072
   select @w_dias_gracia = max(di_gracia_disp)
   from ca_dividendo
   where di_operacion = @w_operacionca_grp

   select @w_dias_gracia = isnull(@w_dias_gracia, 0)
end
-- LGU-INI: controlar que se creen los interciclos con la parametrizacion del padre
-- LGU-fin 10/abr/2017 calcular plazo y fecha de una interciclo
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/* SE REALIZA LA ASIGNACION DE CLASE DE CARTERA */
if @i_clase_cartera is null begin

      if @i_crea_ext is null
         print 'Clase Cartera en blanco o Clase de Cupo es Null'
      else
         select @o_msg_msv = 'Clase Cartera en blanco o Clase de Cupo es Null'
      return 701065

/* Procedimiento no utilizado por credito en BancaMia
    exec cob_credito..sp_clasif_cartera
    @i_toperacion = @i_toperacion,
    @i_moneda = @i_moneda,
    @i_salida = 'S',
    @i_monto = @i_monto,
    @i_cliente = @i_cliente,  ---EPB:ABR-12-2002
    --@i_tipo = 'O',
    @o_clase_cartera = @w_clase_cartera out

    select @i_clase_cartera = @w_clase_cartera
*/
end


if @i_tramite is null
   select @w_estado = @w_est_novigente
else
   select @w_estado = @w_est_credito

/*OBTENCION DE LOS DIAS DE MI DIVIDENDO PARA DIAS CLAUSULA*/
select @w_dias_dividendo = td_factor
from ca_tdividendo
where td_tdividendo = @w_tdividendo

if @i_no_banco = 'S'
begin
   exec @w_operacionca = sp_gen_sec
   @i_operacion   = -1

   select @w_banco = convert(varchar(20),@w_operacionca)
end
else
begin
   exec @w_return = sp_numero_oper
   @s_date        = @s_date,
   @i_oficina     = @i_oficina,
   @i_tramite     = @i_tramite,
   @o_operacion   = @w_operacionca out,
   @o_num_banco   = @w_banco       out

   if @w_return <> 0 return @w_return
end

/* ACTUALIZAR EL NUMERO DE OPERACION EN LA TABLA TEMPORAL DE CLIENTES */
update ca_cliente_tmp
set clt_operacion = cast(@w_operacionca as varchar)
where clt_user    = @s_user
and   clt_sesion  = @s_sesn

if @@error <> 0 return 710002


/* REGISTRAR LOS CLIENTES INGRESADOS PARA SEGUROS DE VIDA Y COBRO DE COMISION POR CONSULTAS A LA CENTRAL DE RIESGOS */
insert into ca_deu_segvida
select clt_operacion, clt_cliente, clt_rol,
    case clt_rol when 'D' then 'S' else 'N' end,
clt_central_riesgo
from ca_cliente_tmp
where clt_user   = @s_user
and   clt_sesion = @s_sesn

if @@error <> 0 return 710001

select @w_error = 0


select @w_tr_tipo = isnull(tr_tipo,'X')
from cob_credito..cr_tramite
where tr_tramite = @i_tramite

if @@rowcount  = 0
   select @w_tr_tipo = 'X'


/*CONTROL PLAZO LINEA*/

/*
if isnull(@w_tr_tipo,'0') not in ('E','M') and isnull(@i_simulacion,'0') <>  'S' and @i_tipo_tramite <> 'M'
begin
   exec @w_return    = sp_parametros_matriz
   @i_fecha          = @i_fecha_ini,
   @i_toperacion     = @i_toperacion,
   @i_plazo          = @w_plazo,
   @i_tplazo         = @w_tplazo,
   @i_monto_valida   = @i_monto,
   @i_cliente        = @i_cliente,
   @o_msg            = @w_msg   out

   if @w_return <> 0 begin
      if @i_crea_ext is null
         print @w_msg
      else
         select @o_msg_msv = @w_msg
      return @w_return
   end
end
*/


   /* NUEVA RUTINA PARA EL CONTROL DE DIA DE PAGO */
if @i_dia_pago is not null and @i_fecha_fija = 'S'
begin
   select @w_control_dia_pago = 'S'
   select @w_dia_pago = @i_dia_pago
end

if @w_control_dia_pago = 'S' and @w_tipo <> 'C' and @w_tipo <> 'R' and @i_crea_ext = 'S'
begin
   if @w_dia_pago < @w_pa_dimive or @w_dia_pago > @w_pa_dimave
   begin
       /*OBTIENE NUEVO DIA DE PAGO*/
      select @w_dia_pago = datepart(dd, @i_fecha_ini)
      select @w_dia_pago = valor
      from cobis..cl_catalogo
      where tabla = (select codigo from cobis..cl_tabla
                     where tabla = 'ca_dias_vencimiento')
      and  codigo = convert(char(10),@w_dia_pago)
   end
end

---Inc. 00129
if @w_tipo = 'C' or @w_tipo = 'R'
   select @w_dia_pago = datepart(dd, @i_fecha_ini)


    
/* CREAR LA OPERACION TEMPORAL */
exec @w_return                  = sp_operacion_tmp
     @i_operacion               = 'I',
     @i_operacionca             = @w_operacionca,
     @i_banco                   = @w_banco,
     @i_anterior                = @i_anterior,
     @i_migrada                 = @i_migrada,
     @i_tramite                 = @i_tramite,
     @i_cliente                 = @i_cliente,
     @i_nombre                  = @i_nombre,
     @i_sector                  = @i_sector,
     @i_toperacion              = @i_toperacion,
     @i_oficina                 = @i_oficina,
     @i_moneda                  = @i_moneda,
     @i_comentario              = @i_comentario,
     @i_oficial                 = @i_oficial,
     @i_fecha_ini               = @i_fecha_ini,
     @i_fecha_fin               = @i_fecha_ini,
     @i_fecha_ult_proceso       = @i_fecha_ini,
     @i_fecha_liq               = @i_fecha_ini,
     @i_fecha_reajuste          = @i_fecha_ini,
     @i_monto                   = @i_monto,
     @i_monto_aprobado          = @i_monto_aprobado,
     @i_destino                 = @i_destino,
     @i_lin_credito             = @i_lin_credito,
     @i_ciudad                  = @i_ciudad,
     @i_estado                  = @w_estado,
     @i_periodo_reajuste        = @w_periodo_reajuste,
     @i_reajuste_especial       = @w_reajuste_especial,
     @i_tipo                    = @w_tipo, --(Hipot/Redes/Normal)
     @i_forma_pago              = @i_forma_pago,
     @i_cuenta                  = @i_cuenta,
     @i_dias_anio               = @w_dias_anio,
     @i_tipo_amortizacion       = @w_tipo_amortizacion,
     @i_cuota_completa          = @w_cuota_completa,
     @i_tipo_cobro              = @w_tipo_cobro,
     @i_tipo_reduccion          = @w_tipo_reduccion,
     @i_aceptar_anticipos       = @w_aceptar_anticipos,
     @i_precancelacion          = @w_precancelacion,
     @i_tipo_aplicacion         = @w_tipo_aplicacion,
     @i_tplazo                  = @w_tplazo,
     @i_plazo                   = @w_plazo,
     @i_tdividendo              = @w_tdividendo,
     @i_periodo_cap             = @w_periodo_cap,
     @i_periodo_int             = @w_periodo_int,
     @i_dist_gracia             = @w_dist_gracia,
     @i_gracia_cap              = @w_gracia_cap,
     @i_gracia_int              = @w_gracia_int,
     @i_dia_fijo                = @w_dia_pago,
     @i_cuota                   = 0,
     @i_evitar_feriados         = @w_evitar_feriados,
     @i_renovacion              = @w_renovacion,
     @i_mes_gracia              = @w_mes_gracia,
     @i_reajustable             = @w_reajustable,
     @i_dias_clausula           = @w_dias_aplicar,
     @i_periodo_crecimiento     = @i_periodo_crecimiento,
     @i_tasa_crecimiento        = @i_tasa_crecimiento,
     @i_direccion               = @i_direccion,
     @i_clase_cartera           = @i_clase_cartera,
     @i_origen_fondos           = @i_origen_fondos ,
     @i_base_calculo            = @w_base_calculo ,
     @i_ult_dia_habil           = @w_ult_dia_habil ,
     @i_recalcular              = @w_recalcular,
     @i_tipo_empresa            = @i_tipo_empresa,
     @i_validacion              = @i_validacion,
     @i_fondos_propios          = @i_fondos_propios,
     @i_ref_exterior            = @i_ref_exterior,
     @i_sujeta_nego             = @i_sujeta_nego,
     @i_prd_cobis               = @w_prd_cobis,
     @i_ref_red                 = @i_ref_red,
     @i_tipo_redondeo           = @w_tipo_redondeo,
     @i_causacion               = @w_causacion,
     @i_convierte_tasa          = @w_convierte_tasa,
     @i_tasa_equivalente        = @w_tasa_equivalente,
     @i_tipo_linea              = @w_tipo_linea,
     @i_subtipo_linea           = @w_subtipo_linea,
     @i_bvirtual                = @w_bvirtual,
     @i_extracto                = @w_extracto,
     @i_reestructuracion        = @i_reestructuracion,
     @i_subtipo                 = @i_subtipo,
     @i_naturaleza              = @w_naturaleza,
     @i_fec_embarque            = @i_fec_embarque,
     @i_fec_dex                 = @i_fec_dex,
     @i_num_deuda_ext           = @i_num_deuda_ext,
     @i_num_comex               = @i_num_comex,
     @i_pago_caja               = @w_pago_caja,
     @i_nace_vencida            = @w_nace_vencida,
     @i_calcula_devolucion      = @w_calcula_devolucion,
     @i_oper_pas_ext            = @i_oper_pas_ext,
     @i_num_reest               = @i_numero_reest,
     @i_entidad_convenio        = @w_entidad_convenio,
     @i_mora_retroactiva        = @w_mora_retroactiva,
     @i_prepago_desde_lavigente = @w_prepago_desde_lavigente,
     @i_tipo_crecimiento        = 'A',    --AUTOMATICA, NO DIGITAN VALORES DE CAPITAL FIJO, O CUOTA FIJA
     @i_banca                   = @i_banca,
     @i_grupal                  = @i_grupal,        --LRE 05/Ene/2017
     @i_promocion               = @i_promocion,     --LPO Santander
     @i_acepta_ren              = @i_acepta_ren,    --LPO Santander
     @i_no_acepta               = @i_no_acepta,     --LPO Santander
     @i_emprendimiento          = @i_emprendimiento,--LPO Santander
     @i_fecha_pri_cuot          = @w_fecha_pri_cuot, -- LGU 11/abr/2017 para controlar la fecha de primer vencimiento del Grupal-Emergente
	 @i_porcen_colateral        = @w_porcen_colateral,
     @i_desplazamiento          = @w_desplazamiento
--end
--end

select @w_return = @w_error  -- Traslada el posible error de modificacion despues de insercion a temporales

if @w_return <> 0 return @w_return 

/* CREAR LOS RUBROS TEMPORALES DE LA OPERACION */

exec @w_return            = sp_gen_rubtmp
     @s_user              = @s_user,
     @s_date              = @s_date,
     @s_term              = @s_term,
     @s_ofi               = @s_ofi,
     @i_crear_pasiva      = @i_crear_pasiva,
     @i_toperacion_pasiva = @i_toperacion_pasiva,
     @i_operacion_activa  = @i_operacion_activa,
     @i_operacionca       = @w_operacionca ,
     @i_tramite_hijo      = @i_tramite_hijo,
     @i_tasa              = @i_tasa --JSA Santander

if @w_return <> 0
begin
   if @i_crea_ext is null begin
      print 'Error al Ejecurar sp_gen_rubtmp'
      print @w_return
   end
   else
      select @o_msg_msv = 'Error al Ejecurar sp_gen_rubtmp'
   return @w_return
end

/*ACTUALIZA SIGNO Y SPREAD OPERACIONES  QUE UTILIZAN LA MATRIZ DE TASA_MAX Y TASA_MIN */
if  (@i_signo is not null and @i_factor is not null) Begin
    update ca_rubro_op_tmp set
    rot_signo           =  @i_signo,
    rot_factor          =  @i_factor
    where rot_operacion = @w_operacionca
    and   rot_concepto  = @w_concepto_interes

     if @@error <> 0 return 710002
End


/* GENERACION DE LA TABLA DE AMORTIZACION */
exec @w_return           = sp_gentabla
     @i_operacionca      = @w_operacionca,
     @i_actualiza_rubros = 'S',
     @i_tabla_nueva      = 'S',
     @i_control_tasa     = 'C',
     @i_crear_op         = 'S',
     @i_batch_dd         = @i_batch_dd,
     @i_tramite_hijo     = @i_tramite_hijo,
     @i_dias_gracia      = @w_dias_gracia,
     @i_crea_ext         = @i_crea_ext,
     @i_tasa             = @i_tasa, --JSA Santander
     @o_fecha_fin        = @w_fecha_fin out,
     @o_msg_msv          = @o_msg_msv   out

if @w_return <> 0
begin
   if @i_crea_ext is null
      PRINT 'creaopin.sp salio con error de sp_gentabla ' + @o_msg_msv
   else
      select @o_msg_msv = 'creaopin.sp salio con error de sp_gentabla ' +  @o_msg_msv
   return @w_return
end


/*CONTROL DE LA TASA IBC ANTES DE CREAR LA OP*/
select
@w_tasa_aplicar     = rot_referencial,
@w_porcentaje       = rot_porcentaje
from ca_rubro_op_tmp
where rot_operacion = @w_operacionca
and   rot_concepto  = @w_concepto_interes

select @w_tasa_referencial = vd_referencia
from ca_valor_det
where vd_tipo   =  @w_tasa_aplicar
and   vd_sector =  @i_sector

select
@w_modalidad         = tv_modalidad,
@w_periodicidad      = tv_periodicidad
from ca_tasa_valor
where tv_nombre_tasa = @w_tasa_referencial
and tv_estado        = 'V'

exec @w_return         = sp_rubro_control_ibc
     @i_operacionca    = @w_operacionca,
     @i_concepto       = @w_concepto_interes,
     @i_porcentaje     = @w_porcentaje,
     @i_periodo_o      = @w_periodicidad,
     @i_modalidad_o    = @w_modalidad,
     @i_num_periodo_o  = 1

if @w_return <> 0
begin
   if @i_crea_ext is null
      PRINT 'creopin.sp Mensaje Informativo Tasa Total de Interes supera el maximo permitido...'
   else
      select @o_msg_msv = 'creopin.sp Mensaje Informativo Tasa Total de Interes supera el maximo permitido...'
end


/* ACTUALIZAR LA FECHA DE REAJUSTE DE LA OPERACION */
select @w_fecha_reajuste = '01/01/1900'

if isnull(@w_periodo_reajuste,0) <> 0 begin

   if @w_periodo_reajuste % @w_periodo_int = 0
      select @w_fecha_reajuste = dit_fecha_ven
      from   ca_dividendo_tmp
      where  dit_operacion = @w_operacionca
      and    dit_dividendo = @w_periodo_reajuste / @w_periodo_int
   else
      select @w_fecha_reajuste =
      dateadd(dd,td_factor*@w_periodo_reajuste, @i_fecha_ini)
      from ca_tdividendo
      where td_tdividendo = @w_tdividendo
end

update ca_operacion_tmp set
opt_fecha_reajuste  = @w_fecha_reajuste
where opt_operacion = @w_operacionca

if @@error <> 0 return 710002

select
@w_fecha_f = convert(varchar(10),@w_fecha_fin,@i_formato_fecha),
@o_banco   = @w_banco

if @i_salida = 'S' begin
   if @i_crea_ext is null
   begin
      select @w_banco
      select @w_fecha_f
      select es_descripcion from ca_estado where es_codigo = 0
      select @w_tipo
      select @i_sector

      select  c.valor
      from  cobis..cl_tabla t, cobis..cl_catalogo c
      where c.tabla = t.codigo      
      and   t.tabla = 'cr_clase_cartera'
      and c.codigo = ltrim(rtrim(@i_clase_cartera))      
      select @w_rowcount = @@rowcount
   end
   else
   begin
      select  @w_rowcount = count(1)
      from  cobis..cl_tabla t, cobis..cl_catalogo c
      where c.tabla = t.codigo      
      and   t.tabla = 'cr_clase_cartera'
      and c.codigo = ltrim(rtrim(@i_clase_cartera))      
   end
   if @w_rowcount = 0 return 710218
end

/*PROCESAMIENTO OPERACION NACE VENCIDA*/
select @w_nace_vencida = opt_nace_vencida
from ca_operacion_tmp
where opt_operacion = @w_operacionca

if @@rowcount = 0 return 701002


if @w_nace_vencida = 'S' begin

   update ca_operacion_tmp set
   opt_fecha_fin = opt_fecha_ini
   where opt_operacion = @w_operacionca

   if @@error <> 0 return 701002

   update ca_dividendo_tmp set
   dit_fecha_ven = dit_fecha_ini
   where dit_operacion = @w_operacionca

   if @@error <> 0 return 705043

   update ca_amortizacion_tmp set
   amt_acumulado = amt_cuota
   where amt_operacion = @w_operacionca

   if @@rowcount = 0 return 705022


   /** CANCELACION DEL INTERES **/
   update ca_amortizacion_tmp set
   amt_pagado    = 0,
   amt_acumulado = 0,
   amt_cuota     = 0,
   amt_estado    = @w_est_cancelado
   where amt_operacion = @w_operacionca
   and   amt_concepto  = @w_concepto_interes

   if @@rowcount = 0 return 705022

end

return 0

go

