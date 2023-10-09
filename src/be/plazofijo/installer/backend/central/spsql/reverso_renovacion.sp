/************************************************************************/
/*      Archivo:                revrenov.sp                             */
/*      Stored procedure:       sp_reverso_renovacion                   */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 29/Ago/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      necesarias para reversar una cancelacion                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA              AUTOR            RAZON                       */
/*                                                                      */
/*      25-Oct-2001        N. Silva         Correcciones Bench M.       */
/*      02-Dic-2002        N. Silva         Renovaciones conservando op.*/
/*      05-Dic-2016        A. Zuluaga       Desacople                   */
/************************************************************************/
use cob_pfijo
go
if exists (select * from sysobjects where name = 'sp_reverso_renovacion')
   drop proc sp_reverso_renovacion
go
create proc sp_reverso_renovacion (
      @s_ssn                  int         = NULL,
      @s_user                 login       = NULL,
      @s_sesn                 int         = NULL,
      @s_term                 varchar(30) = NULL,
      @s_date                 datetime    = NULL,
      @s_srv                  varchar(30) = NULL,
      @s_lsrv                 varchar(30) = NULL,
      @s_ofi                  smallint    = NULL,
      @s_rol                  smallint    = NULL,
      @t_debug                char(1)     = 'N',
      @t_file                 varchar(10) = NULL,
      @t_from                 varchar(32) = NULL,
      @t_trn                  smallint,
      @i_num_banco            cuenta,
      @i_num_lote             cuenta      = NULL,   
      @i_autorizado           login       = NULL,
      @i_reversobanco         char(1)     = 'N'
)
as
/*  Variables para pf_operacion  */
declare         
      @w_sp_name              varchar(32),
      @w_string               varchar(30),
      @w_descripcion          descripcion,
      @w_codigo               int,
      @w_operacionpf          int,
      @w_operacion_new        int,
      @w_producto             tinyint,
      @w_tran_pin             int,
      @w_tran_ren             int,
      @w_return               int,
      @w_incremento           money, 
      @v_estado               catalogo,
      @w_estado_op            catalogo,
      @w_fecha_crea           datetime,
      @w_fecha_mod            datetime,
      @w_monto_pg_int         money,
      @w_int_ganado           money,
      @w_int_no_ganados       money,
      @w_num_banco            cuenta, --xca         
      @w_estado_new           catalogo,
      @w_int_pagados          money,
      @w_total_int_pagados    money,
      @w_total_int_ganado     money,
      @w_total_int_estimado   money,
      @w_msg                  varchar(10),    
      @w_fecha_ven            datetime,
      @w_fecha_hoy            datetime,
      @w_fpago                catalogo,
      @w_tplazo               catalogo,
      @w_toperacion           catalogo,
      @w_fecha_pg_int         datetime,   
      @w_fecha_ult_pg_int     datetime,   
      @v_fecha_ult_pg_int     datetime,   
      @v_fecha_mod            datetime,
      @v_fpago                catalogo,
      @v_fecha_pg_int         datetime,   
      @v_monto_pg_int         money,
      @v_int_ganado           money,
      @v_int_pagados          money,
      @v_total_int_pagados    money,
      @v_historia             int,
      @w_moneda               tinyint,
      @w_oficina              smallint,          -- GAL 31/AGO/2009 - RVVUNICA
      @w_oficina_re           smallint,          -- GAL 31/AGO/2009 - RVVUNICA
      @v_fecha_ven            datetime,
      @w_normal               char(1),
      @w_tipo                 char(1),
      @w_ttipo                char(1),
      @w_afec                 char(1),
      @w_tafec                char(1),
      @w_afectacion           char(1),
      @w_pen_monto            money,
      @w_pen_porce            float,
      @w_penal                money,
      @w_mantiene_stock       char(1),
      @w_stock                int,         
      @w_numero               int,            
      @w_fecha_valor_new      datetime,  
      @w_retiene_capital      char(1),
      @w_max_fecha_crea       datetime,
      @w_op_mon_sgte          int,
      @w_op_fpago             catalogo,
/*  Variables para mov_monet */
      @w_mm_tipo              catalogo,
      @w_mm_estado            char(4),
      @w_mm_beneficiario      int,
      @w_secuencial           int,
      @w_mm_impuesto          money,
      @w_mm_producto          catalogo,
      @w_mm_cuenta            cuenta,         
      @w_mm_valor             money,
      @w_mm_moneda            smallint,
      @w_mm_valor_ext         money, 
      @w_mm_fecha_crea        datetime,
      @w_mm_fecha_mod         datetime, 
      @w_mm_sub_secuencia     int,
      @w_mm_secuencia         smallint,
      @w_total_cancel         money, 
      @w_int_vencido          money, 
      @w_valor                money, 
      @w_secuencia            int,
      @w_secpin               smallint,
      @w_total_pin            money, 
      @w_oficina_ing          smallint,        
      @w_op_tasa              float,
      @w_op_tasa_ant          float,
/* Variables para det_pago */
      @w_pt_beneficiario      int,
      @w_pt_secuencia         int,
      @w_pt_tipo              catalogo,
      @w_pt_forma_pago        catalogo,
      @w_pt_cuenta            cuenta,   
      @w_pt_monto             money,
      @w_pt_porcentaje        float,
      @w_pt_fecha_crea        datetime, 
      @w_pt_fecha_mod         datetime,
      @w_pt_moneda_pago       smallint,
      @w_ssn_spread           int,

/* Variables definidas para nuevo requerimiento del Banco ASB */
      @w_imp                  char(1),
      @w_mc_valor             money,
      @w_mc_producto          catalogo,
      @w_mc_cuenta            cuenta,
      @w_mc_impuesto          money,
      @w_mc_moneda            tinyint,
      @w_mc_secuencial        int,
      @w_alt                  int,
      @w_re_fecha_crea        datetime,
      @w_mc_secuencia         int,
      @w_mc_sub_secuencia     int,
      @w_desc_rev             varchar(64),
      @w_rc_comp              int,
      @w_op_sec_incre         int,
      @w_or_fpago             catalogo,
      @w_mm_secuencia_aux     smallint,
      @w_fecha_beneficiario   datetime,
      @w_dia_pago             smallint,
      @w_or_operacion         int,
      @w_op_accion_sgte       catalogo,   --ccr accion siguiente del DPF
      @w_fecha_inst_esp       datetime,
      @w_ec_sub_secuencia     int,
      @w_codigo_alterno       int,
      @w_operacionec          int,
      @w_ec_numero            int,
      @w_ec_secuencia         int,
      @w_ec_secuencial_lote   int,
      @w_error                int,
      @w_ec_moneda            smallint,
      @w_ec_fpago             catalogo,
      @w_pignorado            char(1),
      @w_ec_subtipo_ins       int,           -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
      @w_instr_chqcom         tinyint,       -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
      @w_grupo1               varchar(30),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
      @w_valor_exec           varchar(255)

/*Creacion Tablas Temporales*/

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
op_saldo             money,     -- LuisG 04.06.2001
op_fecha_fin         datetime,   -- LuisG 04.06.2001
op_base_calculo      char(1) , --lre version estandar 05/06/2001
op_periodo_int       smallint, --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)


create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)


   CREATE TABLE #det_cus_garantias (
            garantia                varchar(64)     NOT NULL,
            tipo                    varchar(64)     NOT NULL,
            tasa                    float           NULL,
            cuenta                  varchar(24)          NULL)

   CREATE TABLE #det_oper_relacion (
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

select @w_sp_name = 'sp_reverso_renovacion'

/*---------------------------------*/
/* Verificar Codigo de transaccion */
/*---------------------------------*/
if @t_trn != 14929
begin
   /*  'Error en codigo de transaccion' */
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = 141018
   return 1
end

-------------------------------
-- Inicializacion de variables
--------------------------- 
----
select @w_mm_sub_secuencia = 0,
       @w_fecha_hoy = convert(datetime, convert (varchar,@s_date,101)),
       @w_tran_pin = 14905,
       @w_tran_ren = 14904,
       @w_oficina_ing = @s_ofi, @w_ttipo = 'T'

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CHEQUES COMERCIALES - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'       
       
------------------------------------- 
-- Obtener variables de pf_operacion
-------------------------------------
select   @w_num_banco          = op_num_banco,            -- Nuevo cambio bajo concepto de Prorroga
        @w_operacionpf        = op_operacion,
        @w_estado_new         = op_estado,
   @v_estado             = op_estado,
   @v_fecha_ven          = op_fecha_ven,
   @v_historia           = op_historia,
   @v_fecha_mod          = op_fecha_mod ,
   @v_fpago              = op_fpago,
   @w_moneda             = op_moneda,
   @w_toperacion         = op_toperacion,
   @w_tplazo             = op_tipo_plazo,
   @w_oficina            = op_oficina,
        @w_producto           = op_producto,
   @w_total_int_estimado = op_total_int_estimado,
   @w_total_int_ganado   = op_total_int_ganados,   
        @w_fecha_valor_new    = op_fecha_valor,
        @w_op_mon_sgte        = op_mon_sgte,
   @v_monto_pg_int         = op_monto_pg_int,
   @v_int_ganado         = op_int_ganado,
   @v_int_pagados        = op_int_pagados,
   @v_total_int_pagados  = op_total_int_pagados,
   @v_fecha_ult_pg_int   = op_fecha_ult_pg_int,
      @v_fecha_pg_int         = op_fecha_pg_int,
        @w_op_fpago           = op_fpago,
        @w_op_sec_incre       = op_sec_incre,
   @w_op_accion_sgte     = op_accion_sgte,
   @w_valor       = op_monto,
        @w_op_tasa            = op_tasa
   from pf_operacion
  where op_num_banco = @i_num_banco
    and op_estado in ('ING', 'ACT')

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from    = @w_sp_name,
        @i_num  = 141051
   return 1
end

/**********************************************************
CCR Validar que el tipo de deposito se encuentre habilitado
**********************************************************/
if not exists  (select 1 from pf_tipo_deposito
      where td_mnemonico   = @w_toperacion
      and   td_estado   = 'A')
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 141212
   return 141212
end
/*****CCR validar tipo de deposito habilitado*************/

/****************************************************************
CCR Validar que no se pueda reversar una renovacion en linea
si ya existe ingresada una instruccion de cancelacion/renovacion
****************************************************************/
if isnull(@w_op_accion_sgte, 'NULL') != 'NULL'
begin
   exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141191
   return 141191
end
/*****Fin CCR validarla existencia de instruc renov/cancel******/

-------------------------------------------------------
-- Verificar para reverso si la operacion fue renovada
-------------------------------------------------------
select @w_or_operacion = or_operacion,
       @w_op_tasa_ant  = or_tasa,
       @w_pignorado    = or_pignorado
  from cob_pfijo..pf_operacion_renov
 where or_operacion = @w_operacionpf
   and or_estado    = 'REN'
if @@rowcount = 0
begin 
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from    = @w_sp_name,
        @i_num  = 141051
   return 1
end

-------------------------------------------------------
-- Borrar registros ingresados de pf_secuen_ticket (I)
-------------------------------------------------------
delete pf_secuen_ticket
 where st_estado = 'I'
   and st_operacion = @w_operacionpf

-------------------------------------------
-- Obtener datos de la tabla pf_renovacion
-------------------------------------------
select  @w_fecha_pg_int      = re_fecha_pg_int,
   @w_incremento       = re_incremento,
   @w_estado_op        = re_estado_ant,
   @w_operacion_new     = re_operacion_new,
   @w_int_pagados      = isnull(re_int_pagados,0), 
        @w_oficina_re        = re_oficina,
   @w_total_int_pagados = re_total_int_pagados,
   @w_fecha_ult_pg_int  = re_fecha_ult_pg_int,
   @w_secuencia         = re_renovacion,
        @w_re_fecha_crea     = re_fecha_crea
  from  pf_renovacion
  where re_operacion = @w_operacionpf 
    and re_estado    in ('A') 
    and datediff(dd,re_fecha_crea,@s_date) = 0 --CVA Oct-20-05 Solo se permite reversos en la misma fecha de transaccion      
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141204 --CVA Oct-20-05 se cambio codigo de error
   return 141204
end


if @w_incremento < 0
begin

	--print 'w_operacionpf ' + cast(@w_operacionpf as varchar)

	if exists (select 1
		from   pf_emision_cheque x
		where  ec_operacion         = @w_operacionpf
		and    ec_tran              = 14904
		and    ec_estado            = 'A'
		and    ec_fecha_emision is not null
		and    ec_caja 		  = 'S'
		and	   ec_fecha_caja is not null	
		and    exists( 
		   select 1
		   from   pf_emision_cheque y
		   where  y.ec_operacion      = @w_operacionpf
		   and    y.ec_tran           = 14943
		   and    y.ec_estado         = 'A'
		   and    y.ec_fecha_emision is not null
		   and    y.ec_fpago          = 'EFEC'
		   and    y.ec_numero         = x.ec_secuencial
		   and    y.ec_fecha_mov      = @s_date)) 
	begin	
		print 'revordpago PAGOS EN EFECTIVO SIN REVERSAR EN BRANCH'
		exec cobis..sp_cerror
			@t_debug       = @t_debug,
			@t_file        = @t_file,
			@t_from        = @w_sp_name,
			@i_num         = 141254
		return 1
	end
end


/**************************************
CCR Obtener datos de pf_operacion_renov
**************************************/
select   @w_or_fpago = or_fpago
from  pf_operacion_renov
where or_operacion   = @w_operacionpf          
and   or_estado   = 'REN'

if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 141138
   return 141138
end
/***FIN CCR datos de pf_operacion_renov****/

if @w_oficina_re <> @s_ofi
begin
   exec cobis..sp_cerror        
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'Oficina de renovacion es diferente a la oficina actual de proceso',
        @i_num   = 141151
   return 1
end                               

----------------------------------------
-- REVERSO EMISION CHEQUE EMITIDO
----------------------------------------
if exists (select ec_operacion 
           from   pf_emision_cheque, 
                  pf_fpago
           where  ec_operacion      = @w_operacionpf
             and  ec_fecha_emision  = @s_date
             and  ec_tran           = 14904 
             and  ec_caja           = 'S'      
             and  ec_fpago          = fp_mnemonico
             and  fp_producto       = 42) 
begin
   select @w_ec_sub_secuencia = 0,
          @w_codigo_alterno = 0

   while 1 = 1
   begin
      set rowcount 1 
      select @w_ec_numero           = ec_numero,
             @w_ec_secuencia        = ec_secuencia,
             @w_ec_sub_secuencia    = ec_sub_secuencia,
             @w_ec_moneda           = ec_moneda,
             @w_ec_fpago            = ec_fpago,
             @w_ec_secuencial_lote  = ec_secuencial_lote,
             @w_ec_subtipo_ins      = ec_subtipo_ins         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
      from   pf_emision_cheque, 
             pf_fpago
      where  ec_operacion      = @w_operacionpf
        and  ec_fecha_emision  = @s_date
        and  ec_tran           = 14904
        and  ec_caja           = 'S'   
        and  ec_sub_secuencia  > @w_ec_sub_secuencia
        and  ec_fpago          = fp_mnemonico
        and  fp_producto       = 42
              
      if @@rowcount = 0
         break
         
      -------------------------------------------
      -- Reversar cheque si no fue emitido en SB
      -------------------------------------------
                 
      select @w_codigo_alterno = @w_codigo_alterno + 1
      
      -- secuencial@estado@serielit@serienum@fautoriza@moneda@ TRAMA REQUERIDA
      select @w_grupo1 = cast(@w_ec_secuencial_lote as varchar) + '@' + 
                         'T'                                    + '@' + 
                         ''                                     + '@' + 
                         ''                                     + '@' + 
                         ''                                     + '@' + 
                         cast(@w_ec_moneda as varchar)          + '@'  
             
      /*
	  exec  @w_return = cob_sbancarios..sp_reversar_lotes
            @s_ssn              = @s_ssn,
            @s_date             = @s_date,
            @s_term             = @s_term,
            @s_sesn             = @s_sesn,
            @s_srv              = @s_srv,
            @s_lsrv             = @s_lsrv,
            @s_user             = @s_user,
            @s_ofi              = @s_ofi,
            @s_rol              = @s_rol,
            @t_debug            = 'N',
            @t_file             = @t_file,
            @t_trn              = 29301,
            @i_codigo_alterno   = @w_codigo_alterno,       -- SI SE LLAMA MAS DE UNA VEZ DESDE UN SP DEBE SUMARSE UNO A ESTE CAMPO PARA LA TRANSACCION DE SERVICIO
            @i_origen_ing       = '1',                     -- 1 INTERFASE 2 CARGA  3 MANUAL
            @i_secuencial       = @w_ec_secuencial_lote,   -- CODIGO GENERADO POR SBA DEL CHEQUE A REVERSAR
            @i_modulo           = 'PFI',                   -- MODULO QUE GENERO LA SOLICITUD DEL CHEQUE
            @i_moneda           = @w_ec_moneda,            -- MONEDA DEL INSTRUMENTO
            @i_func_aut         = @s_user,                 -- LOGIN DEL FUNCIONARIO QUE AUTORIZA EL REVERSO EN EL MODULO ORIGINAL
            @i_producto         = 4,                       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
            @i_instrumento      = @w_instr_chqcom,         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
            @i_subtipo_ins      = @w_ec_subtipo_ins,       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
            @i_causal_anul      = '99',                    -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM                                                                       
            @i_llamada_ext      = 'S',                     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
            @i_grupo1           = @w_grupo1                -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
            
      if @w_return != 0
      begin         
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = @w_return
         return @w_return     
      end
      */  
      --------------------------------
      -- Actualizar registro reversado 
      --------------------------------           
      update pf_emision_cheque
      set    ec_caja = NULL
      where  ec_operacion      = @w_operacionpf
        and  ec_fecha_emision  = @s_date
        and  ec_tran          = 14904 
        and  ec_caja          = 'S'   
        and  ec_secuencia     = @w_ec_secuencia
        and  ec_sub_secuencia = @w_ec_sub_secuencia                
      if @@error != 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141166
         return 1     
      end
   end --while 1 = 1
end
-----------------------------------
-- FIN REVERSO DE CHEQUES  
-----------------------------------

---------------------------------------------------------------
-- Verifica si la orden de pago o el cheque ya ha sido emitido
---------------------------------------------------------------
select @w_operacionec    = ec_operacion  
from   pf_emision_cheque
where  ec_operacion      = @w_operacionpf
  and  ec_fecha_emision  = @s_date
  and  ec_tran           = 14904
  and  ec_caja           = 'S'      -- Verifica si ya fue pagado
if @@rowcount > 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from = @w_sp_name,
      @i_num = 141162
   return 141162
end

begin tran

   --CVA Dic-09-05 Aplicar nuevamente la tasa anterior a las garantias
   if @w_op_tasa_ant <> @w_op_tasa and @w_pignorado = 'S'
   begin
   if exists(select pi_cuenta
            from   pf_pignoracion
         where  pi_operacion    = @w_operacionpf
                    and  pi_producto     = 'GAR')
        begin

        exec @w_return = cob_interfase..sp_icredito -- BRON: 15/07/09  cob_credito..sp_pignoracion_dpf  
             @i_operacion       = 'A',
             @s_date            = @s_date,      -- BRON: 15/07/09   @s_fecha  = @s_date,
             @i_modo            = 1,
             @i_tasa_actual     = @w_op_tasa_ant,
             @i_num_operacion   = @w_num_banco,
             @i_producto        = 14           
       
        if @w_return <> 0
           return @w_return
        end
   end

   update pf_renovacion 
      set re_estado = 'R'
    where re_operacion = @w_operacionpf
      and re_renovacion = @w_secuencia
   if @@rowcount != 1
   begin
      exec cobis..sp_cerror
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_num          = 145001
      return 145001
   end  

   --------------------------------------------------------------------
   -- Buscar Forma de pago sobre pf_mov_monet para afectacion a cuenta de intereses
   --------------------------------------------------------------------
   begin
      select @w_mc_valor                   = re_monto,
             @w_mc_producto                = mm_producto,
             @w_mc_cuenta                  = mm_cuenta,
             @w_mc_impuesto                = mm_impuesto,
             @w_mc_moneda                  = mm_moneda,
             @w_mc_secuencia               = mm_secuencia,
             @w_mc_sub_secuencia           = mm_sub_secuencia,
             @w_mc_secuencial              = mm_secuencial
        from pf_mov_monet,
             pf_renovacion
       where mm_operacion = @w_operacionpf
         and mm_operacion = re_operacion
         and mm_tran      = 14919
         and mm_secuencia = (select max(mm_secuencia) 
                               from pf_mov_monet
                              where mm_operacion   = @w_operacionpf
                                and mm_tran        = 14919)
         and re_renovacion = (select max(re_renovacion)
                                from pf_renovacion
                               where re_operacion   = @w_operacionpf)
         and mm_producto   = 'CTE'
   end

   ------------------------------------------------
   -- Evaluar si el producto retiene impuesto o no
   ------------------------------------------------
/*CVA Oct-20-05 Global no impuestos
   if @w_mm_impuesto > 0
      select @w_imp = 'S''
   else
*/
      select @w_imp = 'N'
  
   ---------------------------------------------------------------
   -- Evaluar si el producto es con afectacion a cuenta corriente
   ---------------------------------------------------------------
   select @w_alt = @w_alt + 1
   if @w_mc_producto = 'CTE' or @w_mc_producto = 'AHO'
   begin
        exec @w_return=sp_aplica_mov
              @s_ssn             = @s_ssn,
              @s_user            = @s_user,
              @s_ofi             = @s_ofi, 
              @s_date            = @s_date,
              @s_srv             = @s_srv,
              @s_term            = @s_term,
              @t_file            = @t_file,
              @t_from            = @w_sp_name,
              @t_debug           = @t_debug,
              @t_trn             = 14919, 
              @i_operacionpf     = @w_operacion_new,
              @i_fecha_proceso   = @w_fecha_hoy,
              @i_secuencia       = @w_mc_secuencia, 
              @i_impuesto        = 0,
              @i_sub_secuencia   = @w_mc_sub_secuencia,
         @i_en_linea        = 'S',
              @i_tipo            = 'R',
         @i_retiene_capital = 'N',  /* mig oracle ral 01/04/2001 */
              @i_mm_secuencial   = @w_mc_secuencial,
              @i_op_num_banco    = @i_num_banco,
              @i_reversobanco    = @i_reversobanco
         if @w_return != 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = @w_return
            return 1
         end 
   end

   ----------------------------------------
   -- Recuperacion de la antigua operacion
   ----------------------------------------
   Delete pf_operacion where op_operacion = @w_operacionpf

   Insert into pf_operacion 
               (op_num_banco          , op_operacion         , op_ente             , op_toperacion,
                op_categoria          , op_producto          , op_oficina          , op_moneda,
                op_num_dias           , op_monto             , op_monto_pg_int     , op_monto_pgdo,      
                op_monto_blq          , op_tasa              , op_int_ganado       , op_int_estimado,
                op_int_pagados        , op_int_provision     , op_total_int_ganados, op_total_int_pagados,
                op_incremento         , op_total_int_estimado, op_ppago            , op_dia_pago,
                op_historia           , op_duplicados        , op_renovaciones     , op_estado,
                op_pignorado          , op_oficial           , op_descripcion      , op_fecha_valor,
                op_fecha_ven          , op_fecha_pg_int      , op_fecha_ult_pg_int , op_fecha_crea,
                op_fecha_mod          , op_fecha_ingreso     , op_totalizado       , op_fecha_total,
                op_tipo_plazo         , op_tipo_monto        , op_causa_mod        , op_retenido,
                op_total_retencion    , op_retienimp         , op_tasa_efectiva    , op_accion_sgte,
                op_mon_sgte           , op_tcapitalizacion   , op_fpago            , op_base_calculo,
                op_casilla            , op_direccion         , op_residuo          , op_total_int_retenido,
                op_renova_todo        , op_imprime           , op_puntos           , op_total_int_acumulado,
                op_tasa_mer           , op_moneda_pg         , op_telefono         , op_impuesto,
                op_retiene_imp_capital, op_impuesto_capital  , op_ley              , op_fecha_real,
                op_ult_fecha_cal_tasa , op_prorroga_aut      , op_num_dias_gracia  , op_estatus_prorroga,
                op_num_prorroga       , op_tasa_variable     , op_mnemonico_tasa   , op_modalidad_tasa, 
                op_periodo_tasa       , op_descr_tasa        , op_operador         , op_spread,
                op_anio_comercial     , op_flag_tasaefec     , op_renovada         , 
                op_ult_fecha_calculo  , op_fecha_cancela     , op_plazo_ant        , op_fecven_ant,
                op_tot_int_est_ant    , op_fecha_ord_act     , op_int_prov_vencida , op_int_total_prov_vencida,
                op_plazo_cont         , op_plazo_orig        , op_tipo_tasa_var    , op_ult_fecha_calven,
                op_sec_incre          , op_sucursal          , op_incremento_suspenso, op_oficial_secundario,
           op_captador           , op_oficial_principal , op_bloqueo_legal    , op_monto_blqlegal,
                op_dias_reales        , op_inactivo          , op_localizado       , op_fecha_localizacion,
                op_fecha_no_localiza  , op_origen_fondos     , op_proposito_cuenta , op_aprobado,
                --op_producto_bancario1 , op_producto_bancario2
      op_producto_bancario1 , op_producto_bancario2, op_oficina_apertura , op_oficial_apertura, --LIM 15/NOV/2005
                op_toperacion_apertura, op_tipo_plazo_apertura,op_tipo_monto_apertura           --LIM 15/NOV/2005 
                )
        select  or_num_banco          , or_operacion         , or_ente             , or_toperacion,
                or_categoria          , or_producto          , or_oficina          , or_moneda, 
                or_num_dias           , or_monto             , or_monto_pg_int     , or_monto_pgdo,
                or_monto_blq          , or_tasa              , or_int_ganado       , or_int_estimado,
                or_int_pagados        , or_int_provision     , or_total_int_ganados, or_total_int_pagados, 
                or_incremento         , or_total_int_estimado, or_ppago            , or_dia_pago,
                (@v_historia + 1)     , or_duplicados        , or_renovaciones     , or_estado_renov,
                or_pignorado          , or_oficial           , or_descripcion      , or_fecha_valor, 
                or_fecha_ven          , or_fecha_pg_int      , or_fecha_ult_pg_int , or_fecha_crea,
                or_fecha_mod          , or_fecha_ingreso     , or_totalizado       , or_fecha_total,
                or_tipo_plazo         , or_tipo_monto        , or_causa_mod        , or_retenido,
                or_total_retencion    , or_retienimp         , or_tasa_efectiva    , NULL,
                @w_op_mon_sgte        , or_tcapitalizacion   , or_fpago            , or_base_calculo,
                or_casilla            , or_direccion         , or_residuo          , or_total_int_retenido,
                or_renova_todo        , or_imprime           , or_puntos           , or_total_int_acumulado,
                or_tasa_mer           , or_moneda_pg         , or_telefono         , or_impuesto,
                or_retiene_imp_capital, or_impuesto_capital  , or_ley              , or_fecha_real,
                or_ult_fecha_cal_tasa , or_prorroga_aut      , or_num_dias_gracia  , or_estatus_prorroga, 
                or_num_prorroga       , or_tasa_variable     , or_mnemonico_tasa   , or_modalidad_tasa, 
                or_periodo_tasa       , or_descr_tasa        , or_operador         , or_spread,
                or_anio_comercial     , or_flag_tasaefec     , or_renovada         , 
                or_ult_fecha_calculo  , or_fecha_cancela     , or_plazo_ant        , or_fecven_ant,
                or_tot_int_est_ant    , or_fecha_ord_act     , or_int_prov_vencida , or_int_total_prov_vencida,
                or_plazo_cont         , or_plazo_orig        , or_tipo_tasa_var    , or_ult_fecha_calven,
                @w_op_sec_incre       , or_sucursal          , or_incremento_suspenso, or_oficial_secundario,
           or_captador           , or_oficial_principal , or_bloqueo_legal    , or_monto_blqlegal,
                or_dias_reales        , or_inactivo          , or_localizado       , or_fecha_localizacion,
                or_fecha_no_localiza  , or_origen_fondos     , or_proposito_cuenta , or_aprobado,
                or_producto_bancario1 , or_producto_bancario2, or_oficina_apertura , or_oficial_apertura,
      or_toperacion_apertura, or_tipo_plazo_apertura,or_tipo_monto_apertura      --LIM 15/NOV/2005
          from pf_operacion_renov
         where or_operacion = @w_operacionpf          
           and or_estado    = 'REN'          -- Renovacion Aplicada


   delete from pf_rubro_op where ro_operacion = @w_operacionpf          
   
   insert into pf_rubro_op(ro_num_banco,ro_operacion,ro_toperacion,ro_moneda,
            ro_tipo_monto,ro_tipo_plazo,ro_concepto,ro_mnemonico_tasa,
            ro_operador,ro_modalidad_tasa,ro_periodo_tasa,ro_descr_tasa,
            ro_spread,ro_valor)
   select      ror_num_banco,ror_operacion,ror_toperacion,ror_moneda,
         ror_tipo_monto,ror_tipo_plazo,ror_concepto,ror_mnemonico_tasa,
         ror_operador,ror_modalidad_tasa,ror_periodo_tasa,ror_descr_tasa,
         ror_spread,ror_valor
   from pf_rubro_op_renov
   where ror_operacion  = @w_operacionpf
     and ror_estado     = 'REN'

   ----------------------------------------------
   -- Actualiza estado de operaciones a Reverso
   ----------------------------------------------
   Update pf_operacion_renov 
      set or_estado    = 'REV'
    where or_operacion = @w_operacionpf 
      and or_estado    = 'REN'

   Update pf_rubro_op_renov 
      set ror_estado    = 'REV'
    where ror_operacion = @w_operacionpf 
      and ror_estado    = 'REN'

   ------------------------------------------------------------
   -- Borrar las cuotas y actualizar con las cuotas originales
   ------------------------------------------------------------
   if @w_or_fpago = 'PER'
   begin

      delete cob_pfijo..pf_cuotas where cu_operacion = @w_operacionpf

      -------------------------------------------------------------
      -- Grabar las cuotas en un archivo historico para el reverso
      -------------------------------------------------------------
      insert into cob_pfijo..pf_cuotas(
             cu_ente          , cu_operacion, cu_cuota   , cu_fecha_pago,
             cu_valor_cuota   , cu_retencion, cu_capital , cu_fecha_crea,
             cu_moneda        , cu_oficina  , cu_num_dias, cu_estado,
             cu_fecha_ult_pago, cu_tasa     , cu_ppago   , cu_base_calculo,
             cu_retenido      , cu_valor_neto)
      select ch_ente          , ch_operacion, ch_cuota   , ch_fecha_pago,
             ch_valor_cuota   , ch_retencion, ch_capital , ch_fecha_crea,
             ch_moneda        , ch_oficina  , ch_num_dias, ch_estado,
             ch_fecha_ult_pago, ch_tasa     , ch_ppago   , ch_base_calculo,
             ch_retenido      , ch_valor_neto
        from cob_pfijo..pf_cuotas_his
       where ch_operacion  = @w_operacionpf 
         and ch_fecha_grab = @s_date

      ---------------------------------
      -- Borrado de cuotas historicas
      ---------------------------------
      delete pf_cuotas_his 
       where ch_operacion =  @w_operacionpf 
         and ch_fecha_grab = @s_date
   end

   -------------------------------------------------------------------- 
   -- Transaccion de Servicio - pf_operacion  con los datos anteriores 
   --------------------------------------------------------------------
   insert into ts_operacion (secuencial         , tipo_transaccion, clase    , fecha         , usuario,
                             terminal           , srv             , lsrv     , fpago         , fecha_ven,
                             fecha_pg_int       , fecha_mod       , estado   , int_pagados   , total_int_pagados,
                             fecha_ult_pg_int   , historia)
                  values    (@s_ssn             , @t_trn          , 'P'      , @s_date       , @s_user,
                             @s_term            , @s_srv          , @s_lsrv  , @v_fpago      , @v_fecha_ven,     
                        @v_fecha_pg_int    , @v_fecha_mod    , @v_estado, @v_int_pagados, @v_total_int_pagados,
                             @v_fecha_ult_pg_int, @v_historia)
   /* Si no se puede insertar error */
   if @@error != 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 143005
      return 1
   end  

   --------------------------------   
   -- Reverso de Detalle de pagos
   --------------------------------
    update cob_pfijo..pf_det_pago 
   set dp_estado_xren = 'R',  --CVA Oct-20-05
            dp_estado      = 'E'
    where dp_fecha_crea = @s_date
      and dp_operacion  = @w_operacionpf
      and ltrim(rtrim(dp_tipo)) in ('INT', 'INTV')
   and   dp_estado_xren = 'N'
   and   dp_estado   = 'I'
   
   if @@error != 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 145037
      return 1
   end  

   select @w_max_fecha_crea = max(dp_fecha_crea)
     from cob_pfijo..pf_det_pago 
    where dp_operacion          = @w_operacionpf
      and ltrim(rtrim(dp_tipo)) in ('INT', 'INTV')
      and dp_estado_xren        = 'N'   --CVA Oct-20-05
      and dp_estado             = 'E'   --CVA Oct-20-05
   
   update cob_pfijo..pf_det_pago
      set dp_estado_xren = 'N', 
          dp_estado      = 'I'
    where dp_operacion          = @w_operacionpf
      and ltrim(rtrim(dp_tipo)) in ('INT', 'INTV')
      and dp_fecha_crea         = @w_max_fecha_crea
   if @@error != 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 145037
      return 1
   end  

   /**********************************
   CCR reverso de beneficiarios
   *********************************/
   update pf_beneficiario
   set   be_estado_xren = 'R',
      be_estado   = 'E'
   where be_fecha_crea  = @s_date
   and   be_estado_xren = 'N'
   and   be_estado   = 'I'
   and   be_operacion   = @w_operacionpf
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 145009
      return 145009
   end
   
   select @w_fecha_beneficiario  = max(be_fecha_crea)
   from  pf_beneficiario
   where be_operacion   = @w_operacionpf
   and   be_estado_xren = 'A'
   and   be_estado   = 'E'
   
   update pf_beneficiario
   set   be_estado_xren = 'N',
      be_estado   = 'I'
   where be_fecha_crea  = @w_fecha_beneficiario
   and   be_estado_xren = 'A'
   and   be_estado   = 'E'
   and   be_operacion   = @w_operacionpf
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 145009
      return 145009
   end
   /***FIN CCR Rev. Benefi.**********/
   /*************************************
   CCR Actualizacion de Spread a Anulado
   *************************************/

   if exists(  select 1 from pf_aut_spread
         where as_estado   = 'U'
         and   as_operacion   = @w_operacionpf
         and   as_fecha = @s_date
      )
   begin
      
      update pf_aut_spread
      set   as_estado   = 'A',
         @w_ssn_spread   = as_secuencial
      where as_estado   = 'U'
         and   as_operacion   = @w_operacionpf
         and   as_fecha = @s_date
                        and     as_secuencial   = (select max(as_secuencial)    from pf_aut_spread 
                     where as_estado   = 'U'
                     and   as_operacion   = @w_operacionpf
                     and   as_fecha = @s_date)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debub = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141187
         return 141187
      end

      delete from pf_autorizacion 
         where au_operacion = @w_operacionpf 
         and au_secuencial = @w_ssn_spread                                         
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debub = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141187
         return 141187
      end


   end
   /***FIN CCR Act spread****************/
   
   /****************************************
   CCR Actualizacion de Instruccion especial
   ****************************************/
   if exists   (select 1 from pf_instruccion
         where in_operacion         = @w_operacionpf
         and   isnull(in_estadoxren, 'N') = 'N'
         and   isnull(in_fecha_crea, @s_date)   = @s_date
         )
   begin
      update pf_instruccion
      set   in_estadoxren  = 'R',
         in_fecha_mod   = @s_date
      where in_operacion         = @w_operacionpf
      and   isnull(in_estadoxren, 'N') = 'N'
      and   isnull(in_fecha_crea, @s_date)   = @s_date
      
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 145056
         return 145056
      end
      
      select @w_fecha_inst_esp   = max(in_fecha_crea)
      from  pf_instruccion
      where in_operacion         = @w_operacionpf
      and   isnull(in_estadoxren, 'N') = 'E'
      
      update pf_instruccion
      set   in_estadoxren  = 'N',
         in_fecha_mod   = @s_date
      where in_operacion         = @w_operacionpf
      and   isnull(in_estadoxren, 'N') = 'E'
      and   isnull(in_fecha_crea, @s_date)   = @w_fecha_inst_esp
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 145056
         return 145056
      end
   end
   /*******FIN CCR Act Inst Esp.***********/

   select @w_mm_secuencia = @w_secuencia, 
          @w_tran_ren     = 14904

   while (@w_mm_secuencia <= (@w_secuencia+2)) 
   begin
      select @w_mm_sub_secuencia = 0,
             @w_tran_ren         = 14904

      while 2=2
      begin
         set rowcount 1
         select @w_mm_sub_secuencia = mm_sub_secuencia,
                @w_mm_producto     = mm_producto,
                @w_mm_cuenta       = mm_cuenta,   
                @w_mm_moneda       = mm_moneda,   
                @w_mm_valor        = mm_valor,
                @w_mm_beneficiario = mm_beneficiario,             
                @w_secuencial      = mm_secuencial,
      @w_mm_secuencia_aux= mm_secuencia,
      @w_mm_estado      = mm_estado
           from pf_mov_monet
          where mm_operacion = @w_operacionpf
            and mm_tran      = @w_tran_ren
            -- and mm_secuencia = @w_mm_secuencia
            and mm_sub_secuencia > @w_mm_sub_secuencia
            and mm_estado = 'A'
            and mm_fecha_crea = @s_date
          order by mm_sub_secuencia
           
         if @@rowcount = 0        
            break

         set rowcount 0
         if @w_mm_estado = 'A' --condicion incrementada por CAL
         begin
            -- print 'Primera entrada'
            exec @w_return = sp_aplica_mov
                 @s_ssn             = @s_ssn,
                 @s_user            = @s_user,
                 @s_ofi             = @s_ofi,
                 @s_date            = @s_date,
                 @s_srv             = @s_srv, 
                 @s_term            = @s_term,
                 @t_file            = @t_file,
                 @t_from            = @w_sp_name, 
                 @t_debug           = @t_debug,
                 @t_trn             = @w_tran_ren,                
                 @i_operacionpf     = @w_operacionpf,
                 @i_fecha_proceso   = @w_fecha_hoy,
                 @i_secuencia       = @w_mm_secuencia_aux,
                 @i_impuesto        = 0,
                 @i_sub_secuencia   = @w_mm_sub_secuencia,    
                 @i_en_linea        = 'S',
                 @i_tipo            = 'R',
                 @i_retiene_capital = 'N'
                 --@i_mm_secuencial   = @w_secuencial,                  
                 --@i_op_num_banco    = @i_num_banco,
                 --@i_reversobanco    = @i_reversobanco
            if @w_return != 0
            begin
               exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = @w_return
               return @w_return
            end 
         end --fin de if @w_mm_estado = 'A'
      end /** END WHILE 2 **/

      select @w_mm_secuencia = @w_mm_secuencia +1,
             @w_tran_ren     = 14919

   end /* fin de while mm_secuencia <= @w_secuencia +2 */

   -------------------------------------------------------------
   -- Reverso los movimientos de las operaciones Renovadas
   -------------------------------------------------------------
   select @w_mm_secuencia =0 
   while 3=3
   begin
      set rowcount 1
      select @w_mm_sub_secuencia = mm_sub_secuencia,
             @w_mm_producto     = mm_producto,
             @w_mm_moneda       = mm_moneda,
             @w_mm_cuenta       = mm_cuenta,   
             @w_mm_tipo         = mm_tipo,   
             @w_tran_ren        = mm_tran,   
             @w_mm_valor        = mm_valor,
             @w_mm_estado       = mm_estado,
             @w_mm_secuencia    = mm_secuencia,
             @w_mm_beneficiario = mm_beneficiario,
             @w_secuencial      = mm_secuencial
        from pf_mov_monet
       where mm_operacion     = @w_operacion_new
         and mm_sub_secuencia > @w_mm_sub_secuencia
         and mm_estado        = 'A'
         and mm_tran          = 14901
         and mm_secuencia = (select max(mm_secuencia) 
                               from pf_mov_monet
                              where mm_operacion   = @w_operacion_new
                                and mm_tran        = 14901)
         and mm_fecha_aplicacion = @w_re_fecha_crea
         and mm_producto         = 'REN'
        order by mm_sub_secuencia
      if @@rowcount = 0
         break
      set rowcount 0
      if @w_mm_estado = 'A'
      begin
         -- print 'Segunda entrada'
         exec @w_return=sp_aplica_mov
              @s_ssn             = @s_ssn,
              @s_user            = @s_user,
              @s_ofi             = @s_ofi, 
              @s_date            = @s_date,
              @s_srv             = @s_srv,
              @s_term            = @s_term,
              @t_file            = @t_file,
              @t_from            = @w_sp_name,
              @t_debug           = @t_debug,
              @t_trn             = 14901, 
              @i_operacionpf     = @w_operacion_new,
              @i_fecha_proceso   = @w_fecha_hoy,
              @i_secuencia       = @w_mm_secuencia, 
              @i_impuesto        = 0,
              @i_sub_secuencia   = @w_mm_sub_secuencia,
         @i_en_linea        = 'S',
              @i_tipo            = 'R',
         @i_retiene_capital = 'N',  /* mig oracle ral 01/04/2001 */
              @i_mm_secuencial   = @w_secuencial,
              @i_op_num_banco    = @i_num_banco,
              @i_reversobanco    = @i_reversobanco
         if @w_return != 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = @w_return
            return 1
         end 
      end 
   end /** END WHILE 3 **/

   ---------------------------------------------------------------
   -- GES 05/10/99 Proceso incrementado para reversar decrementos
   ---------------------------------------------------------------
   select @w_mm_sub_secuencia =0
   while 4=4
   begin
      set rowcount 1
      select @w_mm_sub_secuencia = mm_sub_secuencia,
             @w_mm_producto      = mm_producto,
             @w_mm_moneda        = mm_moneda,
             @w_mm_cuenta        = mm_cuenta,
             @w_mm_tipo          = mm_tipo,
             @w_tran_ren         = mm_tran,
             @w_mm_valor         = mm_valor,
             @w_mm_estado        = mm_estado,
             @w_mm_secuencia     = mm_secuencia,
             @w_mm_beneficiario  = mm_beneficiario,
             @w_secuencial       = mm_secuencial
        from pf_mov_monet
       where mm_operacion        = @w_operacion_new
         and mm_sub_secuencia    > @w_mm_sub_secuencia
         and mm_tran             = 14919  
         and mm_fecha_aplicacion = @s_date  
       order by mm_sub_secuencia           
      if @@rowcount = 0
         break
      set rowcount 0
      if @w_mm_estado = 'A'
      begin
         --   print 'Tercera entrada'
         exec @w_return = sp_aplica_mov
              @s_ssn             = @s_ssn,
              @s_user            = @s_user,
              @s_ofi             = @s_ofi,
              @s_date            = @s_date,
              @s_srv             = @s_srv, 
              @s_term            = @s_term,
              @t_file            = @t_file,
              @t_from            = @w_sp_name,
              @t_debug           = @t_debug,
              @t_trn             = @w_tran_ren, 
              @i_operacionpf     = @w_operacion_new,
              @i_fecha_proceso   = @w_fecha_hoy ,
              @i_secuencia       = @w_mm_secuencia,
              @i_impuesto        = 0,
              @i_sub_secuencia   = @w_mm_sub_secuencia,
              @i_en_linea        = 'S',    
              @i_tipo            = 'R',
              @i_retiene_capital = @w_retiene_capital,
              @i_mm_secuencial   = @w_secuencial,
              @i_op_num_banco    = @i_num_banco,
              @i_reversobanco    = @i_reversobanco
         if @w_return != 0
         begin
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = @w_return
            return 1
         end
      end    
   end /** END WHILE 4 **/

   select @w_pt_secuencia = 0
   while 5= 5
   begin
      set rowcount 1
      select @w_pt_beneficiario = dp_ente,
             @w_pt_tipo    = dp_tipo,
             @w_pt_secuencia    = dp_secuencia,
             @w_pt_forma_pago   = dp_forma_pago,
             @w_pt_cuenta  = dp_cuenta,
             @w_pt_monto   = dp_monto,
             @w_pt_porcentaje   = dp_porcentaje,
             @w_pt_fecha_crea   = dp_fecha_crea,
             @w_pt_fecha_mod  = dp_fecha_mod,
             @w_pt_moneda_pago  = dp_moneda_pago  -- GES 04/09/01 CUZ-002-113
   from pf_det_pago
       where dp_operacion   = @w_operacionpf 
         and dp_secuencia   > @w_pt_secuencia 
         and dp_tipo        = 'REN'
         and dp_estado_xren = 'N'
      if @@rowcount = 0
         break
      
      delete pf_det_pago
       where dp_operacion = @w_operacionpf
         and dp_secuencia = @w_pt_secuencia
   
      if @@error != 0
      begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,  
              @i_num   = 147038
         return 1
      end  
      insert into ts_det_pago (secuencial      , tipo_transaccion, clase       , fecha         , usuario,
                               terminal        , srv             , lsrv        , operacion     , ente,
                               tipo            , forma_pago      , cuenta      , monto         , porcentaje,
                               fecha_crea      , fecha_mod       , moneda_pago)
                      values  (@s_ssn          , @t_trn          , 'B'         , @s_date       , @s_user, 
                               @s_term         , @s_srv          , @s_lsrv     , @w_operacionpf, @w_pt_beneficiario,
                               @w_pt_tipo      , @w_pt_forma_pago, @w_pt_cuenta, @w_pt_monto   , @w_pt_porcentaje,
                               @w_pt_fecha_crea, @w_pt_fecha_mod , @w_pt_moneda_pago)  
      /* Si no se puede insertar error */
      if @@error != 0
      begin
         exec cobis..sp_cerror
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_num         = 143005
         return 1
      end      
   end /*  While 5  */ 

   --------------------------------------------------------------------     
   -- GES 04/12/1999 Verificar si orden de pago ya fue cobrada en caja
   --------------------------------------------------------------------
   if exists (select * from pf_emision_cheque
               where ec_operacion = @w_operacion_new
                 and ec_caja = 'S'
      and ec_tran = 14904
      and ec_fecha_crea = @s_date)
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 141094
      return 1
   end       
   delete pf_emision_cheque 
    where ec_operacion=@w_operacionpf 
      --and ec_secuencia = @w_secuencia
   and ec_tran = 14904
   and ec_fecha_crea = @s_date

   if @@error != 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 143005
      return 1
   end 

   -------------------------------------------------------
   -- GES 07/19/1999 Eliminar orden de pago de decremento
   -------------------------------------------------------
   if exists (select * from pf_emision_cheque
               where ec_operacion = @w_operacion_new
                 and ec_tipo = 'C'
      and ec_fecha_crea = @s_date
      and ec_tran    = 14904)
   begin
      delete pf_emision_cheque
       where ec_operacion = @w_operacion_new
   and   ec_tipo     = 'C'
   and   ec_fecha_crea  = @s_date
   and   ec_tran     = 14904
      if @@error != 0
      begin
         exec cobis..sp_cerror
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @i_num         = 147041
         return 1
      end
   end

   ----------------------------------------------------------------------                             
   -- Contabilizacion del reverso si la nueva operacion ya fue activada
   ----------------------------------------------------------------------
   if @w_estado_new <> 'ING'
   begin
      -----------------------------------------------------------------------------------------------
      -- GES 04/13/1999 No debe reversar si la nueva operacion fue activada en en una fecha anterior
      -----------------------------------------------------------------------------------------------
      if @w_estado_new = 'ACT'
      begin
         /*if @w_fecha_valor_new < @s_date
         begin
            exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_num           = 141133
            return 1
         end*/

         --------------------------------------------------------------------------
         -- GES 08/03/1999 Se debe controlar si hubo ingreso de incremento en caja
         --------------------------------------------------------------------------
         if exists(select * from pf_secuen_ticket      
              where st_operacion = @w_operacion_new
                      and st_estado = 'C'
                      and st_fecha_crea = @s_date)
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 141152
            return 1
         end                          
      end

      set rowcount 0
      update pf_relacion_comp
         set rc_estado = 'R'
       where rc_num_banco = @w_num_banco 
         and rc_tran      = 'APR'
         and rc_estado    = 'N'
         and rc_cod_tran in (14919,14904)

      update pf_scomprobante 
         set sc_estado = 'R'
        from pf_relacion_comp 
       where sc_comprobante = rc_comp 
         and sc_estado = 'I'
         and rc_estado = 'R'
         and rc_tran = 'APR'
         and rc_num_banco = @w_num_banco
         and sc_perfil = '10'
         and sc_descripcion like '%RENOVACION%'

      if @@error  != 0
      begin
         exec cobis..sp_cerror
              @t_debug         = @t_debug,
              @t_file          = @t_file,
              @t_from          = @w_sp_name,
              @i_num           = 143041
         return 1
      end

      exec @w_return = sp_aplica_conta
      @i_anulacion     = 'S',
      @i_operacionpf   = @w_operacionpf,
      @i_tipo_trn      ='REN',
      @i_fecha         = @s_date

      if @w_return <> 0 begin
         rollback tran
         exec cobis..sp_cerror
         @t_from          = @w_sp_name,
         @i_num           = @w_return
   
         return @w_return
      end

      exec @w_return = sp_aplica_conta
      @i_anulacion     = 'S',
      @i_operacionpf   = @w_operacionpf,
      @i_tipo_trn      ='APE',
      @i_fecha         = @s_date


   end

   -----------------------------------
   -- Reverso de intereses Back-Value
   -----------------------------------
   select @w_desc_rev = 'Reverso de Int. Renov por Back-Value (" + rtrim(ltrim(@w_num_banco)) + ")'

   --exec  ('update cob_pfijo..pf_scomprobante set '
   --   + ' sc_estado = ' +  '''' + 'R' + ''''
   --   + ' where '
   --   + ' sc_descripcion like ' + '''' + '%' + ''''
   --   +  @w_desc_rev + '''' + '%' + '''')

   update cob_pfijo..pf_scomprobante
   set sc_estado = 'R' 
   where sc_descripcion  like '%' + @w_desc_rev + '%'

   ---------------------------------------
   -- Reverso de intereses al vencimiento
   ---------------------------------------
   update pf_relacion_comp
      set rc_estado = 'R'
    where rc_num_banco = @w_num_banco 
      and rc_tran      = 'REN'
      and rc_estado  = 'N'

   update pf_scomprobante set sc_estado = 'R'
     from pf_relacion_comp, pf_scomprobante
    where sc_comprobante = rc_comp
      and sc_estado = 'I'
      and rc_estado = 'R'
      and rc_tran = 'REN'
      and rc_num_banco = @w_num_banco
 
   -------------------------------------------------
   -- Reverso de intereses provisionados Back-Value
   -------------------------------------------------
   set rowcount 1
      select @w_rc_comp = rc_comp from cob_pfijo..pf_relacion_comp
       where rc_num_banco = @w_num_banco 
         and rc_tran      = 'PRVARR'
         and rc_estado  = 'N'
       order by rc_comp desc

   update pf_relacion_comp
      set rc_estado = 'R'
    where rc_num_banco = @w_num_banco 
      and rc_tran      = 'PRVARR'
      and rc_estado  = 'N' 
      and rc_comp = @w_rc_comp

   update pf_scomprobante
      set sc_estado = 'R'
    where sc_comprobante = @w_rc_comp
      and sc_estado = 'I'
   set rowcount 0

   ----------------------------------------------------------------------
   -- Reversa comprobante si hubo incremento de capital en la renovacion
   ----------------------------------------------------------------------
   if @w_incremento > 0
   begin
   
   	if exists(select 1
			from   pf_mov_monet
			where  mm_operacion = @w_operacionpf 
			and    mm_tran      = 14995
			and	mm_estado = 'A'
			and	mm_fecha_aplicacion = @s_date
			and	mm_producto = 'EFEC')
	begin
		print 'revordpago PAGOS EN EFECTIVO SIN REVERSAR EN BRANCH'
      		exec cobis..sp_cerror
           		@t_debug       = @t_debug,
           		@t_file        = @t_file,
           		@t_from        = @w_sp_name,
           		@i_num         = 141254
      		return 1
	end	   
   
      set rowcount 0
      update pf_relacion_comp set rc_estado = 'R'
       where rc_num_banco = @i_num_banco
         and rc_tran      = 'INC'
         and rc_estado    = 'N'
      update pf_scomprobante set sc_estado = 'R'
        from pf_relacion_comp
       where  sc_comprobante = rc_comp and
              sc_estado = 'I' and
              rc_estado = 'R' and              
              rc_tran = 'INC' and
              rc_num_banco = @i_num_banco

      if @@error  != 0
      begin
         exec cobis..sp_cerror
              @t_debug         = @t_debug,
              @t_file          = @t_file, 
              @t_from          = @w_sp_name,
              @i_num           = 143041
         return 1
      end
   end 

   ---------------------------
   -- Insercion del historial
   ---------------------------
   insert pf_historia (hi_operacion  , hi_secuencial, hi_fecha     , hi_trn_code , hi_valor,
                       hi_funcionario, hi_oficina   , hi_fecha_crea, hi_fecha_mod)
               values (@w_operacionpf, @v_historia  , @s_date      , @t_trn      ,
                       @w_valor      , @s_user      , @s_ofi       , @s_date     , @s_date)
   if @@error != 0
   begin
      exec cobis..sp_cerror
           @t_debug       = @t_debug,
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @i_num         = 143006
      return  1  
   end

commit tran


--rollback tran
return 0   
                                                                                                                                                                                                                         
go
