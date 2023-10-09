/************************************************************************/
/*   Archivo:              sp_modificar_ope_int_busin.sp                */
/*   Stored procedure:     sp_modificar_ope_int_busin                   */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             cob_pac                                      */
/*   Disenado por:         Ruperado de Base datos                       */
/*   Fecha de escritura:   May 2017                                     */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/* 17-09-2020        Sonia Rojas          Req #140073                   */
/************************************************************************/

USE cob_pac
go

IF OBJECT_ID ('sp_modificar_ope_int_busin') IS NOT NULL
    DROP PROC sp_modificar_ope_int_busin
GO

create proc sp_modificar_ope_int_busin
        @s_user                 login        = NULL,
        @s_sesn                 int          = NULL,
        @s_ofi                 int          = NULL,
        @s_date                 datetime     = NULL,
        @s_term                 varchar(30)  = NULL,
        @i_calcular_tabla       char(1)      = 'N',
        @i_tabla_nueva          char(1)      = 'S',
        @i_operacionca          int          = NULL,
        @i_banco                cuenta       = NULL,
        @i_anterior             cuenta       = NULL,
        @i_migrada              cuenta       = NULL,
        @i_tramite              int          = NULL,
        @i_cliente              int          = NULL,
        @i_nombre               descripcion  = NULL,
        @i_sector               catalogo     = NULL,
        @i_toperacion           catalogo     = NULL,
        @i_oficina              smallint     = NULL,
        @i_moneda               tinyint      = NULL,
        @i_comentario           varchar(255) = NULL,
        @i_oficial              smallint     = NULL,
        @i_fecha_ini            datetime     = NULL,
        @i_fecha_fin            datetime     = NULL,
        @i_fecha_ult_proceso    datetime     = NULL,
        @i_fecha_liq            datetime     = NULL,
        @i_fecha_reajuste       datetime     = NULL,
        @i_monto                money        = NULL,
        @i_monto_aprobado       money        = NULL,
        @i_destino              catalogo     = NULL,
        @i_lin_credito          cuenta       = NULL,
        @i_ciudad               smallint     = NULL,
        @i_estado               tinyint      = NULL,
        @i_periodo_reajuste     smallint     = NULL,
        @i_reajuste_especial    char(1)      = NULL,
        @i_tipo                 char(1)      = NULL,
        @i_forma_pago           catalogo     = NULL,
        @i_cuenta               cuenta       = NULL,
        @i_dias_anio            smallint     = NULL,
        @i_tipo_amortizacion    varchar(10)  = NULL,
        @i_cuota_completa       char(1)      = NULL,
        @i_tipo_cobro           char(1)      = NULL,
        @i_tipo_reduccion       char(1)      = NULL,
        @i_aceptar_anticipos    char(1)      = NULL,
        @i_precancelacion       char(1)      = NULL,
        @i_operacion            char(1)      = NULL,
        @i_tipo_aplicacion      char(1)      = NULL,
        @i_tplazo               catalogo     = NULL,
        @i_plazo                int          = NULL,
        @i_tdividendo           catalogo     = NULL,
        @i_periodo_cap          int          = NULL,
        @i_periodo_int          int          = NULL,
        @i_dist_gracia          char(1)      = NULL,
        @i_gracia_cap           int          = NULL,
        @i_gracia_int           int          = NULL,
        @i_dia_fijo             int          = NULL,
        @i_cuota                money        = NULL,
        @i_evitar_feriados      char(1)      = NULL,
        @i_num_renovacion       int          = NULL,
        @i_renovacion           char(1)      = NULL,
        @i_mes_gracia           tinyint      = NULL,
        @i_formato_fecha        int          = 101,
        @i_upd_clientes         char(1)      = NULL,
        @i_dias_gracia          smallint     = NULL,
        @i_reajustable          char(1)      = NULL,
        @i_salida               char(1)      = 'S',   --Muestra datos al frontend
        @i_fijo_desde           int          = NULL,  --JG Y BP
        @i_fijo_hasta           int          = NULL,  --JG Y BP
        @i_cta_certificado      varchar(24)  = null,
        @i_cta_ahorro            varchar(24)  = null,
        @i_tipo_bloqueo            char(1)      = null,
        @i_clase_bloqueo        char(1)      = null,
        @i_activa_TirTea        char(1)         = 'S',       --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA
        @i_doble_alicuota       char(1)      = null,
        @i_alicuota_aho         varchar(10)  = null,
        @i_alicuota             varchar(10)  = null,
        @i_actividad_destino    catalogo     = null, -- LGU ini 27.03.2002
        @i_compania             int          = null,
        @i_tipo_cca             catalogo     = null, -- LGU fin 09.04.2002
        @i_reaj_diario          char(1)      = null,
        @i_seg_cre              catalogo     = null, -- SRA SEGMENTO CREDITO 14/09/2007
        @i_prodbanc_aho         smallint     = NULL,  --PRON:14NOV07 prod bancario para simulacion
        @i_prodbanc_cer         smallint     = NULL,  --PRON:14NOV07 prod bancario para simulacion
        @i_base_dias_int        char(1)      = NULL,  --PRON:9JUL08
        @i_p_cuota        money         = null,  --cll REQ-956 Obligaciones Financieras
        @i_es_interno           char(1)      = 'N',   --N = No es un programa interno, se llama desde frontend, 'S'= es un llamada desde otro sp
        @i_fecha_redescuento    datetime     = null,  --APE REQ-2400 Aumento del campo fecha de redescuento en la fgenamor de cartera
        @i_entra_fecha_redes    char(1)      = 'S',   --PRON
        @i_parroquia            catalogo     = null,
        @i_base_calculo         char(1)      = null,        
		@i_desplazamiento       int          = null,          --SRO 140073
        @o_cta_ahorro           varchar(24)  = null output,  --PRON:28AGO06
        @o_cta_certificado      varchar(24)  = null output,  --PRON:28AGO06
        --Variables de output Implantación Originador CPN
        @o_tea                  float        = null output,
        @o_tir                  float        = null output,
        @o_plazo                int          = null output,
        @o_tplazo               catalogo     = null OUTPUT,
        @o_cuota                money        = null output
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_error                int,
        @w_fecha_reajuste       datetime,
        @w_fecha_fin            datetime,
        @w_fecha_ini            datetime,
        @w_fecha_f              char(10),
        @w_num_dec              tinyint,
        @w_dias_gracia          int,
        @w_monto_tmp            money,
        @w_monto_aprobado_tmp   money,
        @w_fijo_desde           smallint,
        @w_fijo_hasta           smallint,
        @w_consulta             char(1),
        @w_cta_certificado      cuenta,
        @w_cta_ahorro           cuenta,
        @w_monto_min            money,
        @w_monto_max            money,
        @w_old_tipo_cca         catalogo,
        @w_op_estado            smallint,
        @w_filas_rec            int,
        @w_toperacion           catalogo,
        @w_moneda               tinyint,
        @w_doble_alicuota       char(1),
        @w_valida_bloqueos      char(1),
        @w_clase_bloqueo        char(1),
        @x_doble_alicuota       char(1),
        @x_cliente              int,
        @w_cliente              int,
        @w_est_novigente        tinyint,
        @w_est_credito          tinyint,
        @w_seg_cre              varchar(10),
        @w_programa             varchar(40),
        @w_valor_minimo         money,
        @w_valor_maximo         money,
        @w_tipo_cca             catalogo,
        @w_tipo_cca_seg         catalogo,
        @w_grupo_financiero     varchar(10), --cll REQ-956 Obligaciones Financieras
        @w_calcooperativa     varchar(10),
        @w_calcliente         varchar(10),
        -- LGU-INI 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO
        @w_fecha_pri_cuot    datetime,
        -- LGU-FIN 12/ABR/2017 CONTROL DE DIAS DE LA PRIMERA CUOTA - INTERCICLO
        @w_promocion          char(1),
        @w_porcen_colateral   float

-- CARGAR VALORES INICIALES
select @w_sp_name       = 'sp_modificar_ope_int_busin',
       @w_fijo_desde    = @i_fijo_desde,
       @w_fijo_hasta    = @i_fijo_hasta,
       @w_est_novigente = 0,
       @w_est_credito   = 99,
       @i_activa_TirTea = isnull(@i_activa_TirTea, 'S')  --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA


if @i_operacionca is NULL
begin
   select @i_operacionca      = opt_operacion,
          @w_toperacion       = opt_toperacion,
          @w_moneda           = opt_moneda,
          @i_cliente          = opt_cliente,
      --    @w_doble_alicuota   = opt_doble_alicuota,
          @w_cliente          = opt_cliente,
          @w_op_estado        = opt_estado,
       --   @w_seg_cre          = opt_seg_cre,
        --  @w_tipo_cca = opt_tipo_cca,
        ---  @w_grupo_financiero = opt_grupo_financiero, --cll REQ-956 Obligaciones Financieras
          --@w_calcliente       = opt_calcliente, --CLL RFD-0122
         -- @w_calcooperativa   = opt_calcooperativa
         @w_promocion = opt_promocion,
         @w_porcen_colateral = opt_margen_redescuento
   from   cob_cartera..ca_operacion_tmp
   where  opt_banco = @i_banco
end
else
   select @w_toperacion     = opt_toperacion,
          @w_moneda         = opt_moneda,
          @i_cliente          = opt_cliente,
         -- @w_doble_alicuota = opt_doble_alicuota,
          @w_cliente        = opt_cliente,
          @w_op_estado      = opt_estado,
          @w_promocion      = opt_promocion,
         -- @w_seg_cre        = opt_seg_cre,
          --@w_tipo_cca       = opt_tipo_cca,
          --@w_grupo_financiero = opt_grupo_financiero --cll REQ-956 Obligaciones Financieras
         @w_porcen_colateral = opt_margen_redescuento
   from   cob_cartera..ca_operacion_tmp
   where  opt_operacion = @i_operacionca

--select @w_old_tipo_cca = op_tipo_cca
--from   cob_cartera..ca_operacion
--where  op_operacion = @i_operacionca

select @w_filas_rec = @@rowcount

if @w_op_estado in (@w_est_novigente, @w_est_credito)
   select @w_filas_rec =1
else
  if (@i_tipo_cca != @w_old_tipo_cca) and @w_filas_rec != 0
  begin
     if @i_tipo_cca != null
        print 'No puede modificar el Tipo de Cartera'
     select @i_tipo_cca = @w_old_tipo_cca
  end

/*  PRON:12SEP2008 Se aumenta por actualizacion de Obligaciones Financieras que no manejan
                   tipo de cartera, ni segmento de credito */
if @i_tipo_cca <> '-'
   select @i_tipo_cca = isnull(@i_tipo_cca,@w_tipo_cca)
else
   select @i_tipo_cca = null

if @i_seg_cre <> '-'
    select @i_seg_cre = isnull(@i_seg_cre,@w_seg_cre)
else
   select @i_seg_cre = null
/*  PRON:12SEP2008*/

 select @w_monto_min = dt_monto_min,
        @w_monto_max = dt_monto_max
       -- @w_clase_bloqueo = dt_clase_bloqueo      --PRON:28AGO06
 from   cob_cartera..ca_default_toperacion
 where  dt_toperacion = @w_toperacion
 and    dt_moneda     = @w_moneda


-- VALIDACION DEL MONTO APROBADO
if isnull(@i_monto_aprobado,0) > 0 begin
   if isnull(@w_monto_min,0) > 0 or isnull(@w_monto_max,0) > 0
   begin
      if @i_monto_aprobado < @w_monto_min or @i_monto_aprobado > @w_monto_max
         return 710124
   end
end

-- PRON:28AGO06:Valida Obligatoriedad de los bloqueos
select @w_valida_bloqueos = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'VBLO'

select @w_valida_bloqueos = isnull(@w_valida_bloqueos,'S')
select @x_doble_alicuota= isnull(@i_doble_alicuota, @w_doble_alicuota)
select @x_cliente=  isnull(@i_cliente,0)

if @w_valida_bloqueos = 'S' and @x_cliente <> 0
begin
   --Si la  clase de bloqueo por defecto es distinta a NO APLICA
   -- Verifica si el bloqueo por operacion esta como No aplica
   if @w_clase_bloqueo <> 'N' and @x_doble_alicuota = 'E'
      return 710130
end

if @w_cliente = -666
   select @i_cliente = @w_cliente

-- MODIFICAR LA OPERACION TEMPORAL

--print 'antes de cob_cartera..sp_operacion_tmp @i_sector --< '+@i_sector + 'CLIENTE  ' + convert(varchar, @i_cliente)

-- LGU-ini 10/abr/2017 calcular plazo y fecha de una interciclo
exec @w_return = cob_cartera..sp_emergente_fecha
    @i_toperacion     = @i_toperacion,
    @i_cliente        = @i_cliente,
    @i_fecha_ini      = @i_fecha_ini,
    @i_plazo          = @i_plazo,
    @i_fecha_pri_cuot = null,
    @o_plazo          = @i_plazo          output,
    @o_fecha_pri_cuot = @w_fecha_pri_cuot output

if @w_return <> 0
begin
    print 'modificar_oper_int_busin.sp: sp_emergente_fecha.sp ... No existen Dividendo' + cast(@w_return as varchar)
    return @w_return
end


 exec @w_return = cob_cartera..sp_operacion_tmp
      @s_user              = @s_user,
      @s_sesn              = @s_sesn,
      @s_date              = @s_date,
      @i_operacion         = 'U',
      @i_operacionca       = @i_operacionca ,
      @i_banco             = @i_banco ,
      @i_anterior          = @i_anterior,
      @i_migrada           = @i_migrada,
      @i_tramite           = @i_tramite,
      @i_cliente           = @i_cliente,
      @i_nombre            = @i_nombre,
      @i_sector            = @i_sector,
      @i_toperacion        = @i_toperacion,
      @i_oficina           = @i_oficina,
      @i_moneda            = @i_moneda,
      @i_comentario        = @i_comentario,
      @i_oficial           = @i_oficial,
      @i_fecha_ini         = @i_fecha_ini,
      @i_fecha_fin         = @i_fecha_ini,
      @i_fecha_ult_proceso = @i_fecha_ini,
      @i_fecha_liq         = @i_fecha_ini,
      @i_fecha_reajuste    = @i_fecha_ini,
      @i_monto             = @i_monto,
      @i_monto_aprobado    = @i_monto_aprobado,
      @i_destino           = @i_destino,
      @i_lin_credito       = @i_lin_credito,
      @i_ciudad            = @i_ciudad,
      @i_estado            = @i_estado,
      @i_periodo_reajuste  = @i_periodo_reajuste,
      @i_reajuste_especial = @i_reajuste_especial,
      @i_tipo              = @i_tipo, --(Hipot/Redes/Normal)
      @i_forma_pago        = @i_forma_pago,
      @i_cuenta            = @i_cuenta,
      @i_dias_anio         = @i_dias_anio,
      @i_tipo_amortizacion = @i_tipo_amortizacion,
      @i_cuota_completa    = @i_cuota_completa,
      @i_tipo_cobro        = @i_tipo_cobro,
      @i_tipo_reduccion    = @i_tipo_reduccion,
      @i_aceptar_anticipos = @i_aceptar_anticipos,
      @i_precancelacion    = @i_precancelacion,
      @i_tipo_aplicacion   = @i_tipo_aplicacion,
      @i_tplazo            = @i_tplazo,
      @i_plazo             = @i_plazo,
      @i_tdividendo        = @i_tdividendo,
      @i_periodo_cap       = @i_periodo_cap,
      @i_periodo_int       = @i_periodo_int,
      @i_dist_gracia       = @i_dist_gracia,
      @i_gracia_cap        = @i_gracia_cap,
      @i_gracia_int        = @i_gracia_int,
      @i_dia_fijo          = @i_dia_fijo,
      @i_cuota             = @i_cuota,
      @i_evitar_feriados   = @i_evitar_feriados,
      @i_renovacion        = @i_renovacion,
      @i_mes_gracia        = @i_mes_gracia,
      @i_reajustable       = @i_reajustable,
      @i_dias_clausula     = null,
      --@i_periodo_crecimiento = @i_periodo_crecimiento,
      --@i_tasa_crecimiento   = @i_tasa_crecimiento,
      --@i_direccion          = @i_direccion,
      --@i_clase_cartera      = @i_clase_cartera,
      --@i_origen_fondos      = @i_origen_fondos ,
      @i_base_calculo       = @i_base_calculo,--'E' ,
      --@i_ult_dia_habil      = @i_ult_dia_habil ,
      @i_recalcular         = null,
      @i_tipo_empresa       = 1,
      --@i_validacion         = @i_validacion,
      --@i_fondos_propios     = @i_fondos_propios,
      --@i_ref_exterior       = @i_ref_exterior,
      --@i_sujeta_nego        = @i_sujeta_nego,
      --@i_prd_cobis          = @i_prd_cobis,
      --@i_ref_red            = @i_ref_red,
      --@i_tipo_redondeo      = @i_tipo_redondeo,
      --@i_causacion          = @i_causacion,
      --@i_convierte_tasa     = @i_convierte_tasa,
      --@i_tasa_equivalente   = @i_tasa_equivalente,
      --@i_tipo_linea         = @i_tipo_linea,
      --@i_subtipo_linea      = @i_subtipo_linea,
      --@i_bvirtual           = @i_bvirtual,
      --@i_extracto           = @i_extracto,
      --@i_reestructuracion   = @i_reestructuracion,
      --@i_subtipo            = @i_subtipo,
      --@i_naturaleza         = @i_naturaleza,
      --@i_fec_embarque       = @i_fec_embarque,
      --@i_fec_dex            = @i_fec_dex,
      --@i_num_deuda_ext      = @i_num_deuda_ext,
      --@i_num_comex          = @i_num_comex,
      --@i_pago_caja          = @i_pago_caja,
      --@i_nace_vencida       = @i_nace_vencida,
      --@i_calcula_devolucion = @i_calcula_devolucion,
      --@i_oper_pas_ext       = @i_oper_pas_ext,
      --@i_num_reest          = @i_numero_reest,
      --@i_entidad_convenio   = @i_entidad_convenio,
      --@i_mora_retroactiva   = @i_mora_retroactiva,
      --@i_prepago_desde_lavigente = @i_prepago_desde_lavigente,
      @i_tipo_crecimiento        = 'A',    --AUTOMATICA, NO DIGITAN VALORES DE CAPITAL FIJO, O CUOTA FIJA
      --@i_banca                   = @i_banca
      @i_fecha_pri_cuot          = @w_fecha_pri_cuot, -- LGU 11/abr/2017 para controlar la fecha de primer vencimiento del Grupal-Emergente
      @i_porcen_colateral        = @w_porcen_colateral,
	  @i_desplazamiento          = @i_desplazamiento
	  
      if @w_return != 0  return @w_return

-- DIAS DE GRACIA CUANDO LLAMO DESDE RUBROS
select @w_dias_gracia =dit_gracia
  from cob_cartera..ca_dividendo_tmp
 where dit_operacion = @i_operacionca
   and dit_dividendo = 1

if @i_dias_gracia is NULL
   select @i_dias_gracia = isnull(@w_dias_gracia,0)

select @i_seg_cre = isnull(@i_seg_cre,@w_seg_cre)
if @i_calcular_tabla = 'N' and @w_op_estado in (@w_est_novigente, @w_est_credito)  --AOL 13JUN07
begin
     if @w_seg_cre <> @i_seg_cre        --Si cambia el segmento de credito PRON:20SEP07
     begin
       select @i_calcular_tabla = 'S'

       /* 5MAY08 VALIDACION DE SEGMENTOS   */
       select @w_programa     = st_programa,
              @w_valor_minimo = st_valor_minimo,
              @w_valor_maximo = st_valor_maximo,
              @w_tipo_cca_seg = st_tipo_cca
       from   cob_cartera..ca_segcred_tipocca
       where  st_seg_cred = @i_seg_cre
       and    st_tipo_cca = @i_tipo_cca

       -- VALIDA QUE EL SEGMENTO DE CREDITO CORRESPONDA AL TIPO DE CARTERA
       if @@rowcount = 0 and @i_tipo <> 'R'
          return 710174

       if @w_programa is not null
       begin

          if not exists (select 1 from cob_cartera..sysobjects where name = @w_programa)
             return 707075
          select @w_programa = 'cob_cartera..' + @w_programa
          print 'antes de ejecutar: %1!'+ @w_programa
          exec @w_return      = @w_programa
               @i_operacionca = @i_operacionca,
               @i_monto_min   = @w_valor_minimo,
               @i_monto_max   = @w_valor_maximo,
               @i_tipo_cca    = @w_tipo_cca_seg,
               @i_temporal    = 'S'

          if @w_return != 0
            return @w_return
       end

       -- Cambia los valores de los rubros interes e imo de la operacion
          print 'antes de ejecutar: cob_cartera..sp_gen_rubtmp'
       exec @w_return = cob_cartera..sp_gen_rubtmp
        @s_user        = @s_user,
        @s_term        = @s_term,
        @s_date        = @s_date,
        @i_operacionca = @i_operacionca,
        @i_cambia_int  = 'S'

        if @w_return != 0  return @w_return
     end
     else
     begin
         --PRON:14NOV06 Rubros con tasas por rangos y cuyos parametros requieren del tipo de cartera,
         --             deben regenerar tabla.
         if exists(select 1 from cob_cartera..ca_rubro, cob_cartera..ca_rubro_op_tmp--, cob_cartera..ca_parametro_tasa
                   where ru_toperacion = @w_toperacion
                   and   ru_moneda     = @w_moneda
                  -- and   isnull(ru_porc_rango,'N') = 'S'
                   and   rot_operacion = @i_operacionca
                   and   rot_concepto  = ru_concepto
                 /*  and   pt_concepto   = rot_concepto
                   and   pt_xtipo_cca  = 'S'*/)
            select @i_calcular_tabla = 'S'
     end
end

if @i_calcular_tabla = 'S'
begin

          print 'antes de ejecutar: cob_cartera..sp_gentabla'

   exec @w_return = cob_cartera..sp_gentabla
        @i_operacionca = @i_operacionca,
        @i_tabla_nueva = @i_tabla_nueva,
        @i_dias_gracia = @i_dias_gracia,
        @i_promocion   = @w_promocion,
        @o_fecha_fin   = @w_fecha_fin out,
        @o_cuota       = @o_cuota     out,
        @o_plazo       = @o_plazo     out,
        @o_tplazo      = @o_tplazo out

   if @w_return != 0  return @w_return



   -- ACTUALIZACION DE LA OPERACION
   if isNULL(@i_periodo_reajuste,0) != 0
   begin
      select @w_fecha_reajuste = min(re_fecha)
      from   cob_cartera..ca_reajuste
      where  re_operacion = @i_operacionca
      and    re_fecha    >= @i_fecha_ult_proceso

      select @w_fecha_reajuste = isnull(@i_fecha_reajuste,@w_fecha_reajuste)
   end
   else
      select @w_fecha_reajuste = '01/01/1900'

   -- CONTROL DEL MONTO SEA MENOR O IGUAL AL MONTO APROBADO
   select @w_monto_tmp          = opt_monto,
          @w_monto_aprobado_tmp = opt_monto_aprobado,
          @w_fecha_ini          = opt_fecha_ini
   from   cob_cartera..ca_operacion_tmp
   where  opt_banco = @i_banco

   if @w_monto_tmp > @w_monto_aprobado_tmp
      return 710024

   update cob_cartera..ca_operacion_tmp
      set opt_fecha_fin      = @w_fecha_fin,
          opt_fecha_reajuste = @w_fecha_reajuste,
          opt_plazo          = @o_plazo, --JG NOV.98
          opt_tplazo         = @o_tplazo --JG NOV.98
    where opt_operacion = @i_operacionca

   if @@error != 0 return 710002

   --ojo DISPLAYA DATOS AL FRONTEND DESDE LA PANTALLA FGENAMORTIZACION
   if @i_salida = 'S'
   begin
      select @w_fecha_f  = convert(varchar(10),@w_fecha_fin,@i_formato_fecha)

      select @w_fecha_f,     --1
             @o_cuota,
             @o_plazo,       --3
             @o_tplazo,
             td_descripcion  --5
      from   cob_cartera..ca_tdividendo
      where  td_tdividendo = @o_tplazo
   end
end

select @w_fecha_ini = opt_fecha_ini
from   cob_cartera..ca_operacion_tmp
where  opt_operacion = @i_operacionca

select @i_fecha_ini = isnull(@i_fecha_ini, @w_fecha_ini)

-- ANTES DE SALIR CALCULO LOS RUBROS ANTICIPADOS
-- PRON:22NOV06 Recalcular los rubros anticipados para prestamos no activos
/*
if @w_op_estado in (@w_est_novigente, @w_est_credito) or @w_cliente = -666  --SIMULACION
begin

          print 'antes de ejecutar: cob_cartera..sp_calcular_anticipados'
   exec @w_return = cob_cartera..sp_calcular_anticipados
      @i_operacionca = @i_operacionca,
      @i_fecha       = @i_fecha_ini,
      @i_opcion      = 'U'

   if @w_return != 0 return @w_return
end
*/
--PRON:14NOV07 Calcula la TEA solo en simulacion
if @w_cliente = -666  --SIMULACION
begin
   if (@i_prodbanc_aho is not null) or (@i_prodbanc_cer is not null)   --No se envia este dato desde la pantalla de forma de pago
   begin

          print 'antes de ejecutar: cob_cartera..sp_TIR_TEA'
  /*   exec @w_return = cob_cartera..sp_TIR_TEA
          @s_user                 = @s_user, --CLL SPRINT 7
      @s_date                 = @s_date,
      @s_term                 = @s_term,
          @s_ofi                  = @s_ofi,
          @i_operacionca     = @i_operacionca,
          @i_fecha           = @i_fecha_ini,
          @i_calcula_TEA     = 'S',
          @i_valida_maxima   = 'S',
          @i_temporal        = 'S',
          @i_prodbanc_aho    = @i_prodbanc_aho,
          @i_activa_TirTea     = @i_activa_TirTea,     --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA
          @i_prodbanc_cer    = @i_prodbanc_cer,
          @o_tir             = @o_tir out,
          @o_tea             = @o_tea out
    */
      SELECT @o_tea  = 0.0
      SELECT @o_tir  = 0.0
     if @w_return != 0 return @w_return
   end
end
else
begin
   --PRON:12MAY08 Se incorpora el calculo del TEA cada vez que se calcula la tabla en operaciones aun NO desembolsadas
   if @i_calcular_tabla = 'S' and @i_es_interno = 'N' and (@w_op_estado in (@w_est_novigente, @w_est_credito))
   begin

          print 'antes de ejecutar: cob_cartera..sp_TIR_TEA'
   /*   exec @w_return = cob_cartera..sp_TIR_TEA
             @s_user                 = @s_user, --CLL SPRINT 7
       @s_date                 = @s_date,
       @s_term                 = @s_term,
           @s_ofi                  = @s_ofi,
           @i_operacionca     = @i_operacionca,
           @i_fecha           = @i_fecha_ini,
           @i_calcula_TEA     = 'S',
           @i_valida_maxima   = 'S',
           @i_activa_TirTea      = @i_activa_TirTea,     --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA
           @i_temporal        = 'S',
           @o_tir             = @o_tir out,     --Personalización Originador CPN
           @o_tea             = @o_tea out
      */

       SELECT @o_tea  = 0.0
       SELECT @o_tir  = 0.0
       IF @o_cuota is NULL
              SELECT @o_cuota  = @i_cuota
       ELSE
              SELECT @o_cuota

      if @w_return != 0 return @w_return
   end
end

return 0
go

