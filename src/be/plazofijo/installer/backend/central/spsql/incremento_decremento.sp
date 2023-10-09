/**************************************************************************/
/*      Archivo:                incredef.sp                               */
/*      Stored procedure:       sp_incremento_decremento                  */
/*      Base de datos:          cobis                                     */
/*      Producto:               Plazo Fijo                                */
/*      Disenado por:           N. Silva                                  */
/*      Fecha de documentacion: 16-Dic-2002                               */
/**************************************************************************/
/*                              IMPORTANTE                                */
/*      Este programa es parte de los paquetes bancarios propiedad de     */
/*      'MACOSA', representantes exclusivos para el Ecuador de la         */
/*      'NCR CORPORATION'.                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como        */
/*      cualquier alteracion o agregado hecho por alguno de sus           */
/*      usuarios sin el debido consentimiento por escrito de la           */
/*      Presidencia Ejecutiva de MACOSA o su representante.               */
/**************************************************************************/
/*                              PROPOSITO                                 */
/*      Este programa mueve la informacion de las tablas temporales       */
/*      de operaciones de plazo fijo nuevas a las tablas definitivas      */
/*      realizando la funcion completa de renovacion del deposito.        */
/**************************************************************************/
/*                              MODIFICACIONES                            */
/*      FECHA        AUTOR              RAZON                             */
/*      16-Dic-2002  N. Silva           Emision Inicial                   */
/*      20-Mar-2007  Clotilde Vargas    Totalizar las disminuciones en    */
/*                                      lo total amortizado para bonos    */
/*      10-Nov-2007  N. Silva           Se quita prod quemados para bonos */
/**************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_incremento_decremento') IS  NOT NULL
   drop proc sp_incremento_decremento
go

create proc sp_incremento_decremento (          
@s_ssn                    int             = NULL,
@s_user                    login           = NULL,
@s_term                    varchar(30)     = NULL,
@s_date                    datetime        = NULL,  
@s_sesn                    int             = NULL,
@s_srv                     varchar(30)     = NULL,
@s_lsrv                    varchar(30)     = NULL,
@s_ofi                     smallint        = NULL,
@s_rol                     smallint        = NULL,
@t_debug                   char(1)         = 'N',
@t_file                    varchar(10)     = NULL,
@t_from                    varchar(32)     = NULL,
@t_trn                     smallint        = NULL,
@i_fecha_valor_cambio      datetime        = NULL,      
@i_cuenta                  cuenta,
@i_incremento              money,
@i_modifica                char(1)         = 'N',      
@i_monto_n                 money,
@i_tipo_monto_n            catalogo,
@i_int_ganado_n            money,
@i_int_estimado_n          money,
@i_total_int_ganados_n     money,
@i_total_int_estimado_n    money,
@i_en_linea                char(1)         = 'S',
@i_beneficiario            varchar(255)    = NULL)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
        @w_historia                     smallint,
        @w_inc                          money,
        @w_descripcion                  descripcion,
        @w_comentario                   varchar(32),
        @w_siguiente                    int,
        @w_secuencial                   int,
        @w_secuencia                    int,
        @w_sec                          int,       
        @w_ofi_ing                      int,
        @w_num_oficial                  int,
        @w_money                        money,
        @w_total_monet                  money,
        @w_activa                       char(1),
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @o_comprobante                  int,
        @w_sec_ticket                   int,
        @w_moneda_base                  tinyint,
        @w_ente                         int,
        @w_categoria                    catalogo,
        @w_producto                     tinyint,
        @w_oficina                      smallint,
        @w_moneda                       tinyint,
        @w_num_dias                     smallint,
        @w_monto_pg_int                 money,
        @w_monto_pgdo                   money,
        @w_monto_blq                    money,
        @w_tasa_efectiva                float,
        @w_int_ganado                   money,
        @w_int_estimado                 money,
        @w_residuo                      float,
        @w_int_provision                float,
        @w_total_int_ganados            money,
        @w_total_int_retenido           money,
        @w_total_retencion              money,
        @w_renovaciones                 smallint,
        @w_op_tipo_plazo                catalogo,
        @w_tasa_variable                char(1),
        @w_total_tran                   money,
        @w_incremento_suspenso          money,
        @w_cod_banco_ach                smallint,
        @w_tipo_cuenta_ach              char(1),
       
/*  Variables para la operacion anterior en Renovacion */
        @w_op_operacionpf                 int,
        @w_op_moneda                      tinyint,
        @w_op_toperacion                  catalogo, 
        @w_op_producto                    tinyint,
        @w_op_oficina                     smallint,          -- GAL 31/AGO/2009 - RVVUNICA
        @w_op_num_dias                    smallint,
        @w_op_renovaciones                smallint,
        @w_op_monto                       money,
        @w_op_mont                        money,
        @w_total_int_estimado             money,
        @w_total_int_pagados              money,
        @w_int_pagados                   money,
        @w_monto_incremento               money,
        @w_int_renovar                  money,     
        @w_int_ven                      money,
        @w_int_vencido                    money,
        @w_impuesto                     money,
        @w_incremento                     money,
        @w_op_tasa                        float,
        @w_tasa                           float,
        @w_op_mon_sgte                    smallint,
        @w_op_estado                      catalogo,
        @w_op_accion_sgte                 catalogo,
        @w_op_causa_mod                   varchar(60),
        @w_op_fecha_ven                   datetime,
        @w_op_fecha_valor                 datetime,
        @w_op_fecha_real                  datetime,
        @w_op_tipo_tasa_var               char(1),   -- Si la tasa es Fija, Periodica o Flotante
        @w_op_plazo_orig                  int,
        @w_fecha_pg_int                   datetime,
        @w_tcapitalizacion                char(1),  
        @w_fpago                          catalogo, 
        @w_fecha_ult_pg_int               datetime,
        @w_trn                            smallint,
        @w_op_sec_incre                   int,
/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
   @w_bt_ente                        int,
   @w_bt_rol                         catalogo,
        @w_bt_fecha_crea                  datetime,
        @w_bt_fecha_mod                   datetime,
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
        @w_mt_tipo_cliente                char(1), --CVA Oct-26-05
   @w_mt_sub_secuencia               int,
   @w_mt_producto                    catalogo,
   @w_mt_cuenta                 cuenta,
        @w_mt_tipo           char(1),
   @w_mt_beneficiario             int,
   @w_mt_impuesto            money,
   @w_mt_moneda                      int,
   @w_mt_valor_ext                     money,
        @w_mt_fecha_crea                  datetime,
        @w_mt_fecha_mod                   datetime,
   @w_mt_valor                       money,
        @w_mt_val                         money,
        @w_mt_tran                        int, 
   @w_mt_impuesto_capital_me         money,
        @w_mt_secuencial                  int,
        @w_mt_cta_corresp                 cuenta,
        @w_mt_cod_corresp                 catalogo,
        @w_mt_benef_corresp               varchar(245), 
        @w_mt_ofic_corresp                int,
        @w_mm_secuencia                   int,
        @w_mm_sub_secuencia               tinyint,
/*  Variables para det_cheque_tmp   */
        @w_ct_sub_secuencia               smallint,
        @w_ct_banco                       catalogo,
        @w_ct_cuenta                      cuenta,
        @w_ct_cheque                      int,
        @w_operacion_tmp                  int,
        @w_ct_valor                       money,
        @w_ct_val                         money,
        @w_ct_val_tot                     money,
        @w_ct_descripcion                 descripcion,
        @w_ct_fecha_crea                  datetime,
        @w_ct_fecha_mod                   datetime,
        @w_mt_oficina                     int,        --LIM 11/NOV/2005
/* Variables para det_pago_tmp  */
   @w_pt_beneficiario                int,
   @w_sec1                           int,
   @w_pt_tipo          catalogo,
   @w_pt_forma_pago            catalogo,
   @w_pt_cuenta                cuenta,   
   @w_pt_monto         money,
   @w_pt_porcentaje                  float,
   @w_pt_fecha_crea       datetime, 
   @w_pt_fecha_mod           datetime,
        @w_pt_moneda_pago                 smallint,
   @w_pt_descripcion                 varchar(255), 
   @w_pt_oficina                     int,    
   @w_pt_tipo_cliente                char(1),       
        @w_pt_tipo_cuenta_ach             char(1),
        @w_pt_banco_ach                   descripcion,
   @w_pt_cod_banco_ach               smallint,
        @w_forma_pago                     catalogo,
        @w_cuenta_aho                     cuenta,
        @w_debcred                        char(1),
/* Variables para condicion_tmp  */
   @w_co_condicion         tinyint,
   @w_co_comentario     varchar(60),
   @w_msg               varchar(60),
   @w_co_fecha_crea     datetime,
   @w_co_fecha_mod         datetime,
/*  Variables para det_condicion_tmp   */
   @w_dt_condicion         smallint,
   @w_dt_ente        int,
   @w_dt_fecha_crea     datetime,
   @w_dt_fecha_mod         datetime,
/* Variables para impuesto del 1% */
        @w_retiene_imp_capital          char(1),
        @w_impuesto_capital             money,
        @w_total_monet_me               money,
        @w_afectacion                   char(1),
        @w_dp_forma_pago                catalogo,
        @w_dp_cuenta                    cuenta,
        @w_dp_monto                     money,
        @w_dp_moneda_pago               tinyint,
        @w_dp_secuencia                 int,
        @w_dp_tipo_cliente              char(1),
        @w_dp_oficina                   int,
        @w_dp_ente                      int,
        @w_estado_xren                  char(1),
        @w_io_fecha_aplicacion          datetime,
        @w_in_fecha_incremento          datetime ,
        @w_mt_secuencia                 int,
        @w_mt_sub_secuencia1            int,
        @w_op_monto_blq_legal           money,
        @w_op_bloqueo_legal             char(1),
        @w_valor_suspenso               money,
        @w_valor_suspenso_caja          money,
        @w_fpagosusp                    catalogo,
        @w_ajuste_int                   money,
        @w_ajuste_int_float             float,
        @w_tipo                         char(1),
        @w_num_banco                    cuenta,
        @w_inc_conta                    money,     --+-+
        @w_dec_conta                    money,     --+-+
        @w_monto_new                    money,     --+-+
        @w_dias                         int,    --+-+
        @w_acumulado_int_gan            money,     --+-+
--Variables servicios bancarios           --LIM 27/DIC/2005
        @w_concepto                     varchar(255),
        @w_producto_fpago               tinyint,    
        @w_area_contable                int,
        @w_numero                       int,
        @w_campo1                       varchar(20),
        @w_campo47                       descripcion,
        @w_campo48                      descripcion,
        @w_cheque_ger                   catalogo,
        @w_secuencial_cheque            int, 
        @w_mm_beneficiario              int,
        @w_descripbenef                 varchar(250),
        @w_campo40                      char(1),
        @w_idlote                     int,
        @w_conceptosb                   tinyint,
        @w_origen_ben                   varchar(1),    /*  RLINARES 02222007 */
        @w_cod_ben                      varchar(255) ,  /*  RLINARES 02222007 */   
        @w_benef_cheque                 varchar(255),
        @w_anio_comercial               char(1),
        @w_dia_pago                     int

/*----------------------------------*/
/*  Verificar codigo de Transaccion */
/*----------------------------------*/
if   @t_trn <> 14965 
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
        return 141112
end 

if @i_en_linea = 'S'
begin

   /* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */

   create table #interes_proyectado (
   concepto        varchar(10),
   valor           money
   )

   /* Tabla de cotizaciones usada en el calcdint */
   create table #cotizacion(
         moneda     tinyint,
         valor      money)


   select ct_moneda     as uc_moneda, 
               max(ct_fecha)  as uc_fecha
        into   #ult_cotiz
        from   cob_conta..cb_cotizacion
   group by ct_moneda
       
   insert into #cotizacion
   select ct_moneda, ct_valor
   from   cob_conta..cb_cotizacion, #ult_cotiz
   where ct_moneda = uc_moneda
   and   ct_fecha  = uc_fecha



end


-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name = 'sp_incremento_decremento',        
       @w_secuencial    = @s_ssn,
       @w_ofi_ing    = @s_ofi,
       @w_impuesto   = 0
       
     
select @w_cheque_ger = pa_char            
  from cobis..cl_parametro 
 where pa_nemonico='NCHG'
   and pa_producto='PFI'
   
-----------------------------
-- Moneda Base 26-Jun-2002
-----------------------------
select @w_moneda_base = em_moneda_base
    from cob_conta..cb_empresa where em_empresa = 1

------------------------------------ 
-- Lectura de la tabla pf_operacion
------------------------------------
select   @w_op_operacionpf       = op_operacion,
        @w_num_banco            = op_num_banco,
        @w_secuencia            = op_mon_sgte,    
        @w_op_accion_sgte       = op_accion_sgte, 
         @w_op_estado            = op_estado,
         @w_tcapitalizacion      = op_tcapitalizacion, 
         @w_op_toperacion        = op_toperacion,
         @w_fpago                = op_fpago,
         @w_oficina              = op_oficina,
         @w_historia             = op_historia,
         @w_fecha_ult_pg_int     = op_fecha_ult_pg_int,
         @w_fecha_pg_int         = op_fecha_pg_int,
         @w_moneda               = op_moneda,
         @w_monto_pg_int         = op_monto_pg_int,
         @w_int_ganado           = op_int_ganado,
         @w_int_estimado         = op_int_estimado,
         @w_int_provision        = isnull(op_int_provision,0),
         @w_total_int_ganados    = isnull(op_total_int_ganados,0),
        @w_total_int_pagados    = isnull(op_total_int_pagados,0),
         @w_total_int_estimado   = isnull(op_total_int_estimado,0),
         @w_total_int_retenido   = isnull(op_total_int_retenido,0),
         @w_total_retencion      = isnull(op_total_retencion,0),
         @w_op_sec_incre         = isnull(op_sec_incre,0),
         @w_op_monto_blq_legal   = op_monto_blqlegal,
         @w_op_bloqueo_legal     = op_bloqueo_legal,
         @w_incremento_suspenso  = isnull(op_incremento_suspenso,0),
         @w_anio_comercial       = op_anio_comercial,
        @w_dia_pago             = op_dia_pago
  from pf_operacion
  where op_num_banco        = @i_cuenta
   and op_estado in ('ACT')
if @@rowcount = 0
begin
   exec cobis..sp_cerror 
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141051
   select @w_return =  141051
   goto borra
end

---------------------------------------------------------------------------------------------------------------
-- Control si la operacion tiene una accion a futuro de cancelacion o renovacion no debe incrementar o reducir
---------------------------------------------------------------------------------------------------------------
if @w_op_accion_sgte is not null
begin
   if @w_op_accion_sgte = 'XREN'
      select @w_msg = 'Debe retirar la instrucci¢n de renovacion del deposito'
      
   if @w_op_accion_sgte = 'XCAN'
      select @w_msg = 'Debe retirar la instrucci¢n de Cancelacion del deposito'

   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_msg,
        @i_num   = 141051
   select @w_return =  141051
   goto borra
end


--Obtiene valor captado de SUSP (Valores en suspenso) de pf_mov_monet_tmp
select  @w_valor_suspenso_caja = 0

select   @w_valor_suspenso_caja  = isnull(sum(mt_valor),0)
  from pf_mov_monet_tmp
 where mt_usuario       = @s_user
   and mt_sesion        = @s_sesn
   and mt_producto      = 'SUSP'
   and mt_operacion     = @w_op_operacionpf  
   
select   @w_valor_suspenso = 0

select   @w_valor_suspenso = isnull(sum(mt_valor),0)
from pf_mov_monet_tmp
where mt_usuario           = @s_user
   and mt_sesion        = @s_sesn
   and mt_producto      in ('SUSP','SUSCONTA')
   and mt_operacion        = @w_op_operacionpf  

-------------------------------------------------------------------------------------
-- Valida si el valor ingresado en SUSP es mayor o igual que el valor a incrementar
-------------------------------------------------------------------------------------
if isnull(@i_incremento,0) > 0 and @w_incremento_suspenso < isnull(@w_valor_suspenso_caja,0)
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141194    
   select @w_return = 141194  
   goto borra
end

---------------------------------------------------------------
-- Analiza si se trata de un incremento o Reduccion de capital
---------------------------------------------------------------
if @i_incremento > 0 
   select @w_trn = 14989
else
   select @w_trn = 14990

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)     
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0  

----------------------------------------------------------
-- Creacion de secuencial para incrementos de operaciones
----------------------------------------------------------
exec @w_return = cobis..sp_cseqnos 
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_tabla     = 'pf_incre_op',
   @o_siguiente = @w_siguiente out
if @w_return <> 0
begin 
   exec cobis..sp_cerror  
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return

   return @w_return

   goto borra
end


select @w_op_sec_incre = @w_op_sec_incre + 1

if @i_incremento > 0
   select @w_inc = @w_valor_suspenso_caja --Es incremento => se debe restar el valor corresp val en suspenso
else
   select @w_inc = 0       --Es decremento

begin tran  --***********************************************************************************************

--Actualiza los datos de la operacion
update pf_operacion
   set op_monto                 = @i_monto_n,
       op_monto_pg_int         = @i_monto_n,
       op_tipo_monto        = @i_tipo_monto_n,
       op_int_estimado          = @i_int_estimado_n,
       op_total_int_ganados     = @i_total_int_ganados_n,
       op_int_ganado        = @i_int_ganado_n,
       op_total_int_estimado    = @i_total_int_estimado_n,
       op_fecha_mod             = @s_date,
       op_sec_incre             = @w_op_sec_incre,
       op_incremento            = @i_incremento,
       op_incremento_suspenso   = op_incremento_suspenso - @w_inc,
       op_mon_sgte              = op_mon_sgte + 1, 
       op_historia              = op_historia + 1
 where op_operacion = @w_op_operacionpf
if @@error <> 0
begin
   rollback tran

   select @w_return = 145001

   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return

   goto borra
end

-- Realiza comprobante de provision por el ajuste de interes
select @w_ajuste_int = round(@i_int_ganado_n, @w_numdeci) - round(@w_int_ganado, @w_numdeci)   -- GAL 31/AGO/2009 - RVVUNICA

if @w_ajuste_int < 0
   select @w_tipo = 'R'
else
   select @w_tipo = 'N'

select @w_ajuste_int = abs(@w_ajuste_int)

-- Calcula los nuevos registros de provision de pf_prov_dia
if @i_fecha_valor_cambio < @s_date  
begin
   --borra registros de provision para reinsertarlos
   delete pf_prov_dia
   where pd_operacion = @w_op_operacionpf
   and pd_fecha_proceso >= @i_fecha_valor_cambio
   
   --calcula dias provisionados
   if @w_anio_comercial = 'N'
        begin
      select @w_dias = datediff(dd,@i_fecha_valor_cambio,@s_date)
   end
        else
        begin
           exec sp_funcion_1 @i_operacion = 'DIFE30',
         @i_fechai   = @i_fecha_valor_cambio,
         @i_fechaf   = @s_date,     
         @i_dia_pago = @w_dia_pago, --*-*                    
         @o_dias     = @w_dias out            
        end   
   exec @w_return = sp_calc_diario_int
      @s_ssn           = @s_ssn,
      @s_user          = @s_user,
      @s_ofi           = @s_ofi,
      @s_date          = @s_date,
      @s_srv           = @s_srv,
      @s_lsrv          = @s_lsrv,
      @s_term          = @s_term, 
      @s_rol           = @s_rol,
      @t_debug         = @t_debug,
      @t_file          = @t_file, 
      @t_from          = @t_from,
      @t_trn           = 14926,  
      @i_ejecuta_contable = 'N', --+-+
      @i_fecha_proceso = @i_fecha_valor_cambio,  
      @i_num_banco     = @i_cuenta ,
      @i_dias_interes  = @w_dias
   if @w_return <> 0
   begin
      rollback tran
      select @w_return = 149015
      goto borra
   end 
      
   --ajusta en caso de ser necesario el primer dia 
   select @w_acumulado_int_gan = sum(isnull(pd_valor,0))
   from pf_prov_dia 
   where pd_operacion = @w_op_operacionpf
   and pd_fecha_proceso between @w_fecha_ult_pg_int and @s_date   

   if @i_int_ganado_n <> @w_acumulado_int_gan
   begin
      update pf_prov_dia
      set pd_valor = pd_valor + (@i_int_ganado_n - @w_acumulado_int_gan)
      where pd_operacion = @w_op_operacionpf
      and pd_fecha_proceso = @i_fecha_valor_cambio
   end
end

if @w_ajuste_int > 0
begin
   select @w_descripcion = 'PROVISION DE AJUSTE-' + @w_num_banco
   exec @w_return = cob_pfijo..sp_aplica_conta
      @s_ssn         = @s_ssn,
      @s_date        = @s_date,
      @s_user        = @s_user,
      @s_term        = @s_term,
      @s_ofi         = @s_ofi,
      @t_debug    = @t_debug,
      @t_file        = @t_file,
      @t_from        = @t_from,
      @t_trn               = 14937,
      @i_empresa           = 1,
      @i_fecha             = @s_date,
      @i_tran              = 14926,
      @i_producto          = 14,   /* op_producto de pf_operacion */
      @i_oficina_oper      = @w_oficina,
      @i_oficina           = @w_oficina, 
      @i_toperacion        = @w_op_toperacion,/*op_toperacion de pf_operacion */
      @i_tplazo            = NULL, /* Nemonico del tipo de plazo */ 
      @i_operacionpf       = @w_op_operacionpf,
      @i_valor             = @w_ajuste_int, 
      @i_moneda            = @w_moneda, 
      @i_afectacion        = @w_tipo,  /* N=Normal,  R=Reverso  */
      @i_descripcion       = @w_descripcion,
      @o_comprobante       = @o_comprobante out
   if @w_return <> 0
   begin
      rollback tran
      select @w_return = 143041
      goto borra
   end
end

-------------------------------------------------------
-- insercion de datos sobre la nueva tabla pf_incre_op
-------------------------------------------------------
insert into pf_incre_op
     (io_secuencial         , io_num_banco               , io_operacion          , io_ente,                           
      io_toperacion         , io_categoria               , io_estado             , io_producto,
      io_oficina            , io_moneda                  , io_num_dias           , io_base_calculo,
      io_monto              , io_monto_pg_int            , io_monto_pgdo         , io_monto_blq,
      io_tasa               , io_tasa_efectiva           , io_int_ganado         , io_int_estimado, 
      io_residuo            , io_int_pagados             , io_int_provision      , io_total_int_ganados,
      io_total_int_pagados  , io_total_int_estimado      , io_total_int_retenido , io_total_retencion,
      io_fpago              , io_ppago                   , io_dia_pago           , io_casilla,
      io_direccion          , io_telefono                , io_historia           , io_duplicados, 
      io_renovaciones       , io_incremento              , io_mon_sgte           , io_pignorado,
      io_renova_todo        , io_imprime                 , io_retenido           , io_retienimp,
      io_totalizado         , io_tcapitalizacion         , io_oficial            , io_accion_sgte,
      io_preimpreso         , io_tipo_plazo              , io_tipo_monto         , io_causa_mod, 
      io_descripcion        , io_fecha_valor             , io_fecha_ven          , io_fecha_cancela,
      io_fecha_ingreso      , io_fecha_pg_int            , io_fecha_ult_pg_int   , io_ult_fecha_calculo,
      io_fecha_crea         , io_fecha_mod               , io_fecha_total        , io_puntos,
      io_total_int_acumulado, io_tasa_mer                , io_ced_ruc            , io_plazo_ant,
      io_fecven_ant         , io_tot_int_est_ant         , io_fecha_ord_act      , io_mantiene_stock,
      io_stock              , io_emision_inicial         , io_moneda_pg          , io_impuesto,
      io_num_imp_orig       , io_impuesto_capital        , io_retiene_imp_capital, io_ley,
      io_reestruc           , io_fecha_real              , io_ult_fecha_cal_tasa , io_num_dias_gracia,
      io_prorroga_aut       , io_tasa_variable           , io_mnemonico_tasa     , io_modalidad_tasa,
      io_periodo_tasa       , io_descr_tasa              , io_operador           , io_spread,
      io_estatus_prorroga   , io_num_prorroga            , io_anio_comercial     , io_flag_tasaefec,
      io_renovada           , io_incre                   , io_sec_incre          , io_int_ajuste,
      io_int_prov_vencida   , io_int_total_prov_vencida  , io_residuo_prov       , io_tasa_ant,
      io_cambio_tasa        , io_estado_inc              , io_fecha_aplicacion   , 
      io_oficial_principal  , io_tipo_tasa_var           , io_plazo_orig         , io_ult_fecha_calven,
      io_localizado         , io_fecha_localizacion      , io_fecha_no_localiza  )
select @w_siguiente         , op_num_banco              , op_operacion          , op_ente,
      op_toperacion         , op_categoria               , op_estado             , op_producto,
      op_oficina            , op_moneda                  , op_num_dias           , op_base_calculo,
      op_monto              , op_monto_pg_int            , op_monto_pgdo         , op_monto_blq,
      op_tasa               , op_tasa_efectiva           , op_int_ganado         , op_int_estimado, 
      op_residuo            , op_int_pagados             , op_int_provision      , op_total_int_ganados,
      op_total_int_pagados  , op_total_int_estimado      , op_total_int_retenido , op_total_retencion,
      op_fpago              , op_ppago                   , op_dia_pago           , op_casilla,
      op_direccion          , op_telefono                , op_historia           , op_duplicados, 
      op_renovaciones       , op_incremento              , op_mon_sgte           , op_pignorado,
      op_renova_todo        , op_imprime                 , op_retenido           , op_retienimp,
      op_totalizado         , op_tcapitalizacion         , @s_user               , op_accion_sgte,
      op_preimpreso         , op_tipo_plazo              , op_tipo_monto         , op_causa_mod, 
      op_descripcion        , op_fecha_valor             , op_fecha_ven          , op_fecha_cancela,
      op_fecha_ingreso      , op_fecha_pg_int            , op_fecha_ult_pg_int   , op_ult_fecha_calculo,
      op_fecha_crea         , @i_fecha_valor_cambio      , op_fecha_total        , op_puntos,
      op_total_int_acumulado, op_tasa_mer                , op_ced_ruc            , op_plazo_ant,
      op_fecven_ant         , op_tot_int_est_ant         , op_fecha_ord_act      , op_mantiene_stock,
      op_stock              , op_emision_inicial         , op_moneda_pg          , op_impuesto,
      op_num_imp_orig       , op_impuesto_capital        , op_retiene_imp_capital, op_ley,
      op_reestruc           , op_fecha_real              , op_ult_fecha_cal_tasa , op_num_dias_gracia,
      op_prorroga_aut       , op_tasa_variable           , op_mnemonico_tasa     , op_modalidad_tasa,
      op_periodo_tasa       , op_descr_tasa              , op_operador           , op_spread,
      op_estatus_prorroga   , op_num_prorroga            , op_anio_comercial     , op_flag_tasaefec,
      op_renovada           , op_incre                   , op_sec_incre          , op_int_ajuste,
      op_int_prov_vencida   , op_int_total_prov_vencida  , op_residuo_prov       , op_tasa_ant,
      op_cambio_tasa        , 'ACT'                      , @s_date               , 
      op_oficial_principal  , op_tipo_tasa_var           , op_plazo_orig         , op_ult_fecha_calven,
      op_localizado         , op_fecha_localizacion      , op_fecha_no_localiza  
from pf_operacion
where op_operacion = @w_op_operacionpf
if @@error <> 0
begin
   rollback tran

   exec cobis..sp_cerror
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,                
      @i_num         = 143004,
                @i_msg         = 'Error en insercion de maestro de incremento/disminucion'
      
   select @w_return = 143004

   goto borra
end  

--------------------------------
-- Obtener el valor de impuesto
--------------------------------
select @w_tasa = pa_float
from cobis..cl_parametro
where pa_producto = 'PFI'
 and pa_nemonico = 'IMP'

select @w_mt_sub_secuencia = 0,@w_total_monet = 0, @w_total_monet_me = 0


select @w_afectacion = 'N', @w_total_tran  = 0, @w_pt_beneficiario = 0
               
-------------------------------------------------------------------
-- Barrido de la tabla pf_mov_monet para incrementos o reducciones
-------------------------------------------------------------------  
while 2 = 2
begin
   set rowcount 1
   select   @w_mt_sub_secuencia       = mt_sub_secuencia,
      @w_mt_producto            = mt_producto,
      @w_mt_cuenta              = mt_cuenta,
      @w_mt_valor               = mt_valor,
      @w_mt_tipo            = mt_tipo,
      @w_mt_beneficiario        = mt_beneficiario,
      @w_mt_impuesto           = mt_impuesto,
      @w_mt_moneda              = mt_moneda,
      @w_mt_valor_ext           = mt_valor_ext,
      @w_mt_fecha_crea          = mt_fecha_crea,
      @w_mt_fecha_mod           = mt_fecha_mod,
      @w_mt_impuesto_capital_me = mt_impuesto_capital_me,
      @w_mt_cta_corresp         = mt_cta_corresp,
      @w_mt_cod_corresp         = mt_cod_corresp,
      @w_mt_benef_corresp       = mt_benef_corresp,
      @w_mt_ofic_corresp        = mt_ofic_corresp,
      @w_mt_tran                = mt_tran,
      @w_mt_tipo_cliente        = mt_tipo_cliente, --CVA Oct-26-05
      @w_mt_oficina             = mt_oficina,       --LIM 11/NOV/2005
      @w_cod_banco_ach          = mt_cod_banco_ach,
      @w_tipo_cuenta_ach        = mt_tipo_cuenta_ach,
      @w_benef_cheque           = mt_benef_corresp
   from pf_mov_monet_tmp
   where mt_usuario           = @s_user
      and mt_sesion        = @s_sesn
      and mt_sub_secuencia    > @w_mt_sub_secuencia
      and mt_operacion        = @w_op_operacionpf  
   order by mt_sub_secuencia         
   if @@rowcount = 0
      break

   set rowcount 0
   
   select @w_mt_val  = round(@w_mt_valor, @w_numdeci)
   select @w_mt_impuesto   = round(@w_mt_impuesto, @w_numdeci)
   select @w_mt_valor_ext  = round(@w_mt_valor_ext, @w_numdeci)

   ----------------------------------------------------
   -- Insercion inicial de pf_mov_monet con incremento 
   ----------------------------------------------------
   insert pf_mov_monet (mm_operacion        , mm_secuencia          , mm_secuencial,
      mm_sub_secuencia    , mm_producto           , mm_cuenta,
      mm_tran             , mm_valor              , mm_tipo,
      mm_beneficiario     , mm_impuesto           , mm_moneda,
      mm_valor_ext        , mm_fecha_crea         , mm_fecha_mod,        
      mm_estado           , mm_fecha_aplicacion   , mm_impuesto_capital_me,
      mm_fecha_real       , mm_oficina            , mm_cta_corresp,
      mm_cod_corresp      , mm_benef_corresp      , mm_ofic_corresp,
      mm_incremento       , mm_usuario            , mm_fecha_valor,
      mm_tipo_cliente       , mm_cod_banco_ach      , mm_tipo_cuenta_ach)
   values (@w_op_operacionpf   , @w_secuencia          , 0,
      @w_mt_sub_secuencia , @w_mt_producto        , @w_mt_cuenta,
      @w_trn              , @w_mt_val             , @w_mt_tipo,
      @w_mt_beneficiario  , @w_mt_impuesto        , @w_mt_moneda,
      @w_mt_valor_ext     , @s_date               , @s_date,
      null                , null                  , @w_mt_impuesto_capital_me,
      @w_op_fecha_real    , @w_mt_oficina         , @w_mt_cta_corresp,        --LIM 11/NOV/2005
      @w_mt_cod_corresp   , @w_mt_benef_corresp   , @w_mt_ofic_corresp,
      'S'                 , @s_user               , @i_fecha_valor_cambio,
      @w_mt_tipo_cliente  , @w_cod_banco_ach        , @w_tipo_cuenta_ach)
   if @@error <> 0
   begin
      rollback tran
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num = 143021

      select @w_return = 143021
      goto borra
   end


        ---------------------------------------
   -- Aplicacion del movimiento monetario
   ---------------------------------------  
   exec @w_return= sp_aplica_mov
      @s_ssn             = @s_ssn,
      @s_user            = @s_user,
      @s_ofi             = @s_ofi,
      @s_date            = @s_date,
      @s_srv             = @s_srv,
      @s_term            = @s_term,
      @t_file            = @t_file,
      @t_from            = @w_sp_name, 
      @t_debug           = @t_debug,
      @t_trn             = @w_trn,
      @i_tipo            = 'N', 
      @i_operacionpf     = @w_op_operacionpf,
      @i_secuencia       = @w_secuencia,      -- Cambio ASB Panama
      @i_sub_secuencia   = @w_mt_sub_secuencia,
      @i_fecha_valor     = @i_fecha_valor_cambio,
      @i_benefi          = @w_benef_cheque
   if @w_return <> 0
   begin
      rollback tran
      exec cobis..sp_cerror 
         @t_debug=@t_debug,
         @t_file=@t_file,   
         @t_from=@w_sp_name,
         @i_num = @w_return

      goto borra        
   end

   select @w_mm_secuencia = @w_secuencia
   if @w_mt_tipo = 'C'                 --LIM 27/DIC/2005 
       begin
         select @w_producto_fpago = fp_producto,
              @w_area_contable  = fp_area_contable
         from   pf_fpago
         where  fp_mnemonico = @w_mt_producto

              if (@w_producto_fpago = 42) 
         begin

               /************************************************************************/
               /* Verificar si el beneficiario es del MIS O EXTERNO rlinares 02222007  */
               /************************************************************************/
               if @w_mt_tipo_cliente <> 'M' /* Si es diferente de MIS NO ENVIO  DATOS A SBANCARIOS */
                  begin
                    select @w_cod_ben = NULL
                    select @w_origen_ben = NULL
                  end 
               else
                  begin
                    select @w_origen_ben = @w_mt_tipo_cliente
                    select @w_cod_ben    = convert(varchar(255),@w_mt_beneficiario)
                  end

            ----------------------------------------------------
          -- Tomar la descripcion del beneficiario del cheque 
            ----------------------------------------------------
          select @w_descripbenef     = ec_descripcion
            from   pf_emision_cheque
          where  ec_operacion        = @w_op_operacionpf
              and  ec_tran             = 14990
            and  ec_secuencia        = @w_secuencia
              and  ec_sub_secuencia    = @w_mt_sub_secuencia
              
          if @w_area_contable IS  NULL
            begin
             select @w_area_contable = td_area_contable
               from   pf_tipo_deposito
             where  td_mnemonico = @w_op_toperacion                                          
               if @@error <> 0
               begin
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                          @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                        @i_num          = 141115 
         
         select @w_return = 141115
         goto borra
               end
            end

                 exec   @w_idlote    = cob_interfase..sp_isba_cseqnos   -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos 
                 @i_tabla     = 'sb_identificador_lotes', 
                   @o_siguiente = @w_numero out                 

         
            select @w_campo47  = tn_descripcion,
                 @w_concepto = Substring(tn_descripcion,1,25) 
            from   cobis..cl_ttransaccion
            where  tn_trn_code = 14990

            select @w_concepto = @w_concepto                              
          select @w_campo48 = 'DEPOSITO A PLAZO ' + @i_cuenta
                                 
            select @w_campo1 = 'PFI' 
                                   
          if @w_mt_producto = @w_cheque_ger
               select @w_campo40 = 'E'

            ------------------------------------------------------------------
          -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
            ------------------------------------------------------------------                        
            select @w_conceptosb = convert(tinyint,codigo) 
            from   cobis..cl_catalogo 
            where  tabla in (select codigo 
                             from   cobis..cl_tabla 
                            where  tabla = 'sb_conceptos_implot') 
            and  valor = 'DPF'
            
            exec @w_return = cob_interfase..sp_isba_imprimir_lotes   -- BRON: 15/07/09  cob_sbancarios..sp_imprimir_lotes 
               @s_ssn              = @s_ssn,
               @s_user             = @s_user,
               @s_term             = @s_term,
               @s_date             = @s_date,
               @s_srv              = @s_srv,
               @s_lsrv             = @s_lsrv,
               @s_rol              = @s_rol,
               @s_ofi              = @s_ofi,
               @s_sesn             = @s_ssn,
               @t_debug            = @t_debug,
               @t_trn              = 29334,
               @i_oficina_origen   = @s_ofi,
               @i_ofi_destino      = @w_mt_oficina,     
               @i_func_solicitante = 0,
               @i_fecha_solicitud  = @s_date,
               @i_producto         = 4,
               @i_valor            = @w_mt_val,
               @i_beneficiario     = @w_descripbenef,
               @i_referencia       = @i_cuenta,     
               @i_campo1           = @w_campo1,
               @i_campo2           = @w_concepto,
               @i_estado           = 'D',
               @i_observaciones    = @w_concepto,
               @i_campo8           = @w_campo48,
               @i_campo40          = @w_campo40,
               @i_area_origen      = 90,
               @i_llamada_ext      = 'S',
               @i_concepto         = @w_conceptosb, 
               @i_fpago            = @w_mt_producto, --nuevo requerimiento SBA
               @i_moneda           = @w_mt_moneda,
               @i_origen_ing       = '3',
               @i_idlote           = @w_numero,  --VERIFICAR ESTE VALOR PARA EL REVERSO EN SB
               @i_cod_ben          = @w_cod_ben,   /*  RLINARES 02222007 */
               @i_orig_ben         = @w_origen_ben,       /*  RLINARES 02222007 */
               @i_campo21          = 'PFI',
               @i_campo22          = 'D',
               @o_idlote           = @w_idlote out, 
               @o_secuencial       = @w_secuencial_cheque out 
                                                    
              if @w_return <>0
            begin
                     exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                        @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                       @i_num          = 141095

             select @w_return = 141095

             goto borra
                   end
           
            ----------------------------------------------------------
          -- Actualizar registro en pf_emision_cheque para que
            -- no pueda ser cargado en pantalla de emision de ordenes
          ----------------------------------------------------------
            update pf_emision_cheque
          set    ec_fecha_emision    = @s_date,
                   ec_numero           = @w_numero,
                 ec_estado           = 'A',
                   ec_caja             = 'S',
                   ec_secuencial_lote  = @w_secuencial_cheque       
          where  ec_operacion        = @w_op_operacionpf
              and  ec_tran             = 14990
              and  ec_secuencia        = @w_mm_secuencia
              and  ec_sub_secuencia    = @w_mt_sub_secuencia          
          if @@rowcount = 0
            begin
          exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num = 145031

          select @w_return = 145031

          goto borra
          end
                      
            -------------------------------------------------------------
          -- Actualizar mm_num_cheque para reverso Servicios Bancarios
            -------------------------------------------------------------
          update pf_mov_monet
            set    mm_num_cheque     = @w_numero
            where  mm_operacion      = @w_op_operacionpf
            and  mm_tran           = 14990
              and  mm_secuencia      = @w_mm_secuencia
            and  mm_sub_secuencia  = @w_mt_sub_secuencia          
            if @@error <> 0
          begin   
                    exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 145020

                select @w_return = 145020

                    goto borra
                 end
              end
         end   
end

set rowcount 0 


select @w_sec1 = isnull(max(dp_secuencia),0)+1 
from pf_det_pago
where dp_operacion = @w_op_operacionpf

------------------------------------------------------------------------------------------
-- Actualizar pf_det_pago todos aquellos intereses anteriores a un incremento/disminucion
------------------------------------------------------------------------------------------
set rowcount 0

--CVA Jul-05-06 Para que no guarde en det_pago los valores por INC
  delete pf_det_pago_tmp 
   where dt_usuario  = @s_user 
     and dt_sesion    = @s_sesn
     and dt_operacion = @w_op_operacionpf
     and dt_tipo      = 'INC'

update cob_pfijo..pf_det_pago
set   dp_estado      = 'E',
   dp_fecha_mod   = @s_date,
   dp_estado_xren = 'D'  --CVA Oct-26-05
where dp_estado            = 'I'
   and dp_estado_xren = 'N'
   and dp_tipo in ('INT','INTV')
   and dp_operacion = @w_op_operacionpf
    
while 6=6
begin
   set rowcount 1 
   select   @w_pt_beneficiario    = dt_beneficiario,
      @w_pt_tipo            = dt_tipo,
      @w_pt_forma_pago      = dt_forma_pago,
      @w_pt_cuenta          = dt_cuenta,
      @w_pt_monto           = round(dt_monto, @w_numdeci),
      @w_pt_porcentaje      = dt_porcentaje,
      @w_pt_fecha_crea      = dt_fecha_crea,
      @w_pt_fecha_mod       = dt_fecha_mod,
      @w_pt_moneda_pago     = dt_moneda_pago,
      @w_pt_descripcion     = dt_descripcion,      
      @w_pt_oficina         = dt_oficina,      
      @w_pt_tipo_cliente    = dt_tipo_cliente,
      @w_pt_tipo_cuenta_ach = dt_tipo_cuenta_ach,
      @w_pt_banco_ach       = dt_banco_ach,
      @w_pt_cod_banco_ach   = dt_cod_banco_ach  --CVA Dic-9-06
   from pf_det_pago_tmp
   where dt_usuario           = @s_user
      and dt_sesion           = @s_sesn
          and (dt_beneficiario    >= @w_pt_beneficiario or 
                   (dt_beneficiario     = @w_pt_beneficiario and dt_forma_pago <> @w_pt_forma_pago)) 
      and dt_operacion        = @w_op_operacionpf
   order by dt_beneficiario
     
   if @@rowcount = 0
      break

   if @w_pt_tipo =  'INT' or @w_pt_tipo = 'INTV'
      select @w_estado_xren = 'N'
   else   
      select @w_estado_xren = 'S'
                                      
   insert pf_det_pago (dp_operacion         , dp_ente           , dp_tipo       , dp_secuencia,
      dp_forma_pago        , dp_cuenta         , dp_monto      , dp_porcentaje,
      dp_fecha_crea        , dp_fecha_mod      , dp_estado_xren, dp_estado,
      dp_moneda_pago       , dp_descripcion    , dp_oficina    , dp_tipo_cliente,
      dp_tipo_cuenta_ach   , dp_banco_ach      , dp_cod_banco_ach)   
   values (@w_op_operacionpf    , @w_pt_beneficiario, @w_pt_tipo    , @w_sec1,
      @w_pt_forma_pago     , @w_pt_cuenta      , @w_pt_monto   , @w_pt_porcentaje,
      @s_date              , @s_date           , @w_estado_xren, 'I',
      @w_pt_moneda_pago    , @w_pt_descripcion , @w_pt_oficina , @w_pt_tipo_cliente,
      @w_pt_tipo_cuenta_ach, @w_pt_banco_ach   , @w_pt_cod_banco_ach)   
   if @@error <> 0
   begin
      rollback tran
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143038
      select @w_return = 143038
      goto borra
   end   
         
   delete pf_det_pago_tmp
   where dt_usuario     = @s_user
      and dt_sesion     = @s_sesn
      and dt_beneficiario  = @w_pt_beneficiario
      and dt_operacion  = @w_op_operacionpf
      and dt_tipo       = @w_pt_tipo
      and dt_forma_pago    = @w_pt_forma_pago
      and dt_cuenta     = @w_pt_cuenta
      and dt_monto      = @w_pt_monto
      and dt_porcentaje    = @w_pt_porcentaje

   select @w_sec1 = @w_sec1 + 1 

end /*  While 6  */
         
set rowcount 0


-- Inserta registro de historia
insert pf_historia (hi_operacion,hi_secuencial,    hi_fecha,
   hi_trn_code,      hi_valor,      hi_funcionario,
   hi_oficina,    hi_fecha_crea,    hi_fecha_mod,
   hi_fecha_back,    hi_saldo_capital, hi_secuencia)
values (@w_op_operacionpf,    @w_historia,      @s_date,
   @w_trn,     @i_incremento,    @s_user,
   @s_ofi,        @s_date,    @s_date,
   @i_fecha_valor_cambio,  @i_monto_n,    @w_secuencia)
if @@error <> 0
begin
   rollback tran
   select @w_return = 143006
   goto borra
end

---------------------------------------------
-- Contabilizacion de incremento y reduccion
---------------------------------------------
if abs(@i_incremento) > 0
begin
   if @i_incremento > 0
      select   @w_inc_conta = @i_incremento,
         @w_dec_conta = 0,
         @w_descripcion = 'INCREMENTO-' + @w_num_banco
   else
      select   @w_inc_conta = 0,
         @w_dec_conta = abs(@i_incremento),
         @w_descripcion = 'DISMINUCION-' + @w_num_banco     

   exec @w_return = cob_pfijo..sp_aplica_conta
      @s_ssn              = @s_ssn,
      @s_date             = @s_date,
      @s_user             = @s_user,
      @s_term             = @s_term,
      @s_ofi              = @s_ofi,
      @t_debug         = @t_debug,
      @t_file             = @t_file,
      @t_from             = @t_from,
      @t_trn               = 14937,
      @i_empresa           = 1,
      @i_fecha             = @s_date,
      @i_tran              = @w_trn,
      @i_producto          = 14,       /* op_producto de pf_operacion */
      @i_oficina_oper      = @w_oficina,
      @i_oficina           = @s_ofi, 
      @i_toperacion        = @w_op_toperacion,  /*op_toperacion de pf_operacion */
      @i_tplazo            = NULL,     /* Nemonico del tipo de plazo */ 
      @i_operacionpf       = @w_op_operacionpf,
      @i_incremento     = @w_inc_conta,
      @i_decremento     = @w_dec_conta,
      @i_secuencia      = @w_secuencia,
      @i_valor             = 0, 
      @i_moneda            = @w_moneda, 
      @i_afectacion        = 'N',         /* N=Normal,  R=Reverso  */
      @i_descripcion       = @w_descripcion,
      @o_comprobante       = @o_comprobante out
   if @w_return <> 0
   begin
      rollback tran
      select @w_return = 143041
      goto borra
   end
end

-- Actualizacio de cuotas posteriores a la fecha de proximo pago de interes calculado
-- Borra cuotas >= a fecha de proximo pago de interes
-----------------------------------------------
-- Actualizacion de cuotas segun nuevo calculo
-----------------------------------------------
if @w_fpago = 'PER'
begin
   ---------------------------------
   -- Borrado de la tabla historica
   ---------------------------------
   set rowcount 0
   delete cob_pfijo..pf_cuotas_his
   where ch_operacion = @w_op_operacionpf

   if @w_tcapitalizacion = 'S'
      select @w_monto_new = @i_monto_n + @i_int_estimado_n
   else
      select @w_monto_new = @i_monto_n 

   --------------------------------------------------------------------
   -- Actualizacion de la cuota con el nuevo valor de interes estimado
   --------------------------------------------------------------------
   update pf_cuotas
   set   cu_valor_cuota    = @i_int_estimado_n,
      cu_valor_neto  = @i_int_estimado_n,
      cu_capital        = @i_monto_n   
   where cu_operacion =  @w_op_operacionpf
      and cu_fecha_pago = @w_fecha_pg_int 
   if @@error <> 0
   begin
      rollback tran
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg    = 'Error al actualizar cuotas...',
         @i_num   = 145001
      select @w_return = 145001
      goto borra
   end         
      
   --print 'Llama a sp_cuotas -> monto_new:%1!,@w_fecha_pg_int:%2!',@w_monto_new,@w_fecha_pg_int
   ------------------------------------------------------
   -- Generacion de nuevo archivo de cuotas por operacion (02/23/2004)
   ------------------------------------------------------
   exec @w_return = sp_actualiza_cuota
      @s_ssn                  = @s_ssn,
      @s_user                 = @s_user,
      @s_sesn                 = @s_sesn,
      @s_ofi                  = @s_ofi,
      @s_date                 = @s_date,
      @t_trn                  = 14146,
      @s_srv                  = @s_srv,
      @s_term                 = @s_term,
      @t_file                 = @t_file,
      @t_from                 = @w_sp_name,
      @t_debug                = @t_debug,
      @i_monto                = @w_monto_new,   --para el caso de que el monto deba sumarse al interes debido a que el DPF capitaliza intereses
      @i_fecha_proceso        = @w_fecha_pg_int,
      @i_op_operacion         = @w_op_operacionpf
   if @w_return <> 0
   begin
      rollback tran
      goto borra
   end   
end


select @w_return = 0

commit tran 

goto borra

----------------------------
-- Borrar tablas temporales
----------------------------
borra:
   set rowcount 0
   delete pf_mov_monet_tmp 
   where mt_usuario = @s_user 
      and mt_sesion = @s_sesn
   
   delete pf_det_pago_tmp 
   where dt_usuario = @s_user 
      and dt_sesion = @s_sesn
   
   delete pf_det_cheque_tmp 
    where ct_usuario = @s_user 
       and ct_sesion = @s_sesn

   delete pf_rubro_op_tmp
     where rot_usuario = @s_user 
      and rot_sesion    = @s_sesn
       and rot_operacion = @w_op_operacionpf

      
return @w_return
go
