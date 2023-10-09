
/************************************************************************/ 
/*      Archivo:                afpcobis.sp                             */ 
/*      Stored procedure:       sp_afect_prod_cobis                     */ 
/*      Base de datos:          cob_cartera                             */ 
/*      Producto:               Cartera                                 */ 
/*      Disenado por:           R Garces                                */ 
/*      Fecha de escritura:     Ene 1998                                */ 
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
/* Procedimiento que permite generar las afectaciones a otros productos */    
/* COBIS por conceptos de pagos o desembolsos.                          */     
/************************************************************************/ 
/*                              MODIFICACIONES                          */ 
/*      FECHA           AUTOR           RAZON                           */ 
/*   23/abr/2010   Fdo Carvajal  Interfaz Ahorros-CCA                   */
/*   06/Jun/2010   Elcira Pelaez PAgo Automatico PAsivas                */
/*   24/Sep/2012   Luis C. Moreno CCA 341: Pagos Ctas Inactivas         */
/*   08/Ago/2019   A.ORTIZ     REQ.118442 Forma de pago garantia liquida */
/*   18/ene/2021   A.GONZALEZ  REQ.1479999 RENOVACIONES --               */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_afect_prod_cobis')
   drop proc sp_afect_prod_cobis
go 

create proc sp_afect_prod_cobis
@s_ssn                       int         = NULL, 
@s_sesn                      int         = NULL,
@s_term                      varchar(30) = NULL,
@s_user                      login       = NULL, 
@s_date                      datetime    = NULL, 
@s_srv                       varchar(30) = NULL,
@s_lsrv                      varchar(30) = null, 
@s_org                       char(1)     = null,      
@s_ofi                       smallint    = NULL,
@s_rol                       int         = 1,
@t_ssn_corr                  int         = NULL,
@i_debug                     char(1)     = 'N', -- FCP Interfaz Ahorros
@i_fecha                     datetime    = NULL,
@i_cuenta                    cuenta      = NULL,
@i_producto                  catalogo    = NULL,
@i_monto                     money       = NULL,
@i_moneda                    int         = null,
@i_beneficiario              descripcion = '',
@i_monto_mpg                 money       = null,    
@i_monto_mop                 money       = null,    
@i_monto_mn                  money       = null, 
@i_cotizacion_mpg            money       = null,
@i_cotizacion_mop            money       = null,  
@i_tcotizacion_mpg           char(1)     = null,
@i_tcotizacion_mop           char(1)     = null,
@i_operacion_renovada        int         = null,
@i_no_cheque                 int         = null, 
@i_mon                       smallint    = null, 
@i_operacionca               int         = null,
@i_secuencial_tran           int         = 0,
@i_sec_tran_cca              int         = 0,   -- FCP Interfaz Ahorros Graba la transaccion de la ca_transaccion (RPA, DES, DEV, SOB) en ca_secuencial_atx 
@i_reversa                   char(1)     = 'N', 
@i_abd_cod_banco             catalogo    = null,
@i_en_linea                  char(1)     = 'S',  
@i_alt                       int         = 1,
@i_banco                     cuenta      = null,
@i_opcion                    int         = null,
@i_descripcion               descripcion = null,
@i_cuentaxpagar              int         = null,
@i_instrumento               int         = null,
@i_subtipo                   int         = null,
@i_pagado                    char(1)     = null,  
@i_dm_desembolso             tinyint     = null, 
@i_grupal                    char(1)     = 'N',
@o_num_renovacion            tinyint     = null out,
@o_monto_real                money       = null out, 
@o_secuencial                int         = null out

as 

declare
@w_error                     int,
@w_sp_name                   descripcion,
@w_pcobis                    tinyint,
@w_op_moneda                 smallint,
@w_afectacion                char(1),
@w_trn_prod                  int,
@w_causa                     varchar(20), 
@w_operacion_pag             int,  
@w_reduccion                 char(1), 
@w_cobro                     char(1), 
@w_ult_proceso               datetime, 
@w_tipo_aplicacion           char(1), 
@w_p_int                     int,
@w_p                         varchar(3),
@w_prioridad                 varchar(255),
@w_concepto                  cuenta,
@w_cuenta                    cuenta,
@w_num_renovacion            tinyint, 
@w_mmdc                      money,   
@w_saldo_disponible          money,
@w_ah_cuenta                 int,
@w_saldo_contable            money,
@w_cuenta_int                int,
@w_parametro_fpago           varchar(30),
@w_nro_cheque                int,
@w_ssn_corr                  int,          -- FCP Interfaz Ahorros
@w_msg                       varchar(255), -- FCP Interfaz Ahorros
@w_por_3x1000                float, --ELA valor parametro porcentaje
@w_trespormil                money, --ELA calculo valor 3x1000 
@w_con3x1000                 money,  --ELA monto + valor 3x1000 
@w_tp_operacion              int,
@w_tp_sec_transaccion        tinyint,
@w_tp_sec_detalle_pago     tinyint,
@w_estado_cta                char(1),
@w_corr                      char(1),
@w_factor                    smallint,
@w_saldo_disponiblef         money,
@w_dividendo                 int,
@w_operacion_sidac           varchar(15),
@w_area                      int,
@w_param_sobaut              char(24),
@w_sec_sidac                 varchar(15),
@w_referencia_sidac          varchar(50),
@w_descripcion               varchar(50),
@w_cliente                   int,
@w_oficina_op                int,
@w_parametro_depoga          catalogo,
@w_par_fpago_depogar         catalogo,
@w_area_depogar              int,
@w_oficina_sidac             int,
@w_par_ofi_bv                int,
@w_ab_oficina                int,
@w_subtipo                   int,
@w_categoria                 catalogo,
@w_banco                     cuenta,
@w_referencia                int,
@w_pa_area_cartera           smallint,
@w_tipo_benef                catalogo,
@w_moneda_des                tinyint,
@w_moneda_nac                tinyint,
@w_ente_benefic              int,
@w_producto                  char(1),
@w_instrumento               int,
@w_sub_tipo                  char(1),
@w_serie_desde               int,
@w_serie_hasta               int,
@w_funcionario               login,
@w_motivo_reverso            char(21),
@w_causa_rev                 char(1),
@w_area_origen               smallint,
@w_oficina_origen            smallint,
@w_ofi_destino               smallint,
@w_fecha_solicitud           datetime,
@w_valor                     money,
@w_beneficiario              descripcion,
@w_campo1                    varchar(254),
@w_campo2                    varchar(254),
@w_campo3                    varchar(254),
@w_campo4                    varchar(254),
@w_campo40                   char(1),
@w_grupo1                    varchar(254),    
@w_pa_cdc                    varchar(30),
@w_nom_cdc                   descripcion,
@w_oficina_orig              int,
@w_operacion_def             int,
@w_monto                     money,
@w_fecha                     datetime,
@w_operacionca               int,
@w_ah_disponible	         money,
@w_est_vigente               smallint,
@w_est_vencido               smallint,
@w_est_cancelado             smallint,
@w_intentos                  smallint,
@w_monto_apagar              money,
@w_deposito_min              money,
@w_tipo_def                  char(1),
@w_rolente                   char(1),
@w_cat_ahorro                char(1),
@w_estado                    char(1),
@w_tipocta                   char(1),
@w_prod_banc                 smallint,
@w_moneda                    tinyint,
@w_return                    int,
@w_act_sec                   char(1),
@w_fp_paginac                varchar(30),
@w_sec_ing                   int,
@w_cuenta_branch             int,
@w_is_batch                  char(1),
@w_tramite_grupal            int,
@w_cliente_op                int,
@w_cuota_completa            char(1),
@w_monto_garantia			 money,
@w_forma_pago				 catalogo,
@w_fecha_proceso             datetime,
@w_toperacion_ant            catalogo,
@w_oficina_ant               int,
@w_secuencial_ing            int,
@w_secuencial_pag            int,
@w_cuenta_banco              cuenta,
@w_secuencial                int,
@w_oficial_ant               int 

/* INICIAR VARIABLES DE TRABAJO */
select 
@o_secuencial         = 0,
@w_saldo_disponiblef  = 0,
@w_sp_name            = 'sp_afect_prod_cobis',
@w_monto_apagar       = 0

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out

if @w_error <> 0  return @w_error

select @s_date = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso 


select @w_mmdc = pa_money 
from   cobis..cl_parametro
where  pa_nemonico = 'MMDC' 
and    pa_producto = 'CCA'

if @@rowcount <> 1 return 710481
                               
---VALORES PARA LA REVERSA
if @i_reversa = 'S' begin
   select @w_corr    = 'S'
   select @w_factor  = -1
end else begin
   select @w_corr    = 'N'
   select @w_factor  = 1
end

---PARAMETRO PARA CHEQUE PROPIO
select @w_parametro_fpago = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CHEPRO'

if @@rowcount <> 1 return 710480

---PARAMETRO PARA  TRES POR MIL
select @w_por_3x1000 = pa_float
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = '3XMCCA'

if @@rowcount <> 1 return 710479

select @w_ab_oficina = ab_oficina
from   ca_abono
where  ab_operacion      = @i_operacionca
and    ab_secuencial_pag = @i_secuencial_tran

select @w_par_ofi_bv = pa_int
from   cobis..cl_parametro
where  pa_nemonico = 'OFIVB'
and    pa_producto = 'CCA'

if @w_ab_oficina = @w_par_ofi_bv    select @s_ofi = @w_par_ofi_bv

--- SELECCION DE PRODUCTO COBIS 
select 
@w_pcobis      = isnull(cp_pcobis,0),
@w_afectacion  = cp_afectacion,
@w_instrumento = cp_instrum_SB,
@w_categoria   = cp_categoria
from   ca_producto
where  cp_producto = @i_producto


if @w_pcobis = 6  or @w_pcobis  = 0  --- PAGO AUTOMATICO PASIVAS o NO TIENE RALACIONADO
   return 0                          --- UN PRODUCTO
   
   
select @w_act_sec = 'N'
if  @s_ssn is null and @w_pcobis <> 0
begin
   select @s_ssn = se_numero + 1
   from   cobis..ba_secuencial
   
   select @w_act_sec = 'S'
end
   
if @i_en_linea ='S'
   select @w_is_batch = 'N'
else
   select @w_is_batch = 'S'
  
/* CUENTAS CORRIENTES COBIS */
if @w_pcobis = 3 begin 

   if @w_parametro_fpago =  @i_producto ---INGRESA POR CHEQUE PROPIO
   begin   
      select @w_nro_cheque = @i_no_cheque         
      --- Pagos con cheque 
      exec @w_error = cob_interfase..sp_pago_cheque_automatico
      @s_srv      = @s_srv,
      @s_ssn      = @s_ssn,
      @s_user     = @s_user,
      @s_sesn     = @s_sesn,
      @s_term     = @s_term,
      @s_date     = @s_date,
      @s_org      = '0',  
      @s_ofi      = @s_ofi,
      @s_rol      = @s_rol,
      @t_trn      = 89 ,
      @t_corr     = @w_corr,
      @t_ssn_corr = @t_ssn_corr,
      @i_cta      = @i_cuenta, 
      @i_cheque   = @w_nro_cheque,       --NUMERO DE CHEQUE
      @i_valor    = @i_monto,            --VALOR DE LA TRANSACCION
      @i_fecha    = @s_date,             --FECHA EN QUE SE REALIZA LA TRANSACCION
      @i_mon      = @i_mon,              --ELA 26/02/2002 
      @i_ofi      = @s_ofi,              --OFICINA QUE ORIGINA LA TRANSACCIaN
      @i_totales  = 'N',                 --ELA CHPROPIOS PARA NO ACTUALIZAR TOTALES CAJERO
      @i_factor   = @w_factor            -- ELA CHPROPIOS PARA REVERSAR CHEQUES 
      
      if @w_error <> 0  return @w_error  --MPO Ref. 015 02/05/2002      
      select @o_secuencial = @s_ssn
   end 
   ELSE 
   begin
      exec cob_interfase..sp_afect_prod_cobis_interfase
           @i_cuenta         =  @i_cuenta,
           @i_operacion      =  'C',
           @o_cuenta_int     =  @w_cuenta_int out
           
      if @w_afectacion = 'C' 
      begin
         select 
         @w_trn_prod = 48,
         @w_causa    = '310'
         
         --CAUSAL QUE SE UTILIZA PARA LAS REVERSAS DE PAG. O DESEMBOLSOS 
         if  @i_reversa = 'S'   select @w_causa    = '311'
      end 
      ELSE 
      begin
         select @w_trn_prod = 50         
         if @w_ab_oficina = @w_par_ofi_bv    
            select @w_causa = '453'            
         else 
            select @w_causa = '310'
         
         --CAUSAL QUE SE UTILIZA PARA LAS REVERSAS DE PAG. O DESEMBOLSOS 
         if  @i_reversa = 'S'   select @w_causa = '311'
         
         exec @w_error = cob_interfase..sp_calcula_sin_impuesto
         @s_ofi         = @s_ofi,                  ---OFICINA QUE EJECUTA LA CONSULTA
         @i_pit         = 'S',                     ---INDICADOR PARA NO REALIZAR ROLLBACK
         @i_cta_banco   = @i_cuenta,               ---NUMERO DE CUENTA
         @i_tipo_cta    = 3,                       ---PRODUCTO DE LA CUENTA
         @i_fecha       = @s_date,                 ---FECHA DE LA CONSULTA
         @i_causa       = @w_causa,                ---CAUSA DE DEBITO (para verificar si cobra IVA)
         @o_valor       = @w_saldo_disponible out  ---VALOR PARA REALIZAR LA ND
         
         if @w_corr <> 'S'  --- S, ES UNA REVERSA, SE DEBE REVERSAR EL VALOR TOTAL @i_monto
         begin
            select @w_saldo_disponible = floor(@w_saldo_disponible)           
            select @w_trespormil = @i_monto * @w_por_3x1000
            select @w_con3x1000  = @i_monto + @w_trespormil
            
            if @w_saldo_disponible > @w_mmdc 
            begin
               if @w_con3x1000 < @w_saldo_disponible 
               begin
                  select @i_monto      = floor(@i_monto )
                  select @o_monto_real = @i_monto
               end 
               ELSE 
               begin 
                  select @w_trespormil = @w_saldo_disponible * @w_por_3x1000
                  select @i_monto      = @w_saldo_disponible  - @w_trespormil
                  select @i_monto      = floor(@i_monto )
                  select @o_monto_real = @i_monto
               end
            end 
            ELSE return 710152
         end
      end
      
      exec @w_error = cob_interfase..sp_ccndc_automatica_batch
      @s_ssn      = @s_ssn,
      @s_srv      = @s_srv,
      @s_ofi      = @s_ofi,
      @t_trn      = @w_trn_prod,
      @i_cta      = @i_cuenta,
      @i_val      = @i_monto,  
      @i_cau      = @w_causa, 
      @i_mon      = @i_mon,
      @i_fecha    = @s_date,
      @i_tsn      = @s_ssn,
      @i_alt      = @i_alt,
      @i_valida   = 1,
      @i_enlinea  = @i_en_linea,
      @i_corr     = @w_corr,
      @i_pit      = 'S', 
      @i_enlinea  = 'N'
      
      if @w_error <> 0   return @w_error
      
      --CONFIRMAR SI SE AFECTO EL DISPONIBLE DEL CLIENTE
      exec @w_error = cob_cuentas..sp_calcula_saldo
      @i_cuenta           = @w_cuenta_int,
      @i_fecha            = @s_date,
      @i_ofi              = @s_ofi,
      @o_saldo_para_girar = @w_saldo_disponiblef out,
      @o_saldo_contable   = @w_saldo_contable  out
      
      if @w_error <> 0  return @w_error      
      if @w_saldo_disponible = @w_saldo_disponiblef    return 710477
   end  ---debito o credito ctas ctes
end  ---producto 3


if @w_pcobis = 4 begin --CUENTAS DE AHORROS

  exec cob_interfase..sp_afect_prod_cobis_interfase
   @i_cuenta         =  @i_cuenta,
   @i_pcobis         =  @w_pcobis,
   @o_ah_cuenta      =  @w_ah_cuenta out,
   @o_ah_disponible  =  @w_ah_disponible out,
   @o_cat_ahorro     =  @w_cat_ahorro out,   
   @o_tipocta        =  @w_tipocta out,      
   @o_rolente        =  @w_rolente out,      
   @o_tipo_def       =  @w_tipo_def out,     
   @o_prod_banc      =  @w_prod_banc out,    
   @o_producto       =  @w_producto out,     
   @o_moneda         =  @w_moneda out,       
   @o_estado         =  @w_estado out       
   
   if @@rowcount <> 1   return 701043
   
   /* VALIDACION MONTO MINIMO DE APERTURA */
   if @w_afectacion = 'C'  -- notas de credito
   begin
      /* SI CUENTA EN ESTADO INGRESADA, VALIDAR MONTO PRIMER DEPOSITO */     
      if @w_estado = 'G' and @w_corr = 'N'
      begin
      
         exec @w_return = cob_interfase..sp_genera_costos 
         @i_categoria    = @w_cat_ahorro,
         @i_tipo_ente    = @w_tipocta,
         @i_rol_ente     = @w_rolente,
         @i_tipo_def     = @w_tipo_def,
         @i_prod_banc    = @w_prod_banc,
         @i_producto     = @w_producto,
         @i_moneda       = @w_moneda,
         @i_tipo         = 'R',
         @i_codigo       = 0,
         @i_servicio     = 'MMAP',
         @i_rubro        = '39',
         @i_disponible   = $0,
         @i_contable     = $0,
         @i_promedio     = $0,
         @i_personaliza  = 'N',
         @i_filial       = 1,
         @i_oficina      = @s_ofi,
         @i_fecha        = @s_date,
         @o_valor_total  = @w_deposito_min out
         if @w_return <> 0
            return @w_return --'Error hallando valor monto minimo de apertura'
         
         if @w_deposito_min is null return 251097 --'Monto deposito inicial no existe'
      
         if @i_monto < @w_deposito_min  return 251098 --'Monto depositado inferior al monto minimo establecido'

      end   
   end
        
   select @w_banco       = op_banco ,
          @w_oficina_op  = op_oficina,
          @w_monto       = op_monto,
          @w_fecha       = op_fecha_ult_proceso,
          @w_operacionca = op_operacion
   from   ca_operacion 
   where  op_operacion   = isnull(@i_operacionca, @i_operacion_renovada)

   ---Con este select da el mismo Nro. de Intentos que se venia registrando
   select @w_intentos = isnull(sum(di_intento),0)
   from  ca_dividendo
   where di_operacion   = @w_operacionca
   and   di_estado in (@w_est_vigente, @w_est_vencido, @w_est_cancelado)
   and   di_intento  > 0   
   
   
   if @i_reversa = 'S' begin-- PARA REVERSAS

      select 
      @w_ssn_corr = sa_secuencial_ssn,
      @i_monto    = sa_valor_efe 
      from   ca_secuencial_atx
      where  sa_operacion      = @w_banco         
      and    sa_secuencial_cca = @i_sec_tran_cca
      
      if @@rowcount = 0 return 701043
      
      update cob_cartera..ca_secuencial_atx set    
      sa_estado = 'R'
      where  sa_operacion      = @w_banco
      and    sa_secuencial_cca = @i_sec_tran_cca
      
      if @@error <> 0  return 710002
      
   end else begin  -- no es reverso
   
      if @w_afectacion = 'D' begin
         exec @w_error = cob_interfase..sp_calcula_sin_impuesto
         @s_ofi         = @s_ofi,                  ---OFICINA QUE EJECUTA LA CONSULTA
         @i_pit         = 'S',                     ---INDICADOR PARA NO REALIZAR ROLLBACK
         @i_cta_banco   = @i_cuenta,               ---NUMERO DE CUENTA
         @i_tipo_cta    = 4,                       ---PRODUCTO DE LA CUENTA
         @i_fecha       = @s_date,                 ---FECHA DE LA CONSULTA
         @i_causa       = @w_causa,                ---CAUSA DE DEBITO (para verificar si cobra IVA)
         @i_is_batch    = @w_is_batch,
         @o_valor       = @w_saldo_disponible out  ---VALOR PARA REALIZAR LA ND
          
         if @w_error <> 0 return @w_error
         if @w_saldo_disponible is null return 251033 --FONDOS INSUFICIENTES
             
         select @w_saldo_disponible = floor(@w_saldo_disponible)
         select @w_trespormil       = @i_monto * @w_por_3x1000
         select @w_con3x1000    = @i_monto + @w_trespormil
         
         if @w_saldo_disponible <= @w_mmdc 
            return 710152 -- si el disponible no supera el mßximo debitable, ERROR
         
         if @w_con3x1000 < @w_saldo_disponible begin
            select @i_monto      = floor(@i_monto )
         end else begin
            select @w_trespormil = @w_saldo_disponible * @w_por_3x1000
            select @i_monto      = @w_saldo_disponible  - @w_trespormil
            select @i_monto      = floor(@i_monto )
         end
         
      end
   
      insert into ca_secuencial_atx (
      sa_operacion ,      sa_ssn_corr ,     sa_producto,              sa_secuencial_cca,             
      sa_secuencial_ssn,  sa_oficina,       sa_fecha_ing,             sa_fecha_real,
      sa_estado,          sa_ejecutar,      sa_valor_efe,             sa_valor_cheq,
      sa_error)
      values(
      @w_banco,           isnull(@s_ssn,0), @i_producto,              @i_sec_tran_cca,
      isnull(@s_ssn,0),   isnull(@s_ofi,0), isnull(@s_date,''),       getdate(),
      'A',                'S',              @i_monto,                 0,
      0)   
      
      if @@error <> 0 return 710001
      
   end
   
   if @w_afectacion = 'C' begin  -- notas de credito
   
      select 
      @w_trn_prod = 253,
      @w_causa    = '21' 
      
      if @i_grupal = 'S' select @w_causa = '90'
      if @i_grupal = 'I' select @w_causa = '91'

   end else begin  -- notas de debito

      select 
      @w_trn_prod = 264,
      @w_causa    = '26' 
      
      if @w_ab_oficina = @w_par_ofi_bv select @w_causa = '438' -- para banca virtual
      
   end  
   
   select @o_monto_real = @i_monto
   if 'S' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'VALAHO' and pa_producto = 'CCA')
   exec @w_error   = cob_interfase..sp_ahndc_automatica 
   @s_ssn          = @s_ssn,   
   @s_srv          = @s_srv,
   @s_ofi          = @s_ofi,
   @s_user         = @s_user,
   @t_trn          = @w_trn_prod,
   @i_cta          = @i_cuenta,
   @i_val          = @i_monto,  
   @i_cau          = @w_causa,
   @i_mon          = @i_mon, 
   @i_fecha        = @s_date,
   @t_ssn_corr     = @w_ssn_corr,      --secuencial (@s_ssn) de la transacci=n a reversar.
   @t_corr         = @w_corr,          --S/N dependiendo si es una reversa o no.                     
   @i_alt          = @i_alt,
   @i_inmovi       = 'S',
   @i_activar_cta  = 'N',
   @i_is_batch     = @w_is_batch
   
   if @w_error <> 0  return @w_error
   
   if @w_trn_prod = 264 and @w_causa    = '26' 
   begin
     select @w_monto_apagar = sum(am_acumulado + am_gracia - am_pagado)
     from ca_amortizacion, ca_dividendo
     where am_operacion = @w_operacionca
     and   am_operacion = di_operacion
     and   am_dividendo = di_dividendo
     and   di_estado in (@w_est_vigente,@w_est_vencido)
     
     insert into ca_ahndc_automatica
     values (@w_operacionca, @w_banco, @w_oficina_op, @w_monto, @w_fecha, @w_ah_disponible, @w_monto_apagar, @w_intentos)
     
      if @@error <> 0 begin  
         print 'Error al insertar en tabla -ca_ahndc_automatica- necesaria para reporte de Debitos Automßticos'
         return 710030
      end 
   end
   
   --CONFIRMAR SI SE AFECTO EL DISPONIBLE DEL CLIENTE
   exec @w_error = cob_interfase..sp_ahcalcula_saldo
   @i_cuenta           = @w_ah_cuenta,
   @i_fecha            = @s_date,
   @o_saldo_para_girar = @w_saldo_disponiblef out,
   @o_saldo_contable   = @w_saldo_contable  out
   
   if @w_error <> 0  return @w_error  
    
   if @w_saldo_disponible = @w_saldo_disponiblef  return 710477
   
end  --Debitos o credito s CTAHO


if @w_pcobis = 7 ---RENOVACION AUTOMATICA DE CARTERA OPERACION A LA CUAL SE VA A PAGAR
begin  
   if @i_operacion_renovada <> -1 
   begin 
      select @w_num_renovacion = isnull(op_num_renovacion,0)
      from   ca_operacion
      where  op_banco      = @i_cuenta
      and    op_renovacion = 'S'
      and    op_estado     > 0
      
      if @@rowcount = 0 return 710113--OPERACION NO ES RENOVABLE

      SELECT @w_concepto = @i_producto, 
             @w_dividendo = 0
   end
   ELSE 
   begin
      select @w_concepto = @i_producto      
      select @w_dividendo = di_dividendo
      from   ca_dividendo, ca_operacion
      where  op_banco = @i_cuenta
      and    di_operacion = op_operacion
      and    di_estado    = 1
      
      if @@rowcount = 0  select @w_dividendo = 0
   end
   
   select 
   @w_operacion_pag   = op_operacion,
   @w_reduccion       = op_tipo_reduccion,
   @w_toperacion_ant  = op_toperacion,
   @w_cobro           = op_tipo_cobro,
   @w_ult_proceso     = op_fecha_ult_proceso,
   @w_tipo_aplicacion = op_tipo_aplicacion,
   @w_op_moneda       = op_moneda ,
   @w_oficina_ant     = op_oficina,
   @w_cuenta_banco    = op_cuenta,
   @w_oficial_ant     = op_oficial
   from   ca_operacion
   where  op_banco   = @i_cuenta


   exec @w_error     = sp_pago_cartera_srv
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_date           = @s_date,
   @s_ofi            = @w_oficina_ant,         
   @i_banco          = @i_cuenta,
   @i_fecha_valor    = @w_fecha_proceso,
   @i_forma_pago     = @w_concepto,
   @i_monto_pago     = @i_monto_mn,
   @i_en_linea       = 'S',  
   @i_cuenta         = @w_cuenta_banco,      --Cuenta Santander del Cliente
   @o_msg            = @w_msg out,
   @o_secuencial_ing = @w_secuencial_ing out

   if @w_error <> 0 or @w_secuencial_ing is null begin 
      print 'ERROR EN PAGO DE LA OPERACION ANTERIOR'+ convert(varchar,@w_error) 
      return 709999
   end
-----
   select @w_secuencial_pag = ab_secuencial_pag 
   from ca_abono 
   where ab_operacion = @w_operacion_pag
   and ab_secuencial_ing =@w_secuencial_ing


   update ca_transaccion set 
   tr_observacion = 'RENOVACION'
   where tr_operacion = @w_operacion_pag
   and tr_secuencial  = @w_secuencial_pag

   --VALIDACION DE CANCELACIÓN 
   select @w_estado = op_estado
   from cob_cartera..ca_operacion
   where op_banco      = @i_cuenta 

   if @w_estado <> @w_est_cancelado begin 
   
      print 'ERROR: AL CANCELAR OPERACION ANTERIOR NO ACTUALIZO ESTADO A 3'
	  return 79998
  
   end 

   --NUEVA TRANSACCION DE CUUOTAMIN REN 
   exec @w_secuencial  = sp_gen_sec
   @i_operacion        = @w_operacion_pag

   -- OBTENER RESPALDO ANTES DE la REN
   exec @w_error  = sp_historial
   @i_operacionca  = @w_operacion_pag,
   @i_secuencial   = @w_secuencial


   -- INSERCION TRX REN
   insert into ca_transaccion  with (rowlock)(
   tr_fecha_mov,         tr_toperacion,     tr_moneda,
   tr_operacion,         tr_tran,           tr_secuencial,
   tr_en_linea,          tr_banco,          tr_dias_calc,
   tr_ofi_oper,          tr_ofi_usu,        tr_usuario,
   tr_terminal,          tr_fecha_ref,      tr_secuencial_ref,
   tr_estado,            tr_gerente,        tr_gar_admisible,
   tr_reestructuracion,  tr_calificacion,   tr_observacion,
   tr_fecha_cont,        tr_comprobante)
   values(
   @w_fecha_proceso,    @w_toperacion_ant,    @w_op_moneda,
   @w_operacion_pag,     'REN',               @w_secuencial,
   'N',                 @i_cuenta,             0,
   @w_oficina_ant,      @w_oficina_ant,       'usrren',
   @s_term,             @w_ult_proceso, 0, 
   'ING',               @w_oficial_ant,           '',
   'N',                 '',                   'RENOVACION',
   @s_date,             0)
      
   if @@error <> 0 begin
      print 'ERROR AL CREAR LA TRANSACCION REN'
	  return 710001
 
   end
   

end

if @w_pcobis = 9  and @w_afectacion = 'D' 
begin
   select 
   @w_tp_operacion         = convert(int,@i_beneficiario),
   @w_tp_sec_transaccion   = @i_no_cheque,
   @w_tp_sec_detalle_pago  = convert(int,@i_abd_cod_banco)
   
end

if @w_pcobis = 42 -- SERVICIOS BANCARIOS
begin 
   /* INICIALIZACION VARIABLES */
   select 
   @w_producto       = '4',
   @w_funcionario    = ' ',
   @w_motivo_reverso = 'REVERSO DE DESEMBOLSO',
   @w_causa_rev      = 'T'
   
   /* LECTURA DEL PARAMETRO CAUSA EMISION CHEQUE DE GERENCIA */
   select @w_pa_cdc = pa_char
   from   cobis..cl_parametro
   where  pa_producto    = 'CTE'
   and    pa_nemonico    = 'CDC'
   
   if @@rowcount = 0  return 724519 --No existe moneda   
   
   /* LECTURA DE LA DESCRIPCION DEL PARAMETRO CAUSA EMISION CHEQUE DE GERENCIA */
   select @w_nom_cdc = c.valor
   from   cobis..cl_tabla t, cobis..cl_catalogo c
   where  t.tabla = 'cc_concepto_emision'
   and    c.tabla = t.codigo
   and    c.codigo = @w_pa_cdc
      
   
   /* LECTURA DEL PARAMETRO MONEDA LOCAL */
   select @w_moneda_nac = pa_tinyint
   from   cobis..cl_parametro
   where  pa_producto = 'ADM'
   and    pa_nemonico = 'MLO'
   
   if @@rowcount = 0  return 701069 --No existe moneda
      
   /* LECTURA DEL PARAMETRO AREA ORIGEN DE CARTERA */
   select @w_area_origen = pa_smallint
   from   cobis..cl_parametro
   where  pa_producto    = 'CCA'
   and    pa_nemonico    = 'ARC'
   
   if @@rowcount = 0  return 708176 --No existe area contable para cartera

   select @w_operacion_def = isnull(@i_operacion_renovada, @i_operacionca)
   
   /*OBTENER DATOS DE LA OPERACION */
   select 
   @w_banco   = op_banco,
   @w_cliente = op_cliente,
   @w_oficina_orig = op_oficina
   from   ca_operacion
   where  op_operacion   = @w_operacion_def
   
   /*OBTENER DATOS DEL DESEMBOLSO */
   select 
   @w_oficina_origen   = @w_oficina_orig,
   @w_ofi_destino      = dm_oficina_chg, 
   @w_fecha_solicitud  = dm_fecha,
   @w_valor            = dm_monto_mn,
   @w_beneficiario     = dm_beneficiario,
   @w_ente_benefic     = dm_ente_benef,
   @w_moneda_des       = dm_moneda,
   @w_funcionario      = dm_usuario,
   @w_subtipo          = dm_cod_banco
   from   ca_desembolso
   where  dm_operacion  = @w_operacion_def
   and    dm_desembolso = @i_dm_desembolso
   
   /*OBTENER DATOS DEL TITULAR DEL CREDITO */
   select 
   @w_campo1 = en_tipo_ced + '-' + cast(en_ced_ruc as varchar),
   @w_campo4 = en_nomlar
   from  cobis..cl_ente
   where en_ente = @w_cliente
   
   /*OBTENER DATOS DEL BENEFICIARIO DEL DESEMBOLSO*/
   select 
   @w_campo3     = en_tipo_ced + '-' + cast(en_ced_ruc as varchar),
   @w_campo2     = en_nomlar,
   @w_tipo_benef = c_tipo_compania
   from  cobis..cl_ente
   where en_ente = @w_ente_benefic

   select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')

   /*DETERMINAR IDIOMA PARA IMPRESION DEL CHEQUE */
   if @w_moneda_des = @w_moneda_nac
       select @w_campo40 = 'E'
   else
       select @w_campo40 = 'I'
   
   if @w_categoria = 'CHGE'  begin 
      exec cob_interfase..sp_afect_prod_cobis_interfase
           @i_operacion      = 'S',
           @i_instrumento    = @w_instrumento,
           @o_subtipo        = @w_subtipo out
   end

   select 
   @i_instrumento = isnull(@w_instrumento, @i_instrumento),
   @i_subtipo     = isnull(@w_subtipo, @i_subtipo)
   
   if @i_debug = 'S'
      print '@i_instrumento ' + cast(@i_instrumento as varchar) + ' @i_subtipo ' + cast(@i_subtipo as varchar)

   /*OPCIONES DE PROCESO */      
   if @i_instrumento is not null begin
   
      if @i_reversa = 'N' begin
         select @i_reversa = 'N' -- LGU xq no existe en PRD Santander
		 /*
         exec @w_error = cob_sbancarios..sp_imprimir_lotes
         @t_trn              = 29334,
         @s_ssn              = @s_ssn,
         @s_date             = @s_date,
         @s_user             = @s_user,
         @s_term             = @s_term,
         @s_ofi              = @s_ofi,
         @s_lsrv             = @s_lsrv,
         @s_srv              = @s_srv,
         @i_estado           = 'D',
         @i_oficina_origen   = @w_oficina_origen,
         @i_ofi_destino      = @w_ofi_destino,
         @i_area_origen      = @w_area_origen,
         @i_fecha_solicitud  = @w_fecha_solicitud,
         @i_producto         = 4,
         @i_instrumento      = @i_instrumento,
         @i_subtipo          = @i_subtipo,
         @i_valor            = @i_monto_mpg,
         @i_beneficiario     = @i_beneficiario,
         @i_referencia       = @w_operacion_def,
         @i_tipo_benef       = @w_tipo_benef,
         @i_campo1           = @w_campo1,
         @i_campo2           = @w_campo2,
         @i_campo3           = @w_campo3,
         @i_campo4           = @w_campo4,
         @i_campo5           = @w_banco,
         @i_campo6           = @w_pa_cdc,
         @i_campo7           = @w_nom_cdc,
         @i_campo21          = 'CCA',
         @i_campo22          = 'D',
         @i_campo40          = @w_campo40,
         @o_secuencial       = @o_secuencial out --C=digo de secuencial  (Lo devuelve el sp y se debe grabar en ca_desembolso)
               
         if @w_error <> 0 return @w_error 
         */
      end
      else begin


         select 
         @w_grupo1 = cast(@i_secuencial_tran as varchar) + '@' + 
         @w_causa_rev                   + '@' + 
         ''                             + '@' + 
         ''                             + '@' + 
         ''                             + '@' + 
         cast(@w_moneda_des as varchar) + '@'


         exec @w_error = cob_interfase..sp_actualizar_lotes
         @s_ssn          = @s_ssn,
         @s_date         = @s_date,
         @s_user         = @s_user,
         @s_term         = @s_term,
         @s_ofi          = @w_ofi_destino,
         @s_lsrv         = @s_lsrv,
         @s_srv          = @s_srv,   
         @t_trn          = 29301,
         @i_producto     = 4,
         @i_instrumento  = @i_instrumento,
         @i_causa_anul   = '99',
         @i_subtipo      = @i_subtipo,
         @i_grupo1       = @w_grupo1,
         @i_llamada_ext  = 'S'
     
         if @w_error <> 0 return @w_error 

      end
   end
   else
      return 2902544 -- No se tiene instrumento asociado

end

if @w_pcobis = 26 begin -- BRANCH

   select @w_fp_paginac = pa_char
   from cobis..cl_parametro with (nolock)
   where pa_producto = 'CCA'
   and pa_nemonico = 'PAGINA'

   if @w_fp_paginac = @i_producto
   begin
  if exists (select 1 from cob_credito..cr_corresp_sib with (nolock)
                 where tabla = 'T144'
                 and   codigo = @i_producto)

         return 722507

      /*OBTENER DATOS DE LA OPERACION */
      select @w_cliente = op_cliente
      from   ca_operacion with (nolock)
      where  op_operacion = @i_operacionca

      select @w_sec_ing = ab_secuencial_ing
      from ca_abono with (nolock)
      where ab_operacion = @i_operacionca
      and   ab_secuencial_rpa = @i_sec_tran_cca

      select @w_cuenta_branch = pi_cuenta
      from ca_paginac with (nolock)
      where pi_operacion = @i_operacionca
      and   pi_sec_ing = @w_sec_ing
      

      /* REVERSA REGISTRO DE PAGO EN EL BRANCH DE LA CUENTA */
      exec @w_error   = cob_remesas..sp_act_est_branch
           @s_user    = @s_user,
           @s_date    = @s_date,
           @i_cliente = @w_cliente,
           @i_cuenta  = @w_cuenta_branch,
           @i_accion  = 'I'

      if @w_error <> 0 return @w_error

   end
end

if @w_pcobis = 19
begin


   if  @i_reversa = 'S' select @w_afectacion = 'C'
	select @w_forma_pago = abdt_concepto
	from  ca_abono_det_tmp
	where abdt_user = @s_user 
	and   abdt_sesn = @s_sesn
	
	/** validar que el monto pago no sea mayor al monto de garantia liquida**/
    select @w_tramite_grupal = tg_tramite
    from   cob_credito..cr_tramite_grupal
    where  tg_operacion = @i_operacionca

    select @w_cliente_op = cu_garante
	from cob_custodia..cu_custodia
	where cu_codigo_externo = @i_cuenta

	select @w_monto_garantia = gl_monto_garantia from ca_garantia_liquida 
    where gl_cliente = @w_cliente_op
	and   gl_tramite = @w_tramite_grupal
	
   if @w_forma_pago = 'GAR_DEB'
   begin
		if @i_monto < @w_monto_garantia or @i_monto > @w_monto_garantia
		begin
			if @@rowcount = 0 begin
				select 
				@w_error = 710611,
				@w_msg = 'ERROR: EL IMPORTE NO COINDICE CON EL TOTAL DE LAS GARANTIAS DEL CLIENTE $'+cast(@w_monto_garantia as varchar)
				goto ERROR
			end
		end
    end
   
   exec @w_error = cob_custodia..sp_cambio_valor
   @i_operacion       = 'I',
   @i_filial          = 1,
   @i_codigo_externo  = @i_cuenta,
   @i_fecha_tran      = @s_date,
   @i_debcred         = @w_afectacion,
   @i_valor           = @i_monto,
   @i_num_acciones    = 0,
   @i_valor_accion    = 0,
   @i_descripcion     = 'PAGO GRUPAL CON DESCUENTO DE GARANTIA',
   @i_autoriza        = @s_user,
   @t_trn             = 19863,
   @s_date            = @s_date,
   @s_user            = @s_user,
   @i_afecta_prod     = 'S'

   if @w_error <> 0 return @w_error

   --PRINT ' --> a.1'

   /* ACTUALIZAR VALOR EN LA TABLA DE GARANTIA LIQUIDA */
   select @w_tramite_grupal = tg_tramite
   from   cob_credito..cr_tramite_grupal
   where  tg_operacion = @i_operacionca
   
   if @@rowcount > 0
   begin
		--PRINT ' --> a.2'
		/* ENCONTRAR EL CLIENTE DUEÑO DE LA GARANTIA */
		SELECT @w_cliente_op = cu_garante
		FROM cob_custodia..cu_custodia
		WHERE cu_codigo_externo = @i_cuenta

      if @i_reversa = 'S'
      begin
		 --PRINT ' --> a.3'
         update ca_garantia_liquida set 
         gl_monto_garantia = gl_monto_garantia + @i_monto,
         gl_pag_valor      = gl_pag_valor      + @i_monto
         where gl_cliente = @w_cliente_op
	      and   gl_tramite = @w_tramite_grupal

         if @@error <> 0  return 710002
      end
      else
      begin
		 --PRINT ' --> a.4'
         update ca_garantia_liquida set 
         gl_monto_garantia = case when gl_monto_garantia >= @i_monto then gl_monto_garantia - @i_monto else 0 end,
         gl_pag_valor      = case when gl_pag_valor      >= @i_monto then gl_pag_valor      - @i_monto else 0 end
         where gl_cliente = @w_cliente_op
	      and   gl_tramite = @w_tramite_grupal

         if @@error <> 0  return 710002
      end
   end
end


if @i_grupal = 'N'      
begin
   if @o_monto_real <= 1   return 710552
end

if @w_act_sec = 'S'
begin

 update cobis..ba_secuencial
 set    se_numero = se_numero +1
end

return 0

ERROR: 
	exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file = null,
     @t_from  = @w_sp_name,
     @i_num = @w_error,
	 @i_msg = @w_msg

return @w_error



GO

