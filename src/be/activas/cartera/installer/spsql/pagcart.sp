/************************************************************************/
/*      Archivo:                pagcart.sp                              */
/*      Stored procedure:       sp_pago_cartera                         */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Z.BEDON                                 */
/*      Fecha de escritura:     Ene. 1998                               */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                           PROPOSITO                                  */
/*      Ingreso de abonos                                               */
/*      S: Seleccion de negociacion de abonos automaticos               */
/*      Q: Consulta de negociacion de abonos automaticos                */
/*      I: Insercion de abonos                                          */
/*      U: Actualizacion de negociacion de abonos automaticos           */
/*      D: Eliminacion de negociacion de abonos automaticos             */
/************************************************************************/
/*                                              MODIFICACIONES          */
/*      FECHA                   AUTOR           RAZON                   */
/*      Enero 1998       Z.Bedon            Emision Inicial             */
/* Febrero 7/2002        E.Laguna           Personalizacion errores     */
/*      May-2006         Ivan Jimenez IFJ   REQ 455 - Control de Pagos  */
/*                                          Operaciones Alternas        */
/* Junio 6/2006          Ivan Jimenez       NR 296                      */
/* Enero 18/2012         Javier Rocha       Req. 300                    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_pago_cartera')
   drop proc sp_pago_cartera
go


create proc sp_pago_cartera
   @s_user                 login       = NULL,
   @s_term                 varchar(30) = NULL,
   @s_date                 datetime    = NULL,
   @s_sesn                 int         = NULL,
   @s_ssn                  int,
   @s_srv                  varchar(30),
   @s_ofi                  smallint    = NULL,
   @i_banco                cuenta,
   @i_secuencial           int         = NULL,
   @i_beneficiario         descripcion,
   @i_fecha_vig            datetime    = NULL,
   @i_ejecutar             char(1)     = 'S',
   @i_retencion            smallint    = 0,
   @i_en_linea             char(1)     = 'S',
   @i_producto             catalogo    = NULL,
   @i_monto_mpg            money       = 0,
   @i_cuenta               cuenta      = NULL,
   @i_moneda               tinyint     = 0,
   @i_hora_tandem          varchar(8)  = NULL,
   @i_dividendo            smallint    = 0,
   @i_tipo_dpf             char(1)     = NULL,  /* 'C'=CANCELACION 'R'=REVERSA  */
   @i_fecha_vendpf         datetime    = NULL,  /* Fecha de Vencimiento del DPF */
   @i_cheque               int         = null,
   @i_cod_banco            catalogo    = null,
   @i_tipo_cobro           catalogo    = null, 
   @i_tipo_reduccion       char(1)     = null,
   @i_pago_ext             char(1)     = 'N',   ---req 0309
   @i_sec_desem_renova     int         = null,
   @i_pago_gar_grupal      char(1)     = 'N',
   @i_referencia_pr        VARCHAR(64) = NULL,-- LGU, Por precancelacion grupal
   @o_secuencial_ing       int         = NULL out,
   @o_msg_matriz           descripcion = NULL out  --Req. 300
   as
   declare
   @w_sp_name              descripcion,
   @w_return               int,
   @w_est_vigente          tinyint,
   @w_est_no_vigente       tinyint,
   @w_est_vencido          tinyint,
   @w_est_mora             tinyint,
   @w_est_cancelado        tinyint,
   @w_operacionca          int,
   @w_monto                money,
   @w_moneda               tinyint,
   @w_fecha_ini            datetime,
   @w_toperacion           catalogo,
   @w_secuencial           int,
   @w_estado               tinyint,
   @w_fecha_ult_proceso    datetime,
   @w_cuota_completa       char(1),
   @w_aceptar_anticipos    char(1),
   @w_tipo_reduccion       char(1),
   @w_retencion            tinyint,
   @w_tipo_cobro           char(1),
   @w_tipo_aplicacion      char(1),
   @w_prioridad            tinyint,
   @w_cotizacion_mpg       money,
   @w_tcotizacion_mop      char(1),
   @w_tcotizacion_mpg      char(1),
   @w_fecha                datetime,
   @w_pago_atx             char(1),
   @w_secuencial_ing       int,
   @w_concepto_aux         catalogo,
   @w_valor                varchar(20),
   @w_procedimiento        descripcion,
   @w_numero_recibo        int,
   @w_tipo                 char(1),
   @w_div_vigente          smallint,
   @w_valor_rubro          money,
   @w_concepto             catalogo,
   @w_num_dec              smallint,
   @w_moneda_nacional      smallint,
   @w_tcot_moneda          char(1),
   @w_beneficiario         char(50),
   @w_monto_mop            money,
   @w_monto_mn             money,
   @w_cot_moneda           float,
   @w_moneda_op            smallint,
   @w_num_periodo_d        smallint,
   @w_periodo_d            catalogo,
   @w_valor_pagado         money,
   @w_fecha_proceso        datetime,
   @w_valor_dia_rubro      money,
   @w_dias_div             int,
   @w_di_fecha_ven         datetime,
   @w_dias_faltan_cuota    int,
   @w_devolucion           money,
   @w_monto_max            money,
   @w_fecha_ven_op         datetime,
   @w_cotizacion_hoy       money,
   @w_prepago_desde_lavigente char(1),
   @w_monto_mpg               money,
   @w_parametro_control     catalogo,      -- NR 296
   @w_dias_retencion        smallint,      -- NR 296
   @w_error						     int,
   @w_operacion_alterna     int,        -- IFJ 455
   @w_num_dec_op            smallint,    -- IFJ 455
   @w_rowcount              int,
   @w_monto_seg             money   -- LGU, precancelacion grupales hijas

   /*  NOMBRE DEL SP Y FECHA DE HOY */
   select  @w_sp_name = 'sp_pago_cartera'

   /** LECTURA DE CA_ESTADO **/
   select
   @w_est_mora       = 2,
   @w_est_no_vigente = 0,
   @w_est_vigente    = 1,
   @w_est_vencido    = 2,
   @w_est_cancelado  = 3


   select @w_moneda_nacional = pa_tinyint
   from cobis..cl_parametro
   where pa_producto = 'ADM'
   and   pa_nemonico = 'MLO'
   set transaction isolation level read uncommitted

   /* LECTURA DE LA OPERACION VIGENTE */
   /***********************************/

   select @w_tipo_reduccion   = @i_tipo_reduccion

   select
   @w_operacionca             = op_operacion,
   @w_moneda                  = op_moneda,
   @w_monto                   = op_monto,
   @w_fecha_ini               = op_fecha_ini,
   @w_toperacion              = op_toperacion,
   @w_estado                  = op_estado,
   @w_fecha_ult_proceso       = op_fecha_ult_proceso,
   @w_cuota_completa          = op_cuota_completa,
   @w_aceptar_anticipos       = op_aceptar_anticipos,
   @w_tipo_cobro              = isnull(@i_tipo_cobro,op_tipo_cobro),
   @w_tipo_aplicacion         = op_tipo_aplicacion,
   @w_tipo                    = op_tipo,
   @w_num_periodo_d           = op_periodo_int,
   @w_periodo_d               = op_tdividendo,
   @w_fecha_ven_op            = op_fecha_fin,
   @w_prepago_desde_lavigente = op_prepago_desde_lavigente,
   @w_tipo_reduccion          = isnull(@i_tipo_reduccion, op_tipo_reduccion)
   from  ca_operacion, ca_estado
   where op_banco       = @i_banco
   and   op_estado      = es_codigo
   and   es_acepta_pago = 'S'

   if @@rowcount = 0 return 701025

   /* DETERMINAR EL VALOR DE COTIZACION DEL DIA / MONEDA OPERACION*/
   /***************************************************************/

   select 
   @w_cotizacion_hoy = 1.0,
   @w_cotizacion_mpg = 1.0
	  
   if @w_moneda != @w_moneda_nacional begin
      exec sp_buscar_cotizacion
      @i_moneda     = @w_moneda,
      @i_fecha      = @w_fecha_ult_proceso,
      @o_cotizacion = @w_cotizacion_hoy output
	  
	  /* VALOR COTIZACION MONEDA DE PAGO */
	  /***********************************/
	  exec sp_buscar_cotizacion
	  @i_moneda     = @i_moneda,
	  @i_fecha      = @w_fecha_ult_proceso,
	  @o_cotizacion = @w_cotizacion_mpg output
   
   end

   /* RETENCION DE LA FORMA DE PAGO */
   /*********************************/

   select @w_retencion = isnull(cp_retencion,0)
   from   ca_producto
   where  cp_categoria = @i_producto
   and    cp_moneda    = @i_moneda

   select @w_retencion = isnull(@w_retencion,0)

   /* GENERAR EL SECUENCIAL DE INGRESO */
   /************************************/
   if @i_secuencial is null
      exec @w_secuencial_ing = sp_gen_sec
      @i_operacion           = @w_operacionca
   else
      select @w_secuencial_ing = @i_secuencial

   select
   @o_secuencial_ing = @w_secuencial_ing,
   @w_numero_recibo  = @w_secuencial_ing

   /* MONTO MN */
   select @w_monto_mpg = @i_monto_mpg * @w_cotizacion_mpg

   /* INSERCION DE CA_ABONO */
   /*************************/

   insert into ca_abono
   (
   ab_operacion,          ab_fecha_ing,                 ab_fecha_pag,            ab_cuota_completa,
   ab_aceptar_anticipos,  ab_tipo_reduccion,            ab_tipo_cobro,           ab_dias_retencion_ini,
   ab_dias_retencion,     ab_estado,                    ab_secuencial_ing,       ab_secuencial_rpa,
   ab_secuencial_pag,     ab_usuario,                   ab_terminal,             ab_tipo,
   ab_oficina,            ab_tipo_aplicacion,           ab_nro_recibo,           ab_tasa_prepago,
   ab_dividendo,          ab_prepago_desde_lavigente)
   values
   (
   @w_operacionca,        @i_fecha_vig,                 @i_fecha_vig,            @w_cuota_completa,
   @w_aceptar_anticipos,  @w_tipo_reduccion,            @w_tipo_cobro,           @w_retencion,
   @w_retencion,          'ING',                        @w_secuencial_ing,       0,
   0,                     @s_user,                      @s_term,                 'PAG',
   @s_ofi,                @w_tipo_aplicacion,           @w_numero_recibo,        0,
   @i_dividendo,          @w_prepago_desde_lavigente)

   if @@error <> 0
      return 710294

   if @i_pago_gar_grupal = 'N'
   begin
      /* INSERCION DE CA_DET_ABONO  */
      /******************************/
      insert into ca_abono_det
      (
      abd_secuencial_ing,    abd_operacion,                abd_tipo,                 abd_concepto,
      abd_cuenta,            abd_beneficiario,             abd_monto_mpg,            abd_monto_mop,
      abd_monto_mn,          abd_cotizacion_mpg,           abd_cotizacion_mop,       abd_moneda,
      abd_tcotizacion_mpg,   abd_tcotizacion_mop,          abd_cheque,               abd_cod_banco)
      values
      (
      @w_secuencial_ing,     @w_operacionca,               'PAG',                    @i_producto,
      @i_cuenta,             isnull(@i_beneficiario,''),   @i_monto_mpg,             isnull(@i_monto_mpg/@w_cotizacion_hoy,0),
      @w_monto_mpg,          @w_cotizacion_mpg,            @w_cotizacion_hoy,        @i_moneda,
      'N',                   'N',                          @i_cheque,                @i_cod_banco)

      if @@error <> 0 return 710295

      if isnull(@i_referencia_pr,'') <> ''
      begin
          select @w_monto_seg = 0
          select @w_monto_seg = pr_monto_seg
          from ca_precancela_refer
          where pr_operacion = @w_operacionca
          and pr_secuencial  = (select max(prd_secuencial)
                                from   ca_precancela_refer_det
                                where  prd_operacion  = @w_operacionca
                                and    prd_referencia = @i_referencia_pr)
          select @w_monto_seg = isnull(@w_monto_seg, 0)

          if @w_monto_seg > 0 and exists(select 1 from ca_seguro_externo where se_operacion = @w_operacionca and se_estado = 'S') -- Se cruza con el valor del pago del seguro
          begin
              insert into ca_abono_det
              (
              abd_secuencial_ing,    abd_operacion,                abd_tipo,                 abd_concepto,
              abd_cuenta,            abd_beneficiario,             abd_monto_mpg,            abd_monto_mop,
              abd_monto_mn,          abd_cotizacion_mpg,           abd_cotizacion_mop,       abd_moneda,
              abd_tcotizacion_mpg,   abd_tcotizacion_mop,          abd_cheque,               abd_cod_banco)
              values
              (
              @w_secuencial_ing,     @w_operacionca,               'PAG',                    'DEV_SEG',
              @i_cuenta,             isnull(@i_beneficiario,''),   @w_monto_seg,             isnull(@w_monto_seg/@w_cotizacion_hoy,0),
              @w_monto_seg,          @w_cotizacion_mpg,            @w_cotizacion_hoy,        @i_moneda,
              'N',                   'N',                          @i_cheque,                @i_cod_banco)

              if @@error <> 0 return 710295
          end
      end
   end
   else
   begin

      insert into ca_abono_det
      (
      abd_secuencial_ing,    abd_operacion,                abd_tipo,                 abd_concepto,
      abd_cuenta,            abd_beneficiario,             abd_monto_mpg,            abd_monto_mop,
      abd_monto_mn,          abd_cotizacion_mpg,           abd_cotizacion_mop,       abd_moneda,
      abd_tcotizacion_mpg,   abd_tcotizacion_mop,          abd_cheque,               abd_cod_banco)
      select
      @w_secuencial_ing,     @w_operacionca,               'PAG',                    @i_producto,
      dp_garantia,           isnull(@i_beneficiario,''),   dp_monto,                 isnull(dp_monto/@w_cotizacion_hoy,0),
      dp_monto,                 @w_cotizacion_mpg,            @w_cotizacion_hoy,        @i_moneda,
      'N',                   'N',                          @i_cheque,                @i_cod_banco
	  from #detalle_pagos
	  where dp_operacion = @w_operacionca

      if @@error <> 0 return 710295
   end


   ---NR 296
   ---Si la forma de pago es la parametrizada por el usuario CHLOCAL
   ---y el credito es clase O rotativo, se debe colocar unos dias de retencion al
   -- Pago apra que solo se aplique pasado este tiempo

   select  @w_parametro_control =  pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'FPCHLO'
   and pa_producto = 'CCA'
   set transaction isolation level read uncommitted

   if @w_tipo = 'O' and @i_producto =  @w_parametro_control
   begin
      select  @w_dias_retencion =  pa_smallint
      from    cobis..cl_parametro
      where   pa_nemonico = 'DCHLO'
      and     pa_producto = 'CCA'

      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

      if @w_rowcount = 0
         select  @w_dias_retencion = 0

      update ca_abono
      set    ab_dias_retencion      = @w_dias_retencion,
             ab_dias_retencion_ini  = @w_dias_retencion
      where  ab_operacion           = @w_operacionca
      and    ab_secuencial_ing      = @w_secuencial_ing

      select @i_retencion = @w_dias_retencion
   end
   --- NR 296

   /* INSERTAR PRIORIDADES */
   insert into ca_abono_prioridad (
   ap_secuencial_ing, ap_operacion,ap_concepto, ap_prioridad)
   select
   @w_secuencial_ing, @w_operacionca,ro_concepto, ro_prioridad
   from  ca_rubro_op
   where ro_operacion =  @w_operacionca
   and   ro_fpago not in ('L','B')

   if @@error <> 0
      return 710001

   /*-- Inicio IFJ 455
   Select @w_operacion_alterna = oa_operacion_alterna
   From  ca_operacion_alterna
   Where oa_operacion_original = @w_operacionca

   If @@rowcount <> 0
   Begin
     exec @w_error = sp_decimales
          @i_moneda       = @w_moneda,
          @o_decimales    = @w_num_dec_op out

     if @w_error <> 0
         return  @w_error

     exec sp_dividir_pago_alterna
          @i_operacion_original = @w_operacionca,
          @i_operacion_alterna  = @w_operacion_alterna,
          @i_secuencial_ing     = @w_secuencial_ing,
          @i_num_dec            = @w_num_dec_op

     if @w_error <> 0
         return  @w_error
   End
   -- Fin IFJ 455
   */

   /*CREACION DEL REGISTRO DE PAGO*/
   if (datediff(dd,@i_fecha_vig,@w_fecha_ult_proceso) = 0 and  (@i_ejecutar = 'S'))   --Aplicar en linea
   begin
      exec @w_return    = sp_registro_abono
      @s_user           = @s_user,
      @s_term           = @s_term,
      @s_date           = @s_date,
      @s_ofi            = @s_ofi,
      @s_sesn           = @s_sesn,
      @s_ssn            = @s_ssn,
      @i_secuencial_ing = @w_secuencial_ing,
      @i_en_linea       = @i_en_linea,
      @i_fecha_proceso  = @i_fecha_vig,
      @i_operacionca    = @w_operacionca,
      /*@i_banco          = @i_banco,
      @i_tipo_dpf       = @i_tipo_dpf,   --P.Fijo*/
      @i_cotizacion     = @w_cotizacion_hoy

      if @w_return <> 0
         return @w_return

      /** APLICACION EN LINEA DEL PAGO SIN RETENCION **/

      if @i_retencion = 0
      begin
         exec @w_return = sp_cartera_abono
         @s_user           = @s_user,
         @s_term           = @s_term,
         @s_date           = @s_date,
         @s_sesn           = @s_sesn,
         @s_ofi            = @s_ofi,
         @i_secuencial_ing = @w_secuencial_ing,
         @i_fecha_proceso  = @i_fecha_vig,
         @i_en_linea       = @i_en_linea,
         @i_operacionca    = @w_operacionca,
         @i_cotizacion     = @w_cotizacion_hoy,
         @i_pago_ext       = @i_pago_ext,
         @i_sec_desem_renova = @i_sec_desem_renova,
         @i_cuenta_aux     = @i_cuenta,   --RENOVACION
         @o_msg_matriz     = @o_msg_matriz          --Req. 300

         if @w_return <> 0
            return @w_return
      end --retencion
   end

   return 0

go
