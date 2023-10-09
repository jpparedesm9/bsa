/************************************************************************/
/*      Archivo:                renpfdef.sp                             */
/*      Stored procedure:       sp_renovacion                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 08-Sep-95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa mueve la informacion de las tablas temporales     */
/*      de operaciones de plazo fijo nuevas a las tablas definitivas    */
/*      realizando la funcion completa de renovacion del deposito.      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      19/NOV/05  Luis Im            Se remplaza nombre banco ach por  */
/*                                    cod. banco ach                    */
/************************************************************************/  
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_renovacion')
   drop proc sp_renovacion

go
create proc sp_renovacion (          
      @s_ssn                  int             = NULL,
      @s_ssn_branch           int             = NULL,          
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_sesn                 int             = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,

      --@i_cuenta               cuenta,
      @i_cuenta_ant           cuenta,
      @i_incremento           money,
      @i_int_vencido          money           = 0,
      @i_fecha_valor          datetime,
      @i_tasa                 float           = NULL,
      @i_plazo                int             = NULL,
      @i_impuesto             money           = 0,
      @i_vuelto               money           = 0,
      @i_totint               money           = 0,
      @i_moneda_pg            char(2)         = NULL,
      @i_renova_todo          char(1)         = 'N',
      @i_descripcion          descripcion     = NULL,
      @i_impuesto_capital     money           = 0,
      @i_ley                  char(1)         = NULL,
      @i_fecha_cal_tasa       datetime        = NULL,
      @i_retiene_imp_capital  char(1)         = 'N',   
      @i_tasa_efectiva        float           = 0,      -- 04-May-2000 Tasa Efec/Nom
      @i_flag_tasaefec        char(1)         = 'N',    -- 04-May-2000 Tasa Efec/Nom
      @i_tasa_variable        char(1)         = 'N',    -- 12-Abr-2000 TASA VARIABLE
      @i_mnemonico_tasa       catalogo        = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_modalidad_tasa       char(1)         = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_periodo_tasa         smallint        = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_descr_tasa           descripcion     = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_operador             char(1)         = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_spread               float           = 0,      -- 12-Abr-2000 TASA VARIABLE
      @i_puntos               float           = 0,      -- 12-Abr-2000 TASA VARIABLE
      @i_aut_spread           login           = NULL,   -- 12-Abr-2000 TASA VARIABLE
      @i_autorizback          login           = NULL,   -- Autorizacion por fecha BackValue
      @i_autorizado           login           = NULL,   -- Autoriza pago de intereses vencidos
      @i_diahabil             char(1)         = 'S',    -- Evaluar si se paga int en dia habil
      @i_plazo_orig           int             = NULL,   -- Plazo original para renovacion automatica
      @i_cotizacion           float           = 1,
      @i_calldate             datetime        = NULL,
      @i_firmas_aut           char(1)         = NULL,    -- gap DP00008 Firmas Autorizadas
      @i_ente_corresp         int             = NULL,    -- GAR GB-DP00120
      @i_dia_pago             tinyint         = NULL,    -- GAR GB-DP00120 Dia Pago
      @i_dias_reales          char(1)         = NULL,    -- GAR GB-DP00120 Dia Pago
      @i_localizado           char(1)         = NULL,
      @i_fecha_localizacion   smalldatetime   = NULL,
      @i_fecha_no_localiza    smalldatetime   = NULL,
      @i_fpago                catalogo        = NULL,
      @i_ppago                catalogo        = NULL,
      @i_spread_fijo          float           = 0,
      @i_operador_fijo        char(1)         = NULL,
      @i_instruccion_especial varchar(255)    = NULL,   --CCR Manejo de instruccion especial
      @i_modifica             char(1)         = 'N' ,--CVA Jun-29-06 para escalonados vendra en S
      @i_desmaterializa       char(1)         = 'N' 
)
with encryption
as
declare 
   @w_sp_name                      varchar(32),
   @w_string                       varchar(30),
   @w_descripcion                  descripcion,
   @w_return                       int,
   @w_comentario                   varchar(32),
   @w_siguiente                    int,
   @w_secuencial                   int,
   @w_secuencia                    int,
   @w_sec                          int,
   @w_ofi_ing                      int,
   @w_historia                     int,
   @w_num_oficial                  int,
   @w_money                        money,
   @w_total_monet                  money,
   @w_activa                       char(1),
   @w_fecha_no_lab                 datetime,
   @w_retienimp                    char(1),
   @w_numdeci                      tinyint,
   @w_usadeci                      char(1),
   @w_operacion_nueva              int,            -- Guarda nueva operacion
   @o_operacion_new                cuenta,
   @o_comprobante                  int,
   @w_estado                       char(1),
   @w_sec_ticket                   int,
   @w_moneda_base                  tinyint,
   @w_estado_spread                char(1),
   @w_ssn_spread                   int,
   @w_instruccion                  char(1), --CVA May-06-06
   @w_cheque_ger                   catalogo,--CVA May-06-06
   @w_giro                         catalogo,--CVA May-06-06

/*  Variables para la operacion anterior en Renovacion */
   @w_p_operacionpf                int,
   @w_p_moneda                     tinyint,
   @w_p_toperacion                 catalogo, 
   @w_p_tplazo                     catalogo,
   @w_p_producto                   tinyint,
   @w_p_oficina                    smallint,        -- GAL 31/AGO/2009 - RVVUNICA
   @w_p_num_dias                   smallint,
   @w_p_historia                   smallint,
   @w_p_renovaciones               smallint,
   @w_p_monto                      money,
   @w_p_mont                       money,
   @w_total_int_estimado           money,
   @w_total_int_pagados            money,
   @w_int_pagados                  money,
   @w_monto_renovar                money,
   @w_int_renovar                  money,
   @w_int_ven                      money,
   @w_int_vencido                  money,
   @w_impuesto                     money,
   @w_impven                       money,
   @w_incremento                   money,
   @w_p_tasa                       float,
   @w_tasa                         float,
   @w_tasa_sucres                  float,
   @w_tasa_dolares                 float,
   @w_tasa_uvc                     float, 
   @w_p_tasa_efectiva              float,
   @w_p_mon_sgte                   smallint,
   @w_p_estado                     catalogo,
   @w_ch1                          catalogo,
   @w_p_accion_sgte                catalogo,
   @w_p_causa_mod                  varchar(60),
   @w_p_fecha_ven                  datetime,
   @w_p_fecha_valor                datetime,
   @w_fecha_pg_int                 datetime,
   @w_tcapitalizacion              char(1),  -- Capitaliz.
   @w_fpago                        catalogo, -- Capitaliz.
   @w_fecha_ult_pg_int             datetime,
   @w_op_inactivo                  char(1),
   @w_benef_chq                    varchar(255),

/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
   @w_bt_ente                      int,
   @w_bt_rol                       catalogo,
   @w_bt_fecha_crea                datetime,
   @w_bt_fecha_mod                 datetime,
   @w_bt_tipo                      char(1),
   @w_bt_condicion                 char(1),
   @w_bt_secuencia                 smallint,
 
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
   @w_mt_sub_secuencia             int,
   @w_mt_producto                  catalogo,
   @w_mt_cuenta                    cuenta,
   @w_mt_tipo                      char(1),
   @w_mt_beneficiario              int,
   @w_mt_impuesto                  money,
   @w_mt_moneda                    int,
   @w_mt_valor_ext                 money,
   @w_mt_fecha_crea                datetime,
   @w_mt_fecha_mod                 datetime,
   @w_mt_valor                     money,
   @w_mt_val                       money,
   @w_mt_impuesto_capital_me       money,
   @w_mt_secuencial                money,
   @w_mt_cta_corresp               cuenta,
   @w_mt_cod_corresp               catalogo,
   @w_mt_benef_corresp             varchar(245),
   @w_mt_ofic_corresp              int,
   @w_mm_secuencia                 int,
   @w_mt_ttransito                 smallint,
   @w_mt_oficina                   smallint,
   @w_mt_cod_banco_ach             smallint, --LIM 19/NOV/2005
   @w_mt_tipo_cliente              char(1),
/*  Variables para det_cheque_tmp   */
   @w_ct_sub_secuencia             smallint,
   @w_ct_banco                     catalogo,
   @w_ct_cuenta                    cuenta,
   @w_ct_cheque                    int,
   @w_operacion_tmp                int,
   @w_ct_valor                     money,
   @w_ct_val                       money,
   @w_ct_val_tot                   money,
   @w_ct_descripcion               descripcion,
   @w_ct_fecha_crea                datetime,
   @w_ct_fecha_mod                 datetime,
/* Variables para det_pago_tmp  */
   @w_pt_beneficiario              int,
   @w_sec1                         int,
   @w_pt_tipo                      catalogo,
   @w_pt_forma_pago                catalogo,
   @w_pt_cuenta                    cuenta,   
   @w_pt_monto                     money,
   @w_pt_mont                      money,
   @w_pt_porcentaje                float,
   @w_pt_fecha_crea                datetime, 
   @w_pt_fecha_mod                 datetime,
   @w_pt_moneda_pago               smallint,
   @w_p_ente                       int,
   @w_pt_descripcion               varchar(255),   --gap DP00008
   @w_pt_oficina                   int,      --gap DP00008
   @w_pt_tipo_cliente              char(1),        --gap DP00008
   @w_pt_tipo_cuenta_ach           char(1),
   @w_pt_banco_ach                 descripcion,
   @w_pt_cod_banco_ach             smallint,  --LIM 19/NOV/2005
/* Variables para condicion_tmp  */
   @w_forma_pago                   catalogo,
   @w_cuenta_aho                   cuenta,
   @w_co_condicion                 tinyint,
   @w_co_comentario                varchar(60),
   @w_msg                          varchar(60),
   @w_co_fecha_crea                datetime,
   @w_co_fecha_mod                 datetime,
/*  Variables para det_condicion_tmp   */
   @w_dt_condicion                 smallint,
   @w_dt_ente                      int,
   @w_dt_fecha_crea                datetime,
   @w_dt_fecha_mod                 datetime,
/* Variables para retencion de impuesto */
   @w_retiene_imp_capital          char(1),
   @w_impuesto_capital             money,
   @w_retienimp_tabla              char(1),
   @w_total_monet_me               money,
   @w_op_bloqueo_legal             char(1),
   @w_monto_pgdo                   money,
   @w_monto_blq                    money,
   @w_op_monto_blq_legal           money,
   @w_debcred                      char(1),
   @w_tasa_base                    float,
   @w_op_tipo_monto                catalogo,
   @w_op_nuevo_tipo_plazo          catalogo,
   @w_casilla                      tinyint,
   @w_direccion                    tinyint,
   @w_sucursal                     smallint,
   @w_estado_ejecuta_xren          char(1),
   @w_estado_ejecuta               char(1),
   @w_observacion                  descripcion,
   @w_oficial_pri                  login,
   @w_tipo_cuenta_ach              char(1),  --+-+
   @w_oficial_sec                  login,
   @w_tipo_plazo                   catalogo,
   @w_mt_subtipo_ins               int,                  -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @w_mpago_chqcom                 varchar(30),           -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @w_fpago_ticket                 tinyint,
   @w_embargo			   money,
   @w_tipo_deposito                int

/*----------------------------------*/
/*  Verificar codigo de Transaccion */
/*----------------------------------*/
if   @t_trn <> 14904 
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
        return 1
end 
-------------------------------
-- Inicializacion de variables
-------------------------------
select   @w_sp_name  = 'sp_renovacion',        
         @w_secuencial  = @s_ssn,
         @w_ofi_ing     = @s_ofi,
         @w_impuesto = 0,
         @w_impven   = 0

/*LIM 23/ENE/2006 Creacion Tablas Temporales*/

create table #ca_operacion_aux (
op_operacion         int,
op_banco             varchar(24), 
op_toperacion        varchar(10),
op_moneda            tinyint,
op_oficina           int,
op_fecha_ult_proceso datetime ,
op_dias_anio         int,
op_estado            int,
op_sector            varchar(10),
op_cliente           int,
op_fecha_liq         datetime,
op_fecha_ini         datetime ,
op_cuota_menor       char(1),
op_tipo              char(1),
op_saldo             money,       -- LuisG 04.06.2001
op_fecha_fin         datetime,    -- LuisG 04.06.2001
op_base_calculo      char(1) ,    --lre version estandar 05/06/2001
op_periodo_int       smallint,    --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)



create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)


CREATE TABLE #det_cus_garantias (            --LIM 01/FEB/2006
       garantia                varchar(64)     NOT NULL,
       tipo                    varchar(64)     NOT NULL,
       tasa                    float           NULL,
       cuenta                  varchar(24)     NULL)  


CREATE TABLE #det_oper_relacion (            --LIM 01/FEB/2006
       op_garantia                varchar(64)     NOT NULL,
       op_tramite                 int             NOT NULL,
       op_tipo                    char(1)         NOT NULL,
       op_toperacion              varchar(10)         NULL,
       op_producto                varchar(10)         NULL,
       op_tasa_asoc               char(1)             NULL,
       op_cuenta                  varchar(24)         NULL)

/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (           --LIM 01/FEB/2006
concepto        varchar(10),
valor           money
)

----------------------------
-- Validacion del Call Date
----------------------------
if @i_calldate is null
   select @i_calldate = @s_date

select @i_incremento = isnull(@i_incremento, 0)

select @w_instruccion = 'N' --CVA May-06-06

--I. CVA May-06-06
select @w_cheque_ger = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico='NCHG'
   and pa_producto='PFI'

select @w_giro = pa_char 
  from cobis..cl_parametro
 where pa_nemonico = 'NLI1' 
   and pa_producto = 'PFI'
--F. CVA May-06-06
-- MEDIO DE PAGO CHEQUE COMERCIAL - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char             
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'

select @w_moneda_base = em_moneda_base
    from cob_conta..cb_empresa where em_empresa = 1

-----------------------
-- Lectura del oficial
-----------------------
select @w_num_oficial = fu_funcionario
  from cobis..cl_funcionario
 where fu_login = @s_user

------------------------------------ 
-- Lectura de la tabla pf_operacion
------------------------------------
select @w_p_operacionpf       = op_operacion,
       @w_p_num_dias          = op_num_dias,      
       @w_p_moneda            = op_moneda,
       @w_p_oficina           = op_oficina,
       @w_p_monto             = isnull(op_monto, 0),
       @w_p_producto          = op_producto,
       @w_p_tasa              = op_tasa,       
       @w_p_tasa_efectiva     = op_tasa_efectiva,
       @w_p_historia          = op_historia,      
       @w_p_renovaciones      = op_renovaciones, 
       @w_p_mon_sgte          = op_mon_sgte,    
       @w_p_accion_sgte       = op_accion_sgte, 
       @w_p_fecha_ven         = op_fecha_ven, 
       @w_p_causa_mod         = op_causa_mod, 
       @w_total_int_estimado  = op_total_int_estimado,
       @w_fecha_ult_pg_int    = op_fecha_ult_pg_int,
       @w_fecha_pg_int        = op_fecha_pg_int,
       @w_total_int_pagados   = op_total_int_pagados,    
       @w_int_pagados         = op_int_pagados,    
       @w_historia         = op_historia+1,      
       @w_p_estado            = op_estado,
       @w_tcapitalizacion     = op_tcapitalizacion, -- Capitalizacion
       @w_fpago               = op_fpago,           -- Capitaliz.
       @w_retienimp_tabla     = op_retienimp,       -- PRA
       @w_p_fecha_valor       = op_fecha_valor,
       @w_p_fecha_ven         = op_fecha_ven,
       @w_p_toperacion        = op_toperacion,
       @w_op_bloqueo_legal    = op_bloqueo_legal,
       @w_monto_pgdo          = isnull(op_monto_pgdo, 0),
       @w_monto_blq           = isnull(op_monto_blq, 0),
       @w_op_monto_blq_legal  = isnull(op_monto_blqlegal, 0),
       @w_p_ente              = op_ente,
       @w_op_inactivo         = op_inactivo,
       @w_embargo             = isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0) 
  from pf_operacion
 where op_num_banco        = @i_cuenta_ant
   and ((op_estado = 'ACT' and op_accion_sgte = 'NULL') or op_estado = 'VEN')

if @@rowcount = 0
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
   return 1
end

if @w_embargo > 0 
begin
   exec cobis..sp_cerror 
        @t_from  = @w_sp_name, 
        @i_num   = 141189
   return 1
end

--CVA Nov-25-05 Para que no guarde en det_pago los valores por REN
  delete pf_det_pago_tmp 
   where dt_usuario = @s_user 
     and dt_sesion = @s_sesn
     and dt_operacion = @w_p_operacionpf
     and dt_tipo      = 'REN'





/******************************************************************
CCR Se valida que no se pueda renovar un DPF cuyo tipo de deposito
se encuentre deshabilitado
******************************************************************/
if not exists  (select 1 from pf_tipo_deposito
      where td_mnemonico   = @w_p_toperacion
      and   td_estado   = 'A')
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 141212
   select @w_return = 141212
   goto borra
end

/******CCR Fin validacion tipo deposito deshabilitado*************/


select  @w_tipo_deposito = isnull(td_tipo_deposito,0)
from 	pf_tipo_deposito
where 	td_mnemonico   = @w_p_toperacion
and   	td_estado   = 'A'

-------------------------------------
-- Encontrar el primer dia laborable
-------------------------------------
exec sp_primer_dia_labor 
     @t_debug       = @t_debug,
     @t_file        = @t_file,
     @t_from        = @w_sp_name,
     @i_fecha       = @s_date,
     @s_ofi         = @s_ofi,
     @i_tipo_deposito = @w_tipo_deposito,
     @o_fecha_labor = @w_fecha_no_lab out
-----------------------------
-- Moneda Base 26-Jun-2002
-----------------------------

-------------------------------------------------------------------------
-- Controlar que el valor a reducir no sea mayor que el monto disponible
-------------------------------------------------------------------------
if @i_incremento < 0
begin
   if abs(@i_incremento) > (@w_p_monto - @w_monto_pgdo - @w_monto_blq - @w_op_monto_blq_legal)
   begin
         exec cobis..sp_cerror                
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141189
         select @w_return = 141189
   goto borra
   end
end 

--------------------------------------------------------------
-- Mensaje de advertencia si la operacion tiene bloqueo legal
--------------------------------------------------------------
if @w_op_bloqueo_legal = 'S'
   print 'La operacion tiene Bloqueo legal'

------------------------
-- Validacion de Fechas
------------------------
if datediff(dd,@s_date,@w_fecha_no_lab) <> 0 and  @w_p_estado = 'VEN'
begin
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = 141004
   select @w_return = 141004
   goto borra
end         

select @w_retienimp         = 'N'
------------------------------------
-- Encuentra parametro de decimales
------------------------------------
if @i_moneda_pg IS   NULL select @i_moneda_pg = convert(char(2),@w_p_moneda)
   select @w_usadeci = mo_decimales
     from cobis..cl_moneda
    where mo_moneda = @w_p_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0  
begin tran

   if exists (select * from pf_renovacion 
               where re_operacion = @w_p_operacionpf
            and re_estado = 'I')
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141139
         return 1
      end

      select @w_secuencia  = @w_p_mon_sgte,
        @o_operacion_new   = ''
      select @w_string     = 'Sec ' + convert(varchar, @w_secuencia)
      select @w_incremento    = round(@i_incremento, @w_numdeci)
      select @w_p_mont     = round(@w_p_monto, @w_numdeci)
      select @w_int_vencido   = round(@i_int_vencido, @w_numdeci)
      select @i_impuesto   = round(@i_impuesto, @w_numdeci)
      select @i_totint     = round(@i_totint, @w_numdeci)

   /************************************************************************************
   CCR SE ALMACENA INFORMACION DE ENTREGA DE CORRESPONDENCIA PARA LUEGO PODER ACTUALIZAR
   EL DPF CON DICHA INFORMACION CUANDO SE REALICE LA RENOVACION
   ************************************************************************************/
   select   @w_casilla  = ot_casilla,
      @w_direccion   = ot_direccion,
      @w_sucursal = ot_sucursal,
      @w_oficial_pri = ot_oficial_principal,
      @w_oficial_sec = ot_oficial_secundario
   from  pf_operacion_tmp
   where ot_usuario  = @s_user
   and   ot_sesion   = @s_sesn
   and   ot_num_banco   = @i_cuenta_ant
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 141203
      select @w_return =  141203
      goto borra
   end


      -------------------------------------------------------------
      -- Pongo en estado 'U'(Utilizado) la autorizacion de spread
      -------------------------------------------------------------
      if @i_spread_fijo > 0
   select @w_estado_spread = 'U'
      else
   select @w_estado_spread = 'A'


   if @i_tasa_variable <> 'S' begin
   
         select @w_op_nuevo_tipo_plazo = pl_mnemonico
           from cob_pfijo..pf_plazo, pf_auxiliar_tip
          where @i_plazo >= pl_plazo_min
            and @i_plazo <= pl_plazo_max
            and at_tipo = 'PLA'
            and at_tipo_deposito = (select td_tipo_deposito from pf_tipo_deposito where td_mnemonico = @w_p_toperacion)
            and at_estado = 'A'
            and at_moneda = @w_p_moneda
            and pl_mnemonico = at_valor

         select @w_op_tipo_monto = mo_mnemonico
           from pf_monto, pf_auxiliar_tip
          where @w_p_mont >= mo_monto_min 
            and @w_p_mont <= mo_monto_max 
            and mo_mnemonico = at_valor 
            and at_tipo = 'MOT' 
            and at_tipo_deposito = (select td_tipo_deposito from pf_tipo_deposito where td_mnemonico = @w_p_toperacion)
            and at_moneda = @w_p_moneda
            and at_estado = 'A'

         select @w_tasa_base = ta_vigente
           from pf_tasa
          where ta_tipo_deposito =  @w_p_toperacion
            and ta_tipo_monto = @w_op_tipo_monto
            and ta_tipo_plazo = @w_op_nuevo_tipo_plazo

      end

      update pf_aut_spread
         set as_estado      = @w_estado_spread,
        @w_ssn_spread  = as_secuencial
       where as_operacion = @w_p_operacionpf
         and as_fecha     = @s_date
    and as_estado    = 'V'
      if @@rowcount <> 0  and @w_estado_spread = 'U'
      begin 

         insert into pf_autorizacion ( 
         au_operacion,            au_autoriza,                 au_adicional,                  au_oficina,
         au_tautorizacion,        au_fecha_crea,               au_num_banco,                  au_oficial,                    
         au_spread,               au_tasa_base,                au_tasa,                       au_secuencial)
         values(
         @w_p_operacionpf,        @s_user,                     null,                          @s_ofi,
         'ASP',                   @s_date,                     @i_cuenta_ant,                 @s_user,
         @i_spread_fijo,          @w_tasa_base,                @i_tasa,                       @w_ssn_spread)
         if @@error <> 0
         begin
            exec cobis..sp_cerror 
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143040
            select @w_return = 1
            goto borra
         end

   end 


      if @i_localizado = 'S'  --CVA Dic-14-05
         select @w_op_inactivo = NULL  

      insert pf_renovacion (re_operacion        , re_renovacion         , re_incremento,
                            re_tasa             , re_plazo              , re_monto, 
                            re_int_vencido      , re_oficial            , re_estado,
                            re_fecha_valor      , re_descripcion        , re_fecha_crea,
                            re_fecha_mod        , re_operacion_new      , re_oficina_ant,
                            re_impuesto         , re_tot_int            , re_moneda_pg,
                            re_vuelto           , re_oficina            , re_int_pagados,
                            re_total_int_pagados, re_fecha_ult_pg_int   , re_fecha_pg_int,
                            re_renova_todo      , re_retiene_imp_capital, re_ente_corresp,
                            re_dia_pago         , re_dias_reales        , re_fpago,
                            re_ppago            , re_spread_fijo        , re_operador_fijo,
                            re_plazo_orig       , re_casilla            , re_direccion,
                            re_sucursal         , re_oficial_principal  , re_oficial_secundario,
                            re_localizado       , re_fecha_localizado   , re_fecha_no_localizado,
                            re_inactivo         , re_desmaterializa,      re_puntos,
                            re_tasa_base)
                    values (@w_p_operacionpf    , @w_p_renovaciones     , @w_incremento,
                            @i_tasa             , @i_plazo              , @w_p_mont, 
                            @w_int_vencido      , @s_user               , 'I',
                            @i_fecha_valor      , @i_descripcion        , @s_date,
                            @s_date             , 0                     , @w_p_oficina,
                            @i_impuesto         , @i_totint             , @i_moneda_pg,
                            @i_vuelto           , @s_ofi                , @w_int_pagados,
                            @w_total_int_pagados, @w_fecha_ult_pg_int   , @w_fecha_pg_int,
                            @i_renova_todo      , @i_retiene_imp_capital, @i_ente_corresp, -- Se graba ret.capital
                            @i_dia_pago         , @i_dias_reales        , @i_fpago,
                            @i_ppago            , @i_spread_fijo        , @i_operador_fijo,
                            @i_plazo_orig       , @w_casilla            , @w_direccion,
                            @w_sucursal         , @w_oficial_pri        , @w_oficial_sec,
                            @i_localizado , @i_fecha_localizacion , @i_fecha_no_localiza,
                            @w_op_inactivo      , @i_desmaterializa,         @i_puntos,
                            @w_tasa_base)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_num         = 143004
         select @w_return = 143004
         goto borra
      end 

      ----------------------------------------
      -- Verificar si se autorizo Back Value
      ----------------------------------------
      if @i_autorizback is not null
      begin
         insert pf_autorizacion (au_operacion    , au_autoriza   , au_oficina, au_tautorizacion,
                                 au_fecha_crea   , au_num_banco  , au_oficial)
                         values (@w_p_operacionpf, @i_autorizback, @s_ofi    , 'BACK',
                                 @s_date         , @i_cuenta_ant , @s_user)
         if @@error <> 0
         begin
            exec cobis..sp_cerror 
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143040
            select @w_return = 1
            goto borra
         end
      end
      --------------------------------
      -- Proceso incrementado por cal
      --------------------------------
      if @i_int_vencido > 0
      begin
         insert pf_autorizacion (au_operacion    , au_autoriza  , au_oficina, au_tautorizacion,
                                 au_fecha_crea   , au_num_banco , au_oficial)
                         values (@w_p_operacionpf, @i_autorizado, @s_ofi    , 'PGIV',
                                 @s_date         , @i_cuenta_ant, @s_user)
         if @@error <> 0
         begin
            exec cobis..sp_cerror 
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143040
            select @w_return = 1
            goto borra
         end
         delete pf_funcionario 
          where fu_funcionario = @s_user
            and fu_tautorizacion = 'PGIV'
      end /* fecha back value */ 
      ------------------------------------------------
      -- Controla si se renueva capital mas intereses
      ------------------------------------------------
      if @i_renova_todo='S'
    select @w_int_renovar= @w_total_int_estimado - @w_total_int_pagados
      else
    select @w_int_renovar=0,
                @w_impuesto=0,
                @w_impven=0
      select @w_tasa = pa_float
        from cobis..cl_parametro
       where pa_producto = 'PFI'
         and pa_nemonico = 'IMP'
       
      if @w_retienimp = 'S' and @w_int_renovar > 0
         select @w_impuesto = @w_int_renovar*@w_tasa/100
      if @w_retienimp='S' and @i_int_vencido > 0
         select @w_impven   = @i_int_vencido*@w_tasa/100
      if @i_renova_todo='S'
    select @w_int_ven=@i_int_vencido - @w_impven
      else
         select @w_int_ven=0
      select @w_int_renovar=@w_int_renovar - @w_impuesto  
      select @w_monto_renovar = @w_p_monto + @w_int_renovar + @i_incremento + @w_int_ven - @i_impuesto_capital
      if @i_ley = 'C'
      begin
         if  @w_int_renovar + @i_incremento   < 0
         begin
            --------------------------------------------------------------
            -- Operacion bloqueada:No puede haber un decremento del monto
            --------------------------------------------------------------
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 149067
            return 1
         end     
      end
   /******************************************************************************
   CCR Se realiza la insercion solo si se trata de una instruccion, NO cuando es
   renovacion manual en linea
   ******************************************************************************/
   if @w_p_estado = 'VEN' or @w_p_estado = 'ACT' and datediff(dd,@w_p_fecha_ven,@s_date) < 0 --instruccion
   begin
   select @w_instruccion = 'S' --CVA May-06-06

   select @w_observacion = @i_operador_fijo + convert(varchar,@i_spread_fijo)
   
   if @w_tcapitalizacion = 'N' --ccr si no capitaliza, no se toma en cuenta el interes a renovar
      select @w_monto_renovar = @w_monto_renovar - @w_int_renovar
      --------------------------------------------
      -- Insercion de registro en tabla historica
      -------------------------------------------- 
      insert pf_historia (hi_operacion    , hi_secuencial , hi_fecha  , hi_trn_code,
                          hi_valor        , hi_funcionario, hi_oficina, hi_fecha_crea,
                          hi_fecha_mod    , hi_tasa       , hi_observacion) --En observacion van  los puntos 
                  values (@w_p_operacionpf, @w_p_historia , @s_date   , 14104,
                          @w_monto_renovar, @s_user       , @s_ofi    , @s_date,
                          @s_date         , null          , @w_observacion)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_num         = 143006
         return 1
      end


    ----------------------------------------------------------------------
    --CVA Jun-30-06 Almacenar las tasas para escalonados por instrucciones
    ----------------------------------------------------------------------
         select @w_op_nuevo_tipo_plazo = pl_mnemonico
           from cob_pfijo..pf_plazo, pf_auxiliar_tip
          where @i_plazo >= pl_plazo_min
            and @i_plazo <= pl_plazo_max
            and at_tipo = 'PLA'
            and at_tipo_deposito = (select td_tipo_deposito from pf_tipo_deposito where td_mnemonico = @w_p_toperacion)
            and at_estado = 'A'
            and at_moneda = @w_p_moneda
            and pl_mnemonico = at_valor

         select @w_op_tipo_monto = mo_mnemonico
           from pf_monto, pf_auxiliar_tip
          where @w_p_mont >= mo_monto_min 
            and @w_p_mont <= mo_monto_max 
            and mo_mnemonico = at_valor 
            and at_tipo = 'MOT' 
            and at_tipo_deposito = (select td_tipo_deposito from pf_tipo_deposito where td_mnemonico = @w_p_toperacion)
            and at_moneda = @w_p_moneda
            and at_estado = 'A'

    if  charindex('C',@w_op_nuevo_tipo_plazo) > 0
    begin
    insert into pf_rubro_op_i(roi_num_banco,roi_operacion,roi_toperacion,roi_moneda,
             roi_tipo_monto,roi_tipo_plazo,roi_concepto,roi_mnemonico_tasa,
             roi_operador,roi_modalidad_tasa,roi_periodo_tasa,roi_descr_tasa,
             roi_spread,roi_valor)
    select      rot_num_banco,rot_operacion,rot_toperacion,rot_moneda,
             rot_tipo_monto,rot_tipo_plazo,rot_concepto,rot_mnemonico_tasa,
             rot_operador,rot_modalidad_tasa,rot_periodo_tasa,rot_descr_tasa,
             rot_spread,rot_valor
    from pf_rubro_op_tmp
         where rot_operacion  =  @w_p_operacionpf
    end

   end
      ----------------------------------------------------------------------------
      -- Actualizar Operacion como causa de modificacion en REN y accion ste XREN
      ----------------------------------------------------------------------------
      update pf_operacion 
         set op_mon_sgte           = op_mon_sgte + 1,
             op_renovaciones       = (@w_p_renovaciones + 1),
             op_accion_sgte        = 'XREN',
             op_retienimp          = @w_retienimp,
             op_causa_mod          = 'REN',
             op_historia           = op_historia +1,
             op_fecha_mod          = @s_date
       where op_num_banco = @i_cuenta_ant
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_num         = 145001
         select @w_return = 1
         goto borra
      end 
               
      select @w_bt_ente = 0
      while 1 = 1
      begin
         set rowcount 1 
         select @w_bt_ente        = bt_ente,
                @w_bt_rol         = bt_rol,
           @w_bt_fecha_crea  = bt_fecha_crea,
           @w_bt_fecha_mod   = bt_fecha_mod,
                @w_bt_tipo        = bt_tipo,
                @w_bt_condicion   = bt_condicion,
                @w_bt_secuencia   = bt_secuencia
           from pf_beneficiario_tmp
          where bt_usuario     = @s_user
            and bt_sesion      = @s_sesn
            and bt_ente        > @w_bt_ente
            and bt_operacion   = @w_p_operacionpf
          order by bt_ente
         if @@rowcount = 0
            break
         set rowcount 0 
         -----------------------------------------------------------
         -- Insercion definitiva de beneficiarios de ese plazo fijo
         -----------------------------------------------------------
         exec @w_return = sp_beneficiario 
              @s_ssn         = @s_ssn,
              @s_user        = @s_user,
              @s_term        = @s_term,
              @s_date        = @s_date,
              @s_srv         = @s_srv,
              @s_lsrv        = @s_lsrv,
              @s_ofi         = @s_ofi,
              @s_rol         = @s_rol,
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @t_from,
              @t_trn         = 14109,
              @i_operacion   = 'I',
              @i_cuenta      = @i_cuenta_ant,
              @i_ente        = @w_bt_ente,
              @i_rol         = @w_bt_rol,
              @i_estado_xren = 'S',
              @i_tipo        = @w_bt_tipo,
              @i_condicion   = @w_bt_condicion,
              @i_secuencia   = @w_bt_secuencia
         if @w_return <> 0
         begin
       select @w_return = 1    
            goto borra
         end
      end /* while 1 */
      select @w_mt_sub_secuencia = 0,@w_total_monet = 0, @w_total_monet_me = 0
      -------------------------------------------------------------
      -- Generar el secuencial del ticket monetario
      -------------------------------------------------------------
      exec @w_return = cob_pfijo..sp_gen_ticket
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_oficina      = @s_ofi,
           @o_secuencial   = @w_sec_ticket out
      while 2 = 2
      begin
         set rowcount 1
         select @w_mt_sub_secuencia       = mt_sub_secuencia,
         @w_mt_producto            = mt_producto,
         @w_mt_cuenta              = mt_cuenta,
         @w_mt_valor               = mt_valor,
         @w_mt_tipo                = mt_tipo,
         @w_mt_tipo_cliente        = mt_tipo_cliente,
         @w_mt_beneficiario        = mt_beneficiario,
         @w_mt_impuesto            = mt_impuesto,
         @w_mt_moneda              = mt_moneda,
         @w_mt_valor_ext           = mt_valor_ext,
         @w_mt_fecha_crea      = mt_fecha_crea,
         @w_mt_fecha_mod       = mt_fecha_mod,
         @w_mt_impuesto_capital_me = mt_impuesto_capital_me,
         @w_mt_cta_corresp         = mt_cta_corresp,
         @w_mt_cod_corresp         = mt_cod_corresp,
         @w_mt_benef_corresp       = mt_benef_corresp,
         @w_mt_ofic_corresp        = mt_ofic_corresp,
         @w_mt_ttransito           = mt_ttransito, --gap DP00008
         @w_mt_oficina         = mt_oficina,    
         @w_mt_cod_banco_ach       = mt_cod_banco_ach,   --LIM 19/NOV/2005
         @w_tipo_cuenta_ach        = mt_tipo_cuenta_ach,
         @w_mt_subtipo_ins         = mt_subtipo_ins            -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
           from pf_mov_monet_tmp
          where mt_usuario     = @s_user
            and mt_sesion      = @s_sesn
            and mt_sub_secuencia > @w_mt_sub_secuencia
            and mt_operacion   = @w_p_operacionpf
      
         if @@rowcount = 0
            break
   
         set rowcount 0
         select @w_mt_val = round(@w_mt_valor, @w_numdeci)
         select @w_mt_impuesto = round(@w_mt_impuesto, @w_numdeci)
         select @w_mt_valor_ext = round(@w_mt_valor_ext, @w_numdeci)
         if @w_incremento > 0
         begin
            insert into pf_secuen_ticket (st_num_banco   , st_operacion  , st_secuencial, st_secuencia,
                                          st_fpago       , st_valor      , st_estado    , st_moneda,
                                          st_valor_ext   , st_fecha_crea , st_oficina)
            values (@i_cuenta_ant  , @w_p_operacionpf, @w_sec_ticket, @w_secuencia,
                 @w_mt_producto , @w_mt_valor   , 'I'          , @w_mt_moneda,
                 @w_mt_valor_ext, @s_date       , @s_ofi) 
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @i_num         = 143045
               select @w_return = 143045
               goto borra
            end
        end    

    --I. CVA May-06-06 Cuando se ejecute la instruccion tomara la oficina del deposito
    if @w_instruccion = 'S'
    begin
       if  @w_mt_producto not in (@w_cheque_ger, @w_giro, @w_mpago_chqcom)  -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM - @w_mpago_chqcom
                select @w_mt_oficina = NULL
    end
    --F. CVA May-06-06
    
--print 'renovacion @w_mt_benef_corresp:%1!,@t_trn:%2!',@w_mt_benef_corresp,@t_trn

         insert pf_mov_monet (mm_operacion       , mm_secuencia             , mm_secuencial    , mm_sub_secuencia, 
                              mm_producto        , mm_cuenta                , mm_tran          , mm_valor,
                              mm_tipo            , mm_beneficiario          , mm_impuesto      , mm_moneda,
                              mm_valor_ext       , mm_fecha_crea            , mm_fecha_mod     , mm_estado,
                              mm_fecha_aplicacion, mm_impuesto_capital_me   , mm_cta_corresp   , mm_cod_corresp,
                              mm_benef_corresp   , mm_ofic_corresp          , mm_ttransito     , mm_usuario,
                              mm_fecha_valor     , mm_oficina               , mm_cod_banco_ach , 
                              mm_tipo_cliente,     mm_tipo_cuenta_ach       , mm_subtipo_ins)                            -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM - mm_subtipo_ins 
                      values (@w_p_operacionpf   , @w_secuencia             , 0                , @w_mt_sub_secuencia, 
                              @w_mt_producto     , @w_mt_cuenta             , @t_trn           , @w_mt_val,
                              @w_mt_tipo         , @w_mt_beneficiario       , @w_mt_impuesto   , @w_mt_moneda,
                              @w_mt_valor_ext    , @s_date                  , @s_date          , null,
                              null               , @w_mt_impuesto_capital_me, @w_mt_cta_corresp, @w_mt_cod_corresp,
                              @w_mt_benef_corresp, @w_mt_ofic_corresp       , @w_mt_ttransito  , @s_user,
                              null               , @w_mt_oficina            , @w_mt_cod_banco_ach,
                              @w_mt_tipo_cliente,  @w_tipo_cuenta_ach       , @w_mt_subtipo_ins)                         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM - @w_mt_subtipo_ins
         if @@error <> 0
         begin
            exec cobis..sp_cerror 
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num = 143021
            select @w_return = 143021
            goto borra
         end

         insert into ts_mov_monet (secuencial        , tipo_transaccion, clase       , fecha,
                                   usuario           , terminal        , srv         , lsrv,
                                   operacion         , transaccion     , secuencia   , sub_secuencia,
                                   producto          , cuenta          , valor       , tipo,
                                   beneficiario      , impuesto        , moneda      , valor_ext,
                                   fecha_crea        , fecha_mod       , estado)
                          values  (@s_ssn            , @t_trn          , 'N'         , @s_date,
                                   @s_user           , @s_term         , @s_srv      , @s_lsrv,
                                   @w_p_operacionpf  , @t_trn          , @w_secuencia, @w_mt_sub_secuencia,
                                   @w_mt_producto    , @w_mt_cuenta    , @w_mt_val   , @w_mt_tipo,
                                   @w_mt_beneficiario, @w_mt_impuesto  , @w_mt_moneda, @w_mt_valor_ext, 
                                   @s_date           , @s_date         , null)
         /* Si no se puede insertar error */
         if @@error <> 0
         begin
            exec cobis..sp_cerror
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @i_num         = 143005
            select @w_return = 143005
            goto borra
         end   

         set rowcount 0 
         --------------------------------------------------------------------------------------------------
         -- RET-IMPTO 1% Se debe sumar tambien el impuesto para comparar con el incremento, 
         -- y tambien se debe tomar en cuenta la moneda.
         --------------------------------------------------------------------------------------------------
         select @w_total_monet = @w_total_monet + @w_mt_valor + @w_mt_impuesto
         select @w_total_monet_me = @w_total_monet_me + @w_mt_valor_ext + @w_mt_impuesto_capital_me
         select @w_ct_banco = '',@w_ct_val_tot = 0  
         while 3 = 3
         begin
            set rowcount 1
            select @w_ct_sub_secuencia = ct_secuencial,
                   @w_ct_banco         = ct_banco,
                   @w_ct_cuenta        = ct_cuenta,
                   @w_ct_cheque        = ct_cheque,
                   @w_ct_valor         = ct_valor,
         @w_ct_descripcion   = ct_descripcion,
                   @w_ct_fecha_crea    = ct_fecha_crea,
                   @w_ct_fecha_mod     = ct_fecha_mod
              from pf_det_cheque_tmp
             where ltrim(ct_usuario)   = ltrim(@s_user)
               and ct_sesion  = @s_sesn 
               and ct_operacion = @w_p_operacionpf
               and ct_secuencial = @w_mt_sub_secuencia
             order by ct_secuencial
          
            if @@rowcount = 0
            begin
               break
            end
            set rowcount 0
            select @w_ct_val = round(@w_ct_valor, @w_numdeci)
            insert  pf_emision_cheque (ec_operacion    , ec_secuencia    , ec_sub_secuencia,
                                       ec_secuencial   , ec_moneda       , ec_descripcion,
                                       ec_tipo         , ec_tran         , ec_banco,
                                       ec_cuenta       , ec_numero       , ec_valor,
                                       ec_fecha_crea   , ec_fecha_mod    , ec_fecha_emision,
                                       ec_fecha_mov    , ec_estado       , ec_fpago
                                       )
                               values (@w_p_operacionpf, @w_secuencia    , @w_ct_sub_secuencia,
                                       0               , @w_mt_moneda    , @w_ct_descripcion  ,
                                       'B'             , @t_trn          , @w_ct_banco,
                                       @w_ct_cuenta    , @w_ct_cheque    , @w_ct_val,
                                       @w_ct_fecha_crea, @w_ct_fecha_mod , null,
                                       @s_date         , 'I'             , @w_mt_producto
                                       )
       if @w_return <> 0
            begin
               exec cobis..sp_cerror 
                    @t_debug = @t_debug, 
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143031   
               return 1
            end
            select @w_ct_val_tot = @w_ct_val_tot + @w_ct_valor
            delete  pf_det_cheque_tmp
             where ct_usuario = @s_user
               and ct_sesion = @s_sesn
               and ct_operacion = @w_p_operacionpf
               and ct_secuencial = @w_mt_sub_secuencia
          and ct_banco = @w_ct_banco
               and ct_cuenta = @w_ct_cuenta
               and ct_cheque  = @w_ct_cheque
            end /*  While 3  */
            ----------------------------------------------
            -- Se suma el impuesto capital
            ----------------------------------------------
            if (@w_ct_val_tot <> @w_mt_valor_ext+@w_mt_impuesto_capital_me 
                 and @w_ct_val_tot <> 0 and @w_mt_moneda <> @w_moneda_base) or
               (@w_ct_val_tot <> @w_mt_valor+@w_mt_impuesto and @w_ct_val_tot <> 0 and @w_mt_moneda = @w_moneda_base) 
            begin
               exec cobis..sp_cerror 
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name, 
                    @i_num = 149019
               return 1
            end               
         end /* END WHILE 2 */
         set rowcount 0 



         select @w_sec1 = isnull(max(dp_secuencia),0)+1 from pf_det_pago
         where dp_operacion = @w_p_operacionpf
         select @w_pt_beneficiario = 0
         select @w_string = 'Sec ' + convert(varchar, @w_sec1) 
        
   /*************************************
   CCR inserccion de instruccion especial
   *************************************/
   if @i_instruccion_especial is not null
   begin
      insert into pf_instruccion (in_operacion,    in_instruccion,      in_estadoxren,
                  in_fecha_crea, in_fecha_mod)
         values         (@w_p_operacionpf,   @i_instruccion_especial,'S',
                  @s_date, @s_date)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 143053
         select @w_return = 143053
         goto borra
      end
      insert into ts_instruccion (secuencial,      tipo_transaccion, clase,   fecha,
                  usuario,    terminal,      srv,  lsrv,
                  operacion,     instruccion)
         values         (@s_ssn,    14151,         'N',  @s_date,
                  @s_user,    @s_term,    @s_srv,  @s_lsrv,
                  @w_p_operacionpf, @i_instruccion_especial)
      if @@error <>0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 143005
         select @w_return = 143005
         goto borra
      end
   end
   /*****FIN CCR Instruccion especial***/
   
   /************************************************************
   CCR se inserta registro SIEMPRE con xren = 'S'
   *************************************************************/

   select   @w_estado_ejecuta_xren  = 'S', --CVA Oct-17-05
      @w_estado_ejecuta = 'I'
   
         while 6=6
    begin
       set rowcount 1 
            select @w_pt_beneficiario    = dt_beneficiario,
                   @w_pt_tipo            = dt_tipo,
                   @w_pt_forma_pago      = dt_forma_pago,
                   @w_pt_cuenta          = dt_cuenta,
                   @w_pt_monto           = dt_monto,
                   @w_pt_porcentaje      = dt_porcentaje,
                   @w_pt_fecha_crea      = dt_fecha_crea,
                   @w_pt_fecha_mod       = dt_fecha_mod,
                   @w_pt_moneda_pago     = dt_moneda_pago,
                   @w_pt_descripcion     = dt_descripcion,
         @w_pt_oficina         = dt_oficina,     
              @w_pt_tipo_cliente    = dt_tipo_cliente,
                   @w_pt_tipo_cuenta_ach = dt_tipo_cuenta_ach,
                   @w_pt_banco_ach       = dt_banco_ach,
                   @w_pt_cod_banco_ach   = dt_cod_banco_ach,
                   @w_benef_chq          = dt_benef_chq
   --LIM 19/NOV/2005
         from pf_det_pago_tmp
        where dt_usuario = @s_user
               and dt_sesion = @s_sesn
               and dt_beneficiario >= @w_pt_beneficiario
               and dt_operacion = @w_p_operacionpf
             order by dt_beneficiario  
      
            if @@rowcount = 0
               break
            select @w_pt_mont = round(@w_pt_monto, @w_numdeci)

            insert pf_det_pago (dp_operacion      , dp_ente           , dp_tipo          , dp_secuencia,
                      dp_forma_pago     , dp_cuenta         , dp_monto         , dp_porcentaje,
                                dp_fecha_crea     , dp_fecha_mod      , dp_estado_xren   , dp_estado,
                                dp_moneda_pago    , dp_descripcion    , dp_oficina       , dp_tipo_cliente,
                                --dp_tipo_cuenta_ach, dp_banco_ach)  --LIM 19/NOV/2005 Comentado
            dp_tipo_cuenta_ach, dp_cod_banco_ach  , dp_benef_chq)   --LIM 19/NOV/2005
                        values (@w_p_operacionpf , @w_pt_beneficiario, @w_pt_tipo       , @w_sec1,
                                @w_pt_forma_pago , @w_pt_cuenta      , @w_pt_mont       , @w_pt_porcentaje,
                                @s_date          , @s_date           , @w_estado_ejecuta_xren              , @w_estado_ejecuta,
                                @w_pt_moneda_pago, @w_pt_descripcion , @w_pt_oficina    , @w_pt_tipo_cliente,
                                --@w_pt_tipo_cuenta_ach, @w_pt_banco_ach)  --LIM 19/NOV/2005 Comentado
                        @w_pt_tipo_cuenta_ach, @w_pt_cod_banco_ach,  @w_benef_chq)  --LIM 19/NOV/2005
            if @@error <> 0
            begin
               exec cobis..sp_cerror 
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143038
               select @w_return = 1
               goto borra
            end   
            
            insert into ts_det_pago (secuencial      , tipo_transaccion  , clase           , fecha,
                                     usuario         , terminal          , srv             , lsrv,
                                     operacion       , ente              , tipo            , forma_pago,
                                     cuenta          , monto             , porcentaje      , fecha_crea,
                                     fecha_mod       , moneda_pago)
                            values  (@s_ssn          , @t_trn            , 'N'             , @s_date, 
                                     @s_user         , @s_term           , @s_srv          , @s_lsrv,  
                                     @w_p_operacionpf, @w_pt_beneficiario, @w_pt_tipo      , @w_pt_forma_pago,
                                     @w_pt_cuenta    , @w_pt_mont        , @w_pt_porcentaje, @s_date,
                                     @s_date         , @w_pt_moneda_pago)
            /* Si no se puede insertar error */
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = 143005
               select @w_return = 1
               goto borra
            end     
            delete pf_det_pago_tmp
        where dt_usuario = @s_user
               and dt_sesion = @s_sesn
               and dt_beneficiario = @w_pt_beneficiario
               and dt_operacion = @w_p_operacionpf
               and dt_tipo = @w_pt_tipo
               and dt_forma_pago = @w_pt_forma_pago
               and dt_cuenta = @w_pt_cuenta
               and dt_monto = @w_pt_monto
               and dt_porcentaje = @w_pt_porcentaje
            select @w_sec1 = @w_sec1 + 1 
         end /*  While 6  */      
         set rowcount 0


         -------------------------------------
         -- Contabilizacion de la operacion
         -- Aplicacion en firme de Renovacion
         -------------------------------------
         if @w_p_estado = 'VEN' or  @w_p_estado = 'ACT' and datediff(dd,@w_p_fecha_ven,@s_date) >= 0
         begin
            if @w_p_fecha_valor < '03/15/1999' and @i_ley IS  NOT NULL
               select @i_fecha_cal_tasa = dateadd(dd,90,@s_date)    
            select @w_fpago_ticket = count(*) 
            from pf_secuen_ticket 
            where st_num_banco = @i_cuenta_ant
            and st_estado = 'I'  
            and st_fpago in ('EFEC')          
            and st_moneda = @w_p_moneda   
            if @w_fpago_ticket = 0
            begin 
  
                exec @w_return = sp_renova_op
                     @s_ssn            = @s_ssn, 
                     @s_ssn_branch     = @s_ssn_branch,
                     @s_user           = @s_user,
                     @s_sesn           = @s_sesn,
                     @s_ofi            = @s_ofi,
                     @s_date           = @s_date,
                     @t_trn            = 14918,
                     @s_srv            = @s_srv, 
                     @s_term           = @s_term,
                     @t_file           = @t_file,
                     @t_from           = @w_sp_name,
                     @t_debug          = @t_debug,
                     @i_cuenta         = @i_cuenta_ant,
                     @i_cuenta_banco   = @w_pt_cuenta,
                     @i_cuenta_ant     = @i_cuenta_ant,
                     @i_descripcion    = @i_descripcion,
                     @i_fecha_proceso  = @s_date,
                     @i_ley            = @i_ley,
                     @i_fecha_cal_tasa = @i_fecha_cal_tasa,
                     @i_tasa_efectiva  = @i_tasa_efectiva , -- 04-May-2000 Tasa Efec/Nom
                     @i_flag_tasaefec  = @i_flag_tasaefec,  -- 04-May-2000 Tasa Efec/No
                     @i_tasa_variable  = @i_tasa_variable,  -- 12-Abr-2000 TASA VARIABLE
                     @i_mnemonico_tasa = @i_mnemonico_tasa, -- 12-Abr-2000 TASA VARIABLE
                     @i_modalidad_tasa = @i_modalidad_tasa, -- 12-Abr-2000 TASA VARIABLE
                     @i_periodo_tasa   = @i_periodo_tasa,   -- 12-Abr-2000 TASA VARIABLE
                     @i_descr_tasa     = @i_descr_tasa,     -- 12-Abr-2000 TASA VARIABLE
                     @i_operador       = @i_operador,       -- 12-Abr-2000 TASA VARIABLE
                     @i_spread         = @i_spread,         -- 12-Abr-2000 TASA VARIABLE 
                     @i_puntos         = @i_puntos,         -- 12-Abr-2000 TASA VARIABLE 
                     @i_aut_spread     = @i_aut_spread,     -- 12-Abr-2000 TASA VARIABLE
                     @i_tipcuenta      = @w_pt_forma_pago,
                     @i_inicio         = @w_p_operacionpf,
                     @i_fin            = @w_p_operacionpf,
                     @i_operacion      = @w_p_operacionpf,
                     @i_diahabil       = @i_diahabil,
                     @i_fecha_valor    = @i_fecha_valor,
                     @i_plazo_orig     = @i_plazo_orig,
                     @i_cotizacion     = @i_cotizacion,
                     @i_calldate       = @i_calldate,
                     @i_modifica       = @i_modifica,
                     @i_desmaterializado = @i_desmaterializa,           
                     @o_operacion_new  = @o_operacion_new out
                if @w_return <> 0
                begin
                   select @w_return = @w_return
                   rollback tran
                   goto borra
                end
                set rowcount 0
            end            
         end                      -- if estado = 'VEN'

         select @w_return = 0

         select  '15637'= @o_operacion_new,
                 '15638'= @w_sec_ticket     

     commit tran
     
     
--rollback tran

      goto borra
----------------------------
-- Borrar tablas temporales
----------------------------
borra:
  set rowcount 0
  delete pf_mov_monet_tmp 
   where mt_usuario = @s_user 
     and mt_sesion = @s_sesn
     and mt_operacion = @w_p_operacionpf

  delete pf_beneficiario_tmp 
   where bt_usuario = @s_user 
     and bt_sesion = @s_sesn
     and bt_operacion = @w_p_operacionpf

  delete pf_det_pago_tmp 
   where dt_usuario = @s_user 
     and dt_sesion = @s_sesn
     and dt_operacion = @w_p_operacionpf
  delete pf_det_cheque_tmp 
   where ct_usuario = @s_user 
     and ct_sesion = @s_sesn
     and ct_operacion = @w_p_operacionpf
  delete pf_operacion_tmp
   where ot_usuario  = @s_user
     and ot_sesion   = @s_sesn
     and ot_operacion   = @w_p_operacionpf 

  if @w_return = 0
     delete from pf_rubro_op_tmp where rot_operacion = @w_p_operacionpf

return @w_return
go
