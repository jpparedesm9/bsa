/************************************************************************/
/*     Archivo:                  cancela.sp                             */
/*     Stored procedure:         sp_cancela                             */
/*     Base de datos:            cob_pfijo                              */
/*     Producto:                 Plazo_fijo                             */
/*     Disenado por:             Myriam Davila                          */
/*     Fecha de documentacion:   21/Nov/94                              */
/************************************************************************/
/*                             IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     'MACOSA', representantes exclusivos para el Ecuador de la        */
/*     'NCR CORPORATION'.                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/*                             PROPOSITO                                */
/*     Este procedimiento almacenado realiza las actualizaciones        */
/*     necesarias para dar por terminada una operacion de Plazo Fijo    */
/*     cuando se ha cumplido  o no su plazo.                            */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*     FECHA       AUTOR               RAZON                            */
/*     21/Nov/94   Roxana Serrano      Emision Inicial                  */
/*     28/Ago/95   Carolina Alvarado   Grabacion definitiva de det_pago */
/*     03/Sep/01   Memito Saborfo      Busqueda del cliente debido al   */
/*     25/Abr/05   Katty Tamayo        Identaci=n y correcciones        */
/*     06/Oct/05   Luis Im             Inclusion correcta de registros  */
/*    15/Jul/2009 Y. Martinez NYM DPF00015 ICA     */
/*     05/Dic/2016 N. Martillo         Correccion errores preexistentes */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go
   
if exists (select 1 from sysobjects where name = 'sp_cancela')
   drop proc sp_cancela
go

create proc sp_cancela (
@s_ssn                   int         = NULL,
@s_ssn_branch            int         = NULL,
@s_user                  login       = NULL,
@s_sesn                  int         = NULL,
@s_term                  varchar(30) = NULL,
@s_date                  datetime    = NULL,
@s_srv                   varchar(30) = NULL,
@s_lsrv                  varchar(30) = NULL,
@s_ofi                   smallint    = NULL,
@s_rol                   smallint    = NULL,
@s_org                   char(1)     = null,    --LIM 23/ENE/2006 
@t_debug                 char(1)     = 'N',
@t_file                  varchar(10) = NULL,
@t_from                  varchar(32) = NULL,
@t_trn                   smallint,
@i_operacion             char(1),
@i_operacion_lote        cuenta      = NULL,
@i_num_banco             cuenta,
@i_solicitante           int,
@i_autorizado            login       = NULL,
@i_tasa_aut              float       = NULL,
@i_pen_monto             money       = 0,
@i_moneda_pg             char(2)     = NULL,
@i_int_vencido           money       = 0,    
@i_pen_porce             float       = NULL,
@i_primer_lote           char(1)     = 'N',
@i_ley                   char(1)     = NULL,
@i_comentario            descripcion = NULL,
@i_autoriza_pago_otros   login       = NULL,
@o_sec_comprobante       int         = NULL out,
@i_emite_orden           char(1)     = 'S',
@i_pen_porce_capital     float       = NULL, --GAP DP00034
@i_pen_monto_capital     money       = 0 ,    --GAP DP00034
@i_int_pagado            money       = 0,
@i_fecha_back            datetime    = null,
@i_back_value            char(1)     = 'N',
-- INI NYM DPF00015 ICA
@i_renta                 char(1)     = 'N',
@i_ica                   char(1)     = 'N',
@i_tasa_renta            money       = NULL,
@i_tasa_ica              money       = NULL,
@i_total_int_pagado      money       = NULL)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_codigo               int,
@w_oficina              int,
@w_operacionpf          int,
@w_tran_pin             int,
@w_tran_can             int,
@w_return               int,
@w_estado               catalogo,
@w_fpago                catalogo,
@w_accion_sgte          catalogo,
@w_tautorizacion        catalogo,
@w_mon_sgte             int,
@w_mon_sgt1             int,
@v_accion_sgte          catalogo,
@v_fecha_ven            datetime,
@w_fecha                datetime,
@w_fecha_crea           datetime,
@w_fecha_mod            datetime,
@v_fecha_mod            datetime,
@w_fecha_ven            datetime,
@w_fecha_valor          datetime,
@w_fecha_no_lab         datetime,
@w_fecha_hoy            datetime,
@w_fecha_pg_int         datetime,   
@v_fecha_pg_int         datetime,   
@w_monto_pg_int         money,
@w_monto_pg_in          money,
@w_monto_pg_in1         money,
@w_int_ganado           money,
@w_int_vencido          money,
@w_int_ven              money,
@w_int_pagados          money,
@w_val_renta            money,
@w_impven               money,
@w_int_cancelar         money,
@w_int_canc1            money,
@w_total_int_pagados    money,
@w_total_int_estimado   money,
@w_total_int_pagado     money,
@w_total_int_ganado     money,
@w_fecha_ult_pg_int     datetime,
@w_tasa                 float,
@w_moneda               smallint,
@w_numdeci              tinyint,
@w_usadeci              char(1),  
@w_pen_monto            money,
@w_pen_monto_capital    money,
@w_mm_sec_mov           int,
@w_tcapitalizacion      char(1),    --LIM 01/NOV/2005
@w_pen_cap_porce        float,          --LIM 04/NOV/2005
@w_instruccion          char(1),   --CVA May-06-06
@w_mt_tipo              catalogo,
@w_mt_beneficiario      int,
@w_mt_impuesto          money,
@w_mt_producto          catalogo,
@w_mt_cuenta            cuenta,
@w_mt_valor             money,
@w_mt_moneda            smallint,
@w_mt_valor_ext         money, 
@w_monto_renovar        money,
@w_monto                money,
@w_mt_fecha_crea        datetime,
@w_mt_fecha_mod         datetime, 
@w_mt_sub_secuencia     tinyint,
@w_mt_cotizacion        money, 
@w_mt_tipo_cotiza       char(1),
@w_mt_tipo_cliente      char(1),
@w_max                  smallint,
@w_sec                  int,
@w_cont                 int,
@w_tot_can              money, 
@w_monto_can            money, 
@w_toperacion           catalogo, 
@w_mantiene_stock       char(1),
@w_max_sub              tinyint, 
@w_sec_comprobante      int,
@w_mm_beneficiario      int,
@w_ente                 int,
@w_mt_sec_mov           int,
@w_mt_tipo_cuenta_ach   char(1),
@w_mt_oficina           int,         --CVA May-06-06
@w_mt_oficina_dest      int,         --LIM 08/OCT/2005
@w_mt_cod_banco_ach     smallint,
@w_benef_chq            varchar(255),
@w_pt_tipo              catalogo,
@w_pt_forma_pago        catalogo,
@w_pt_cuenta            cuenta,   
@w_pt_monto             money,
@w_pt_mon               money,
@w_pt_porcentaje        float,
@w_pt_secuencia         int,
@w_pt_fecha_crea        datetime, 
@w_pt_fecha_mod         datetime,
@w_pt_moneda_pago       smallint,
@w_pt_descripcion       varchar(255),
@w_pt_oficina           int,
@w_pt_tipo_cliente      char(1),
@w_pt_tipo_cuenta_ach   char(1),
@w_pt_banco_ach         descripcion,
@w_ley                  char(1),
@w_historia             int,
@w_fecha_valor_can      datetime,   --LIM 29/NOV/2005
-- INI NYM DPF00015 ICA
@w_mt_ica               money,      
@w_impven_ica           money,
@w_val_ica              money,
@w_total_renta          money,
@w_total_ica            money,
@w_monto_renta          decimal(30,6),
@w_monto_ica            decimal(30,6),
@w_porcen_pago          decimal(30,6),
@w_acum_renta           money,
@w_acum_ica             money,
@w_contador             int,
-- FINI NYM DPF00015 ICA
@w_mt_subtipo_ins       int,          -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
@w_descripcion          descripcion,
@w_comprobante		int,
@w_tplazo		varchar(10),
@w_tipo_deposito        int,
@w_num_dias             int


select @w_sp_name = 'sp_cancela',
       @w_mt_sub_secuencia = 0, 
       @w_fecha   = convert(datetime, convert(varchar, @s_date, 101))
       

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

select 
   ct_moneda     as uc_moneda, 
   max(ct_fecha) as uc_fecha
into #ult_cotiz
from cob_conta..cb_cotizacion
group by ct_moneda
       

insert into #cotizacion
select ct_moneda, ct_valor
from   cob_conta..cb_cotizacion, #ult_cotiz
where ct_moneda = uc_moneda
and   ct_fecha  = uc_fecha


-------------------------------
-- Validacion de la Transaccion
------------------------------- 
if @t_trn <> 14903
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
        -- 'Error en codigo de transaccion'
   return 1
end

-----------------------------
-- Validacion de la Operacion
----------------------------- 
if @i_operacion not in ('N','A')
begin 
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141004
        -- 'Operacion no existe'
   return 1
end


select @w_operacionpf        = op_operacion,
       @w_estado             = op_estado,
       @w_oficina            = op_oficina,
       @w_fpago              = op_fpago, 
       @w_fecha_ven          = op_fecha_ven,
       @w_fecha_valor        = op_fecha_valor,
       @w_accion_sgte        = op_accion_sgte,
       @w_mon_sgte           = op_mon_sgte,
       @w_fecha_mod          = op_fecha_mod ,
       @w_monto_pg_int       = op_monto_pg_int,
       @w_monto              = op_monto,
       @w_monto_pg_in1       = op_monto_pg_int,
       @w_toperacion         = op_toperacion,
       @w_tplazo	     = op_tipo_plazo ,	--*-*
       @w_int_ganado         = op_int_ganado,
       @w_int_pagados        = op_int_pagados,
       @w_historia           = op_historia,
       @w_moneda             = op_moneda,
       @w_total_int_pagados  = op_total_int_pagados,
       @w_total_int_ganado   = op_total_int_ganados,
       @w_total_int_estimado = op_total_int_ganados,
       @w_fecha_ult_pg_int   = op_fecha_ult_pg_int,
       @w_fecha_pg_int       = op_fecha_pg_int,
       @w_ley                = op_ley,
       @w_fecha_ven          = op_fecha_ven,
       @w_ente               = op_ente,
       @w_tcapitalizacion    = op_tcapitalizacion     --LIM 01/NOV/2005
  from pf_operacion
 where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
   return 1
end


select @w_mantiene_stock = td_mantiene_stock,
       @w_tipo_deposito = isnull(td_tipo_deposito,0)
  from pf_tipo_deposito
 where td_mnemonico = @w_toperacion


exec sp_primer_dia_labor
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_fecha = @s_date,
     @s_ofi   = @s_ofi,
     @i_tipo_deposito = @w_tipo_deposito,
     @o_fecha_labor = @w_fecha_no_lab out

if (datediff(dd,@s_date,@w_fecha_no_lab) <> 0 and @i_operacion = 'A') or
   (datediff(dd,@s_date,@w_fecha_no_lab) <> 0 and @w_estado = 'VEN' and @i_operacion = 'N') 
begin     
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141004
   return 1
end


if @i_moneda_pg is null 
   select @i_moneda_pg = convert(char(2),@w_moneda)

-----------------------------------
-- Encuentra parametro de decimales
-----------------------------------
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


if @i_operacion = 'A' 
   select @w_num_dias = datediff(dd,@w_fecha_valor,@s_date) --Cancelacion anticipada dias transcurridos para el calculo de impuesto

select @i_moneda_pg = isnull(@i_moneda_pg,@w_moneda)

select @v_accion_sgte  = @w_accion_sgte,
       @v_fecha_ven    = @w_fecha_ven,
       @v_fecha_pg_int = @w_fecha_pg_int,
       @v_fecha_mod    = @w_fecha_mod,
       @w_val_renta     = 0,
       @w_impven       = 0,
       @w_int_cancelar = 0,
       @w_int_vencido  = 0,
       @w_max_sub      = 0         


if @w_estado not in ('ACT', 'VEN','PEN')       
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141031
   return 1
end



if (@i_operacion = 'A') or (@i_operacion = 'N' and @w_estado in ('VEN','PEN')) or 
   (@i_operacion = 'N' and @w_estado = 'ACT' and @w_fecha_ven <= @w_fecha)
   select  @w_instruccion = 'N'  
else
   select  @w_instruccion = 'S'  


begin tran         --LIM 13/OCT/2005
---------------------
-- Cancelacion normal
---------------------
if @i_operacion in ('N','A') 
begin
   -------------------------------------------------
   -- Inicializaci=n de variables para pf_mov_monet          
   -------------------------------------------------
   select @w_cont = 0  
   select @w_mm_sec_mov = isnull(max(mm_sec_mov),0)+1
   from   pf_mov_monet
   where  mm_operacion = @w_operacionpf
   
   select @w_mm_sec_mov = isnull(@w_mm_sec_mov,0)+1

   select @w_mt_sub_secuencia = 0,
      @w_tot_can          = 0 
   ------------------------------------------------
   -- Inicializaci=n de variables para pf_det_pago
   ------------------------------------------------  

   -- NYM DPF00015 ICA
   select  @w_acum_renta   = 0
   select  @w_acum_ica  = 0
   select   @w_contador = 0
   -- NYM DPF00015 ICA

   while 1 = 1
   begin
      set rowcount 1
      select  @w_mt_producto    = mt_producto,
         @w_mt_sub_secuencia    = mt_sub_secuencia,
         @w_mt_tipo             = mt_tipo,
         @w_mt_beneficiario     = mt_beneficiario,
         @w_mt_impuesto         = mt_impuesto,
         @w_mt_cuenta           = mt_cuenta,
         @w_mt_valor            = mt_valor,
         @w_mt_valor_ext        = mt_valor_ext,
         @w_mt_moneda           = mt_moneda,
         @w_mt_fecha_crea       = mt_fecha_crea,
         @w_mt_fecha_mod        = mt_fecha_mod,
         @w_mt_tipo_cliente     = mt_tipo_cliente,
         @w_mt_cotizacion       = mt_cotizacion,
         @w_mt_tipo_cotiza      = mt_tipo_cotiza,
         @w_mt_sec_mov          = mt_sec_mov,
         @w_mt_tipo_cuenta_ach  = mt_tipo_cuenta_ach,
         @w_mt_oficina_dest     = mt_oficina,         --LIM 08/OCT/2005
         @w_mt_cod_banco_ach    = mt_cod_banco_ach,   --LIM 19/NOV/2005
         @w_benef_chq           = mt_benef_corresp,
         @w_mt_ica              = mt_ica,             -- NYM DPF00015 ICA
         @w_mt_subtipo_ins      = mt_subtipo_ins      -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
      from pf_mov_monet_tmp
      where mt_usuario       = @s_user 
      and   mt_sesion        = @s_sesn
      and   mt_operacion     = @w_operacionpf 
      and   mt_sub_secuencia > @w_mt_sub_secuencia
      order by mt_sub_secuencia
                         
      if @@rowcount = 1
      begin                       
         select @w_cont    = @w_cont + 1,
            @w_tot_can = @w_tot_can + @w_mt_valor        

         select @w_mt_oficina = @w_mt_oficina_dest  --CVA May-06-06
         select @w_mt_valor = round(@w_mt_valor, @w_numdeci)
         select @w_mt_valor_ext = round(@w_mt_valor_ext, @w_numdeci)

         --------------------------------------------------------------------
         -- Traslada los datos a la tabla definitiva - Actualiza pf_mov_monet 
         --------------------------------------------------------------------
         if @i_back_value = 'S'           --LIM 19/NOV/2005
            select @w_fecha_valor_can = @i_fecha_back
         else
            select @w_fecha_valor_can = @s_date

      
         --INI  NYM DPF00015 ICA
         if @w_cont = 1
         begin
            select @w_total_renta = round(@w_mt_impuesto, @w_numdeci)
            select @w_total_ica = round(@w_mt_ica, @w_numdeci)
         end
         select @w_porcen_pago   = @w_mt_valor / @i_total_int_pagado

         --print 'cancela @w_porcen_pago %1! , @w_mt_valor %2! , @i_total_int_pagado %3!  ', @w_porcen_pago, @w_mt_valor, @i_total_int_pagado

         select @w_monto_renta   = round((@w_porcen_pago * @w_total_renta ) ,@w_numdeci)

         --print 'cancela @w_monto_renta %1! , @w_porcen_pago %2! , @w_total_renta %3!  ', @w_monto_renta, @w_porcen_pago, @w_total_renta

         select @w_monto_ica  = round((@w_porcen_pago * @w_total_ica ) ,@w_numdeci)

         --print 'cancela @w_monto_ica %1! , @w_porcen_pago %2! , @w_total_ica %3!  ', @w_monto_ica, @w_porcen_pago, @w_total_ica



         select   @w_contador = isnull(count(1),0)
         from  pf_mov_monet_tmp
         where    mt_usuario       = @s_user 
         and   mt_sesion        = @s_sesn
         and   mt_operacion     = @w_operacionpf 
         and   mt_sub_secuencia > @w_mt_sub_secuencia

         --print ' cancela @w_contador %1! ', @w_contador

         if @w_contador = 0 
         begin
            select @w_monto_renta      = @w_total_renta - @w_acum_renta    
            select @w_monto_ica     = @w_total_ica - @w_acum_ica     
         end

         --print 'cancela  inserta movmonet @w_monto_renta %1! @w_monto_ica %2! ', @w_monto_renta, @w_monto_ica


         --FINI  NYM DPF00015 ICA
         
         insert into pf_mov_monet (
            mm_operacion,        mm_tran,               mm_secuencia,        mm_secuencial,
            mm_sub_secuencia,    mm_producto,           mm_cuenta,           mm_valor,
            mm_tipo,             mm_beneficiario,       mm_impuesto,         mm_moneda,
            mm_valor_ext,        mm_fecha_crea,         mm_fecha_mod,        mm_user, 
            mm_tipo_cliente,     mm_cotizacion,         mm_tipo_cotiza,      mm_sec_mov,
            mm_usuario,          mm_tipo_cuenta_ach,    mm_cod_banco_ach,                       --LIM 19/NOV/2005
            mm_oficina_pago,     mm_oficina,            mm_fecha_valor,      mm_benef_corresp,  --LIM 19/NOV/2005
            mm_ica,              mm_subtipo_ins )                                               -- NYM DPF00015 ICA  -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
         values (
            @w_operacionpf,      @t_trn,                @w_mon_sgte,         0, 
            @w_mt_sub_secuencia, @w_mt_producto,        @w_mt_cuenta,        @w_mt_valor, 
            @w_mt_tipo,          @w_mt_beneficiario,    @w_monto_renta,      @w_mt_moneda, 
            @w_mt_valor_ext,     @s_date,               @s_date,             @s_user, 
            @w_mt_tipo_cliente,  @w_mt_cotizacion,      @w_mt_tipo_cotiza,   @w_mm_sec_mov,
            @s_user,             @w_mt_tipo_cuenta_ach, @w_mt_cod_banco_ach,                  --LIM 19/NOV/2005 se remplaza nomb. banco por cod. banco ach
            @w_mt_oficina_dest,  @w_mt_oficina,         @w_fecha_valor_can,  @w_benef_chq,    --LIM 19/NOV/2005
            @w_monto_ica,        @w_mt_subtipo_ins)                                           --NYM DPF00015 ICA -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM

         /* Si no se puede insertar, error */
         if @@error <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @i_num   = 143022
            return 1
         end 

                  -- NYM DPF00015 ICA
         select @w_acum_renta    = @w_acum_renta + @w_monto_renta
         select @w_acum_ica   = @w_acum_ica + @w_monto_ica
                  -- NYM DPF00015 ICA

         --print ' cancela total @w_acum_renta %1! @w_acum_ica %2! ', @w_acum_renta, @w_acum_ica


         -----------------------------------------------------
         -- Actualizaci=n de Secuenciales para transferencias
         -----------------------------------------------------
         if @w_mt_producto = 'TRANS' 
         begin
            set rowcount 0
            update pf_transferencias_tmp
            set    tr_sec_mov       = @w_mm_sec_mov,
               tr_act_sec_mm    = 'S' -- GAR Actualiz= el secuencial
            where  tr_cod_operacion = @w_operacionpf
               and  tr_sec_mov       = @w_mt_sec_mov -- GAR para atar con la transferencia
               and  tr_act_sec_mm    = 'N'
               and  tr_tipo_pago     = 'N' --tipo de pago cancelacion
               and  tr_estado       <> 'R' --Estado reversado
            set rowcount 1
         
         end
         
         select @w_mm_sec_mov = @w_mm_sec_mov + 1        
         insert into ts_mov_monet (secuencial,         tipo_transaccion, clase,        fecha,
            usuario,            terminal,         srv,          lsrv,
            operacion,          transaccion,      secuencia,    sub_secuencia,
            producto,           cuenta,           valor,        tipo,
            beneficiario,       impuesto,         moneda,       valor_ext,
            fecha_crea,         fecha_mod,        estado,      ica)  -- NYM DPF00015 ICA
         values  (@s_ssn,             @t_trn,           'N',          @s_date, 
            @s_user,            @s_term,          @s_srv,       @s_lsrv,
            @w_operacionpf,     @t_trn,           @w_mon_sgte,  @w_mt_sub_secuencia,
            @w_mt_producto,     @w_mt_cuenta,     @w_mt_valor,  @w_mt_tipo,
            --@w_mt_beneficiario, @w_mt_impuesto,   @w_mt_moneda, @w_mt_valor_ext, 
            0, @w_mt_impuesto,   @w_mt_moneda, @w_mt_valor_ext, 
            @s_date,            @s_date,          null,     @w_mt_ica)  -- NYM DPF00015 ICA
                                      
         if @@error <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
            return 1
         end  
                 
         -----------------------------------------
         -- Borra el registro de la tabla temporal
         -----------------------------------------
         delete from pf_mov_monet_tmp
         where mt_usuario       = @s_user 
            and mt_sesion        = @s_sesn
            and mt_operacion     = @w_operacionpf 
            and mt_sub_secuencia = @w_mt_sub_secuencia
         
         if @@error <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 147022
            return 1
         end
      end /** Fin de If rowcount = 1 **/
      else 
         if (@w_cont = 0  and @w_mantiene_stock='N') or (@w_cont = 0  and @w_mantiene_stock='S' and @i_primer_lote = 'S')
         begin  
            exec cobis..sp_cerror
               @t_debug = @t_debug, 
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141036
               -- 'No existen mas registros'
            return 1
            break          --LIM 06/OCT/2005
         end
         else
         begin
            set rowcount 0
            break
         end
   end   /** End del while **/

   select @w_tot_can           = round(@w_tot_can, @w_numdeci)
   select @w_monto_pg_in       = round(@w_monto_pg_int, @w_numdeci)
   select @w_monto_pg_in1      = round(@w_monto_pg_in1, @w_numdeci)
   select @w_int_ganado        = round(@w_int_ganado, @w_numdeci)  
   select @w_int_pagados       = round(@w_int_pagados, @w_numdeci)
   select @w_total_int_pagado  = round(@w_total_int_pagados, @w_numdeci)
   select @w_int_ven           = round(@i_int_vencido, @w_numdeci)
   select @w_pen_monto         = round(@i_pen_monto, @w_numdeci)
   select @w_pen_monto_capital = round(@i_pen_monto_capital, @w_numdeci)
   select @w_pen_cap_porce     = round(@i_pen_porce_capital,   @w_numdeci)

--*-* GENERA CONTABLE DE PROVISION PARA DIAS VENCIDOS , ESTE NO SE REGISTRA EN PF_PROV_DIA
   if @w_int_ven > 0
   begin
	select @w_descripcion = 'PROV-DIAS-VEN ('+@i_num_banco+')'   
	exec @w_return = cob_pfijo..sp_aplica_conta
		@s_ssn         = @s_ssn,
		@s_date        = @s_date,
		@s_user        = @s_user,
		@s_term        = @s_term,
		@s_ofi         = @s_ofi,
		@t_debug       = @t_debug,
		@t_file        = @t_file,
		@t_from        = @t_from,
		@t_trn            = 14937,
		@i_empresa        = 1,
		@i_fecha          = @s_date,
		@i_tran           = 14926,
		@i_producto       = 14,   /* op_producto de pf_operacion */
		@i_oficina_oper   = @w_oficina,
		@i_oficina        = @w_oficina, 
		@i_toperacion     = @w_toperacion,/*op_toperacion de pf_operacion */
		@i_tplazo         = @w_tplazo, /* Nemonico del tipo de plazo */ 
		@i_operacionpf    = @w_operacionpf,
		@i_estado         = @w_estado ,
		@i_valor          = @w_int_ven, 
		@i_moneda         = @w_moneda, 
		@i_afectacion     = 'N',  /* N=Normal,  R=Reverso  */
		@i_descripcion    = @w_descripcion,
		@i_codval         = '18',           /* Codigo de valor para el detalle */ --cambia el tipo de dato a varchar
		@i_movmonet       = '1',
		@i_debcred        = '1',           /* Si es debito = 1 o credito = 2 */ 
		@o_comprobante    = @w_comprobante out
	if @w_return <> 0
	begin
		exec cobis..sp_cerror 
			@t_debug     = @t_debug,
			@t_file      = @t_file,
			@t_from      = @w_sp_name,
			@i_num       = 143041
			rollback tran
		return 143041
	end
    end


      insert pf_cancelacion (ca_operacion,   ca_funcionario,  ca_oficina,           ca_pen_monto,
         ca_pen_porce,   ca_secuencial,   ca_solicitante,       ca_tipo,
         ca_estado,      ca_comentario,   ca_fecha_crea,        ca_fpago,  
         ca_fecha_ven,   ca_fecha_pg_int, ca_accion_sgte,       ca_estado_op,  
         ca_autorizado,  ca_fecha_mod,    ca_valor,             ca_monto_pg_int,
         ca_int_ganado,  ca_int_pagados,  ca_total_int_pagados, ca_fecha_ult_pg_int,
         --ca_int_vencido, ca_oficina_ant)
         ca_int_vencido, ca_oficina_ant,  ca_pen_capital      , ca_pen_cap_porce)
      values (@w_operacionpf, @s_user,         @s_ofi,               @w_pen_monto,
         @i_pen_porce,   @w_mon_sgte,     @i_solicitante,       @i_operacion,
         'I',            @i_comentario,   @s_date,              @w_fpago,
         @w_fecha_ven,   @w_fecha_pg_int, @w_accion_sgte,       @w_estado,
         @i_autorizado,  @s_date,         @w_tot_can,           @w_monto_pg_in1,
         @w_int_ganado,  @w_int_pagados,  @w_total_int_pagado,  @w_fecha_ult_pg_int,
         @w_int_ven,     @w_oficina   ,  @w_pen_monto_capital     ,  @w_pen_cap_porce) --LIM 04/NOV/2005
      /* Si no se puede insertar, error */
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143039
         return 1
      end 
      
      insert into ts_cancelacion (secuencial,     tipo_transaccion, clase,          fecha,
         usuario,        terminal,         srv,            lsrv,
         operacion,      funcionario,      oficina,        pen_monto,
         pen_porce,      secuencia,        solicitante,    tipo,
         estado,         comentario,       fecha_crea,     fpago,
         fecha_ven,      fecha_pg_int,     accion_sgte,    estado_op,
         autorizado,     fecha_mod,        valor )
      values  (@s_ssn,         @t_trn,           'N',            @s_date, 
         @s_user,        @s_term,          @s_srv,         @s_lsrv,
         @w_operacionpf, @s_user,          @s_ofi,         @w_pen_monto,
         @i_pen_porce,   @w_max,           @i_solicitante, @i_operacion,
         'I',            @i_comentario,    @s_date,        @w_fpago,
         @w_fecha_ven,   @w_fecha_pg_int,  @w_accion_sgte, @w_estado,
         @i_autorizado,  @s_date,          @w_tot_can)           
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143005
         return 1
      end

   if @i_autoriza_pago_otros IS NOT NULL --GAR 21-feb-2005 DP00036
   begin
      insert pf_autorizacion (au_operacion,     au_autoriza,            au_oficina,
         au_tautorizacion, au_fecha_crea,          au_num_banco, au_oficial)
      values (@w_operacionpf,   @i_autoriza_pago_otros, @s_ofi,
         'PGOC',           @s_date,                @i_num_banco, @s_user)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143040
         return 1
      end
   end
    
   if @w_mantiene_stock = 'N' and @w_fpago <> 'ANT'
      select @w_int_cancelar = @w_total_int_estimado - @w_total_int_pagados
   

   --INI NYM DPF00015 ICA
   if @w_int_cancelar > 0
   begin
      select @w_int_canc1 = @w_int_cancelar - @w_pen_monto
      if @i_renta = 'S' 
         select @w_val_renta = round(@w_int_canc1*@i_tasa_renta/100 , @w_numdeci)
      if @i_ica = 'S'
            select @w_val_ica = round(@w_int_canc1*@i_tasa_ica/100 , @w_numdeci)
   end

   --print 'NYM Cancela @w_int_cancelar %1! @i_renta %2! @i_tasa_renta %3! , @w_val_renta %4! ', @w_int_cancelar, @i_renta, @i_tasa_renta, @w_val_renta
   --print 'NYM Cancela @@w_int_canc1 %1! @w_pen_monto %2! @i_ica %3! , @i_tasa_ica %4! @@w_val_ica %5! ', @w_int_canc1, @w_pen_monto, @i_ica, @i_tasa_ica, @w_val_ica
   
   if @i_int_vencido > 0
   begin
      if @i_renta='S' 
         select @w_impven = @i_int_vencido*@i_tasa_renta/100
      if @i_ica = 'S'
         select @w_impven_ica = @i_int_vencido*@i_tasa_ica/100 
   end
   --FINI NYM DPF00015 ICA


   select @w_int_cancelar = @w_int_cancelar - @w_val_renta - @w_val_ica,
      @w_int_vencido  = @i_int_vencido - @w_impven - @w_impven_ica

   --select @w_monto_pg_int = @w_monto_pg_int + @w_int_cancelar + @w_int_vencido - @w_pen_monto
   if @w_tcapitalizacion = 'S'                                          --LIM 01/NOV/2005
      select @w_monto_pg_int = @w_monto_pg_int + @w_int_cancelar  - @w_pen_monto    --LIM 28/OCT/2005 Global no paga int. vencidos
   else
      select @w_monto_pg_int = @w_monto_pg_int - @w_pen_monto                    --LIM 01/NOV/2005 

   select @w_monto_pg_int = round(@w_monto_pg_int, @w_numdeci)

    -------------------------------------------
    -- Control para instruccion de cancelacion 
    -------------------------------------------
    if (@w_estado='ACT' and @w_accion_sgte='NULL') or (@w_estado='VEN' and @w_accion_sgte='NULL') 
        select @w_accion_sgte = 'XCAN'
    else
    begin
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141131
       return 141131
    end            
    
   --------------------------------------------------
   -- Actualizacion de la accion sgte de la operacion
   --------------------------------------------------
   update pf_operacion
       set op_accion_sgte = @w_accion_sgte,
           op_mon_sgte    = op_mon_sgte + 1,
           op_fecha_mod   = @s_date,
           op_moneda_pg   = @i_moneda_pg,
           op_historia    = op_historia +1,
           op_retienimp   = @i_renta ,
           op_ica         = @i_ica
    where op_operacion   = @w_operacionpf 
   /* Si no se puede modificar, error */
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 145001
      return 1
   end
   
   -----------------------------------------
   -- transaccion de Servicio - pf_operacion
   -----------------------------------------
   insert into ts_operacion (secuencial,     tipo_transaccion, clase,      fecha,
      usuario,        terminal,         srv,        lsrv,
      accion_sgte,    mon_sgte,         fecha_mod)
   values (@s_ssn,         @t_trn,           'N',        @s_date, 
      @s_user,        @s_term,          @s_srv,     @s_lsrv,
      @v_accion_sgte, @w_mon_sgte,      @v_fecha_mod)
   if @@error <> 0  
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143005
      return 1
   end

   --NYM DPF00015 ICA   PENDIENTE EVALUAR SI SE NESCESITA
   /*
   if (@i_operacion = 'N' and @w_estado = 'VEN' and @i_tasa_aut > 0.000001) or @i_operacion = 'A'
   begin
      if @i_operacion = 'N' and @w_estado = 'VEN'
         select @w_tautorizacion = 'PGIV'
      else
         select @w_tautorizacion = 'CAAN'

      if @i_autorizado is not null 
      begin
         --GAR 21-feb-2005 DP00036 Inserta solo si existe un autorizador
         insert pf_autorizacion (au_operacion,     au_autoriza,   au_adicional, au_oficina,
            au_tautorizacion, au_fecha_crea, au_num_banco, au_oficial)
         values (@w_operacionpf,   @i_autorizado, @i_tasa_aut,  @s_ofi,
            @w_tautorizacion, @s_date,       @i_num_banco, @s_user) 
         if @@error <>0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143040
            return 1
         end         
      end /* Autorizacion por pago de intereses vencido o canc. anticipada */ 
   end
   */
   
end /* END de if operacion = 'N' or 'A' */


--print 'cancela 3 @w_fecha_ven %1! , @w_fecha %2! @i_operacion %3! @w_estado %4! ', @w_fecha_ven, @w_fecha, @i_operacion, @w_estado

if @w_instruccion = 'S' --instruccion de cancelacion
begin  
    insert pf_historia (hi_operacion,   hi_secuencial,   hi_fecha,
      hi_trn_code,    hi_valor,        hi_funcionario,
      hi_oficina,     hi_fecha_crea,   hi_fecha_mod) 
   values (@w_operacionpf, @w_historia,     @s_date,
      14140,          @w_monto_pg_int, @s_user, 
      @s_ofi,         @s_date,         @s_date)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143006
      return 143006
   end

end
else
begin
   select @w_fecha_hoy = convert(datetime, convert (varchar,@s_date,101))
      
   ----------------------
   -- Ejecuta Cancelacion
   ----------------------
   exec @w_return           = sp_cancelacion_op
      @s_ssn              = @s_ssn,
      @s_ssn_branch       = @s_ssn_branch,  
      @s_user             = @s_user,
      @s_ofi              = @s_ofi,
      @s_date             = @s_date,
      @s_srv              = @s_srv,
      @s_lsrv             = @s_lsrv,
      @s_term             = @s_term,
      @s_rol              = @s_rol,
      @s_sesn             = @s_sesn,   --LIM 20/ENE/2006
      @s_org              = @s_org,
      @t_debug            = @t_debug,
      @t_file             = @t_file,
      @t_from             = @t_from,
      @t_trn              = 14903,
      @i_fecha_proceso    = @w_fecha_hoy,
      @i_num_banco        = @i_num_banco,
      @i_tasa             = @w_tasa,
      @i_numdeci          = @w_numdeci,
      @i_mantiene_stock   = @w_mantiene_stock,
      @i_tipo             = @i_operacion,
      @i_penalizacion     = @w_pen_monto,
      @i_emite_orden      = @i_emite_orden,
      @i_penaliza_capital = @i_pen_monto_capital,
      @i_int_pagado       = @i_int_pagado,
      @i_fecha_back       = @i_fecha_back,
      @i_back_value       = @i_back_value
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 149016
      
      delete pf_mov_monet_tmp
      where mt_usuario = @s_user 
      and mt_sesion    = @s_sesn
      and mt_operacion = @w_operacionpf  
      
      delete pf_det_pago_tmp
      where dt_usuario   = @s_user 
        and dt_sesion    = @s_sesn
        and dt_operacion = @w_operacionpf  
      
      return  149016
   end
end 

  
exec @w_return    = cobis..sp_cseqnos
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_tabla     = 'pf_cancelacion',
   @o_siguiente = @w_sec_comprobante out

if @w_return <> 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 147038
   return 147038
end

select @w_sec_comprobante

commit tran
return 0   
go
