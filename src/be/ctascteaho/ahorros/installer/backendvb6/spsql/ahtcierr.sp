/************************************************************************/
/*  Archivo:                ahtcierr.sp                                 */
/*  Stored procedure:       sp_cierre_ctah                              */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura:     18-Feb-1993                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de cierre de cuentas           */
/*  de ahorros.                                                         */
/*  213 = Cierre de cuentas de ahorros                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  05/Mar/1993 P. Mena         Emision inicial                         */
/*  26/Abr/1999 J. Gordillo     Parametro Dias del Anio                 */
/*  28/Abr/1999 J. Gordillo     Insercion de Trx. Monetarias            */
/*  30/Abr/1999 V. Molina       Determinacion del bloqueo tanto         */
/*                              de Valores como de movimientos          */
/*  17/Jun/1999 V. Molina       Cobro del IDB                           */
/*  23/Ago/1999 J. Salazar      Division de la transaccion monetaria en */
/*                              capitalizacion y retencion.             */
/*  25/Ago/1999 J. Salazar      Correccion del calculo del promedio     */
/*                              disponible y promedio1.                 */
/*  09/Sep/1999 J. Salazar      Insercion de IDB en tran_serv           */
/*  26/Dic/2002 C. Milan        Recalculo int sobre saldo minimo        */
/*  08/Abr/2005 D. Villagomez   No se acreditan intereses               */
/*                              provisionados, se reversan              */
/*  06/May/2006 P. Coello       Considerar estado en la                 */
/*                              pf_det_pago                             */
/*  27/Jun/2006 P. Coello       Limpiar campo de interes                */
/*                              acumulado e interes del mes             */
/*  30/Jun/2006 R. Ramos        No cerrar cuenta si esta asociada a un  */
/*                              convenio activo                         */
/*  01/Ago/2006 P. Coello       Insertar Transaccion de servicio por    */
/*                              cierre de la cuenta                     */
/*  10/Ene/2007 R. Ramos        Enviar alerta si la cuenta canc.        */
/*                              tiene servicio deb. autom visa          */
/*   19/MAR/2007P. Coello       ENVIO DE PARAMETRO PARA INCIDAR         */
/*                              SI SE COBRA O NO LA 3 POR CIE           */
/*                              RRE ANTICIPADO                          */
/*   18/Mar/2010 C. Munoz       Tipos de Entrega de Fondos por          */
/*                              Cierre de Cuenta                        */
/*   03/Abr/2012 L. Moreno      Desmarcacion cuenta GMF en cancelacion  */
/*   16/Abr/2013 J. Colorado    Reintegro de GMF ALIANZA                */
/*   02/May/2016 J. Calderon    Migración a CEN                         */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cierre_ctah')
  drop proc sp_cierre_ctah
go

create proc sp_cierre_ctah
(
  @s_ssn                int,
  @s_srv                varchar(30) = null,
  @s_user               varchar(30) = null,
  @s_sesn               int,
  @s_term               varchar(10),
  @s_date               datetime,
  @s_org                char(1),
  @s_ofi                smallint = 1,/* Localidad origen transaccion */
  @s_rol                smallint = 1,
  @s_ssn_branch         int=null,
  @s_lsrv               smallint = null,--ojo cmu                      
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(32) = null,
  @t_rty                char(1) = 'N',
  @t_trn                smallint,
  @t_ejec               char(1) = null,
  @t_show_version       bit = 0,
  @i_oficina            smallint,
  @i_cta                cuenta,
  @i_mon                tinyint,
  @i_sldlib             money,
  @i_val                money,
  @i_nctrl              smallint,
  @i_orden              char(1),
  @i_causa              char(3),
  @i_aut                descripcion,

  -- lgr decir a ena que desde branch no se envia esto                         
  @i_turno              smallint = null,
  @i_filial             tinyint = 1,
  @i_sld_caja           money = 0,
  @i_idcierre           int = 0,
  @i_idcaja             int = 0,
  @i_ctatrn             cuenta = null,

  -- Nro de cuenta para la transf de cierre                            
  @i_producto           varchar(3) = null,

  -- Tipo de cuenta para la transf de cierre                            
  @i_tadmin             tinyint = 0,

  -- Diferencia el cierre desde caja o term adminis                       
  @i_fcancel            char(1) =null,

  -- Forma de cancelación T=transferencia C=cheque                        
  @i_cobra              tinyint = 0,
  @i_observacion        varchar(120) = null,
  @i_observacion1       varchar(120) = null,
  @i_cobra_multa_ant    char(1) = 'S',

  --  PCO COBRAR MULTA POR CIERRE ANTICIPADO O NO                       
  @i_canal              smallint = 4,
  @i_srv                varchar(64) = null,
  @o_sldcont            money out,
  @i_codbene            int = null,
  @i_ejec_marca         char(1) = 'S',

  -- Parametro para saber si ejecuta o no el llamado desmarcacion GMF 
  @i_gmf_reintegro      money,
  @o_cliente            int = null out,
  @o_slddisp            money out,
  @o_sldint             money out,
  @o_control            int out,
  @o_nombre             varchar(30) out,
  @o_int_cap            money out,
  @o_impuesto           money out,
  @o_multa              money out,
  @o_prod_banc          smallint = null out,
  @o_categoria          char(1) = null out,
  @o_monto_imp          money = null out,
  @o_monto_imp_ret      money = null out,
  @o_tipo_exonerado_imp char(2) = null out,
  @o_tipocta_super      char(1) = null out,
  @o_clase_clte         char(1) = null out,
  @o_sldmantval         money = 0 out,

  --Saldo por Mantenimiento de valor                                 
  @o_sldint1            money = 0 out,--premio ctas de navidad    
  @o_multa1             money = 0 out,

  --penalizacion ctas de navidad                                     
  @o_idlote             int = null out,
  @o_secuencial         int = null out,
  @o_valir              money = 0 out,
  @o_int_perdido        money = null out,
  @o_indicador          tinyint = null out,
  @o_gmf_valcie         money = null out,
  @o_gmf_reitengro_cie  money = null out
)
as
  declare
    @w_return              int,
    @w_sp_name             varchar(30),
    @w_date                varchar(10),
    @w_cuenta              int,
    @w_est                 char(1),
    @w_filial              tinyint,
    @w_linea               smallint,
    @w_num_bloqueos        smallint,
    @w_tipo_prom           char(1),
    @w_alicuota            float,
    @w_tot_alic            float,
    @w_numdeci             tinyint,
    @w_numdeci_imp         tinyint,
    @w_secuencial          int,
    @w_saldo_libreta       money,
    @w_saldo_contable      money,
    @w_saldo_para_girar    money,
    @w_usadeci             char(1),
    @w_personalizada       char(1),
    @w_rol_ente            char(1),
    @w_tipo_def            char(1),
    @w_prod_banc           smallint,
    @w_producto            tinyint,
    @w_moneda              tinyint,
    @w_tipo                char(1),
    @w_aut                 descripcion,
    @w_numrg               int,
    @w_default             int,
    @w_categoria           char(1),
    @w_valor_impuesto      money,
    @w_val_cierre          money,
    @w_valcie              money,
    @w_promedio1           money,
    @w_sldint              money,
    @w_saldo_min_mes       money,
    @w_tipo_ente           char(1),
    @w_fec_aper            datetime,
    @w_dias                smallint,
    @w_dia                 tinyint,
    @w_dias_mes            tinyint,
    @w_ofi_cta             smallint,
    @w_diferencia_fechas   smallint,
    @w_rubro               varchar(5),
    @w_retencion           char(1),
    @w_ente                int,
    @w_tasa_interes        float,
    @w_mes                 varchar(2),
    @w_anio                varchar(4),
    @w_primer              varchar(10),
    @w_primer_fecha        datetime,
    @w_dias_anio           smallint,
    @w_tipo_bloqueo        char(3),
    @w_monto_bloq          money,
    @w_mensaje             mensaje,
    @w_monto_imp           money,
    @w_monto_imp_multa     money,
    @w_monto_imp_retiro    money,
    @w_monto_imp_retencion money,
    @w_retiro              money,
    -- @w_tasa_imp           float,                                       
    @w_prom_disponible     money,
    @w_monto_max_dev       float,
    @w_unidad_trib         money,
    @w_monto_max_idb       money,
    @w_monto_imp_total     money,
    @w_tipo_atributo       char(1),
    @w_sucursal            smallint,
    @w_int_mes             money,
    @w_dias_mes_act_tipoDE tinyint,
    @w_ult_dia_mes         datetime,
    @w_mes_sig             datetime,
    @w_mes_sigc            varchar(10),
    @w_dia_pri             varchar(10),
    @w_tipo_rango          tinyint,
    @w_mercado             smallint,
    @w_servicio_dis        smallint,
    @w_servicio_per        int,
    @w_pro_final           smallint,
    @w_monto               money,
    @w_sldmantval          money,
    @w_msg                 descripcion,
    @w_monto_emb           money,
    @w_nombre              descripcion,
    @w_cliente             int,
    @w_idlote              int,
    @w_trn                 int,
    @w_cau                 char(3),
    @w_sp                  char(40),
    @w_cod_prdnav          smallint,
    @w_cuota               money,
    @w_multa               money,
    @w_num_cuopre          tinyint,
    @w_val22               money,
    @w_ssn                 int,
    @w_disponible2         money,
    @w_mencta              varchar(60),
    @w_comision_imp_renta  float,
    @w_impuesto            char(1),
    @w_promedio            money,
    @w_resultado           int,
    @w_ah_monto_emb        money,
    @w_oficina             int,
    --PCOELLO GRABAR oficina EN TRN DE SERVICIO                                   
    @w_clase_clt           char(1),
    @w_cta_banco           cuenta,
    @w_num_orden           int,
    @w_error               int,
    @w_ente_b              int,
    @w_nomlar_b            varchar(50),
    @w_tipo_ced_b          char(3),
    @w_ced_ruc_b           varchar(13),
    @w_ente_c              int,
    @w_nomlar_c            varchar(50),
    @w_tipo_ced_c          char(3),
    @w_ced_ruc_c           varchar(13),
    @w_campo1              varchar(20),
    @w_campo3              varchar(20),
    @w_codigo_pais         catalogo,
    @w_fecha_ult_capi      datetime,
    @w_dias_prx_mes        tinyint,
    @w_binc                money,
    @w_base_rtfte          money,
    @w_cpto_rte            char(4),
    @w_tasa_imp            float,
    @w_cpto_rteica         char(4),
    @w_imp2                money,
    @w_tasa_imp_gral       float,
    @w_fecha               datetime,
    @w_dias_capi           smallint,
    @w_exento              char(1),
    @w_porcentaje          float,
    @w_tasa_impuesto       float,
    @w_tasa_imp_usado      float,
    @w_tipo_exonerado_imp  char(2),
    @w_total_gmf           money,
    @w_base_gmf            money,
    @w_acumu_deb           money,
    @w_actualiza           char(1),
    @w_ciudad_rte_ica      int,
    @w_tasa_reteica        float,
    @w_valor_reteica       money,
    @w_total_interes       money,
    @w_disponible          money,
    @w_contable            money,
    @w_fecha_ult_mov       datetime,
    @w_fecha_ult_mov_int   datetime,
    @w_estado              char(1),
    @w_trn_code            int,
    @w_saldo_interes_ir    money,
    @w_tipocta_super       char(1),
    @w_creditos            money,
    @w_creditos_hoy        money,
    @w_debitos             money,
    @w_debitos_hoy         money,
    @w_monto_ult_capi      money,
    @w_campo6              char(3),
    @w_campo7              varchar(40),
    @w_base_gmf_retencion  money,
    @w_base                money,
    @w_imp_retencion       money,
    @w_base_gmf_reteica    money,
    @w_imp_reteica         money,
    @w_gmfmarca            char(1),
    @w_debug               char(1),
    @w_gmf_valcie          money,
    @w_tasa                float,
    @w_pais                varchar(10),
    @w_banco               varchar(10),
    --                            
    @w_com_iva             char(1),
    @w_imp_gmf             char(1),
    @w_accion              char(1),
    @w_impuesto_iva        money,
    @w_impuesto_gmf        money,
    @w_timpuesto           float,
    @o_valiva              money,
    @w_concto_iva          char(4),
    @w_piva                float,
    @w_totval              money,
    --                            
    @w_causa               char(3),
    @w_cliente_b           int,
    @w_clase_clte_b        char(1),
    @w_gmfbco              money,
    @w_tasagmf             float,
    @w_es_contractual      char(1),
    @w_interes_con         money,-- REQ 217 Intereses Contractual     
    @w_interes_acum        money,
    -- REQ 217 Intereses acumulados no capitalizados                            
    @w_porc_tiempo         float,-- REQ 217 Porcentaje Tiempo Cumplido
    @w_cant_plazos         smallint,
    -- REQ 217 Cantidad de Plazos Contractual                                   
    @w_interes_con_tot     money,
    -- REQ 217 Total de Intereses con multa                                    
    @w_camcat              varchar(2),-- REQ 217 Categoria Normal Contractual
    @w_par_prod_cont       int,
    @w_gmfconcepto         smallint,-- REQ 315 Marcacion GMF Linea
    @w_cauciina            varchar(10),
    @w_cauegina            varchar(10),
    @w_gmf_reitengro_cie   money,
    @w_tasa_reintegro      float,
    @w_valor_cal           money

  select
    @w_sp_name = 'sp_cierre_ctah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  select
    @w_idlote = 0,
    @w_gmf_reitengro_cie = 0,
    @i_aut = isnull(@i_aut,
                    @s_user),
    @w_tasa_imp = 0,
    @w_debug = 'N'

  -- Captura del nombre del Stored Procedure                                    
  select
    @w_sp_name = 'sp_cierre_ctah'
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_sldlib = @i_sldlib,
      i_val = @i_val,
      i_nctrl = @i_nctrl,
      i_orden = @i_orden,
      i_causa = @i_causa,
      i_aut = @i_aut
    exec cobis..sp_end_debug
  end

  select
    @w_tasa_imp = 0,
    @w_monto_imp = 0,
    @w_monto_imp_retencion = 0,
    @w_monto_imp_multa = 0,
    @w_monto_imp_retiro = 0

  select
    @w_monto_max_idb = 0 -- lgr                                          

  -- Encuentra dias del anio para provision diaria interes                      
  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    return 205031
  end

  -- Encuentra parametro de decimales                                           
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'

    select
      @w_numdeci_imp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DIM'
       and pa_producto = 'AHO'

  end
  else
    select
      @w_numdeci = 0,
      @w_numdeci_imp = 0

  select
    @w_valcie = round(@i_val,
                      @w_numdeci)

  /* REQ 217 PARAMETRO CATEGORIA NORMAL AHO CONTRACTUAL */
  select
    @w_camcat = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'CAMCAT'

  /* REQ 217 PARAMETRO PRODUCTO AHO CONTRACTUAL */
  select
    @w_par_prod_cont = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PAHCT'

  if @t_trn <> 213
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  -- Validacion para que la cuenta de ahorros no tenga operaciones de DPF pendientes                                   
  if exists(select
              dp_cuenta
            from   cob_pfijo..pf_det_pago,
                   cob_pfijo..pf_fpago,
                   cob_pfijo..pf_operacion
            where  dp_cuenta     = @i_cta
               and dp_forma_pago = fp_mnemonico
               and fp_producto   = 4
               and dp_operacion  = op_operacion
               and op_estado in ('ING', 'ACT', 'XACT')
               and dp_estado     <> 'E' --PCOELLO CAMBIAR IGUAL POR NO IGUAL 
           )
  begin
    /* Cuenta vinculada con operacion de Plazo Fijo */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 258005
    return 1
  end

  -- Validacion para que la cuenta no tenga operaciones de Cartera pendientes   
  exec @w_return = cob_interfase..sp_icar_valida_cuenta_cca
    @s_ssn       = @s_ssn,
    @s_ssn_branch= @s_ssn_branch,
    @s_term      = @s_term,
    @s_date      = @s_date,
    @s_org       = @s_org,
    @s_ofi       = @s_ofi,
    @s_rol       = @s_rol,
    @t_trn       = @t_trn,
    @i_cuenta    = @i_cta,
    @i_producto  = 4,
    @o_cuenta    = @w_resultado out

  if @w_resultado = 1
      or @w_return <> 0 /* Si existe un producto asociado con Cartera */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201305
    return 1
  end

  -- Validacion para que la cuenta no tenga operaciones de Garantias pendientes 
  exec @w_return = cob_interfase..sp_icus_valida_cuenta_gar
    @s_ssn       = @s_ssn,
    @s_ssn_branch= @s_ssn_branch,
    @s_term      = @s_term,
    @s_date      = @s_date,
    @s_org       = @s_org,
    @s_ofi       = @s_ofi,
    @s_rol       = @s_rol,
    @t_trn       = @t_trn,
    @i_cuenta    = @i_cta,
    @i_producto  = 4,
    @o_cuenta    = @w_resultado out

  if @w_resultado = 1
      or @w_return <> 0 /* Si existe un producto asociado con Garantias */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201307
    return 1
  end

  if exists (select
               1
             from   cob_credito..cr_linea
             where  li_num_banco = @i_cta
                and li_estado    <> 'CAN')
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 207066
    --PCOELLO CUENTAS SE ENCUENTRA RELACIONADA A LINEA DE CREDITO                           
    return 1
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  select
    @w_gmfmarca = eg_marca,
    @w_gmfconcepto = eg_concepto
  from   cob_ahorros..ah_exenta_gmf
  where  eg_cta_banco = @i_cta
     and eg_marca     = 'S'

  if @w_gmfmarca is null
    select
      @w_gmfmarca = 'N'

  if @w_gmfmarca = 'S'
    print
'Cuenta marcada con exoneracion de GMF. Por favor diligenciar Formato de Desmarcacion de Cuenta'

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @o_control = ah_control,
    @w_linea = ah_linea,
    @w_saldo_libreta = ah_saldo_libreta,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @w_monto_bloq = ah_monto_bloq,
    @w_tipo_ente = ah_tipocta,
    @w_sldmantval = ah_saldo_mantval,
    @w_monto_emb = ah_monto_emb,
    @w_nombre = ah_nombre,
    @w_cliente = ah_cliente,
    @w_ah_monto_emb = ah_monto_emb,
    @o_tipocta_super = ah_tipocta_super,
    @o_clase_clte = ah_clase_clte,
    @w_oficina = ah_oficina
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon
  if @@rowcount = 0
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 251001
  end

  select
    @o_cliente = @o_cliente

  if @w_tipo_ente = 'I'
  begin
    select
      1
    from   cob_ahorros..ah_oficina_ctas_cifradas
    where  oc_oficina = @s_ofi
       and oc_estado  = 'V'
    if @@rowcount = 0
    begin
      -- Oficina no autorizada para cuentas cifradas                            
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251081
      return 251081
    end
  end

  -- VALORES EMBARGADOS         
  if @w_ah_monto_emb > 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201315
    return 201315

  end
  /* Determina el tipo de bloqueo */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @w_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('1', '2', '3')

  if @@rowcount <> 0
  begin
    select
      @w_mensaje = rtrim(valor)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_tbloqueo')
       and codigo = @w_tipo_bloqueo
    if @@rowcount = 0
    begin /** Tipo Bloqueo No Identificado **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @t_from,
        @i_num   = 251025
      return 251025
    end
    else
    begin
      select
        @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251007,
        @i_sev   = 1,
        @i_msg   = @w_mensaje
      return 251007
    end
  end

  if exists (select
               1
             from   cob_ahorros..ah_embargo
             where  he_cta_banco = @i_cta
                and he_fecha_lev is null)
  begin
    select
      @w_msg = '[' + @w_sp_name + ']' + ' LA CUENTA TIENE VALORES EN EMBARGO'
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @t_from,
      @i_num   = 251025,
      @i_msg   = @w_msg

    return 251025
  end

  /*Determina el bloqueo de valores */

  if @w_monto_bloq > 0
      or @w_monto_emb > 0
  begin
    /* Existe Bloqueo o Embargo de Valores */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251076
    return 251076
  end

  if @i_nctrl <> @o_control
     and @i_tadmin = 0
  begin
    /* Numero de Control Errado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251004
    return 251004
  end

  if @w_linea <> 0
  begin
    update cob_ahorros..ah_cuenta
    set    ah_linea = 0
    where  ah_cuenta = @w_cuenta
  end

/*------------------------------------------------------------------------------*/
/* debe marcarse todas las lineas pendientes en estado canceladas por el cierre */
/* para que no reimprimir lineas despues de una reapertura en otra libreta  */
  /*------------------------------------------------------------------------------*/
  if exists(select
              1
            from   cob_ahorros..ah_linea_pendiente
            where  lp_cuenta = @w_cuenta)
  begin
    update cob_ahorros..ah_linea_pendiente
    set    lp_enviada = 'C'
    where  lp_cuenta = @w_cuenta
  end

  if @i_sldlib <> @w_saldo_libreta
     and @i_tadmin = 0
  begin
    /* Numero de Control Errado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251005
    return 251005
  end

  --Busqueda de Pais            
  select
    @w_codigo_pais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @@rowcount = 0
  begin
    /** No existe parametro de pais local **/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101190
    return 101190
  end

  -- Parametros para nuevas opciones Entrega de dinero, CMU -BPT- REQ016 BANCAMIA                                      
  select
    @w_binc = isnull(pa_money,
                     0)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'BINCR'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN PARAMETRO DE BASE DIARIA'
    return 201196
  end

  -- Tasa de Impuesto           
  select
    @w_tasa_imp_gral = pa_float
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'TIDB'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido tasa de impuesto */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE TASA DE IMPUESTO'
    return 205031
  end

  if @w_codigo_pais = 'CO'
  begin
    if exists (select
                 1
               from   cob_ahorros..ah_val_suspenso
               where  vs_procesada = 'N'
                  and vs_cuenta    = @w_cuenta)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251074
      return 251074
    end
  end

  if @i_aut is null
  begin
    /* Oficial no puede ser nulo */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101036
    return 101036
  end

  select
    @w_aut = lower(@i_aut)

  if not exists (select
                   fu_funcionario
                 from   cobis..cl_funcionario
                 where  fu_login = @w_aut)
  begin
    /* No existe funcionario autorizante */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101036
    return 101036
  end

  /* Transaccion de cierre a la cuenta */
  if @t_trn = 213
  begin
    select
      @w_date = convert(varchar(10), @s_date, 101)

    -- Calculo del saldo contable de la cuenta                                 
    exec @w_return = cob_ahorros..sp_ahcalcula_saldo
      @t_debug            = @t_debug,
      @t_file             = @t_file,
      @t_from             = @w_sp_name,
      @i_cuenta           = @w_cuenta,
      @i_fecha            = @w_date,
      @o_saldo_para_girar = @w_saldo_para_girar out,
      @o_saldo_contable   = @w_saldo_contable out
    if @w_return <> 0
      return @w_return

    select
      @w_sldint = ah_saldo_interes,
      @w_tipo_prom = ah_tipo_promedio,
      @o_slddisp = ah_disponible,
      @o_int_cap = ah_interes_ganado,
      @o_nombre = substring(ah_nombre,
                            1,
                            30),
      @w_promedio1 = ah_promedio1,
      @w_rol_ente = ah_rol_ente,
      @w_tipo_def = ah_tipo_def,
      @w_default = ah_default,
      @w_personalizada = ah_personalizada,
      @w_prod_banc = ah_prod_banc,
      @w_producto = ah_producto,
      @w_moneda = ah_moneda,
      @w_tipo = ah_tipo,
      @w_fec_aper = ah_fecha_aper,
      @w_categoria = ah_categoria,
      @w_ofi_cta = ah_oficina,
      @w_ente = ah_cliente,
      @w_saldo_min_mes = ah_min_dispmes,
      @w_prom_disponible = ah_prom_disponible,
      @w_monto_imp_total = ah_monto_imp,
      @w_int_mes = ah_int_mes,
      @w_sldmantval = ah_saldo_mantval,
      @w_cuota = ah_cuota,
      @w_clase_clt = ah_clase_clte,
      @w_cta_banco = ah_cta_banco,
      @w_fecha_ult_capi = ah_fecha_ult_capi
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta
       and ah_moneda = @i_mon

    select
      @o_cliente = @w_ente
    select
      @o_sldint = isnull(@w_sldint,
                         0)
    select
      @o_multa = isnull(@o_multa,
                        0)
    select
      @o_clase_clte = @w_clase_clt

    if @w_saldo_contable <> @o_slddisp
    begin
      /* Cuenta con Retenciones */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251059
      return 251059
    end

    /* REQ 217 AHORRO CONTRACTUAL*/
    if exists (select
                 1
               from   cob_remesas..re_cuenta_contractual
               where  cc_cta_banco = @i_cta
                  and cc_estado    = 'A')
      select
        @w_es_contractual = 'S'
    else
      select
        @w_es_contractual = 'N'

    /*CALCULA SALDO MINIMO */
    if @w_saldo_min_mes = -1
    begin
      if @o_slddisp >= 0
        select
          @w_saldo_min_mes = @o_slddisp
      else
        select
          @w_saldo_min_mes = 0
    end
    else if @o_slddisp < @w_saldo_min_mes
      select
        @w_saldo_min_mes = @o_slddisp

    if @w_codigo_pais = 'CO'
    begin
      --Parametro concepto de retencion                                       
      select
        @w_cpto_rte = ci_concepto
      from   cob_remesas..re_concepto_imp
      where  ci_tran        = 308
         and ci_impuesto    = 'R' --Verificar nemonico tipo de impuesto       
         and ci_contabiliza = 'tm_valor'

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @i_num = 201196,
          @i_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
        return 201196
      end
      --Parametro concepto de reteica                                         
      select
        @w_cpto_rteica = ci_concepto
      from   cob_remesas..re_concepto_imp
      where  ci_tran     = 334
         and ci_impuesto = 'C'

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @i_num = 201196,
          @i_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETEICA'
        return 201196
      end
    end
    else
    begin
      select
        @w_cpto_rte = null,
        @w_cpto_rteica = null

      select
        @o_sldint = 0,
        -- PORQUE LOS INTERESES NO SE ACREDITAN, EL CLIENTE LOS PIERDE                      
        @w_sldmantval = 0
    end

    select
      @w_val_cierre = round((@o_slddisp + @o_sldint + @w_sldmantval +
                             @i_gmf_reintegro
                                         ),
                            @w_numdeci)

    --print 'Cobra Comision por cierre ' + @i_cobra_multa_ant                  

    select
      @w_pais = isnull(pa_char,
                       'PA')
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'ABPAIS'

    if @w_pais is null
      select
        @w_pais = 'PA'

    select
      @w_banco = isnull(pa_char,
                        '')
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'CLIENT'

    if @w_banco is null
      select
        @w_banco = ''

    --PCOELLO SI APLICA PARA GLOBAL BANK /* COMENTADO NO APLICA A GLOBALBANK   
    if @i_cobra_multa_ant = 'N'
    begin
      select
        @w_multa = 0
      select
        @o_multa = 0
    end
    else
    begin
      select
        @w_dias = pa_smallint --pa_tinyint  lgr                     
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'MCI'

      /* cobra una multa por cerrar una cuenta antes de tiempo */
      if (datediff(dd,
                   @w_fec_aper,
                   @s_date) < @w_dias)
         and @t_ejec <> 'R'
      begin
        /* REQ 217 Cobro por Cierre Anticipado */
        if @w_es_contractual = 'S'
           and @w_prod_banc = @w_par_prod_cont
           and @w_categoria <> @w_camcat
        begin
          select
            @w_cant_plazos = cc_plazo,
            @w_interes_con = cc_intereses
          from   cob_remesas..re_cuenta_contractual
          where  cc_cta_banco = @i_cta
             and cc_estado    = 'A'

          select
            @w_interes_con_tot = round(isnull(@w_interes_con, 0) + isnull(
                                       @w_sldint
                                       ,
                                       0
                                       ),
                                       @w_numdeci),
            @w_porc_tiempo = round(convert(float, (datediff(mm,
                                                            @w_fec_aper,
                                                            @s_date))) /
                                   convert(float, @w_cant_plazos),
                                   @w_numdeci),
            @w_rubro = '3'
          -- REQ 217 Rubro Deduccion de Intereses por Cancelacion Anticipada              

          exec @w_return = cob_remesas..sp_genera_costos
            @i_filial      = @i_filial,
            @i_fecha       = @s_date,
            @i_oficina     = @w_ofi_cta,
            @i_categoria   = @w_categoria,
            @i_tipo_ente   = @w_tipo_ente,
            @i_rol_ente    = @w_rol_ente,
            @i_tipo_def    = @w_tipo_def,
            @i_prod_banc   = @w_prod_banc,
            @i_producto    = @w_producto,
            @i_moneda      = @w_moneda,
            @i_tipo        = @w_tipo,
            @i_codigo      = @w_default,
            @i_servicio    = 'CCTA',
            @i_rubro       = @w_rubro,
            @i_disponible  = @o_slddisp,
            @i_contable    = @w_saldo_contable,
            @i_promedio    = @w_promedio1,
            @i_porc_tiempo = @w_porc_tiempo,
            -- REQ 217 Porcentaje de Tiempo Cumplido                       
            @i_personaliza = @w_personalizada,
            @o_valor_total = @w_multa out

          if @w_return <> 0
            return @w_return

          select
            @w_multa = round(@w_interes_con_tot * @w_multa,
                             @w_numdeci)
        end
        else
        begin
          if @w_pais = 'CO'
             and @w_banco = 'BM'
            select
              @w_rubro = '41'
          else
            select
              @w_rubro = '22'
          --       print ' w-rubro  ' + @w_rubro                                     
          exec @w_return = cob_remesas..sp_genera_costos
            @i_filial      = @i_filial,
            @i_fecha       = @s_date,
            @i_oficina     = @w_ofi_cta,
            @i_categoria   = @w_categoria,
            @i_tipo_ente   = @w_tipo_ente,
            @i_rol_ente    = @w_rol_ente,
            @i_tipo_def    = @w_tipo_def,
            @i_prod_banc   = @w_prod_banc,
            @i_producto    = @w_producto,
            @i_moneda      = @w_moneda,
            @i_tipo        = @w_tipo,
            @i_codigo      = @w_default,
            @i_servicio    = 'CCTA',
            @i_rubro       = @w_rubro,
            @i_disponible  = @o_slddisp,
            @i_contable    = @w_saldo_contable,
            @i_promedio    = @w_promedio1,
            @i_personaliza = @w_personalizada,
            @o_valor_total = @w_multa out

          if @w_return <> 0
            return @w_return
        end

      end
      --PCOELLO SI APLICA PARA GLOBAL BANK  FIN COMENTARIO */                    
      select
        @w_multa = isnull(@w_multa,
                          0)
      select
        @o_multa = isnull(@w_multa,
                          0)
    end

    --PCOELLO SI APLICA PARA GLOBAL BANK /* COMENTADO NO APLICA GLOBALBANK     
    -- Cobro del IDB de la multa --                                            

    if @w_val_cierre >= @o_multa
      select
        @w_val_cierre = @w_val_cierre - @o_multa
    else
    begin
      select
        @o_multa = @w_val_cierre,
        @w_multa = @w_val_cierre,
        @w_val_cierre = 0,
        @w_valcie = 0
    end

    --PCOELLO SI APLICA PARA GLOBAL BANK  FIN COMENTARIO */                    

    select
      @w_val_cierre = isnull(@w_val_cierre,
                             0)
    select
      @w_retiro = isnull(@w_val_cierre,
                         0)

    if @w_codigo_pais = 'CO' -- Colombia                                       
      select
        @w_valcie = @w_valcie
    else
      select
        @w_valcie = @w_valcie - @w_multa --lgr                         

    select
      @w_valor_impuesto = isnull(@w_valor_impuesto,
                                 0)
    select
      @o_valir = isnull(@w_valor_impuesto,
                        0)

    select
      @w_val_cierre = isnull(@w_val_cierre,
                             0)
    select
      @w_retiro = isnull(@w_val_cierre,
                         0)

    select
      @w_valcie = @w_valcie - @w_valor_impuesto --lgr                   

    /* Se obtiene la filial */
    select
      @w_filial = of_filial
    from   cobis..cl_oficina
    where  of_oficina = @s_ofi

    /* Encuentra la alicuota para el promedio */
    select
      @w_alicuota = fp_alicuota
    from   cob_ahorros..ah_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_prom
       and fp_fecha_inicio  = @w_date

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251013
      return 251013
    end

    select
      @w_fecha = @s_date--dateadd(dd,1,@s_date)                          

    begin tran
  /* Grabar transaccion de servicio por reverso de intereses  provisionados*/
    -------------------------------xxxxxxxxxxxxxxx---------------------------------------------                       
    ------------------         
    -- CAPITALIZACION          
    ------------------         
    select
      @w_valor_impuesto = 0
    if @w_debug = 'S'
       and @w_sldint > 0
      print 'Antes capitalizacion @w_sldint ' + cast(@w_sldint as varchar)

    -- Si corresponde capitalizar                                              
    if @w_sldint > 0
    begin
      /*** Preguntar si el cliente es sujeto de retencion ***/
      select
        @w_retencion = isnull(en_retencion,
                              'N')
      from   cobis..cl_ente
      where  en_ente = @w_cliente

      if @@rowcount = 0
      begin
        /* Error en insercion de transaccion servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 121032
        return 121032
      end

      --Verificar si @w_saldo_interes supera parametro de interes diario * cantidad de dias a capitalizar            
      select
        @w_dias_capi = abs(datediff(dd,
                                    @w_fecha_ult_capi,
                                    @w_fecha))
      -- @w_dias_prx_mes no aplica en cierre       

      select
        @w_base_rtfte = @w_dias_capi * @w_binc
      --@w_min_rtfte JAR 14/01/2010                                   

      if @w_debug = 'S'
        print '@w_base_rtfte ' + cast(@w_base_rtfte as varchar) +
              ' @w_cpto_rte  '
              +
                                @w_cpto_rte

      if @w_cpto_rte is not null
         and @w_sldint >= @w_base_rtfte
      begin
        --Calculo tasa retefuente - interfaz con contabilidad en variable @w_tasa_impuesto                          
        exec @w_return = cob_interfase..sp_icon_impuestos
          @i_empresa      = @w_filial,
          @i_concepto     = @w_cpto_rte,
          @i_debcred      = 'D',
          @i_monto        = @w_sldint,
          @i_impuesto     = 'R',--Verificar nemonico tipo de impuesto         
          @i_oforig_admin = @w_oficina,
          @i_ofdest_admin = @w_oficina,
          @i_ente         = @w_cliente,
          @i_producto     = 4,
          @o_exento       = @w_exento out,
          @o_porcentaje   = @w_porcentaje out

        if @w_return <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 121032
          return 121032
        end

        if @w_exento = 'N'
          select
            @w_tasa_impuesto = (@w_porcentaje / 100)
        else
          select
            @w_tasa_impuesto = 0
      end

      if @w_tasa_impuesto is null
      begin
        select
          @w_tasa_impuesto = 0
        if @w_tasa_imp > 0
          select
            @w_valor_impuesto = round((@w_sldint * @w_tasa_imp),
                                      @w_numdeci_imp)
        else
          select
            @w_valor_impuesto = 0
        select
          @w_tasa_imp_usado = @w_tasa_imp
      end
      else
      begin
        select
          @w_tasa_imp = 0
        if @w_tasa_impuesto > 0
          select
            @w_valor_impuesto = round((@w_sldint * @w_tasa_impuesto),
                                      @w_numdeci_imp)
        else
          select
            @w_valor_impuesto = 0
        select
          @w_tasa_imp_usado = @w_tasa_impuesto
      end

      if @w_debug = 'S'
        print '@w_tasa_impuesto ' + cast(@w_tasa_impuesto as varchar) +
                                      ' @w_valor_impuesto '
              + cast(@w_valor_impuesto as varchar)

      if (@w_tasa_imp_gral > 0
          and (@w_tasa_impuesto > 0
                or @w_tasa_imp > 0))
      begin
        /* Verificar que la cuenta este exonerada  de IDB*/
        select
          @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
        from   cob_remesas..re_exoneracion_impuesto
        where  ei_producto = 'AHO'
           and ei_cuenta   = @w_cuenta

        if @@rowcount = 1 -- Cuenta exonerada                                
          select
            @w_tasa_imp_gral = 0.0
      end

      /* CALCULO DEL MONTO DE IDB */
      if (@w_tasa_imp_gral > 0
          and (@w_tasa_impuesto > 0
                or @w_tasa_imp > 0))
        select
          @w_imp2 = round((@w_valor_impuesto * @w_tasa_imp_gral),
                          @w_numdeci_imp)
      else
        select
          @w_imp2 = $0

      if @w_valor_impuesto > 0
      begin
        --Calculo de cliente exonerado GMF                                   
        select
          @w_total_gmf = 0,
          @w_base_gmf = 0

        if @w_codigo_pais = 'CO' -- Colombia                                 
        begin
          exec @w_return = cob_ahorros..sp_calcula_gmf
            @s_date      = @w_fecha,
            @i_cuenta    = @w_cuenta,
            @i_cta       = @w_cta_banco,
            @i_operacion = 'Q',
            @i_producto  = 4,
            @i_cliente   = @w_ente,
            @i_val       = @w_valor_impuesto,
            @o_total_gmf = @w_total_gmf out,
            @o_acumu_deb = @w_acumu_deb out,
            @o_base_gmf  = @w_base_gmf out,
            @o_actualiza = @w_actualiza out

          -- Actualiza acumulados topes gmf                                 
          if @w_actualiza = 'S'
             and isnull(@w_acumu_deb,
                        0) <> 0
          begin
            exec @w_return = sp_calcula_gmf
              @s_date      = @w_fecha,
              @i_cuenta    = @w_cuenta,
              @i_producto  = @w_producto,
              @i_operacion = 'U',
              @i_acum_deb  = @w_acumu_deb

            if @w_return <> 0
              return @w_return
          end

        end
        select
          @w_imp_retencion = @w_total_gmf,
          @w_base_gmf_retencion = @w_base_gmf
        select
          @w_imp2 = @w_imp2 + @w_total_gmf
      end

      --Calcular tasa de reteica                                              

      if @w_cpto_rteica is not null
      begin
        exec @w_return = cob_interfase..sp_icon_impuestos
          @i_empresa      = @w_filial,
          @i_concepto     = @w_cpto_rteica,
          @i_debcred      = 'D',
          @i_monto        = @w_sldint,
          @i_impuesto     = 'C',
          @i_oforig_admin = @w_oficina,
          @i_ofdest_admin = @w_oficina,
          @i_ente         = @w_cliente,
          @i_ciudad       = @w_ciudad_rte_ica,
          @i_producto     = 4,
          @o_exento       = @w_exento out,
          @o_porcentaje   = @w_porcentaje out

        if @w_return <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 121032
          return 121032
        end

        if @w_exento = 'N'
          select
            @w_tasa_reteica = @w_porcentaje
        else
          select
            @w_tasa_reteica = 0

        if @w_tasa_reteica > 0
          select
            @w_valor_reteica = round((@w_sldint * @w_tasa_reteica),
                                     @w_numdeci_imp)
        else
          select
            @w_valor_reteica = 0
      end
      else
        select
          @w_valor_reteica = 0

      if @w_debug = 'S'
        print '@w_tasa_reteica ' + cast(@w_tasa_reteica as varchar) +
                                                           ' @w_valor_reteica '
              + cast(@w_valor_reteica as varchar)

      if @w_valor_reteica > 0
      begin
        --Calculo de cliente exonerado GMF                                   
        select
          @w_total_gmf = 0,
          @w_base_gmf = 0

        if @w_codigo_pais = 'CO' -- Colombia                                 
        begin
          exec @w_return = cob_ahorros..sp_calcula_gmf
            @s_date      = @w_fecha,
            @i_cta       = @w_cta_banco,
            @i_cuenta    = @w_cuenta,
            @i_operacion = 'Q',
            @i_val       = @w_valor_reteica,
            @i_cliente   = @w_ente,
            @o_total_gmf = @w_total_gmf out,
            @o_acumu_deb = @w_acumu_deb out,
            @o_base_gmf  = @w_base_gmf out,
            @o_actualiza = @w_actualiza out

          -- Actualiza acumulados topes gmf                                 
          if @w_actualiza = 'S'
             and isnull(@w_acumu_deb,
                        0) <> 0
          begin
            exec @w_return = sp_calcula_gmf
              @s_date      = @w_fecha,
              @i_cuenta    = @w_cuenta,
              @i_producto  = @w_producto,
              @i_operacion = 'U',
              @i_acum_deb  = @w_acumu_deb

            if @w_return <> 0
              return @w_return
          end

        end

        select
          @w_imp2 = @w_imp2 + @w_total_gmf
        select
          @w_imp_reteica = @w_total_gmf,
          @w_base_gmf_reteica = @w_base_gmf
      end

      select
        @w_total_interes = round(@w_sldint - isnull(@w_valor_impuesto,
                                                    $0) - @w_valor_reteica
                                 - @w_imp2
                           ,
                                 @w_numdeci) --JAR 14/01/2010 

      select
        @w_prom_disponible = @w_prom_disponible
                             + convert(money, round((@w_total_interes *
                             @w_alicuota)
                             ,
                                    @w_numdeci))
      select
        @w_promedio1 =
        @w_promedio1 + convert(money, round((@w_total_interes *
        @w_alicuota), @w_numdeci
        ))

      select
        @w_sldint = round(@w_sldint,
                          @w_numdeci)
      select
        @o_slddisp = @o_slddisp + @w_sldint
      select
        @w_saldo_contable = @w_saldo_contable + @w_sldint

      select
        @w_fecha_ult_mov_int = @w_fecha,
        @w_fecha_ult_capi = @w_fecha

      if @w_estado = 'I'
        select
          @w_trn_code = 304
      else
        select
          @w_trn_code = 221

      select
        @w_saldo_interes_ir = @w_sldint

      /* Inserta transaccion monetaria de capitalizacion */
      insert into ah_notcredeb
                  (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                   usuario,terminal,correccion,sec_correccion,reentry,
                   origen,nodo,fecha,cta_banco,signo,
                   indicador,remoto_ssn,moneda,causa,interes,
                   valor,saldocont,saldodisp,oficina_cta,filial,
                   prod_banc,categoria,monto_imp,tipo_exonerado,hora,
                   tipocta_super,turno,canal,cliente,clase_clte)
      values      ( @s_ssn,@s_ssn,1,@w_trn_code,@w_oficina,
                    @s_user,@s_term,'N',null,'N',
                    'L',@s_srv,@w_fecha,@w_cta_banco,'C',
                    1,null,@w_moneda,null,null,
                    @w_sldint,@w_saldo_contable,@o_slddisp,@w_oficina,@w_filial,
                    @w_prod_banc,@w_categoria,null,null,getdate(),
                    @o_tipocta_super,@i_turno,@i_canal,@w_cliente,@o_clase_clte)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255004
        return 255004
      end
      if @w_debug = 'S'
        print '@w_retencion  ' + @w_retencion + ' @w_valor_impuesto '
              + cast (@w_valor_impuesto as varchar)

      if (@w_retencion = 'S'
          and @w_valor_impuesto > 0)
      begin
        select
          @o_slddisp = @o_slddisp - @w_valor_impuesto - @w_imp_retencion
        select
          @w_saldo_contable = @w_saldo_contable - @w_valor_impuesto
                              - @w_imp_retencion

        select
          @w_prom_disponible = @w_prom_disponible - convert(money, round((
          @w_valor_impuesto
          * @w_alicuota),
          @w_numdeci))
        select
          @w_promedio1 = @w_promedio1 - convert(money, round(
                                                                (
                                        @w_valor_impuesto *
                                        @w_alicuota)
                                                       ,
                                                             @w_numdeci))

        if @w_estado = 'I'
          select
            @w_trn_code = 309
        else
          select
            @w_trn_code = 308

        /* Inserta transaccion monetaria de retencion de IPF */
        insert into ah_notcredeb
                    (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                     usuario,terminal,correccion,sec_correccion,reentry,
                     origen,nodo,fecha,cta_banco,signo,
                     indicador,remoto_ssn,moneda,causa,interes,
                     valor,val_cheque,saldocont,saldodisp,oficina_cta,
                     filial,prod_banc,categoria,monto_imp,tipo_exonerado,
                     hora,tipocta_super,turno,canal,cliente,
                     saldo_lib,base_gmf,clase_clte)
        values      ( @s_ssn,@s_ssn,2,@w_trn_code,@w_oficina,
                      @s_user,@s_term,'N',null,'N',
                      'L',@i_srv,@w_fecha,@w_cta_banco,'D',
                      1,null,@w_moneda,null,@w_sldint,
                      @w_valor_impuesto,@w_tasa_imp_usado,@w_saldo_contable,
                      @o_slddisp
                      ,
                      @w_oficina,
                      @w_filial,@w_prod_banc,@w_categoria,@w_imp2,
                      @w_tipo_exonerado_imp,
                      getdate(),@o_tipocta_super,@i_turno,@i_canal,@w_cliente,
                      @w_sldint,@w_base_gmf_retencion,@o_clase_clte)

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 203035
          return 203035
        end
      end

      if @w_valor_reteica > 0
      begin
        select
          @o_slddisp = @o_slddisp - @w_valor_reteica - @w_imp_reteica
        select
          @w_saldo_contable = @w_saldo_contable - @w_valor_reteica
                              - @w_imp_reteica

        select
          @w_prom_disponible = @w_prom_disponible - convert(money, round((
          @w_valor_reteica *
          @w_alicuota),
          @w_numdeci))
        select
          @w_promedio1 = @w_promedio1 - convert(money, round((
                                        @w_valor_reteica *
                                        @w_alicuota
                                                       ),
                                                             @w_numdeci))

        select
          @w_trn_code = 334
        --Ini JAR 14/01/2010 
        /* Inserta transaccion de servicio para reteica */
        insert into ah_notcredeb
                    (secuencial,ssn_branch,alterno,tipo_tran,oficina,
                     usuario,terminal,correccion,sec_correccion,reentry,
                     origen,nodo,fecha,cta_banco,signo,
                     indicador,remoto_ssn,moneda,causa,interes,
                     valor,val_cheque,saldocont,saldodisp,oficina_cta,
                     filial,prod_banc,categoria,monto_imp,tipo_exonerado,
                     hora,tipocta_super,turno,canal,cliente,
                     saldo_lib,saldoint,clase_clte)
        values      ( @s_ssn,@s_ssn,3,@w_trn_code,@w_oficina,
                      @s_user,@s_term,'N',null,'N',
                      'L',@i_srv,@w_fecha,@w_cta_banco,'D',
                      1,null,@w_moneda,null,@w_sldint,
                      @w_valor_reteica,@w_tasa_imp_usado,@w_contable,
                      @w_disponible
                      ,
                      @w_oficina,
                      @w_filial,@w_prod_banc,@w_categoria,@w_imp2,
                      @w_tipo_exonerado_imp,
                      getdate(),@o_tipocta_super,@i_turno,@i_canal,@w_cliente,
                      @w_sldint,@w_base_gmf_reteica,@o_clase_clte)

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 203035
          return 203035
        end
      end
      --FIN JAR 14/01/2010    

      select
        @w_creditos = @w_creditos + @w_sldint,
        @w_creditos_hoy = @w_creditos_hoy + @w_sldint,
        @w_debitos = @w_debitos + @w_valor_impuesto + @w_imp2,
        @w_debitos_hoy = @w_debitos_hoy + @w_valor_impuesto + @w_imp2,
        @w_monto_imp = @w_monto_imp + @w_imp2,
        @w_monto_ult_capi = @w_sldint

      if @w_codigo_pais = 'CO'
      begin
        select
          @w_cliente_b = pa_int
        from   cobis..cl_parametro
        where  pa_nemonico = 'CCBA'
           and pa_producto = 'CTE'

        if @@rowcount <> 1
        begin
          if @@trancount > 0
            rollback
          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 201196
          return 201196
        end

        select
          @w_clase_clte_b = case c_tipo_compania
                              when 'OF' then 'O'
                              else 'P'
                            end
        from   cobis..cl_ente
        where  en_ente = @w_cliente_b

        if @@rowcount <> 1
        begin
          if @@trancount > 0
            rollback
          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 201196
          return 201196
        end

        /*Impuesto GMF general a debitos*/
        select
          @w_tasagmf = pa_float
        from   cobis..cl_parametro
        where  pa_producto = 'AHO'
           and pa_nemonico = 'IGMF'

        if @@rowcount = 0
        begin
          if @@trancount > 0
            rollback
          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 201196
          return 201196
        end

        select
          @w_gmfbco = round((@w_sldint * @w_tasagmf),
                            @w_numdeci)
        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                     ts_usuario,
                     ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                     ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria
                     ,
                     ts_tipocta_super,ts_turno,
                     ts_clase_clte,ts_cliente,ts_interes
        )
        values      (@s_ssn,@s_ssn,379,@s_date,@s_user,
                     @s_term,@i_oficina,'N','U',@w_cta_banco,
                     @w_gmfbco,@w_moneda,@w_ofi_cta,@w_prod_banc,@w_categoria,
                     @o_tipocta_super,@i_turno,@w_clase_clte_b,@w_cliente_b,
                     @w_sldint)

        if @@error <> 0
        begin
          if @@trancount > 0
            rollback
          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 201196
          return 201196
        end
      end

      select
        @w_sldint = 0
      select
        @w_ssn = @w_ssn + 1
    end -- @w_saldo_interes > 0                                               

    -------------------------  
    -- FIN DE CAPITALIZACION   
    -------------------------  

    ------------------------------------xxxxxxxxxxxxxxxxxxxx----------------------------                              

    if @w_sldint > 0
       and @w_codigo_pais <> 'CO' -- lgr                       
    begin
      --select  @w_valcie      = @w_valcie - @o_sldint,                       
      --        @o_int_perdido = @w_sldint                                    

      select
        @o_int_perdido = @w_sldint
      insert into ah_tran_servicio
                  (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                   ts_usuario,
                   ts_terminal,ts_ctacte,ts_filial,ts_valor,ts_oficina,
                   ts_oficina_cta,ts_prod_banc,ts_categoria,ts_moneda,
                   ts_tipocta_super
                   ,
                   ts_turno,ts_saldo,ts_cta_banco,ts_cliente,
                   ts_clase_clte)
      values      (@s_ssn,@s_ssn,323,@s_date,@s_user,
                   @s_term,@w_cuenta,@w_filial,@w_sldint,@i_oficina,
                   @i_oficina,@w_prod_banc,@w_categoria,@w_moneda,
                   @o_tipocta_super
                   ,
                   @i_turno,@o_int_cap,@i_cta,@o_cliente,
                   @o_clase_clte)
      --pcoello graba tambien el interes capitalizado solo como referencia                    

      if @@error <> 0
      begin
        /* Error en insercion de transaccion servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253004
        return 253004
      end

      select
        @o_sldint = 0
    -- se reversaron los intereses provisionados y no se pagaran                              
    end

    /* Graba transaccion monetaria en caso de multa antes de cierre */
    if @w_multa > 0
    begin
      select
        @w_trn = 264,
        @w_cau = '12'

      ------------            
      /* Cobro del GMF y del IVA en caso de requerirlo ****/
      select
        @w_com_iva = an_comision,
        @w_imp_gmf = an_impuesto,
        @w_accion = an_accion
      from   cob_remesas..re_accion_nd
      where  an_producto = 4
         and an_causa    = @w_cau

      if @@rowcount = 0
          or @w_com_iva = 'N'
      begin
        select
          @w_impuesto_iva = 0,
          @w_accion = 'E',
          @w_imp_gmf = 'N',
          @w_com_iva = 'N'
      end

      if @w_com_iva = 'S'
      begin--3                
        select
          @w_concto_iva = ci_concepto
        from   cob_remesas..re_concepto_imp
        where  ci_tran     = 264
           and ci_causal   = @w_cau
           and ci_impuesto = 'V'

        if @@rowcount = 0
          return 201232

        exec @w_return = cob_interfase..sp_icon_impuestos
          @i_empresa      = 1,
          @i_concepto     = @w_concto_iva,
          @i_debcred      = 'C',
          @i_monto        = @w_multa,
          @i_impuesto     = 'V',
          @i_oforig_admin = @s_ofi,
          @i_ofdest_admin = @w_oficina,
          @i_ente         = @w_ente,
          @i_producto     = 4,
          @o_exento       = @w_exento out,
          @o_porcentaje   = @w_porcentaje out

        if @w_exento = 'N'
          select
            @w_piva = @w_porcentaje
        else
          select
            @w_piva = 0

        select
          @w_impuesto_iva = round((@w_multa * @w_piva / 100),
                                  @w_numdeci_imp)
      end --3            
      else
        select
          @w_impuesto_iva = 0

      select
        @w_totval = @w_multa + @w_impuesto_iva

      if @w_codigo_pais = 'CO' -- Colombia                                    
      begin
        exec @w_return = cob_ahorros..sp_calcula_gmf
          @s_date      = @w_fecha,
          @i_cuenta    = @w_cuenta,
          @i_cta       = @w_cta_banco,
          @i_operacion = 'Q',
          @i_producto  = 4,
          @i_cliente   = @w_ente,
          @i_val       = @w_totval,
          @o_total_gmf = @w_monto_imp_multa out,
          @o_acumu_deb = @w_acumu_deb out,
          @o_base_gmf  = @w_base_gmf out,
          @o_actualiza = @w_actualiza out

      end
      else
        select
          @w_monto_imp_multa = 0,
          @w_base_gmf = 0

      if (@w_multa + @w_impuesto_iva + @w_monto_imp_multa) > @o_slddisp
      begin
        select
          @w_msg = '[' + @w_sp_name + '] ' +
                          'VALORES POR COBRAR -- MAYOR A SALDO DE CIERRE'
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251059,
          @i_sev   = 1,
          @i_msg   = @w_msg
        return 1
      end
      -- Actualizacion de Impuesto GMF causado                                
      if @w_codigo_pais = 'CO' -- Colombia                                    
      begin
        -- Actualiza acumulados topes gmf                                    
        if @w_actualiza = 'S'
        begin
          exec @w_return = sp_calcula_gmf
            @s_date      = @s_date,
            @i_cuenta    = @w_cuenta,
            @i_producto  = @w_producto,
            @i_operacion = 'U',
            @i_acum_deb  = @w_acumu_deb

          if @w_return <> 0
            return @w_return
        end
      end

      ------------                
      select
        @o_slddisp = @o_slddisp - @o_multa - @w_monto_imp_multa
                     - @w_impuesto_iva
      select
        @w_prom_disponible = @w_prom_disponible - (@o_multa + @w_monto_imp_multa
                                                   +
        @w_impuesto_iva
        ) *
        @w_alicuota,
        @w_promedio1 = @w_promedio1 - (@o_multa + @w_monto_imp_multa +
                                       @w_impuesto_iva
                                      )
                                      * @w_alicuota

      insert into cob_ahorros..ah_notcredeb
                  (secuencial,alterno,tipo_tran,oficina,usuario,
                   terminal,correccion,sec_correccion,reentry,origen,
                   nodo,fecha,cta_banco,signo,indicador,
                   remoto_ssn,moneda,causa,interes,valor,
                   saldocont,saldodisp,oficina_cta,filial,prod_banc,
                   categoria,monto_imp,tipo_exonerado,ssn_branch,tipocta_super,
                   turno,hora,canal,cliente,monto_iva,
                   base_gmf,clase_clte)
      values      (@s_ssn,4,@w_trn,@i_oficina,@s_user,
                   @s_term,'N',null,'N','L',
                   @s_srv,@s_date,@i_cta,'D',1,
                   null,@i_mon,@w_cau,0,@o_multa,
                   @o_slddisp,@o_slddisp,@w_ofi_cta,@i_filial,@o_prod_banc,
                   @o_categoria,@w_monto_imp_multa,@o_tipo_exonerado_imp,
                   @s_ssn_branch
                   ,@o_tipocta_super,
                   @i_turno,getdate(),@i_canal,@o_cliente,@w_impuesto_iva,
                   @w_base_gmf,@o_clase_clte)

      if @@error <> 0
      begin
        /* Error en insercion de transaccion monetaria */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 203000
        return 203000
      end
    end -- MULTA > 0          

    if @w_valcie > 0
    begin
      --Calculo gmf en valor de cierre                                        
      select
        @w_total_gmf = 0,
        @w_base_gmf = 0,
        @w_gmf_reitengro_cie = 0

      if @w_codigo_pais = 'CO' -- Colombia                                    
      begin
        select
          @w_valor_cal = @w_valcie - @i_gmf_reintegro + @w_valor_impuesto

        exec @w_return = cob_ahorros..sp_calcula_gmf
          @s_date            = @w_fecha,
          @i_cuenta          = @w_cuenta,
          @i_cta             = @w_cta_banco,
          @i_operacion       = 'Q',
          @i_val             = @w_valor_cal,
          @i_val_tran        = @w_valor_cal,
          @i_cliente         = @w_ente,
          -- @i_total     = 'S',                                               
          @o_total_gmf       = @w_monto_imp_retiro out,
          @o_acumu_deb       = @w_acumu_deb out,
          @o_base_gmf        = @w_base_gmf out,
          @o_actualiza       = @w_actualiza out,
          @o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
          @o_valor_reintegro = @w_gmf_reitengro_cie out
        -- JCO                                                

        -- Actualiza acumulados topes gmf                                    
        if @w_actualiza = 'S'
        begin
          exec @w_return = sp_calcula_gmf
            @s_date      = @s_date,
            @i_cuenta    = @w_cuenta,
            @i_producto  = @w_producto,
            @i_operacion = 'U',
            @i_acum_deb  = @w_acumu_deb

          if @w_return <> 0
            return @w_return
        end

        if @i_gmf_reintegro <> @w_gmf_reitengro_cie
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 252094
          return 252094
        end

        /* credito por Reintegro de GMF */

        if @w_gmf_reitengro_cie > 0
        begin
          select
            @o_slddisp = @o_slddisp + isnull(@w_gmf_reitengro_cie, 0)

          insert into cob_ahorros..ah_notcredeb
                      (secuencial,alterno,tipo_tran,oficina,usuario,
                       terminal,correccion,sec_correccion,reentry,origen,
                       nodo,fecha,cta_banco,signo,indicador,
                       remoto_ssn,moneda,causa,interes,valor,
                       saldocont,saldodisp,oficina_cta,filial,prod_banc,
                       categoria,tipo_exonerado,ssn_branch,tipocta_super,turno,
                       hora,canal,cliente,base_gmf,clase_clte)
          values      (@s_ssn,5,253,@i_oficina,@s_user,
                       @s_term,'N',null,'N','L',
                       @s_srv,@s_date,@i_cta,'C',1,
                       null,@i_mon,'20',0,@w_gmf_reitengro_cie,
                       @o_slddisp,@o_slddisp,@w_ofi_cta,@i_filial,@o_prod_banc,
                       @o_categoria,@o_tipo_exonerado_imp,@s_ssn_branch,
                       @o_tipocta_super
                       ,
                       @i_turno,
                       getdate(),@i_canal,@o_cliente,@w_monto_imp_retiro,
                       @o_clase_clte
          )

          if @@error <> 0
          begin
            /* Error en insercion de transaccion monetaria */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 203000
            return 203000
          end
        end
      end

      select
        @w_gmf_valcie = @w_base_gmf
      -- INI CMUNOZ REQ016 CIERRE CUENTA  

      select
        @w_cauciina = pa_char --Causal cierre inactivas
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'CAUT'

      if @w_cauciina is null
        select
          @w_cauciina = '12'

      select
        @w_cauegina = pa_char --Causal egreso dev. fondos inactivas
      from   cobis..cl_parametro
      where  pa_producto = 'CTE'
         and pa_nemonico = 'CEDLA'

      if @w_cauegina is null
        select
          @w_cauciina = '035'

      if @i_fcancel = 'E'
          or (@i_causa = '6'
               or @i_causa = @w_cauciina)
      begin
        if @i_causa = '6'
          select
            @w_causa = '012'
        --DEVOLUCION DE FONDOS CIERRE UNILATERAL BANCO                                     
        else if @i_causa = @w_cauciina
          select
            @w_causa = @w_cauegina
        --ENTREGA SALDO CTA AHORROS CANCELACION INACTIVA 
        else
          select
            @w_causa = '014' --DEVOLUCION DE FONDOS DE CUENTA CERRADA-AHORROS

        /* Invoca interfaz otros modulos y marca estado orden */
        exec @w_return = cob_remesas..sp_genera_orden
          @s_date      = @s_date,--> Fecha de proceso            
          @s_user      = @s_user,--> Usuario                     
          @i_ofi       = @s_ofi,--> Oficina de la transaccion   
          @i_operacion = 'I',
          --> Operacion ('I' -> Insercion, 'A' Anulaci=n)                        
          @i_causa     = @w_causa,
          --> @i_causa, --> Causal de Ingreso(cc_causa_oioe)                      
          @i_ente      = @w_cliente,--> Cod ente,                   
          @i_valor     = @w_valcie,--> Valor,                      
          @i_tipo      = 'P',
          --> 'C' -> Orden de Cobro/Ingreso, 'P' -> Orden de Pago/Egreso         
          @i_idorden   = null,
          --> C=d Orden cuando operaci=n 'A',                                    
          @i_ref1      = @w_cuenta,--> Ref. N·merica no oblicatoria
          @i_ref2      = 0,--> Ref. N·merica no oblicatoria
          @i_ref3      = @w_cta_banco,
          --> Ref. AlfaN·merica no oblicatoria                                   
          @i_interfaz  = 'N',
          --> 'N' - Invoca sp_cerror, 'S' - Solo devuelve c=d error              
          @o_idorden   = @w_num_orden out
        --> Devuelve c=d orden de pago/cobro generada - Operaci=n 'I'          

        if @@error <> 0
            or @w_return <> 0
        begin
          if @w_return <> 0
            return @w_return
          /* Error en creacion de registro en ah_his_cierre */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 205000
          return 205000
        end
      end

      if @i_fcancel = 'G'
      begin
        if @i_codbene is not null
        begin
          /*Datos de beneficiario si es Cheque de GErencia cmu*/
          select
            @w_ente_b = null
          select
            @w_ente_b = en_ente,
            @w_nomlar_b = en_nomlar,
            @w_tipo_ced_b = en_tipo_ced,
            @w_ced_ruc_b = en_ced_ruc
          from   cobis..cl_ente
          where  en_ente = @i_codbene

          if @w_ente_b is null
          begin
            /* No existe beneficiario */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 258007
            return 258007
          end

          select
            @w_campo3 = @w_tipo_ced_b + '-' + @w_ced_ruc_b

          /*Datos de cliente si es Cheque de GErencia cmu*/

          select
            @w_ente_c = null

          select
            @w_ente_c = en_ente,
            @w_nomlar_c = en_nomlar,
            @w_tipo_ced_c = en_tipo_ced,
            @w_ced_ruc_c = en_ced_ruc
          from   cobis..cl_ente
          where  en_ente = @w_cliente

          if @w_ente_c is null
          begin
            /* No existe cliente */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 258008
            return 258008
          end

          select
            @w_campo1 = @w_tipo_ced_c + '-' + @w_ced_ruc_c
        end
        else
        begin
          /* Beneficiario es obligatorio */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 258009
          return 258009
        end

        select
          @w_campo6 = pa_char,
          @w_campo7 = pa_parametro
        from   cobis..cl_parametro
        where  pa_nemonico = 'DFCC'

        if @@rowcount <> 1
        begin
          /* Error: no se parametro de devolucion de cuentas cerrada */
          exec cobis..sp_cerror
            @i_num = 205031,
            @i_msg =
          'ERROR EN PARAMETRO DE DEVOLUCION DE FONDOS DE CUENTAS CERRADAS'
          return 205031
        end

        exec @w_return = cob_interfase..sp_isba_imprimir_lotes
          @t_trn             = 29334,
          @s_ssn             = @s_ssn,
          @s_date            = @s_date,
          @s_user            = @s_user,
          @s_term            = @s_term,
          @s_ofi             = @s_ofi,
          @s_lsrv            = @s_lsrv,
          @s_srv             = @s_srv,
          @i_estado          = 'D',
          --> ESTADO DE LA SOLICITUD ('DISPONIBLE PARA GIRO)                      
          @i_oficina_origen  = @s_ofi,--  OFICINA ORIGEN               
          @i_ofi_destino     = @s_ofi,--  OFICINA QUE GIRA EL CHEQUE   
          @i_area_origen     = 99,
          @i_fecha_solicitud = @s_date,--  FECHA DE SOLICITUD DE GIRO   
          @i_producto        = 4,-- (4- VENTA DE INSTRUMENTOS)    
          @i_instrumento     = 1,
          -- (1-cheques de gerencia, 5-cheques comerciales)                       
          @i_subtipo         = 1,
          -- (depende del instrumento, 1 para  CGER)                              
          @i_valor           = @w_valcie,--  Valor                        
          @i_beneficiario    = @w_nomlar_b,
          --  Nombre beneficiario cheque (Deben estar en cl_ente)                 
          @i_referencia      = @w_cuenta,
          --  Campo entero que sirve para la cuenta/operacion/referencia          
          --  general de quien origina la solicitud                               
          @i_tipo_benef      = @w_clase_clt,--  Particular u Oficial         
          @i_campo1          = @w_campo1,
          --  tipo y numero del titular ej. CC-79876543                           
          @i_campo2          = @o_nombre,--  Nombre Titular               
          @i_campo3          = @w_campo3,
          --  tipo y numero del beneficiario ej. CC-79876545                      
          @i_campo4          = @w_nomlar_b,--  Nombre Beneficiario          
          @i_campo5          = @w_cta_banco,
          --  Numero oficio o algo que identifique la operacion(conocido por el cliente)                                          
          @i_campo6          = @w_campo6,
          --  Codigo concepto de emision                                      
          @i_campo7          = @w_campo7,
          --  Descripcion concepto de emision                              
          @i_campo21         = 'AHO',
          --  Sigla del producto que env8a (DPF, CCA, MIS, e.t.c.)                
          @i_campo22         = 'D',
          @i_campo40         = 'E',
          --  Idioma 'E' --> Espa±ol, 'I' --> Ingles                              
          @o_secuencial      = @w_num_orden out
        --  Codigo de secuencial  (Campo de salida que  devuelve el sp y se debe grabar en tabla del modulo)                

        if @@error <> 0
            or @w_return <> 0
        begin
          /* Error en creacion de registro en ah_his_cierre */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 205000
          return 205000
        end
      end
    end

  /* Actualizacion de las tablas: ah_his_cierre, ah_cuenta y cl_det_producto */
    /* Esta parte es para guardar en la vista de servicio esta transaccion */
    exec @w_return = cobis..sp_cseqnos
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_his_cierre',
      @o_siguiente = @w_numrg out
    if @w_return <> 0
      return @w_return

    /* PEDRO COELLO AGOSTO 1 DEL 2006 Creacion de transaccion de servicio */
    insert into cob_ahorros..ah_tscierre_cta
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,oficina,reentry,origen,secuencia,
                 cta_banco,causa,saldo,fecha,autorizante,
                 moneda,oficina_cta,prod_banc,categoria,tipocta_super,
                 turno,no_cobra_multa_ant,multa_ant,cliente,numorden)
    values      (@s_ssn,@s_ssn_branch,213,@s_date,@s_user,
                 @s_term,@s_ofi,@t_rty,@s_org,@w_numrg,
                 @i_cta,@i_causa,@w_valcie,@s_date,@i_aut,
                 @i_mon,@w_oficina,@o_prod_banc,@o_categoria,@o_tipocta_super,
                 @i_turno,@i_cobra_multa_ant,@w_multa,@o_cliente,@w_num_orden)

    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    end

    insert into cob_ahorros..ah_his_cierre
                (hc_secuencial,hc_cuenta,hc_orden,hc_causa,hc_saldo,
                 hc_fecha,hc_filial,hc_oficina,hc_autorizante,hc_ssn_branch,
                 hc_forma_pg,hc_observacion,hc_observacion1,hc_estado,
                 hc_sec_ord_pago)
    values      (@w_numrg,@w_cuenta,@i_orden,@i_causa,@w_valcie,
                 @w_date,@w_filial,@s_ofi,@i_aut,@s_ssn_branch,
                 isnull(@i_fcancel,
                        'E'),@i_observacion,@i_observacion1,'C',@w_num_orden)

    if @@error <> 0
    begin
      /* Error en creacion de registro en ah_his_cierre */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203010
      return 203010
    end

    if @i_fcancel = 'C'
        or @i_causa = '6'
      select
        @o_indicador = 0
    if @i_fcancel = 'E'
      select
        @o_indicador = 1
    if @i_fcancel = 'G'
      select
        @o_indicador = 3
    if @i_causa = @w_cauciina
      select
        @o_indicador = 2

    if @i_cobra = 1
    begin
      select
        @w_prom_disponible = @w_prom_disponible - (@w_multa) * @w_alicuota,
        @w_promedio1 = @w_promedio1 - (@w_multa) * @w_alicuota

      update cob_ahorros..ah_cuenta
      set    ah_disponible = round(@o_slddisp,
                                   @w_numdeci),
             ah_promedio1 = round(isnull(@w_promedio1,
                                         0),
                                  @w_numdeci),
             ah_prom_disponible = round (isnull(@w_prom_disponible,
                                                0),
                                         @w_numdeci),
             ah_debitos = ah_debitos + @w_multa,
             ah_debitos_hoy = ah_debitos_hoy + @w_multa,
             ah_creditos = ah_creditos + @o_sldint,
             ah_creditos_hoy = ah_creditos_hoy + @o_sldint,
             ah_fecha_ult_mov = @s_date,
             ah_contador_trx = ah_contador_trx + 1
      where  ah_cuenta = @w_cuenta

      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro en ah_cuenta */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255001
        return 255001
      end
    end

    if @i_cobra = 0
    begin
      select
        @o_control = 0,
        @o_slddisp = 0,
        @o_sldcont = @o_slddisp,
        @w_prom_disponible = @w_prom_disponible - (@w_valcie) * @w_alicuota,
        @w_promedio1 = @w_promedio1 - (@w_valcie) * @w_alicuota,
        @o_impuesto = @w_valor_impuesto
      select
        @w_monto_imp_total = 0

      /* REALIZA DESMARCACION DE GMF PARA LA CUENTA */
      if @w_gmfmarca = 'S'
      begin
        if @i_ejec_marca = 'S'
        begin
          exec @w_return = cob_ahorros..sp_upd_gmf_ac
            @s_ssn         = @s_ssn,
            @s_srv         = @s_srv,
            @s_user        = @s_user,
            @s_sesn        = @s_sesn,
            @s_term        = @s_term,
            @s_date        = @s_date,
            @s_org         = @s_org,
            @s_ofi         = @s_ofi,
            @s_rol         = @s_rol,
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @t_from,
            @t_rty         = @t_rty,
            @t_trn         = @t_trn,
            @i_gmfmarca    = 'N',--Desmarca cuenta
            @i_concepto    = @w_gmfconcepto,
            @i_descripcion = 'DESMARCACION POR CANCELACION DE CUENTA',
            @i_operacion   = 'U',
            @i_cta         = @i_cta
        end
      end
      update cob_ahorros..ah_cuenta
      set    ah_estado = 'C',
             ah_int_hoy = $0,
             ah_disponible = 0,--@o_slddisp,                           
             ah_saldo_libreta = $0,
             ah_saldo_interes = $0,
             ah_int_mes = $0,
             ah_interes_ganado = $0,
             ah_monto_bloq = $0,
             ah_monto_imp = @w_monto_imp_total,
             ah_num_blqmonto = 0,
             ah_promedio1 = round(isnull(@w_promedio1,
                                         0),
                                  @w_numdeci),
             ah_prom_disponible = round (isnull(@w_prom_disponible,
                                                0),
                                         @w_numdeci),
             ah_debitos = ah_debitos + @w_valcie + @o_multa + @o_valir + isnull(
                          @w_imp2, 0)
                          + isnull(@w_monto_imp_retiro, 0) + isnull(
                          @w_monto_imp_multa, 0),
             ah_debitos_hoy = ah_debitos_hoy + @w_valcie + @o_multa + @o_valir +
                              isnull(
                              @w_imp2, 0)
                              + isnull(@w_monto_imp_retiro, 0) + isnull(
                              @w_monto_imp_multa,
                              0 ),
             ah_creditos = ah_creditos + @o_sldint + @w_gmf_reitengro_cie,
             ah_creditos_hoy = ah_creditos_hoy + @o_sldint +
                               @w_gmf_reitengro_cie,
             ah_fecha_ult_mov = @s_date,
             ah_control = @o_control,
             ah_contador_trx = ah_contador_trx + 1,
             ah_min_dispmes = 0,
             ah_saldo_mantval = 0
      where  ah_cuenta = @w_cuenta

      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro en ah_cuenta */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 255001
        return 255001
      end

      update cobis..cl_det_producto
      set    dp_estado_ser = 'C'
      where  dp_cuenta   = @i_cta
         and dp_producto = 4

      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro en cl_det_producto */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105050
        return 105050
      end

      update cob_ahorros..ah_val_suspenso
      set    vs_procesada = 'S',
             vs_estado = 'C'
      where  vs_procesada = 'N'
         and vs_cuenta    = @w_cuenta

      if @@error <> 0
      begin
        /* Error en actualizacion de valor en suspenso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205013
        return 205013
      end
    end -- ICOBRA CERO         

    commit tran

    select
      @o_int_cap = round (@o_int_cap,
                          @w_numdeci),
      @o_sldint = round (@o_sldint,
                         @w_numdeci),
      @o_impuesto = round (@o_impuesto,
                           @w_numdeci_imp),
      @o_multa = round (@o_multa,
                        @w_numdeci),
      @o_monto_imp = round (@w_monto_imp,
                            @w_numdeci),
      @o_monto_imp_ret = round (@w_monto_imp_retiro,
                                @w_numdeci_imp),
      @o_gmf_valcie = round (@w_gmf_valcie,
                             @w_numdeci_imp),
      @o_sldmantval = @w_sldmantval,
      @o_idlote = @w_idlote,
      @o_secuencial = @w_num_orden,
      @o_valir = round(@o_valir,
                       @w_numdeci),
      @o_gmf_reitengro_cie = isnull(@w_gmf_reitengro_cie,
                                    0)

    if @t_ejec = 'R'
    begin
      exec @w_return = cob_ahorros..sp_resultados_branch_ah
        @s_ssn_host    = @s_ssn,
        @i_cuenta      = @w_cuenta,
        @i_fecha       = @s_date,
        @i_ofi         = @s_ofi,
        @i_tipo_cuenta = 'O'

      if @w_return <> 0
        return @w_return
    end
    return 0
  end -- trn 213                

go

