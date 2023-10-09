/************************************************************************/
/*  Archivo               : icuentas.sp                                 */
/*  Stored procedure      : sp_icuentas                                 */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 29 de Noviembre de 2016                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa busca desacoplar el modulo de cuentas corrientes con  */
/*  el modulo de plazo fijo                                             */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Oscar Saavedra     Emision Inicial DPF-H91368        */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_icuentas')
   drop proc sp_icuentas
go

create proc sp_icuentas(
   @s_ssn               int             = NULL,
   @s_date              datetime        = NULL,
   @s_term              varchar(30)     = NULL,
   @s_sesn              int             = NULL,
   @s_srv               varchar(30)     = NULL,
   @s_lsrv              varchar(30)     = NULL,
   @s_user              varchar(30)     = NULL,
   @s_ofi               smallint        = NULL,
   @s_rol               smallint        = NULL,
   @s_org               char(1)         = NULL,
   @s_sev               tinyint         = NULL,
   @s_ssn_branch        int             = NULL,
   @t_from              varchar(32)     = NULL,
   @t_ssn_corr          int             = NULL,
   @t_rty               char(1)         = NULL,
   @t_debug             char(1)         = NULL,
   @t_file              varchar(14)     = NULL,
   @t_trn               smallint        = NULL,
   @t_corr              char(1)         = NULL,
   @p_lssn              int             = NULL,
   @t_tcorr             char(1)         = NULL,
   @p_rssn_corr         int             = NULL,
   @i_operacion         varchar(2)      = NULL,
   @i_oficina           int             = NULL,
   @i_cod_ml            smallint        = NULL, 
   @i_cta_bco_gerencia  varchar(24)     = NULL,
   @i_pit               int             = NULL,
   @i_cau               char(1)         = NULL,
   @i_cla               char(1)         = NULL,
   @i_orimod            varchar(3)      = NULL,
   @i_spid              int             = NULL,
   @i_serie_desde_aux   int             = NULL,
   @i_cta_gerencia      int             = NULL,
   @i_cta_banco         varchar(24)     = NULL,
   @i_cta_ger           varchar(24)     = NULL,
   @i_tarjeta           varchar(24)     = NULL,
   @i_cuenta            int             = NULL,
   @i_cheque            int             = NULL,
   @i_val_cta           char(1)         = NULL,
   @i_fecha_proceso     datetime        = NULL,
   @i_moneda            int             = NULL,
   @i_codigo_conv       smallint        = NULL,
   @i_val               money           = NULL,
   @i_nchq              int             = NULL,
   @i_factor            int             = NULL,
   @i_cod_conv          int             = NULL,
   @i_benef             varchar(64)     = NULL,
   @i_tipo_ben          varchar(1)      = NULL,
   @i_nomtrn            varchar(20)     = NULL,
   @i_cod_operacion     int             = NULL,
   @i_serie_desde       int             = NULL,
   @i_serie_hasta       int             = NULL,
   @i_causa_lev         char(1)         = NULL,
   @i_causa             char(1)         = NULL,
   @i_causager          char(1)         = NULL,
   @i_sec_producto      int             = NULL,
   @i_filial            int             = NULL,
   @i_gerencia          char(1)         = NULL,
   @i_cod_alterno       int             = NULL,
   @i_codigo_alterno    int             = NULL,
   @i_clase             char(1)         = NULL,
   @i_monto             money           = NULL,
   @i_enlinea           char(1)         = NULL,
   @i_total             money           = NULL,
   @i_pit_cta           char(1)         = NULL,
   @i_cliente           int             = NULL,
   @i_ver_nodo          char(1)         = NULL,
   @i_autorizado        char(1)         = NULL,
   @i_concepto          varchar(64)     = NULL,
   @i_fecha_valor_a     datetime        = NULL,
   @i_fecha             datetime        = NULL,
   @i_fecha_ini         datetime        = NULL,
   @i_fecha_fin         datetime        = NULL,
   @i_tipo              char(1)         = NULL,
   @i_reentry           char(1)         = NULL,
   @i_cert              varchar(14)     = NULL,
   @i_efe               money           = NULL,
   @i_op_ente           int             = NULL,
   @i_prod_banc         int             = NULL,
   @i_estado            int             = NULL,
   @i_contratado        money           = NULL,
   @i_ocasional         money           = NULL,
   @i_categoria         char(1)         = NULL,
   @i_func_creador      varchar(30)     = NULL,
   @i_trn_dbcr          smallint        = NULL,
   @i_numero_cuenta     varchar(64)     = NULL,
   @i_causa_al          varchar(3)      = NULL,
   @i_ssn_al            int             = NULL,
   @i_num_cta_ahorro    varchar(16)     = NULL,
   @i_valor             money           = NULL,
   @i_campo             varchar(20)     = NULL,
   @i_campo1            varchar(20)     = NULL,
   @o_ctacte            int             = NULL OUT,
   @o_tipo_bloqueo      varchar(10)     = NULL OUT,
   @o_saldo_para_girar  money           = NULL OUT,
   @o_saldo_contable    money           = NULL OUT,
   @o_cuenta            varchar(24)     = NULL OUT,
   @o_rowcount          int             = NULL OUT,
   @o_cta_bco_gerencia  varchar(24)     = NULL OUT,
   @o_existe_chq        int             = NULL OUT,
   @o_existe_chq_h      int             = NULL OUT,
   @o_existe_chq_t      int             = NULL OUT,
   @o_existe_cta        int             = NULL OUT,
   @o_cta_gerencia      int             = NULL OUT,
   @o_estado_actual     varchar(1)      = NULL OUT,
   @o_estado_anterior   varchar(1)      = NULL OUT,
   @o_causa_np          char(3)         = NULL OUT,
   @o_clase_np          char(1)         = NULL OUT,
   @o_fecha_reg         datetime        = NULL OUT,
   @o_plazo_reint       smallint        = NULL OUT,
   @o_tipo_conv         char(1)         = NULL OUT,  
   @o_conv              int             = NULL OUT,
   @o_cuenta_cte        int             = NULL OUT,
   @o_cta_ger           varchar(24)     = NULL OUT,
   @o_valnxmil          money           = NULL OUT,
   @o_desacople_cta     varchar(1)      = NULL OUT,
   @o_existe_cte        int             = NULL OUT,
   @o_saldo_d           money           = NULL OUT,
   @o_saldo_c           money           = NULL OUT,
   @o_existe_ger        int             = NULL OUT,
   @o_valor             money           = NULL OUT,
   @o_nom_conv          varchar(255)    = NULL OUT,
   @o_cheque            int             = NULL OUT,
   @o_cc_cta_banco      varchar(14)     = NULL OUT,
   @o_existe_cta_act    int             = NULL OUT,
   @o_tipochq           estado          = NULL OUT
   )
with encryption   
as
declare
   @w_error             int,
   @w_return            int,
   @w_mensaje           varchar(255), 
   @w_producto          smallint,
   @w_total_gmf         money,
   @w_acumu_deb         money,
   @w_base_gmf          money,
   @w_sp_name           varchar(50),
   @w_actualiza         varchar(10),
   @w_cuenta            int,
   @w_estado_actual     varchar(1),
   @w_estado_anterior   varchar(1),
   @w_causa_np          char(3),
   @w_clase_np          char(1),
   @w_fecha_reg         datetime,
   @w_val_3xmil         money,
   @w_saldo_d           money,
   @w_saldo_c           money,
   @w_valor             money

select @w_sp_name = 'sp_icuentas'
select @w_error   = 0

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 3
  and pd_estado   = 'V'

if @w_producto = 0
begin
  /* MAPEO DE VARIABLES */
  select @o_ctacte            = 0
  select @o_cuenta            = null
  select @o_rowcount          = null
  select @o_cta_bco_gerencia  = null
  select @o_existe_chq        = 0
  select @o_cta_gerencia      = 0
  select @o_estado_actual     = ''
  select @o_estado_anterior   = ''
  select @o_causa_np          = ''
  select @o_clase_np          = ''
  select @o_fecha_reg         = '01/01/2000'
  select @o_plazo_reint       = 0  
  select @o_conv              = 0
  select @o_tipo_conv         = ''
  select @o_cuenta_cte        = 0
  select @o_existe_chq        = 0
  select @o_existe_chq_h      = 0
  select @o_existe_chq_t      = 0
  select @o_valnxmil          = 0
  select @o_cta_ger           = ''
  select @o_desacople_cta     = 'S'
  select @o_existe_cte        = 0
  select @o_saldo_d           = 0
  select @o_saldo_c           = 0 
  select @o_existe_cta        = 0
  select @o_existe_ger        = 0
  select @o_valor             = 0
  select @o_nom_conv          = null
  select @o_cheque            = null
  select @o_tipo_bloqueo      = null
  select @o_cc_cta_banco      = null
  select @o_existe_cta_act    = 0
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */

/*

if @w_producto > 0 
begin
   select @o_desacople_cta = 'N'
   
   if @i_operacion = 'A'
   begin

      if @i_cta_bco_gerencia is not null
         select @i_cta_ger = @i_cta_bco_gerencia 
      
      select @o_cuenta_cte     = cc_ctacte,
             @o_cta_gerencia   = cc_ctacte,
             @o_existe_cta_act = count(1)
        from cob_cuentas..cc_ctacte
       where cc_cta_banco  = @i_cta_ger
         and (cc_estado    = @i_estado or @i_estado is null) 
         and (cc_moneda    = @i_moneda or @i_moneda is null)
 
      if @@rowcount = 0
      begin
         select @w_erorr = 141047
         goto ERROR
      end

      select @o_cuenta          = cg_cuenta,
             @o_existe_cta      = count(1),
             o_cta_bco_gerencia = cg_cuenta
      from cob_cuentas..cc_cta_gerencia
      where (cg_oficina = @s_ofi     or @s_ofi     is null)
        and (cg_oficina = @i_oficina or @i_oficina is null)
        and (cg_moneda  = @i_cod_ml  or @i_cod_ml  is null)
        and (cg_cuenta  = @i_cta_ger or @i_cta_ger is null)
        and (cg_moneda  = @i_moneda  or @i_moneda  is null)
 
      if @@rowcount = 0
      begin
         select @w_erorr = 201082
         goto ERROR
      end

     select @o_existe_ger = count(1) 
      from cob_cuentas..cc_gerencia
      where ge_cuenta        = @i_cuenta          
        and ge_cheque        = @i_cheque          
        and ge_valor         = @i_val
        and ge_estado_actual = @i_estado

      if @@rowcount = 0
      begin
         select @w_erorr = 201082
         goto ERROR
      end
   end
   
   if @i_operacion = 'B'
   begin
      select @o_nom_conv = cv_nombre
      from cob_cuentas..cc_convenios
      where cv_codigo = @i_cod_conv   

      if @@rowcount = 0
      begin
         select @w_error = 201285 
         goto ERROR
      end
   end 
   
   if @i_operacion = 'C'
   begin
      select @o_existe_chq = COUNT(1) 
      from cob_cuentas..cc_cheque
      where cq_cheque = @i_serie_desde_aux
        and (cq_estado_actual <>'P' or cq_estado_actual <>'A')
        and cq_cuenta = @i_cta_gerencia
        
      if @o_existe_chq is null
         select @o_existe_chq = 0
   end
   
   if @i_operacion = 'D'
   begin
   
      exec @w_return = cob_cuentas..sp_valida_cheque
           @t_debug            = @t_debug,
           @t_file             = @t_file,
           @t_from             = @w_sp_name,
           @i_cuenta           = @i_cta_ger, 
           @i_cheque           = @i_cheque, 
           @i_val_cta          = @i_val_cta,    
           @i_moneda           = @i_moneda,
           @o_estado_actual    = @w_estado_actual      out, 
           @o_estado_anterior  = @w_estado_anterior    out, 
           @o_causa_np         = @w_causa_np           out, 
           @o_clase_np         = @w_clase_np           out,
           @o_fecha_reg        = @w_fecha_reg          out,
           @o_valor            = @w_valor              out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      select @o_estado_actual   = @w_estado_actual,
             @o_estado_anterior = @w_estado_anterior,
             @o_causa_np        = @w_causa_np,
             @o_clase_np        = @w_clase_np,
             @o_fecha_reg       = @w_fecha_reg,
             @o_valor           = @w_valor             
   end 
   
   if @i_operacion = 'E'
   begin
      exec  @w_return = cob_cuentas..sp_emision_cheque_gerencia
            @s_ssn        = @s_ssn,
            @s_srv        = @s_srv,
            @s_lsrv       = @s_lsrv,
            @s_user       = @s_user,
            @s_term       = @s_term,
            @s_date       = @s_date,
            @s_ofi        = @s_ofi,
            @s_org        = @s_org,
            @t_ssn_corr   = @t_ssn_corr,
            @s_sev        = @s_sev,
            @p_lssn       = @p_lssn,
            @p_rssn_corr  = @p_rssn_corr,
            @t_trn        = 91,
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @t_from,
            @t_rty        = @t_rty,
            @i_cuenta     = @i_cuenta,
            @i_val        = @i_val,
            @i_nchq       = @i_nchq,
            @i_mon        = @i_moneda,
            @i_factor     = @i_factor,
            @i_fecha      = @s_date,
            @i_benef      = @i_benef,
            @i_tipo_ben   = @i_tipo_ben,
            @i_causager   = @i_causager,
            @i_filial     = @i_filial,
            @i_orimod     = @i_orimod,
            @i_pit        = @i_pit,
            @t_corr       = 'N',
            @i_causa      = '000'

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end 
 
   if @i_operacion = 'F'
   begin
      exec @w_return = cob_cuentas..sp_tr_lev_anl_chq
           @s_ssn        = @s_ssn,
           @s_srv        = @s_srv,
           @s_lsrv       = @s_lsrv,
           @s_user       = @s_user,
           @s_sesn       = @s_sesn,
           @s_term       = @s_term,
           @s_date       = @s_date,
           @s_ofi        = @s_ofi,
           @s_rol        = @s_rol,
           @s_org        = @s_org,
           @t_trn        = 2572,
           @i_cta        = @i_cta_ger,
           @i_mon        = @i_moneda,
           @i_desde      = @i_serie_desde,
           @i_hasta      = @i_serie_hasta
             
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

   end
   
   if @i_operacion = 'G'
   begin   
        select @o_cuenta = cg_cuenta
        from cob_cuentas..cc_cta_gerencia a, cob_sbancarios..sb_operacion b
        where a.cg_oficina         = b.op_oficina 
          and b.op_cod_operacion    = @i_cod_operacion
          and a.cg_moneda            = @i_moneda
   end
   
   if @i_operacion = 'H'
   begin
   
      exec @w_return = cob_cuentas..sp_tr_lev_revochq
           @s_ssn        = @s_ssn,
           @s_srv        = @s_srv,
           @s_lsrv       = @s_lsrv,
           @s_user       = @s_user,
           @s_sesn       = @s_sesn,
           @s_term       = @s_term,
           @s_date       = @s_date,
           @s_ofi        = @s_ofi,
           @s_rol        = @s_rol,
           @s_org        = @s_org,
           @t_trn        = 2572,
           @i_cta        = @i_cta_ger,
           @i_val        = @i_val,
           @i_nchq       = @i_nchq,
           @i_mon        = @i_moneda,
           @i_causa      = @i_causa_lev 
               
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'I'
   begin
      
        select @o_cuenta = cg_cuenta
        from cob_cuentas..cc_cta_gerencia a, cob_sbancarios..sb_impresion_lotes b
        where a.cg_oficina    = b.il_oficina_destino 
        and   b.il_secuencial = @i_sec_producto
        and   a.cg_moneda     = @i_moneda
   end
   
   if @i_operacion = 'J'
   begin
      select @o_cheque = cq_cheque
      from cob_cuentas..cc_cheque
      where (cq_estado_actual = 'P' or cq_estado_actual = 'A')
        and  cq_cuenta = @i_cta_ger
   end
   
   /*
   if @i_operacion = 'K'
   begin
      exec @w_return = cob_cuentas..sp_tr_tarjvisa
           @s_ssn          = @s_ssn,
           @s_lsrv         = @s_lsrv,
           @s_date         = @s_date,
           @s_org          = @s_org,
           @s_user         = @s_user,
           @s_ofi          = @s_ofi,
           @s_srv          = @s_srv,
           @s_ssn_branch   = @s_ssn_branch,
           @s_term         = @s_term,
           @s_rol          = @s_rol,
           @t_corr         = @t_tcorr,
           @t_ssn_corr     = @t_ssn_corr,
           @t_trn          = @t_trn,
           @t_ejec         = 'N',
           @i_ActTot       = 'N',
           @i_acredita     = 'N',        --CVA May-12-06
           @i_total        = @i_total,
           @i_tarjeta      = @i_tarjeta,
           @i_filial       = @i_filial,
           @i_mon          = @i_moneda,
           @i_mon_tarjeta  = @i_moneda,
           @i_cod_alterno  = @i_cod_alterno, --+-+
           @i_val          = @i_val,
           @i_canal        = 37 --DPF CVA May-22-06           

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end   
   end
   */
   
   if @i_operacion = 'L'
   begin
   
      select @o_plazo_reint = cv_plazo_reintegro,
             @o_tipo_conv   = cv_tipo_convenio,
             @o_conv        = cv_codigo      
      from cob_cuentas..cc_convenios
      where cv_codigo          = @i_codigo_conv
        and cv_plazo_reintegro > 0
   end
   
   if @i_operacion = 'M'
   begin
   
      exec @w_return = cob_cuentas..sp_tr_anl_chq_ncosto
           @s_srv      = @s_srv,
           @s_lsrv     = @s_lsrv,
           @s_ssn      = @s_ssn,
           @s_rol      = @s_rol,
           @s_ofi      = @s_ofi,
           @s_date     = @s_date,
           @s_user     = @s_user,
           @s_sesn     = @s_sesn,
           @s_term     = @s_term,
           @s_org      = @s_org,
           @t_trn      = 2507,
           @i_cta      = @i_cta_ger,
           @i_mon      = @i_moneda,
           @i_desde    = @i_serie_desde,
           @i_hasta    = @i_serie_hasta,
           @i_clase    = @i_clase,   /* cc_clase_np : (P)Permanente  */
           @i_causa    = @i_causa,
           @i_aut      = @s_user,
           @i_alt      = @i_codigo_alterno

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'N'
   begin
      exec @w_return = cob_cuentas..sp_revocatoria_cheques
           @s_srv      = @s_srv,
           @s_lsrv     = @s_lsrv,
           @s_ssn      = @s_ssn,
           @s_rol      = @s_rol,
           @s_ofi      = @s_ofi,
           @s_date     = @s_date,
           @s_user     = @s_user,
           @s_term     = @s_term,
           @t_trn      = @t_trn,
           @i_cta      = @i_cta_ger,
           @i_cau      = @i_cau,      /* cc_causa_np : (T)Destruccion */
           @i_cla      = @i_cla,      /* cc_clase_np : (P)Permanente  */
           @i_nchq     = @i_nchq,
           @i_valch    = @i_val,
           @i_mon      = @i_moneda,
           @i_factor   = @i_factor,
           @i_fecha    = @s_date,
           @i_benef    = @i_benef 

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end

   if @i_operacion = 'O'
   begin
        select @o_existe_chq = COUNT(1)
        from cob_cuentas..cc_chequera 
        where ch_cuenta = @i_cuenta
          and ch_estado = 'E'
          and (@i_serie_desde  >= ch_inicial and 
               @i_serie_desde  <= (ch_inicial+ch_numero-1))
               
        select @o_existe_chq = COUNT(1)
        from cob_cuentas..cc_chequera 
        where ch_cuenta = @i_cuenta
          and ch_estado = 'E'
          and (@i_serie_hasta  >= ch_inicial and 
               @i_serie_hasta  <= (ch_inicial+ch_numero-1))
                
        select @o_existe_chq_t = COUNT(1) 
        from cob_cuentas..cc_cheque
        where cq_cuenta = @i_cuenta
          and cq_cheque >= @i_serie_desde and cq_cheque <= @i_serie_hasta        
   end
   
   if @i_operacion = 'P'
   begin
       exec @w_return = cob_cuentas..sp_ccndc_automatica
            @s_srv             = @s_srv,
            @s_ofi             = @s_ofi,
            @s_ssn             = @s_ssn,
            @s_ssn_branch      = @s_ssn_branch,
            @s_user            = @s_user,
            @s_term            = @s_term,
            @t_ssn_corr        = @t_ssn_corr,
            @i_nomtrn          = @i_nomtrn,
            @t_trn             = @t_trn,
            @t_corr            = 'S', 
            @i_corr            = 'S',
            @i_cta             = @i_cta_ger,
            @i_val             = @i_val,
            @i_cau             = @i_cau,
            @i_mon             = @i_monto,
            @i_moneda          = @i_moneda,
            @i_fecha           = @s_date,
            @i_enlinea         = @i_enlinea,
            @i_concepto        = @i_concepto,
            @i_autorizado      = @i_autorizado,
            @i_alt             = @i_codigo_alterno,
            @i_fecha_valor_a   = @i_fecha_valor_a,
            @i_pit             = @i_pit_cta,
            @o_valnxmil        = @w_val_3xmil out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end

   if @i_operacion = 'Q'
   begin
   
      select @o_conv    = cv_codigo,
             @o_cta_ger = ltrim(rtrim(cv_num_cta))      
      from cob_cuentas..cc_convenios
      where cv_codigo = @i_codigo_conv
   end

   if @i_operacion = 'R'
   begin
      exec @w_return = cob_cuentas..sp_cta_vigente
           @s_ofi            = @s_ofi,   --OFICINA ORIGINADORA
           @s_srv            = @s_srv,   --SERVIDOR AL QUE ESTAN CONECTADOS
           @i_ver_nodo       = 'S',      --FLAG DE VERIFICACION DE FUERA DE LINEA
           @i_val            = @i_val,   --VALOR DE LA TRANSACCION
           @i_cta_banco      = @i_cta_ger,   --CUENTA
           @i_moneda         = @i_moneda    --MONEDA      

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'S'
   begin
      select 'COD. CLIENTE'    = cl_cliente,
             'NOM. CLIENTE'    = en_nomlar
        from cob_cuentas..cc_ctacte,    
             cobis..cl_det_producto,
             cobis..cl_cliente,
             cobis..cl_ente                
        where cc_cta_banco        = @i_cta_ger
          and cc_estado           = 'A'
          and cc_moneda           = @i_moneda
          and dp_cuenta           = cc_cta_banco
          and dp_producto         = 3
          and cl_det_producto     = dp_det_producto
          and cl_rol              in ('T', 'C')
          and en_ente             = cl_cliente
        order by cl_rol desc
   end
   
   if @i_operacion = 'T'
   begin
         select 'CUENTA'        = cc_cta_banco,
                'COD. CLIENTE'  = cl_cliente,
                'NOM. CLIENTE'  = en_nomlar
      from cobis..cl_det_producto,
           cobis..cl_cliente,
           cobis..cl_ente,
           cob_cuentas..cc_ctacte
      where dp_producto     = 3
        and dp_moneda       = @i_moneda
        and dp_det_producto = cl_det_producto
        and ((cl_cliente = @i_cliente) or (@i_cliente is null))
        and cl_rol          in ('T', 'C')
        and en_ente         = cl_cliente    
        and cc_cta_banco    = dp_cuenta
        and cc_estado       = 'A'
      order by dp_cuenta
   end
   
   if @i_operacion = 'T'
   begin
         select 'CUENTA'          = cc_cta_banco,
                'COD. CLIENTE'    = cl_cliente,
                'NOM. CLIENTE'    = en_nomlar
      from cobis..cl_det_producto,
           cobis..cl_cliente,
           cobis..cl_ente,
           cob_cuentas..cc_ctacte
      where dp_det_producto    = cl_det_producto
        and cl_cliente         = en_ente
        and dp_cuenta          = cc_cta_banco
        and dp_producto        = 3
        and cc_estado          = 'A'
        and cc_moneda          = @i_moneda
        and cl_rol             in ('T', 'C')
        and dp_cuenta          > @i_cta_ger
        and ((cl_cliente = @i_cliente) or (@i_cliente is null))
      order by dp_cuenta
   end
   
   if @i_operacion = 'U'
   begin
       exec @w_return = cob_cuentas..sp_tr_query_nom_ctacte
            @s_srv   = @s_srv,
            @s_lsrv  = @s_lsrv,
            @s_ofi   = @s_ofi,
            @i_cta   = @i_cta_ger,
            @i_mon   = @i_moneda   

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'V'
   begin
      exec @w_return = cob_cuentas..sp_calcula_saldo
           @i_cuenta           = @i_cuenta,
           @i_fecha            = @s_date,
           @i_ofi              = @s_ofi,
           @o_saldo_para_girar = @w_saldo_d out,
           @o_saldo_contable   = @w_saldo_c out
           
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      select @o_saldo_d = @w_saldo_d
      select @o_saldo_c = @w_saldo_c
   end
   
   if @i_operacion = 'W'
   begin
       exec @w_return = cob_cuentas..sp_cta_vigente 
            @s_ofi            = @s_ofi,   --OFICINA ORIGINADORA
            @s_srv            = @s_srv,   --SERVIDOR AL QUE ESTAN CONECTADOS
            @i_ver_nodo       = @i_ver_nodo,      --FLAG DE VERIFICACION DE FUERA DE LINEA
            @i_val            = @i_val,   --VALOR DE LA TRANSACCION
            @i_cta_banco      = @i_cta_ger,   --CUENTA
            @i_moneda         = @i_moneda,    --MONEDA 
            @i_gerencia       = @i_gerencia  

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'X'
   begin
   
      select 20
      
      select top 20 'Cuenta'        = cc_cta_banco,
                    'Producto'      = 'CTE'
      from cobis..cl_det_producto,
           cobis..cl_cliente,
           cob_cuentas..cc_ctacte
      where cc_cta_banco    = dp_cuenta
        and dp_det_producto = cl_det_producto 
        and dp_producto     = 3
        and dp_cuenta       > @i_cta_ger
        and cl_cliente      = @i_cliente
        and cl_rol          in ('T', 'C')
        and cc_cta_banco    > @i_cta_ger
        and cc_estado       in ('A', 'I')
      order  by cc_cta_banco
   end
   
   if @i_operacion = 'Y'
   begin   
      exec @w_return = cob_cuentas..sp_pago_cheque_automatico         
           @s_ssn       = @s_ssn,
           @s_srv       = @s_srv,
           @s_user      = @s_user,  /* func. que creo la operacion */
           @s_sesn      = @s_sesn,
           @s_term      = @s_term,
           @s_date      = @s_date,
           @s_org       = @s_org,
           @s_ofi       = @s_ofi,
           @s_rol       = @s_rol,
           @t_debug     = @t_debug,
           @t_trn       = @t_trn,
           @t_corr      = 'S',
           @t_ssn_corr  = @s_ssn,
           @t_file      = 'sp_pago_cheque_automatico',
           @t_from      = 'sp_pago_cheque_automatico',
           @i_ofi       = @s_ofi,
           @i_cta       = @i_cta_ger,
           @i_cheque    = @i_cheque,
           @i_prod      = 'CTE',
           @i_valor     = @i_monto,
           @i_factor    = 1,
           @i_fecha     = @s_date,
           @i_duplicado = 'N',
           @i_mon       = @i_moneda,
           @i_alterno   = @i_codigo_alterno 
        
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'Z'
   begin
       exec @w_return = cob_cuentas..sp_levantamiento_revocatoria
            @s_ssn        = @s_ssn,
            @s_date       = @s_date,
            @s_sesn       = @s_sesn,
            @s_org        = @s_org,
            @s_srv        = @s_srv,
            @s_lsrv       = @s_lsrv,
            @s_user       = @s_user,
            @s_term       = @s_term,
            @s_ofi        = @s_ofi,
            @s_rol        = @s_rol,
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @t_from,
            @t_rty        = @t_rty,
            @t_trn        = @t_trn,
            @i_operacion  = 'U',
            @i_cta        = @i_cta_ger,
            @i_mon        = @i_moneda,
            @i_nchq       = @i_nchq,
            @i_val        = @i_monto,
            @i_cau        = @i_cau,
            @i_causa      = @i_causa,
            @i_alterno    = @i_codigo_alterno 
  
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'AA'
   begin
      if OBJECT_ID(N'tempdb..#cheques', N'U') is not null
      begin
         insert into #cheques(
         oficina,
         des_oficina,
         cheque,
         fecha_emision,
         nom_benef,
         ide_benef,
         valor,
         concepto,
         destino,
         base_gmf,
         valor_gmf,
         estado,
         usuario)
         select 
         oficina       = np_oficina,
         des_oficina   = (select top 1 of_nombre from cobis..cl_oficina with (nolock) where of_oficina = X.np_oficina),
         cheque        = cq_cheque,   
         fecha_emision = cq_fecha_reg,
         nom_benef     = cb_beneficiario,
         ide_benef     = convert(varchar(24),''),
         valor         = cq_valor,
         concepto      = convert(varchar(255),''),
         destino       = isnull((select top 1 CAT.valor from cobis..cl_tabla TAB with (nolock), cobis..cl_catalogo CAT with (nolock)
                          where Y.hs_tipo_transaccion = 91
                          and   TAB.tabla  = 'cc_concepto_emision'
                          and   TAB.codigo = CAT.tabla
                          and   CAT.codigo = Y.hs_causa), 'NO EXISTE VALOR DE CATALOGO: ' + convert(varchar(10),hs_causa)),
         base_gmf      = case when cq_estado_actual <> 'A' then round(hs_saldo, 2) else 0 end,
         valor_gmf     = case when cq_estado_actual <> 'A' then round(hs_monto, 2) else 0 end,
         estado        = 'No Emitido           ',
         usuario       = hs_usuario
         from  cob_cuentas..cc_cheque X with (nolock),cob_cuentas..cc_ctacte with (nolock), cob_cuentas..cc_chq_beneficiario with (nolock), cob_cuentas_his..cc_his_servicio Y with (nolock)
         where cq_fecha_reg    >= @i_fecha_ini
         and   cq_fecha_reg    <= @i_fecha_fin
         and   cq_cuenta       = cc_ctacte
         and   cb_cuenta       = cq_cuenta
         and   cb_cheque       = cq_cheque
         and   hs_cta_banco    = cc_cta_banco
         and   hs_cheque_desde = cq_cheque
         and   hs_tipo_transaccion = 91
         order by np_oficina, cq_estado_actual, ge_tipo_ben
      end
   end
   
   if @i_operacion = 'AB'
   begin
      select @o_ctacte    = cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cta_banco
      and    cc_estado not in ('G','C')
   end
   
   if @i_operacion = 'AC'
   begin
      select @o_tipo_bloqueo = cb_tipo_bloqueo
      from   cob_cuentas..cc_ctabloqueada
      where  cb_cuenta       = @i_cuenta
      and    cb_estado       = 'V'
      and   (cb_tipo_bloqueo = @i_tipo or cb_tipo_bloqueo = '3')
   end
   
   if @i_operacion = 'AD'
   begin
      if OBJECT_ID(N'tempdb..#cl_transacciones_of', N'U') is not null
      begin
         insert into #cl_transacciones_of
         select 
         @i_fecha_proceso,
         hs_oficina,
         NULL,
         NULL,
         NULL,
         NULL,
         NULL,
         (select c.valor from cobis..cl_catalogo c where c.tabla = (select t.codigo from cobis..cl_tabla t where  t.tabla = 'cr_meses') and c.codigo = datepart(mm,hs_tsfecha)),
         right('00' + convert(varchar(2),datepart(dd,hs_tsfecha)),2),
         (select eq_val_num_fin from cob_remesas..re_equivalencias where eq_tabla = 'REPOFIR549' and eq_val_cfijo = convert(varchar(10),hs_tipo_transaccion)),
         hs_tipo_transaccion,
         0,
         hs_saldo,
         0,
         0,
         hs_tsfecha,
         hs_cta_banco
         from  cob_cuentas_his..cc_his_servicio 
         where hs_tsfecha between @i_fecha_ini and @i_fecha_fin
         and   hs_tipo_transaccion in (14545)
         order by hs_oficina
      end
   end
   
   if @i_operacion = 'AE'
   begin
      select @o_tipo_bloqueo = cb_tipo_bloqueo
      from   cob_cuentas..cc_ctabloqueada
      where  cb_cuenta       = @i_cuenta
      and    cb_estado       = 'V'
      and   (cb_tipo_bloqueo = '2' or cb_tipo_bloqueo = '3')
   end
   
   if @i_operacion = 'AF'
   begin
      select @o_cc_cta_banco = cc_cta_banco
      from   cob_cuentas..cc_ctacte
      where  cc_cliente      = @i_op_ente      
      and    cc_moneda       = @i_moneda
      and    cc_estado       = 'A'
      order by cc_cta_banco  
   end
   
   if @i_operacion = 'AG'
   begin
      insert into cob_cuentas..cc_tran_servicio(
      ts_secuencial,    ts_ssn_branch,   ts_tipo_transaccion,   ts_tsfecha,
      ts_usuario,       ts_terminal,     ts_oficina,            ts_reentry,
      ts_origen,        ts_cta_banco,    ts_saldo,              ts_moneda,
      ts_oficina_cta,   ts_prod_banc,    ts_categoria,          ts_correccion,
      ts_ssn_corr,      ts_estado,       ts_monto,              ts_contratado,
      ts_ocasional)
      values (
      @s_ssn,           @s_ssn_branch,   @t_trn,                @s_date,
      @s_user,          @s_term,         @s_ofi,                @i_reentry,
      @s_org,           @i_cert,         @i_efe,                @i_moneda,
      @i_oficina,       @i_prod_banc,    @i_categoria,          @t_corr,
      @t_ssn_corr,      @i_estado,       @i_monto,              @i_contratado,
      @i_ocasional)   
      
      if @@error <> 0 begin
         exec cobis..sp_cerror
              @t_debug      = @t_debug,
              @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 143005
         return 143005
      end
   end
   
   if @i_operacion = 'AH'
   begin
      begin tran
      
      update cob_cuentas..cc_tran_servicio
      set    ts_estado     = @i_estado
      where  ts_ssn_branch = @t_ssn_corr
      and    ts_oficina    = @s_ofi
      
      if @@rowcount <> 1
      begin
         if @@trancount > 0
            rollback tran
         /* Error en actualizacion de registro en cc_tran_servicio */
         exec cobis..sp_cerror
              @t_debug      = @t_debug,
              @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 205043
         return 1
      end     
      commit tran
   end

   if @i_operacion = 'AI'
   begin
      select 
            @i_cta_ger = cg_cuenta
      from  cob_cuentas..cc_cta_gerencia, 
            sb_operacion
      where cg_oficina = op_oficina
        and cg_moneda = @i_cod_conv
        and op_cod_operacion = @i_cod_operacion
   end
   if @i_operacion = 'AJ'
   begin
      exec @w_return   = cob_cuentas..sp_tr_anl_chq_ncosto
           @s_srv      = @s_srv,
           @s_lsrv     = @s_lsrv,
           @s_ssn      = @s_ssn,
           @s_rol      = @s_rol,
           @s_ofi      = @s_ofi,
           @s_date     = @s_date,
           @s_user     = @s_user,
           @s_sesn     = @s_sesn,
           @s_term     = @s_term,
           @s_org      = @s_org,
           @t_trn      = 2507,
           @i_cta      = @i_cta_ger,
           @i_mon      = @i_cod_conv,
           @i_desde    = @i_serie_desde,
           @i_hasta    = @i_serie_hasta,
           @i_clase    = 'P',  /* cc_clase_np : (P)Permanente  */
           @i_causa    = 'T',  /* cc_causa_np : (T)Destruccion */
           @i_aut      = @s_user,
           @i_alt      = @i_codigo_alterno
           
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AK'
   begin
      select @i_cta_ger = cg_cuenta
        from cob_cuentas..cc_cta_gerencia
       where cg_oficina = @s_ofi
         and cg_moneda  = @i_cod_conv
   end
   if @i_operacion = 'AL'
   begin
      exec @w_return=cob_cuentas..sp_levantamiento_revocatoria  
           @s_ssn        = @s_ssn,
           @s_date       = @s_date,
           @s_sesn       = @s_sesn,
           @s_org        = @s_org,
           @s_srv        = @s_srv,
           @s_lsrv       = @s_lsrv,
           @s_user       = @s_user,
           @s_term       = @s_term,
           @s_ofi        = @s_ofi,
           @s_rol        = @s_rol,
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @t_from,
           @t_rty        = @t_rty,
           @t_trn        = 2512,
           @i_operacion  = 'U',
           @i_cta        = @i_cta_ger,
           @i_mon        = @i_cod_conv,
           @i_nchq       = @i_nchq,
           @i_val        = @i_monto,
           @i_cau        = ' ',
           @i_causa      = '400',
           @i_alterno    = 10
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AM'
   begin
      exec @w_return = cob_cuentas..sp_ccndc_automatica
           @s_srv        = @s_srv,
           @s_ofi        = @s_ofi,
           @s_ssn        = @s_ssn,
           @s_ssn_branch = @s_ssn,
           @s_user       = @i_func_creador,
           @t_trn        = @i_trn_dbcr,
           @i_cta        = @i_numero_cuenta,
           @i_val        = @i_monto,
           @i_cau        = @i_causa_al,
           @i_mon        = @i_cod_conv,
           @i_fecha      = @s_date,
           @i_corr       ='S',
           @t_ssn_corr   = @i_ssn_al,
           @i_alt        = @i_cod_operacion

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AN'
   begin
      exec @w_return    = cob_cuentas..sp_pago_cheque_automatico
           @s_ssn       = @s_ssn,
           @s_srv       = @s_srv,
           @s_user      = @i_func_creador,  /* func. que creo la operacion */
           @s_sesn      = @s_sesn,
           @s_term      = @s_term,
           @s_date      = @s_date,
           @s_org       = @s_org,
           @s_ofi       = @s_ofi,
           @s_rol       = @s_rol,
           @t_debug     = 'N',
           @t_trn       = 89,
           @t_corr      = @t_corr,
           @t_ssn_corr  = @i_ssn_al,
           @t_file      = 'sp_pago_cheque_automatico',
           @t_from      = 'sp_pago_cheque_automatico',
           @i_ofi       = @s_ofi,
           @i_cta       = @i_numero_cuenta,
           @i_cheque    = @i_cheque,
           @i_prod      = 'CTE',
           @i_valor     = @i_monto,
           @i_factor    = 1,
           @i_fecha     = @s_date,
           @i_duplicado = 'N',
           @i_mon       = @i_cod_conv,
           @i_alterno   = @i_cod_operacion,
           @o_tipochq   = @o_tipochq out
      
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AO'
   begin
      select o_existe_cta_act = 0
      select 
             o_existe_cta_act = 1
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = ltrim(rtrim(@i_num_cta_ahorro))
   end
   if @i_operacion = 'AP'
   begin
      exec @w_return       = cob_cuentas..sp_emision_cheque_gerencia
           @s_ofi          = @s_ofi,
           @s_org          = @s_org,
           @s_sev          = @s_sev,
           @s_user         = @s_user,
           @s_srv          = @s_srv,
           @s_term         = @s_term,
           @s_ssn          = @s_ssn,
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @t_from,
           @t_ssn_corr     = @t_ssn_corr,
           @t_trn          = 91,
           @t_rty          = @t_rty,
           @t_corr         = 'N',
           @p_lssn         = @p_lssn,
           @p_rssn_corr    = @p_rssn_corr,
           @i_nchq         = @i_nchq,
           @i_cuenta       = @i_cta_ger,
           @i_val          = @i_valor,
           @i_mon          = @i_cod_conv,
           @i_factor       = 1,
           @i_fecha        = @s_date,
           @i_benef        = @i_benef,
           @i_tipo_ben     = @i_tipo_ben,
           @i_alterno      = @i_cod_operacion,
           @i_ind          = 2,
           @i_causa        = @i_campo, -- Asociar Concepto de Emisión
           @i_refer        = @i_campo1
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AQ'
   begin
      exec @w_return = cob_cuentas..sp_anl_chq_ncosto_cc 
           @s_srv      = @s_srv,
           @s_lsrv     = @s_lsrv,
           @s_ssn      = @s_ssn,
           @s_sesn     = @s_sesn,
           @s_rol      = @s_rol,
           @s_ofi      = @s_ofi,
           @s_org      = @s_org,
           @s_date     = @s_date,
           @s_user     = @s_user,
           @s_term     = @s_term,
           @t_trn      = 2507,
           @i_cta      = @i_cta_ger,
           @i_mon      = @i_cod_conv,
           @i_desde    = @i_nchq,
           @i_hasta    = @i_nchq,
           @i_clase    = 'P',      /* cc_clase_np : (P)Permanente  */
           @i_causa    = 'T',      /* cc_causa_np : (T)Destruccion */
           @i_valor    = @i_valor,
           @i_aut      = '',
           @i_modulo   = 'SBA'
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   if @i_operacion = 'AR'
   begin
      exec @w_return = cob_cuentas..sp_ccndc_automatica
           @s_srv        = @s_srv,
           @s_ofi        = @s_ofi,
           @s_ssn        = @s_ssn,
           @s_ssn_branch = @s_ssn,
           @s_user       = @s_user,
           @t_trn        = @t_trn,
           @i_cta        = @i_numero_cuenta,
           @i_val        = @i_valor,
           @i_cau        = @i_causa_al,
           @i_mon        = @i_cod_conv,
           @i_fecha      = @s_date,
           @i_alt        = @i_cod_operacion,
           @o_valnxmil   = @o_valor out
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
end
*/
return 0

ERROR:
   /*no se pudo anular operacion*/
   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go