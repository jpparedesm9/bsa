/************************************************************************/
/*      Archivo:                revcan.sp                               */
/*      Stored procedure:       sp_reverso_cancela                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 29/Ago/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      necesarias para reversar una cancelacion                        */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR            RAZON                               */
/* 12-Nov-99     Marcelo Cartagena No borra todas las ordenes de pago   */
/*                                 cuando se realiza el reverso de can- */
/*                                 celacion                             */
/* 05-May-2005   N. Silva          Identacion                           */
/* 12-Oct-05     Luis Im           Secuencial de lotes de cheques para  */
/*                                 reverso de cheques                   */
/* 03-Nov-05     Luis Im           Control reversar cancelaciones       */
/*                                 mismo dia de creacion                */
/* 07-Nov-2007   N. Silva          Volver a reactivar inst. canc.       */
/* 09-Jul-2009   Y. Martinez       NYM DPF00015 ICA                     */
/* 03-Jul-2013   O. Saavedra       INC 112895 Compatibilidad 90 y       */
/*                                 Ajustes al reverso de Comprobantes   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_reverso_cancela')
   drop proc sp_reverso_cancela
go

create proc sp_reverso_cancela (
   @s_ssn                  int = NULL,
   @s_user                 login = NULL,
   @s_sesn                  int = NULL,
   @s_term                 varchar(30) = NULL,
   @s_date                 datetime = NULL,
   @s_srv                  varchar(30) = NULL,
   @s_lsrv                 varchar(30) = NULL,
   @s_ofi                  smallint = NULL,
   @s_rol                  smallint = NULL,
   @t_debug                char(1) = 'N',
   @t_file                 varchar(10) = NULL,
   @t_from                 varchar(32) = NULL,
   @t_trn                  smallint,
   @i_num_banco  cuenta,
   @i_num_lote             cuenta  = NULL,   
   @i_autorizado login,
   @i_empresa              tinyint = 1 -- GES 09/17/01 CUZ-032-004
)
with encryption
as
/*  Variables para pf_operacion  */
declare         
   @w_sp_name                   varchar(32),
   @w_string                    varchar(30),
   @w_descripcion               descripcion,
   @w_codigo                    int,
   @w_operacionpf               int,
   @w_operacionec               int,
   @w_producto                  tinyint,
   @w_tran_pin                  int,
   @w_tran_can                  int,
   @w_return                    int,
   @w_estado                    char(1), 
   @w_estado_new                char(1), 
   @v_estado                    catalogo,
   @w_estado_op                 catalogo,
   @w_accion_sgte               catalogo,
   @v_accion_sgte               catalogo,
   @w_fecha_crea                datetime,
   @w_fecha_mod                 datetime,
   @w_monto_pg_int              money,
   @w_int_ganado                money,
   @w_int_no_ganados            money,
   @w_int_pagados               money,
   @w_total_int_pagados         money,
   @w_total_int_ganado          money,
   @w_total_int_estimado        money,
   @w_msg                       varchar(10),
   @w_fecha_ven                 datetime,
   @w_fecha_hoy                 datetime,
   @w_fpago                     catalogo,
   @w_tplazo                    catalogo,
   @w_toperacion                catalogo,
   @w_fecha_pg_int              datetime,
   @w_fecha_ult_pg_int          datetime,
   @v_fecha_ult_pg_int          datetime,
   @v_fecha_mod                 datetime,
   @v_fpago                     catalogo,
   @v_fecha_pg_int              datetime,
   @v_monto_pg_int              money,
   @v_int_ganado                money,
   @v_int_pagados               money,
   @v_total_int_pagados         money,
   @v_historia                  tinyint,
   @w_moneda                    tinyint,
   @w_oficina                   smallint,     -- GAL 31/AGO/2009 - RVVUNICA
   @v_fecha_ven                 datetime,
   @w_normal                    char(1),
   @w_tipo                      char(1),
   @w_ttipo                     char(1),
   @w_afec                      char(1),
   @w_tafec                     char(1),
   @w_afectacion                char(1),
   @w_pen_monto                 money,
   @w_pen_porce                 float,
   @w_penal                     money,
   @w_stock                     int,         
   @w_numero                    int,
   ----------------------------------
   -- Variables para mov_monet 
   ----------------------------------
   @w_mm_tipo                   catalogo,
   @w_mm_beneficiario           int,
   @w_secuencial                int,
   @w_mm_impuesto               money,
   @w_mm_producto               catalogo,
   @w_mm_cuenta                 cuenta,
   @w_mm_valor                  money,
   @w_mm_moneda                 smallint,
   @w_mm_valor_ext              money, 
   @w_mm_fecha_crea             datetime,
   @w_mm_fecha_mod              datetime, 
   @w_mm_sub_secuencia          tinyint,
   @w_mm_secuencia              smallint,
   @w_mm_secuencial             int,
   @w_mm_sec_mov                int,
   @w_total_cancel              money, 
   @w_int_vencido               money, 
   @w_valor                     money, 
   @w_secuencia                 smallint,
   @w_secpin                    smallint,
   @w_total_pin                 money, 
   @w_oficina_ing               smallint,
   -----------------------------------
   -- Variables para det_pago 
   -----------------------------------
   @w_pt_beneficiario           int,
   @w_pt_secuencia              int,
   @w_pt_tipo                   catalogo,
   @w_pt_forma_pago             catalogo,
   @w_pt_cuenta                 cuenta,   
   @w_pt_monto                  money,
   @w_pt_porcentaje             float,
   @w_pt_fecha_crea             datetime, 
   @w_pt_fecha_mod              datetime,
   @w_retiene_capital           char(1),
   @w_error                     int,
   --------------------------------------
   -- Variables para actualizacion de cupones
   --------------------------------------
   @w_cu_estado                 catalogo, 
   @w_cu_estado_ant             catalogo, 
   @w_cupon                     tinyint,
   @w_op_cupon                  char(1),
   --------------------------------------
   -- Variables para reverso de cheques 
   --------------------------------------
   @w_ec_moneda                 tinyint,
   @w_moneda_base               tinyint,
   @w_parametro                 char(6),   
   @w_instrumento               tinyint,
   @w_subtipo                   tinyint,       
   @w_instrumento_subtipo       varchar(30),
   @w_ec_numero                 int,
   @w_ec_secuencia              int,
   @w_ec_sub_secuencia          int,
   @w_codigo_alterno            int,
   @w_cadena                    char(30),
   @w_ec_fpago                  catalogo,
   @w_ec_secuencial_lote        int,
   @w_cod_transf     int,
   @w_trancex        char(1),
   @w_mm_secuencia2             int,
   @w_mm_sub_secuencia2         int,
   @w_mt_estado2                char(1),
   -- INI NYM DPF00015 ICA
   @w_total_int_retenido        money,
   @w_total_ica                 money,
   -- FINI NYM DPF00015 ICA
   @w_ec_subtipo_ins            int,           -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @w_instr_chqcom              tinyint,       -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
   @w_grupo1                    varchar(30),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
   @w_mt_producto		varchar(30),
   @w_instrumento_chger 	int,
   @w_subtipo_ins_chger 	int,
   @w_instrumento_aux		int,
   @w_cheque_ger 		varchar(20),
   @w_mpago_chqcom 		varchar(20)


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
       max(ct_fecha)    as uc_fecha
into   #ult_cotiz
from   cob_conta..cb_cotizacion
group by ct_moneda

insert into #cotizacion
select ct_moneda, ct_valor
from   cob_conta..cb_cotizacion, #ult_cotiz
where ct_moneda = uc_moneda
and   ct_fecha  = uc_fecha

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CHEQUES COMERCIALES - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'


-- INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009
select @w_instrumento_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'ICHDG'
and   pa_producto = 'PFI'

-- SUBTIPO INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009
select @w_subtipo_ins_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'SICHDG'
and   pa_producto = 'PFI'


select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'

-- MEDIO DE PAGO CHEQUE COMERCIAL - GAL 07/SEP/2009 - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'


select @w_fecha_hoy   = convert(datetime, convert (varchar,@s_date,101)) ,
       @w_tran_pin    = 14905,
       @w_tran_can    = 14903,
       @w_oficina_ing = @s_ofi, 
       @w_ttipo       = 'T'

if @t_trn <> 14913
begin
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141018
   return 1
end

select @w_operacionpf            = op_operacion,
       @v_estado                 = op_estado,
       @v_fecha_ven              = op_fecha_ven,
       @v_accion_sgte            = op_accion_sgte,
       @v_historia               = op_historia,
       @v_fecha_mod              = op_fecha_mod ,
       @v_fpago                  = op_fpago,
       @w_moneda                 = op_moneda,
       @w_toperacion             = op_toperacion,
       @w_tplazo                 = op_tipo_plazo,
       @w_oficina                = op_oficina,
       @w_producto               = op_producto,
       @w_total_int_estimado     = op_total_int_estimado,
       @w_total_int_ganado       = op_total_int_ganados,   
       @v_monto_pg_int           = op_monto_pg_int,
       @v_int_ganado             = op_int_ganado,
       @v_int_pagados            = op_int_pagados,
       @v_total_int_pagados      = op_total_int_pagados,
       @v_fecha_ult_pg_int       = op_fecha_ult_pg_int,
       @v_fecha_pg_int           = op_fecha_pg_int,
       @w_op_cupon               = op_cupon    
from   pf_operacion
where  op_num_banco = @i_num_banco

if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141051
   return 1
end


-- valido existencia de pagos en efectivo
if exists 
(select 1
from   pf_emision_cheque x
where  ec_operacion         = @w_operacionpf
and    ec_tran              = 14903
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
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 141254
   return 1
end		


select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa = @i_empresa

if @@rowcount = 0
begin
    exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 601018
    return  1
end

----------------------------------------
-- REVERSO EMISION CHEQUE EMITIDO
----------------------------------------
if exists (select ec_operacion 
           from   pf_emision_cheque, 
                  pf_fpago
           where  ec_operacion      = @w_operacionpf
             and  ec_fecha_emision IS   NOT NULL
             and  ec_tran           = 14903 
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
        and  ec_fecha_emision is not null
        and  ec_tran           = 14903
        and  ec_caja           = 'S'
        and  ec_sub_secuencia  > @w_ec_sub_secuencia
        and  ec_fpago          = fp_mnemonico
        and  fp_producto       = 42
              
      if @@rowcount = 0
         break
        
      --------------------------------
      -- Actualizar registro reversado 
      --------------------------------
           
      update pf_emision_cheque
      set    ec_caja = NULL
      where  ec_operacion      = @w_operacionpf
        and  ec_fecha_emision IS   NOT NULL
        and  ec_tran          = 14903 
        and  ec_caja          = 'S'   
        and  ec_secuencia     = @w_ec_secuencia
        and  ec_sub_secuencia = @w_ec_sub_secuencia
                
      if @@error <> 0
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
  and  ec_fecha_emision IS   NOT NULL
  and  ec_tran           = 14903 
  and  ec_caja           = 'S'      -- Verifica si ya fue pagado

if @@rowcount > 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from = @w_sp_name,
      @i_num = 141162
   return 1
end


------------------------------
-- Lectura de pf_cancelaci¢n 
------------------------------
select  @w_fpago             = ca_fpago,
        @w_fecha_ven         = ca_fecha_ven,
        @w_fecha_mod         = ca_fecha_mod,
        @w_fecha_pg_int      = ca_fecha_pg_int,
        @w_accion_sgte       = ca_accion_sgte,
        @w_estado_op         = ca_estado_op,
        @w_secuencia         = ca_secuencial,
        @w_secpin            = ca_secpin,
        @w_estado            = ca_estado,
        @w_monto_pg_int      = ca_monto_pg_int,
        @w_int_ganado        = isnull(ca_int_ganado,0), 
        @w_int_pagados       = isnull(ca_int_pagados,0), 
        @w_int_vencido       = isnull(ca_int_vencido, 0), 
        @w_total_int_pagados = ca_total_int_pagados,
        @w_fecha_ult_pg_int  = ca_fecha_ult_pg_int,
        @w_valor             = ca_valor,
        @w_pen_monto         = ca_pen_monto,
        @w_pen_porce         = ca_pen_porce,
        @w_tipo              = ca_tipo
  from  pf_cancelacion,

        cob_pfijo..pf_operacion
  where ca_operacion = @w_operacionpf 

    and op_operacion = ca_operacion
    and ca_oficina   = @s_ofi
    and ca_estado   in ('A','I') 
    and ((datediff(dd,ca_fecha_crea,@s_date) = 0 and op_estado = 'CAN') or op_estado = 'ACT') -- Control instruccion de cancelacion


if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141132
   return 1
end



if @w_estado='A'
   if datediff (dd,@w_fecha_mod,@s_date)<>0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141141
      return 1
   end
 
if @w_pen_monto is not null
   select @w_penal=@w_pen_monto
if @w_pen_monto is null and @w_pen_porce is null
   select @w_penal=0             

----------------------------------------------------------------------
-- Lectura de la vista pf_tran_reg para la operacion pago de intereses 
----------------------------------------------------------------------
if @w_estado_op='VEN'
   select @w_normal='N', @w_tafec = 'V'
else
   select @w_normal='S' , @w_tafec = 'N'

if @v_estado <> 'CAN' 
   and (@v_estado <> 'ACT' or  @v_accion_sgte <> 'XCAN') 
   and @v_estado <> 'PEN'    
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 141133
   return 1
end

select @w_estado_new = 'R'

BEGIN TRAN

update pf_cancelacion
set    ca_estado = @w_estado_new,
       ca_fecha_mod = @s_date
where  ca_operacion = @w_operacionpf
   and ca_secuencial = @w_secuencia   

if @@rowcount = 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 145036
   select @w_error = 145036
   goto ERROR
end 

insert into ts_cancelacion (secuencial,    tipo_transaccion,          clase,         fecha,             usuario,
                            terminal,      srv,                       lsrv,          fecha_mod,         estado)
                values     (@s_ssn,        @t_trn,                    'A',           @s_date,           @s_user, 
                            @s_term,       @s_srv,                    @s_lsrv,       @s_date,           @w_estado_new)
                               
if @@error <> 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
   select @w_error = 143005
   goto ERROR
end 


------------------------------------------

-- Control de instruccion de cancelacion

------------------------------------------

if @v_estado = 'ACT'

begin


   update pf_operacion

    set   op_accion_sgte       =  @w_accion_sgte,

          op_historia          =  @v_historia + 1,

          op_fecha_mod         =  @s_date,

          op_fecha_cancela     =  null       

    where op_operacion         =  @w_operacionpf
end

else

begin


-- INI NYM DPF00015 ICA
--Consulto valor de retencion e ica aplicado en ultima cancelacion
select   @w_total_int_retenido   = isnull(sum(mm_impuesto),0),
   @w_total_ica      = isnull(sum(mm_ica),0)
from  pf_mov_monet
where mm_operacion     = @w_operacionpf
and   mm_tran          = @w_tran_can
and   mm_secuencia     = @w_secuencia
and   mm_sub_secuencia > 0
and   mm_estado        = 'A'    
-- FINI NYM DPF00015 ICA

--print 'revcan @w_total_int_retenido %1! @w_total_ica %2! ', @w_total_int_retenido, @w_total_ica
   

update pf_operacion set 
   op_fpago             =  @w_fpago,
   op_fecha_ven         =  @w_fecha_ven,
   op_fecha_pg_int      =  @w_fecha_pg_int,
   op_accion_sgte       =  @w_accion_sgte,
   op_estado            =  @w_estado_op,
   op_historia          =  @v_historia + 1,
   op_monto_pg_int      =  @w_monto_pg_int,
   op_int_ganado        =  @w_int_ganado,
   op_int_pagados       =  @w_int_pagados,
   op_total_int_pagados =  @w_total_int_pagados,
   op_fecha_ult_pg_int  =  @w_fecha_ult_pg_int,
   op_fecha_mod         =  @s_date,
   op_fecha_cancela     =  null,       --CVA Abr-03-06
   op_total_int_retenido = op_total_int_retenido  - @w_total_int_retenido, -- NYM DPF00015 ICA
   op_total_ica      = op_total_ica - @w_total_ica
    where op_operacion         =  @w_operacionpf
end

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 145001
   select @w_error = 145001
   goto ERROR
end  
              
------------------------------------------------------------------------- 
-- transaccion de Servicio - pf_operacion  con los datos anteriores 
------------------------------------------------------------------------- 
insert into ts_operacion (secuencial,        tipo_transaccion,             clase,                fecha,               usuario,
                          terminal,          srv,                          lsrv,                 fpago,               fecha_ven,
                          fecha_pg_int,      fecha_mod,                    accion_sgte,          estado,              monto_pg_int,
                          int_ganado,        int_pagados,                  total_int_pagados,    fecha_ult_pg_int,    historia)
                values   (@s_ssn,            @t_trn,                       'P',                  @s_date,             @s_user, 
                          @s_term,           @s_srv,                       @s_lsrv,              @v_fpago,            @v_fecha_ven,     
                          @v_fecha_pg_int,   @v_fecha_mod,                 @v_accion_sgte,       @v_estado,           @v_monto_pg_int,
                          @v_int_ganado,     @v_int_pagados,               @v_total_int_pagados, @v_fecha_ult_pg_int, @v_historia)

if @@error <> 0
begin
   exec cobis..sp_cerror
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_num         = 143005
   select @w_error = 143005
   goto ERROR
end  
-----------------------------------------------------------------
--transaccion de Servicio - pf_operacion  con los datos actuales
-----------------------------------------------------------------
insert into ts_operacion (secuencial,        tipo_transaccion,             clase,                fecha,               usuario,
                          terminal,          srv,                          lsrv,                 fpago,               fecha_ven,
                          fecha_pg_int,      fecha_mod,                    accion_sgte,          estado,              monto_pg_int,
                          int_ganado,        int_pagados,                  total_int_pagados,    fecha_ult_pg_int,    historia)
               values    (@s_ssn,            @t_trn,                       'A',                  @s_date,             @s_user, 
                          @s_term,           @s_srv,                       @s_lsrv,              @w_fpago,            @w_fecha_ven,
                          @w_fecha_pg_int,   @s_date,                      @w_accion_sgte,       @w_estado_op,        @w_monto_pg_int,
                          @w_int_ganado,     @w_int_pagados,               @w_total_int_pagados, @w_fecha_ult_pg_int, @v_historia+1)
if @@error <> 0
begin
   exec cobis..sp_cerror
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_num         = 143005
   select @w_error = 143005
   goto ERROR
end 

if @i_autorizado is NOT NULL
begin --GAR 21-feb-2005 DP00036 Inserta solo si ingres¢ un autorizador
   insert pf_autorizacion (au_operacion,             au_autoriza,               au_oficina,
                           au_tautorizacion,         au_fecha_crea,             au_num_banco,
                           au_oficial)
                   values (@w_operacionpf,           @i_autorizado,             @s_ofi,
                           'RECA',                   @s_date,                   @i_num_banco,
                           @s_user)   
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_num         = 143040
      select @w_error = 143040
      goto ERROR
   end  
end

select @w_total_cancel = 0, @w_mm_sub_secuencia = 0
select @w_mm_secuencia = @w_secuencia 




--  CAMBIO REVERSO CHG APLICADO DESDE CANcelacion


if  @t_debug = 'S' print 'w_operacionpf ' + cast(@w_operacionpf as varchar )
if  @t_debug = 'S' print 's_date ' + cast(@s_date as varchar )

      select @w_mm_secuencia2  	= mm_secuencia,
        @w_mm_sub_secuencia2   	= mm_sub_secuencia,
        @w_mt_estado2          	= mm_estado,
        @w_mt_producto 		= mm_producto,
        @w_ec_secuencial_lote 	= mm_secuencial_lote,
        @w_ec_moneda		= mm_moneda,
        @w_ec_subtipo_ins	= mm_subtipo_ins
      from pf_mov_monet
      where mm_operacion     		= @w_operacionpf
        and mm_tran          		= 14903
        and mm_producto 		= 'CHG' 
        and mm_estado        		= 'A'    
        and mm_fecha_aplicacion     	= @s_date
        and mm_secuencial_lote          is not null

      if @@rowcount >= 0 begin

	      if @w_mt_producto in (@w_cheque_ger, @w_mpago_chqcom)
	      begin 
	      
	      		select @w_codigo_alterno = @w_codigo_alterno + 1
	      
	      		if @w_mt_producto = @w_mpago_chqcom
	      		begin
	      			select	@w_instrumento_aux	= @w_instr_chqcom
	      		end
	
	      		if @w_mt_producto = @w_cheque_ger
	      		begin
	      			select	@w_instrumento_aux	= @w_instrumento_chger,
	      				@w_ec_subtipo_ins 	= @w_subtipo_ins_chger
	      		end
	
			if  @t_debug = 'S' print 'w_ec_secuencial_lote ' + cast(@w_ec_secuencial_lote as varchar )
			if  @t_debug = 'S' print 'w_instrumento_aux ' + cast(@w_instrumento_aux as varchar )
			if  @t_debug = 'S' print 'w_ec_subtipo_ins ' + cast(@w_ec_subtipo_ins as varchar )
			if  @t_debug = 'S' print 'w_codigo_alterno ' + cast(@w_codigo_alterno as varchar )
			if  @t_debug = 'S' print 'w_ec_moneda ' + cast(@w_ec_moneda as varchar )
	
	      		
	      		-- secuencial@estado@serielit@serienum@fautoriza@moneda@ TRAMA REQUERIDA
	      		select @w_grupo1 = cast(@w_ec_secuencial_lote as varchar) + '@' + 
	                         'T'                                    + '@' + 
	                         ''                                     + '@' + 
	                         ''                                     + '@' + 
	                         ''                                     + '@' + 
	                         cast(@w_ec_moneda as varchar)          + '@'      
	
			      exec  @w_return = cob_interfase..sp_isba_reversar_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_reversar_lotes
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
			            @i_instrumento      = @w_instrumento_aux,         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
			            @i_subtipo_ins      = @w_ec_subtipo_ins,       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
			            @i_causal_anul      = '99',                    -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
			            @i_llamada_ext      = 'S',                     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
			            @i_grupo1           = @w_grupo1                -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
			                           
			      if @w_return <> 0
			      begin         
			         select @w_error = @w_return
			         goto ERROR
			      end
		
		end

      end

--  CAMBIO REVERSO CHG APLICADO DESDE CAN



--------------------------------------------------------------------------
-- reverso de Transferencias con Movimientos Monetarios  No Aplicados
--------------------------------------------------------------------------



while 3=3
begin
   set rowcount 1
   select @w_mm_sec_mov    = mm_sec_mov,
     @w_mm_sub_secuencia = mm_sub_secuencia
   from pf_mov_monet
   where mm_operacion     = @w_operacionpf
      and mm_tran          = @w_tran_can
      and mm_secuencia     = @w_mm_secuencia
      and mm_sub_secuencia >= @w_mm_sub_secuencia
      and mm_estado        IS NULL
   order by mm_sub_secuencia
   
   if @@rowcount = 0
      break

   set rowcount 0
   
   update pf_mov_monet
     set mm_estado = 'R'
   where mm_operacion     = @w_operacionpf
      and mm_tran          = @w_tran_can
      and mm_secuencia     = @w_mm_secuencia
      and mm_sub_secuencia = @w_mm_sub_secuencia
      and mm_estado        IS NULL

   ---------------------------------------------------
   -- Reverso de Transferencias
   ---------------------------------------------------
   update pf_transferencias_tmp   
      set tr_estado = 'R'
    where tr_cod_operacion = @w_operacionpf 
      and tr_sec_mov       = @w_mm_sec_mov
      and tr_tipo_pago     = 'N'
      and tr_estado       <> 'R'

   select @w_mm_sub_secuencia = @w_mm_sub_secuencia + 1
end
     
select @w_total_cancel = 0, @w_mm_sub_secuencia = 0




-----------------------------------------------------
-- reverso de Movimientos Monetarios  Aplicados
-----------------------------------------------------

while 2=2
begin
   set rowcount 1
   select @w_mm_sub_secuencia = mm_sub_secuencia,
          @w_mm_producto      = mm_producto,
          @w_mm_cuenta        = mm_cuenta,   
          @w_mm_valor         = mm_valor,
          @w_secuencial       = mm_secuencial,
          @w_mm_sec_mov       = mm_sec_mov
     from pf_mov_monet
    where mm_operacion     = @w_operacionpf
      and mm_tran          = @w_tran_can
      and mm_secuencia     = @w_mm_secuencia
      and mm_sub_secuencia > @w_mm_sub_secuencia
      and mm_estado        = 'A'    
    order by mm_sub_secuencia

   if @@rowcount = 0
      break
   set rowcount 0
   ----------------------------------------------
   -- Verificar si ya se realizo la orden de pago 
   ----------------------------------------------
   if exists (select * 
                from pf_emision_cheque
               where ec_operacion     = @w_operacionpf
                 and ec_secuencia     = @w_mm_secuencia
                 and ec_sub_secuencia = @w_mm_sub_secuencia
                 and ec_secuencial    = @w_secuencial 
                 and ec_caja          = 'S' )
   begin
      exec cobis..sp_cerror
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_num         = 141094
      select @w_error = 141094
      goto ERROR
   end
   ---------------------------------------------------
   -- Reverso de Transferencias
   ---------------------------------------------------
   select  @w_cod_transf = 0

   select @w_cod_transf = tr_cod_transf
   from  pf_transferencias_tmp     
   where tr_cod_operacion = @w_operacionpf 
      and tr_sec_mov       = @w_mm_sec_mov
      and tr_tipo_pago     = 'N'
      and tr_estado       <> 'R'

   select @w_cod_transf = isnull(@w_cod_transf, 0)

   if @w_cod_transf <> 0
     begin
     update pf_transferencias_tmp   
        set tr_estado = 'R'
     where tr_cod_operacion = @w_operacionpf 
        and tr_sec_mov       = @w_mm_sec_mov
        and tr_tipo_pago     = 'N'
        and tr_estado       <> 'R'
     select @w_trancex = 'S'
     end
   else
     select @w_trancex = 'N'

   ---------------------------------------------------------------------------------
   -- DGU-GES 122998 RET.IMPTO 1% Para indicar en sp_aplica_mov a CTAS Inversion
   -- si se debe o no retener el 1% al generar la nota de credito automatica    
   -- ya que el sp_retiene_capital compara la transaccion y el cliente          
   ---------------------------------------------------------------------------------
   exec @w_return = sp_retiene_capital
          @s_ssn             = @s_ssn, 
          @s_user            = @s_user,
          @s_ofi             = @s_ofi, 
          @s_date            = @s_date,
          @s_srv             = @s_srv, 
          @s_term            = @s_term, 
          @t_file            = @t_file,
          @t_from            = @w_sp_name, 
          @t_debug           = @t_debug,
          @t_trn             = @t_trn, 
          @i_operacion       = @w_operacionpf,
          @o_retiene_capital = @w_retiene_capital out
   if @@error <> 0
   begin
      select @w_error = 141155
      goto ERROR
   end           

   exec @w_return=sp_aplica_mov
      @s_ssn                   = @s_ssn, 
      @s_user                  = @s_user,
      @s_ofi                   = @s_ofi,
      @s_date                  = @s_date,
      @s_srv                   = @s_srv, 
      @s_term                  = @s_term, 
      @t_file                  = @t_file,
      @t_from                  = @w_sp_name, 
      @t_debug                 = @t_debug,
      @t_trn                   = 14903, 
      @i_operacionpf           = @w_operacionpf,
      @i_fecha_proceso         = @w_fecha_hoy ,
      @i_secuencia             = @w_mm_secuencia ,
      @i_impuesto              = 0,              
      @i_sub_secuencia         = @w_mm_sub_secuencia,
      @i_en_linea              = 'S',
      @i_tipo                  = 'R',
      @i_capital               = 'S',
      @i_normal                = @w_normal,  
      @i_retiene_capital       = @w_retiene_capital,
      @i_transferencia         = @w_trancex,
      @i_tr_cod_transf         = @w_cod_transf
 
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = @w_return
      select @w_error = @w_return
      goto ERROR
   end 

   select @w_total_cancel = @w_total_cancel + @w_mm_valor

   delete pf_emision_cheque  
    where ec_operacion = @w_operacionpf 
      and ec_secuencia = @w_secuencia

   if @@error <> 0
   begin
       exec cobis..sp_cerror
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 143005
       select @w_error = 143005
       goto ERROR
   end 

   select @w_mm_secuencia2 = 0
   select @w_mm_sub_secuencia2 = 0
   select @w_ec_sub_secuencia = 0,
          @w_codigo_alterno = 0


if  @t_debug = 'S' print 'w_operacionpf ' + cast(@w_operacionpf as varchar )
if  @t_debug = 'S' print 'w_mm_secuencia ' + cast(@w_mm_secuencia as varchar )



   while 2=2
      begin
      set rowcount 1
      select @w_mm_secuencia2  	= mm_secuencia,
        @w_mm_sub_secuencia2   	= mm_sub_secuencia,
        @w_mt_estado2          	= mm_estado,
        @w_mt_producto 		= mm_producto,
        @w_ec_secuencial_lote 	= mm_secuencial_lote,
        @w_ec_moneda		= mm_moneda,
        @w_ec_subtipo_ins	= mm_subtipo_ins
      from pf_mov_monet
      where mm_operacion     = @w_operacionpf
        and mm_tran          = 14943
        and mm_secuencia_emis_che  = @w_mm_secuencia
        and (mm_secuencia > @w_mm_secuencia2
        or mm_secuencia = @w_mm_secuencia2 and mm_sub_secuencia > @w_mm_sub_secuencia2)       
        and mm_estado        = 'A'    
      order by mm_secuencia, mm_sub_secuencia

      if @@rowcount = 0
         break

      set rowcount 0

      -------------------------------------------
      -- Reversar cheque si no fue emitido en SB
      -------------------------------------------


if  @t_debug = 'S' print 'w_mt_producto ' + cast(@w_mt_producto as varchar )

      if @w_mt_producto in (@w_cheque_ger, @w_mpago_chqcom)
      begin 
      
      		select @w_codigo_alterno = @w_codigo_alterno + 1
      
      		if @w_mt_producto = @w_mpago_chqcom
      		begin
      			select	@w_instrumento_aux	= @w_instr_chqcom
      		end

      		if @w_mt_producto = @w_cheque_ger
      		begin
      			select	@w_instrumento_aux	= @w_instrumento_chger,
      				@w_ec_subtipo_ins 	= @w_subtipo_ins_chger
      		end

if  @t_debug = 'S' print 'w_ec_secuencial_lote ' + cast(@w_ec_secuencial_lote as varchar )
if  @t_debug = 'S' print 'w_instrumento_aux ' + cast(@w_instrumento_aux as varchar )
if  @t_debug = 'S' print 'w_ec_subtipo_ins ' + cast(@w_ec_subtipo_ins as varchar )
if  @t_debug = 'S' print 'w_codigo_alterno ' + cast(@w_codigo_alterno as varchar )
if  @t_debug = 'S' print 'w_ec_moneda ' + cast(@w_ec_moneda as varchar )

      		
      		-- secuencial@estado@serielit@serienum@fautoriza@moneda@ TRAMA REQUERIDA
      		select @w_grupo1 = cast(@w_ec_secuencial_lote as varchar) + '@' + 
                         'T'                                    + '@' + 
                         ''                                     + '@' + 
                         ''                                     + '@' + 
                         ''                                     + '@' + 
                         cast(@w_ec_moneda as varchar)          + '@'      

		      exec  @w_return = cob_interfase..sp_isba_reversar_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_reversar_lotes
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
		            @i_instrumento      = @w_instrumento_aux,         -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
		            @i_subtipo_ins      = @w_ec_subtipo_ins,       -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
		            @i_causal_anul      = '99',                    -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
		            @i_llamada_ext      = 'S',                     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
		            @i_grupo1           = @w_grupo1                -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
		                           
		      if @w_return <> 0
		      begin         
		         select @w_error = @w_return
		         goto ERROR
		      end
	
	end


      exec @w_return=sp_aplica_mov
        @s_ssn                   = @s_ssn, 
        @s_user                  = @s_user,
        @s_ofi                   = @s_ofi,
        @s_date                  = @s_date,
        @s_srv                   = @s_srv, 
        @s_term                  = @s_term, 
        @t_file                  = @t_file,
        @t_from                  = @w_sp_name, 
        @t_debug                 = @t_debug,
        @t_trn                   = 14943, 
        @i_operacionpf           = @w_operacionpf,
        @i_fecha_proceso         = @w_fecha_hoy ,
        @i_secuencia             = @w_mm_secuencia2 ,
        @i_sub_secuencia         = @w_mm_sub_secuencia2,
        @i_en_linea              = 'S',
        @i_tipo                  = 'R'--,
        --@i_estado                = @w_mt_estado2

      if @w_return <> 0 begin
         exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = @w_return
         select @w_error = @w_return
         goto ERROR
      end 

      if exists(select 1 from cob_pfijo..pf_emision_cheque
	            where ec_fecha_mov = @s_date
				and  ec_secuencia     = @w_mm_secuencia2
				and  ec_operacion     = @w_operacionpf)
      begin
         update pf_emision_cheque set
		 ec_estado           = 'R',
		 ec_fecha_emision    = NULL
		 where ec_fecha_mov  = @s_date
		 and  ec_secuencia   = @w_mm_secuencia2
		 and  ec_operacion   = @w_operacionpf
      end  
   end   
end

if exists(select 1 from cob_pfijo..pf_emision_cheque
          where ec_fecha_mov    = @s_date
		  and  ec_secuencia     = @w_mm_secuencia2
		  and  ec_operacion     = @w_operacionpf
		  and  ec_estado        = 'A') 
begin

   -------------------------------------------------
   -- Reversar los comprobantes contables generados
   -------------------------------------------------
   exec @w_return = sp_aplica_conta
   @i_anulacion     = 'S',
   @i_operacionpf   = @w_operacionpf,
   @i_tipo_trn      = 'EOP',
   @i_fecha         = @s_date,
   @i_secuencia     = @w_mm_secuencia2
   if @w_return <> 0 begin
      rollback tran
      exec cobis..sp_cerror
      @t_from       = @w_sp_name,
      @i_num        = @w_return      
      return @w_return
   end
end

---------------------------
-- Actualizar pf_det_pago
---------------------------
set rowcount 0
update pf_det_pago
   set dp_estado = 'R'
where  dp_operacion  = @w_operacionpf
  and  dp_secuencial = @w_secuencial
  and  dp_tipo       = 'CAN'


if @w_tipo = 'A'
begin     
   if @w_estado_op = 'ACT'
   begin
      if @w_fpago='ANT' 
         select @w_int_no_ganados = @w_total_int_estimado - @w_total_int_ganado,
                @w_ttipo          = 'I'
      else 
         select @w_int_no_ganados = @w_int_ganado - @w_int_pagados,
                @w_ttipo          = 'T'
   end
end /* cancelacion anticipada  */
else 
begin 
   if @w_estado_op = 'ACT'
   begin
      if @w_fpago <> 'ANT' 
         select @w_int_no_ganados = @w_total_int_ganado - @w_total_int_pagados
   end
   else
         select @w_int_no_ganados = @w_total_int_ganado - @w_total_int_pagados
end 

-----------------------------------------------------
--  CONTABILIZACION DE  LA   OPERACION  
-----------------------------------------------------
if @v_estado = 'CAN'
begin
   set rowcount 0
   update pf_relacion_comp 
      set rc_estado = 'R'
    where rc_num_banco = @i_num_banco
      and rc_tran      = 'CAN' 
      and rc_estado    = 'N'

   update pf_scomprobante 
      set sc_estado = 'R'
     from pf_relacion_comp 
    where sc_comprobante = rc_comp
      and sc_estado      = 'I' 
      and rc_estado      = 'R' 
      and rc_tran        = 'CAN' 
      and rc_num_banco   = @i_num_banco

   if @@error  <> 0
   begin
      exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_num           = 143041
      select @w_error = 143041
      goto ERROR
   end

if @w_int_vencido > 0
begin
   exec @w_return = sp_aplica_conta
   @i_anulacion     = 'S',
   @i_operacionpf   = @w_operacionpf,
   @i_tipo_trn      = 'CAU',
   @i_fecha         = @s_date

   if @w_return <> 0 begin
      rollback tran
      exec cobis..sp_cerror
      @t_from          = @w_sp_name,
      @i_num           = @w_return
   
      return @w_return
   end
end   

   exec @w_return = sp_aplica_conta
   @i_anulacion     = 'S',
   @i_operacionpf   = @w_operacionpf,
   @i_tipo_trn      = 'CAN',
   @i_fecha         = @s_date

   if @w_return <> 0 begin
      rollback tran
      exec cobis..sp_cerror
      @t_from          = @w_sp_name,
      @i_num           = @w_return
   
      return @w_return
   end

     
      
/******************************************************************/
select @w_string = 'Despues de Aplica_conta'

end 
/******************************************************************/

------------------------------------------
--INSERCION DEL HISTORIAL 
------------------------------------------
insert pf_historia (hi_operacion,               hi_secuencial,                     hi_fecha,
                    hi_trn_code,                hi_valor,                          hi_funcionario, 
                    hi_oficina,                 hi_fecha_crea,                     hi_fecha_mod)
            values (@w_operacionpf,             @v_historia,                       @s_date,
                    @t_trn,                     @w_valor,                          @s_user, 
                    @s_ofi,                     @s_date,                           @s_date)

if @@error <> 0
begin
   exec cobis..sp_cerror
      @t_debug       = @t_debug,
      @t_file        = @t_file,
      @t_from        = @w_sp_name,
      @i_num         = 143006
   select @w_error = 143006
   goto ERROR
end
----------------------------------------------------------
-- Se actualiza cupones a su estado anterior 
----------------------------------------------------------
if @w_op_cupon = 'S'
begin
   select @w_cupon = 0
   set rowcount 1

   while 1 = 1
   begin
      select @w_cupon         = cu_cuota,
             @w_cu_estado     = cu_estado,
             @w_fecha_mod     = cu_fecha_mod,
             @w_cu_estado_ant = cu_estado_ant
        from pf_cuotas
       where cu_operacion     = @w_operacionpf
         and cu_cuota         > @w_cupon
         and cu_estado        = 'ANU'           

      if @@rowcount = 0
         break
      
      update pf_cuotas
         set cu_estado    = cu_estado_ant,
             cu_fecha_mod = @s_date
       where cu_operacion = @w_operacionpf
         and cu_cuota     = @w_cupon

      if @@error <> 0
      begin
         select @w_error = 145043
         goto ERROR
      end

      insert ts_cuotas (secuencial,           tipo_transaccion,              clase,            usuario, 
                        terminal,             srv,                           lsrv,             fecha, 
                        operacion,            cuota,                         fecha_mod,        estado)
                values (@s_ssn,               14146,                         'P',              @s_user, 
                        @s_term,              @s_srv,                        @s_lsrv,          @s_date, 
                        @w_operacionpf,       @w_cupon,                      @s_date,          'ANU')
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143005
         return 1                
      end

      insert ts_cuotas (secuencial,           tipo_transaccion,              clase,             usuario, 
                        terminal,             srv,                           lsrv,              fecha, 
                        operacion,            cuota,                         fecha_mod,         estado)
                values (@s_ssn,               14146,                         'A',               @s_user, 
                        @s_term,              @s_srv,                        @s_lsrv,           @s_date, 
                        @w_operacionpf,       @w_cupon,                      @s_date,           @w_cu_estado_ant)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 143005
         return 1
      end
   end
   set rowcount 0
end

delete from pf_det_pago_tmp 
where dt_usuario   = @s_user
  and dt_sesion    = @s_sesn
  and dt_operacion = @w_operacionpf
  
if @@error <> 0
   begin
       exec cobis..sp_cerror
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 143005
       select @w_error = 143005
       goto ERROR
   end 
   
COMMIT TRAN


return 0   
ERROR:
  rollback tran
  exec sp_errorlog @i_fecha    = @s_date,
                   @i_error    = @w_error, 
                   @i_usuario  = @s_user,
                   @i_tran     = @t_trn,
                   @i_cuenta   = @i_num_banco         
  commit tran
return @w_error
go
