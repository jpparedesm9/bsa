 /************************************************************************/
/*     Archivo:                cancelop.sp                              */
/*     Stored procedure:       sp_cancelacion_op                        */
/*     Base de datos:          cobis                                    */
/*     Producto:               Plazo Fijo                               */
/*     Disenado por:           Miryam Davila                            */
/*     Fecha de documentacion: 24/Oct/94                                */
/************************************************************************/
/*                             IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     'MACOSA', representantes exclusivos para el Ecuador de la        */
/*     'NCR CORPORATION'.                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/************************************************************************/
/*                             PROPOSITO                                */
/*     Este script crea el Procedimiento para la cancelacion.           */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*     FECHA        AUTOR              RAZON                            */
/*     03-Jul-2009  Y. Martinez        NYM PF00013 IEECOLBM             */
/*     03-Jul-2009  Y. Martinez        NYM PF00015 ICA                  */
/*     03-Jul-2009  Y. Martinez        NYM PF00016 CERTRET              */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_cancelacion_op' and type = 'P')
   drop proc sp_cancelacion_op
go
create proc sp_cancelacion_op(
@s_ssn                int         = NULL,
@s_ssn_branch         int         = null,
@s_user               login       = NULL,
@s_term               varchar(30) = NULL,
@s_date               datetime    = NULL,
@s_srv                varchar(30) = NULL,
@s_lsrv               varchar(30) = NULL,
@s_ofi                smallint    = 1,
@s_rol                smallint    = NULL,
@s_sesn               int         = NULL,    --LIM 20/ENE/2006
@s_org                char(1)     = null,    --LIM 23/ENE/2006
@t_debug              char(1)     = 'N',
@t_file               varchar(10) = NULL,
@t_from               varchar(32) = NULL,
@t_trn                int         = NULL,
@i_en_linea           char(1)     = 'S',
@i_numdeci            tinyint     = 0,
@i_tasa               float       = 0,
@i_mantiene_stock     char(1)     = NULL,
@i_tipo               char(1)     = 'N',
@i_penalizacion       money       = 0,
@i_fecha_proceso      datetime,
@i_num_banco          cuenta,
@i_empresa            tinyint     = 1,
@i_emite_orden        char(1)     = 'S',
@i_penaliza_capital   money       = 0,
@i_idlote             int         = 0,
@i_int_pagado         money       = 0,
@i_fecha_back         datetime    = null,
@i_back_value         char(1)     = 'N')
with encryption  
as
declare @w_sp_name               descripcion,
        @w_string                varchar(30),
        @w_descripcion           varchar(150),
        @w_empresa               tinyint,
        @w_filial                tinyint,
        @w_ofi_org               int,
        @w_ofi_ing               int,
        @w_return                int,
        @w_fecha_hoy             datetime,
        @w_fecha                 datetime,
        @w_secuencial            int,
        @w_secuencia             int,
        @w_error                 int,
        @w_money                 money,
        @w_impuesto              money,
        @w_impvenc               money,
        @w_monto                 money,
        @w_total_cancel          money,
        @w_total_op              money,
        @w_int_total             money,
        @w_imp_total             money,
        @w_int_cancelar          money,
        @w_int_canc1             money,
        @w_afec                  char(1),
        @w_tipo                  char(1),
        @w_base_imp              money,
        @w_ret_paga_int          varchar(30),
        @w_numdeci               tinyint,
        @w_usadeci               char(1),
        @w_mantiene_stock        char(1),
        @w_valor_act             money,
        @w_valor_act_tot         money,
        @w_tipo_cotiza           char(1),
        @w_cotizacion            money,
        @w_cotizacion_compra_b   money,
        @w_cotizacion_conta      money,
        @w_cotizacion_venta_b    money,
        @w_pen_capital           money,        --LIM 04/NOV/2005
        @w_mm_oficina            smallint,     --LIM 14/NOV/2005
        @w_monto_cancel          money,

        ------------------------------
        -- VARIABLES PARA PF_OPERACION
        ------------------------------
        @w_num_banco             cuenta,
        @w_operacionpf           int,
        @w_toperacion            catalogo,
        @w_categoria             catalogo,
        @w_accion_sgte           catalogo,
        @w_estado                catalogo,
        @w_tplazo                catalogo,
        @w_producto              tinyint,
        @w_fpago                 catalogo,
        @w_monto_blq             money,
        @w_monto_pg_int          money,
        @w_int_estimado          money,
        @w_int_ganado            money,
        @w_int_pagado            money,
        @w_int_vencido           money,
        @w_total_int_estimado    money,
        @w_tot_int_pag           money,
        @w_total_int_ganado      money,
        @w_total_int_pagados     money,
        @w_tasa                  float,
        @w_op_tasa               float,

        @w_int_no_ganados        money,
        @w_fecha_valor           datetime,
        @w_fecha_ingreso         datetime,
        @w_fecha_ven             datetime,
        @w_fecha_can             datetime,
        @w_moneda                tinyint,
        @w_historia              smallint,
        @w_pignorado             char(1),
        @w_ley                   char(1),
        @w_retieneimp            char(1),
        @w_fecha_mod             datetime,
        @w_causa_mod             catalogo,
        @w_fecha_cal_tasa        datetime,
        @v_historia              smallint,
        @v_estado                catalogo,
        @v_fecha_mod             datetime,
        @v_causa_mod             catalogo,
        ---------------------------------
        -- VARIABLES PARA PF_BENEFICIARIO
        ---------------------------------
        @w_be_ente               int,
        @w_be_producto           catalogo,
        @w_be_cuenta             cuenta,
        @w_be_porcentaje         float,
        ------------------------------
        -- VARIABLES PARA PF_MOV_MONET
        ------------------------------
        @w_mm_secuencia          int,
        @w_mm_sub_secuencia      tinyint,
        @w_mm_cuenta             cuenta,
        @w_mm_valor              money,
        @w_mm_impuesto           money,
        @w_mm_producto           catalogo,
        @w_pen_monto             money,
        @w_pen_porce             float,
        @w_penal                 money,
        @o_comprobante           int,
        @w_mm_moneda             smallint,
        @w_mm_valor_ext          money,
        -------------------------------
        -- Variables de Comp. retencion
        -------------------------------
        @w_factor                float,
        @w_concepto              varchar(40),
        @w_retenido              money,
        @w_gravado               money,
        @w_ente                  int,
        @w_retiene_capital       char (1),
        @w_cero                  char (1),
        @w_cupon                 tinyint,
        @w_op_cupon              char(1),
        @w_cu_estado             catalogo,
        @w_moneda_base           tinyint,
        --------------------------------------
        -- Variables para Servicios Bancarios
        --------------------------------------
        @w_tasa_var              varchar(20),  --Tasa
        @w_monto_var             varchar(30),  --Saldo Capital
        @w_producto_fpago        tinyint,
        @w_area_contable         int,
        @w_numero                int,
        @w_campo1                varchar(20),
        @w_campo47               descripcion,
        @w_campo48               descripcion,
        @w_mm_tran               int,
        @w_cheque_ger            catalogo,
        @w_secuencial_cheque     int,
        @w_mm_beneficiario       int,
        @w_cod_ben               varchar(255), /*  RLINARES 02222007 */
        @w_descripbenef          varchar(250),
        @w_origen_ben            varchar(1),  /*  RLINARES 02222007 */
        @w_campo40               char(1),
        @w_idlote                int,
        @w_conceptosb            tinyint,
        @w_ajuste_int            money,
        @w_fecha_valor_cte       datetime,
        @w_comprobante           int,
        @w_contador              int,
        @w_debcred               char(1),
        @w_asiento               smallint,
        @w_codval                varchar(20),
        @w_prov_vencida          money,
        @w_ajuste_int_mn         money,
        @w_ajuste_int_me         money,
        @t_rty                   char(1),
        @w_mensaje               varchar(100),
        @w_codval2               smallint,      --LIM 12/ENE/2005
        @w_benef_chq             varchar(255),
        -- INI NYM DOF00015 ICA
        @w_total_renta           money,
        @w_total_ica             money,
        @w_ret_ica               char(1),
        @w_tasa_retencion        float,
        @w_tasa_ica              float,
        @w_base_ret              money,
        @w_base_ica              money,
        @w_mm_ica                money,
        @w_val_ica               money,
        @w_retienimp             char(1),
        -- INI NYM DOF00015 ICA
        @w_campo2                varchar(20),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo3                varchar(20),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo4                varchar(20),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo5                varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo6                varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo7                varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_tipo_benef            catalogo,       -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_desc_conc_cancela     descripcion,    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_mpago_chqcom          varchar(30),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_cod_conc_cancela      varchar(30),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_instr_chqcom          tinyint,        -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_mm_subtipo_ins        int,            -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_instrumento           tinyint,        -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_subtipo_ins           int,            -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_beneficiario          varchar(255),   -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_referencia            cuenta,         -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_area_origen           smallint,       -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_val_gmf               money,          -- MVG 25/SEP/2009
        @w_instrumento_chger     tinyint,        -- MAL 26/OCT/2009 
        @w_subtipo_ins_chger     int,            -- MAL 26/OCT/2009 
	@w_int_no_ganados_aux	 money,
        @w_par_pago              varchar(20),
        @w_op_num_dias int,
        @w_op_base_calculo int

	
select @w_sp_name        = 'sp_cancelacion_op',
       @i_en_linea       = isnull(@i_en_linea,'S'),
       @w_fecha_hoy      = convert(datetime,convert(varchar,@i_fecha_proceso,101)),
       @w_empresa        = 1,
       @w_filial         = 1,
       @w_ofi_ing        = @s_ofi,
       @w_impuesto       = 0,
       @w_impvenc        = 0,
       @w_base_imp       = 0,
       @w_int_no_ganados = 0,
       @w_tipo           = 'T',
       @w_mensaje        = null,
       @w_monto_cancel   = 0,
       @w_total_renta    = 0, -- NYM DPF00015 ICA
       @w_total_ica      = 0  -- NYM DPF00015 ICA

select @w_par_pago = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'NVXP'



-----------------------------------
-- VERIFICAR CODIGO DE TRANSACCION
-----------------------------------
if @t_trn <> 14903
begin
   return 141018
end

------------------------
-- CONSULTA MONEDA BASE
------------------------
select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
   return 601018
end

--------------------------------------
-- SECCION DE LECTURA DE PF_OPERACION
--------------------------------------
select @w_num_banco          = op_num_banco,
       @w_ente               = op_ente,
       @w_operacionpf        = op_operacion,
       @w_toperacion         = op_toperacion,
       @w_producto           = op_producto,
       @w_categoria          = op_categoria,
       @w_tplazo             = op_tipo_plazo,
       @w_monto              = op_monto,
       @w_monto_blq          = op_monto_blq,
       @w_monto_pg_int       = op_monto_pg_int,
       @w_int_estimado       = op_int_estimado,
       @w_int_ganado         = op_int_ganado,
       @w_int_pagado         = op_int_pagados,
       @w_fecha_valor        = op_fecha_valor,
       @w_fecha_ingreso      = op_fecha_ingreso,
       @w_fecha_ven          = op_fecha_ven,
       @w_fecha_can          = op_fecha_cancela,
       @w_total_int_estimado = op_total_int_estimado,
       @w_total_int_ganado   = op_total_int_ganados,
       @w_total_int_pagados  = op_total_int_pagados,
       @w_ofi_org            = op_oficina,
       @w_moneda             = op_moneda,
       @w_historia           = op_historia,
       @w_pignorado          = op_pignorado,
       @w_estado             = op_estado,
       @w_fpago              = op_fpago,
       @w_accion_sgte        = op_accion_sgte,
       @w_fecha_mod          = op_fecha_mod,
       @w_causa_mod          = op_causa_mod,
       @w_secuencia          = op_mon_sgte,
       @w_retieneimp         = op_retienimp ,
       @w_ret_ica            = op_ica,
       @w_ley                = op_ley,
       @w_fecha_cal_tasa     = op_ult_fecha_cal_tasa,
       @w_op_cupon           = op_cupon,
       @w_op_tasa            = op_tasa,
       @w_op_num_dias        = op_num_dias,
       @w_op_base_calculo       = op_base_calculo
from pf_operacion
where op_num_banco                              = @i_num_banco
and   datediff(dd,op_fecha_valor,@w_fecha_hoy) >= 0
and   op_estado                                in ('ACT','VEN','PEN')

if @@rowcount = 0
begin
   return  141004
end

------------------------------------
-- Busqueda de parametros iniciales
------------------------------------
select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'

-- MEDIO DE PAGO CHEQUE COMERCIAL - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'

-- CODIGO DE CONCEPTO DE EMISION POR CANCELACION - GAL 08/SEP/2009 - INTERFAZ - CHQCOM
select @w_cod_conc_cancela = pa_char
from cobis..cl_parametro
where pa_nemonico = 'EMCANC'
and   pa_producto = 'PFI'

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


--PRINT 'CANCELOP i_en_linea %1! ',@i_en_linea

if @i_en_linea = 'N'
begin
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

   select @w_mantiene_stock=td_mantiene_stock
     from pf_tipo_deposito
    where td_mnemonico=@w_toperacion
end
else
   select @w_numdeci        = @i_numdeci,
          @w_tasa           = @i_tasa,
          @w_mantiene_stock = @i_mantiene_stock

-----------------------------------------
-- Lectura de registro en pf_cancelacion
-----------------------------------------

select @w_mm_secuencia = ca_secuencial,
       @w_pen_monto    = ca_pen_monto,
       @w_pen_porce    = ca_pen_porce,
       @w_int_vencido  = ca_int_vencido,
       @w_pen_capital  = ca_pen_capital,           --LIM 04/NOV/2005
       @w_monto_cancel = ca_pen_capital --CVA Dic-20-05
  from pf_cancelacion
 where ca_operacion = @w_operacionpf
   and ca_estado    = 'I'
   and ca_tipo      = @i_tipo
if @@rowcount = 0
begin
   return  141135
end

----------------------------------------------------
-- AJUSTE DE VARIABLES E INICIALIZACION DE VARIABLES
----------------------------------------------------
select @w_fecha_ven = convert(datetime,convert(varchar,@w_fecha_ven,101)),
       @w_fecha_can = convert(datetime,convert(varchar,@w_fecha_can,101)),
       @v_historia  = @w_historia,
       @v_fecha_mod = @w_fecha_mod,
       @v_causa_mod = @w_causa_mod,
       @v_estado    = @w_estado,
       @w_be_ente   = 0,
       @w_int_total = 0,
       @w_imp_total = 0,
       @w_total_op  = 0

begin tran  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -------------------------
   -- CANCELACION DEFINITIVA
   -------------------------
   if @w_pignorado = 'S'
   begin
      select @w_error = 149006
      goto ERROR
   end

   if @w_monto_blq > 0
   begin
      select @w_error = 149007
      goto ERROR
   end
   ---------------------------
   -- Se lee cotizacion actual
   ---------------------------
   select @w_mm_sub_secuencia = 0,
          @w_total_cancel     = 0
   --------------------------------------------------------------------
   -- Se aumenta condicion para saber si existe compra/venta de divisas
   --------------------------------------------------------------------
   select @w_cero = 'N',
          @w_tasa_var  = convert(varchar(20),@w_op_tasa),  --Tasa  LIM 20/ENE/2006
     @w_monto_var = convert(varchar(30),@w_monto_cancel) --Saldo Capital CVA Dic-20-05

   if exists ( select 1
                 from cob_pfijo..pf_mov_monet
                where mm_operacion = @w_operacionpf
                  and mm_tran      = @t_trn
                  and mm_secuencia = @w_mm_secuencia
                  and mm_moneda    = @w_moneda_base)
      select @w_cero = 'S'

while 3=3
begin

   -------------------------------------------------
   -- Lectura de registro insertado en pf_mov_monet
   -------------------------------------------------
   set rowcount 1
   select
      @w_mm_sub_secuencia = mm_sub_secuencia,
      @w_mm_producto      = mm_producto,
      @w_mm_cuenta        = mm_cuenta,
      @w_mm_valor         = mm_valor,
      @w_mm_impuesto      = mm_impuesto,
      @w_mm_valor_ext     = mm_valor_ext,
      @w_mm_moneda        = mm_moneda,
      @w_mm_tran          = mm_tran,
      @w_mm_beneficiario  = mm_beneficiario,
      @w_mm_oficina       = mm_oficina,         --LIM 14/NOV/2005
      @w_origen_ben       = mm_tipo_cliente,    /* rlinares 02222007 */
      @w_benef_chq        = mm_benef_corresp,
      @w_mm_ica           = mm_ica,             -- NYM DPF00015 ICA
      @w_mm_subtipo_ins   = mm_subtipo_ins      -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
   from pf_mov_monet
   where mm_operacion         = @w_operacionpf
   and   mm_tran              = @t_trn
   and   mm_secuencia         = @w_mm_secuencia
   and   mm_sub_secuencia     > @w_mm_sub_secuencia
   and   mm_estado           is null
   and   mm_secuencial        = 0
   and   mm_fecha_aplicacion is null
   if @@rowcount = 0
      break
     
      
   select
      @w_total_renta = @w_total_renta + @w_mm_impuesto,  -- NYM DPF00015 ICA
      @w_total_ica   = @w_total_ica + @w_mm_ica       -- NYM DPF00015 ICA

   select
      @w_cotizacion_conta    = co_conta,
      @w_cotizacion_venta_b  = co_venta_billete,
      @w_cotizacion_compra_b = co_compra_billete
   from cob_pfijo..pf_cotizacion
   where co_moneda = @w_mm_moneda
      and co_fecha = @s_date
   order by co_hora desc

   select @w_valor_act_tot = 0
   set rowcount 0

   -------------------------------------------------------------------------------------------------
   -- Actualizacion del valor en moneda nacional de acuerdo a la cotizacion en la tabla pf_mov_monet
   -------------------------------------------------------------------------------------------------
   if @w_mm_moneda <> @w_moneda_base
   begin

      -----------------------------------------------------------------------
      -- Se utiliza cotizacion dependiendo si hay compra/venta implicita o no
      -----------------------------------------------------------------------
      if @w_mm_moneda <> @w_moneda
         select @w_cotizacion = @w_cotizacion_venta_b, @w_tipo_cotiza = 'V'

      if @w_mm_moneda = @w_moneda
         if @w_cero = 'N'
            select @w_cotizacion = @w_cotizacion_conta, @w_tipo_cotiza = 'N'
         else
            select @w_cotizacion = @w_cotizacion_compra_b, @w_tipo_cotiza = 'C'

      select @w_valor_act = @w_mm_valor_ext * @w_cotizacion

      if @w_valor_act <> @w_mm_valor
      begin
         update pf_mov_monet
         set mm_valor = @w_valor_act,
         mm_cotizacion  = @w_cotizacion,
         mm_tipo_cotiza = @w_tipo_cotiza
         where mm_operacion   = @w_operacionpf
         and mm_tran        = @t_trn
         and mm_secuencia   = @w_mm_secuencia
         and mm_sub_secuencia = @w_mm_sub_secuencia
         and mm_estado is null
         and mm_secuencial  = 0
         and mm_fecha_aplicacion is null

         if @@error <> 0
         begin
         select @w_error = 145000
         goto ERROR
         end

         select @w_valor_act_tot = @w_valor_act_tot + @w_valor_act
      end
   end  --if @w_mm_moneda <> @w_moneda_base


	 -- Si es cheque de gerencia o cheque comercial
	 -- y el beneficairio esta en listas Inhibitorias se 
	 -- cambia medio de pago a VXP para que se pague en linea con un beneficiario adecuado.

	 --print ' @w_mm_beneficiario ' +  cast(@w_mm_beneficiario as varchar)
	 --print ' @w_mm_producto ' +  cast(@w_mm_producto as varchar)
	 --print ' @w_mpago_chqcom ' +  cast(@w_mpago_chqcom as varchar)
	 --print ' @w_cheque_ger ' +  cast(@w_cheque_ger as varchar)

      if @w_mm_producto in (@w_mpago_chqcom , @w_cheque_ger) begin
	    if exists (      
	    select 	1
      	    from 	cobis..cl_ente,
			cobis..cl_refinh
      	    where en_ente 		= @w_mm_beneficiario 
      	    and	en_mala_referencia 	= 'S'
	    and	in_tipo_ced 		= en_tipo_ced
	    and	in_ced_ruc 		= en_ced_ruc
	    ) begin
               select @w_mensaje = 'Aplica_inst_can. Se cambio medio de pago ' + @w_mm_producto + ' a VXP por que Ente: ' + cast(@w_mm_beneficiario as varchar) + ' Esta en Ref.Inhibitorias'
               print  ' ' + @w_mensaje 
               select @w_mm_producto = @w_par_pago
               exec sp_errorlog
                    @i_fecha   = @s_date,
                    @i_error   = 0,
                    @i_usuario = @s_user,
                    @i_tran    = @t_trn,
                    @i_descripcion = @w_mensaje,
                    @i_cuenta  = @w_num_banco

               update pf_mov_monet
               set mm_producto  = @w_mm_producto 
               where mm_operacion   = @w_operacionpf
               and mm_tran        = @t_trn
               and mm_secuencia   = @w_mm_secuencia
               and mm_sub_secuencia = @w_mm_sub_secuencia
               and mm_estado is null
               and mm_secuencial  = 0
               and mm_fecha_aplicacion is null

      	    end
      end



   -------------------------------------------------------------------------
   -- RET.IMPTO 1% Para indicar en sp_aplica_mov a CTAS Inversion si se debe
   -- o no retener el 1% al generar la nota de credito automatica ya que el
   -- sp_retiene_capital compara la transaccion y el cliente
   -------------------------------------------------------------------------
   exec @w_return  = sp_retiene_capital
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

   -------------------------------------------------------------------------
   -- Evalucacion para fecha valor en cancelacion back_value
   ---------------------------------------------------------------------
   if @i_back_value = 'S'
      select @w_fecha_valor_cte = @i_fecha_back


--PRINT 'CANCELOP i_back_value %1! @w_fecha_valor_cte %2! ',@i_back_value, @w_fecha_valor_cte


   ----------------------------------------------------
   -- Realiza aplicacion de los movimientos monetarios
   ----------------------------------------------------
   exec @w_return = sp_aplica_mov
      @s_ssn             = @s_ssn,
      @s_user            = @s_user,
      @s_ofi             = @s_ofi,
      @s_date            = @s_date,
      @s_srv             = @s_srv,
      @s_term            = @s_term,
      @s_sesn            = @s_sesn,   --LIM 20/ENE/2006
      @s_org             = @s_org,         --LIM 23/ENE/2006
      @s_lsrv            = @s_lsrv,   --LIM 23/ENE/2006
      @t_file            = @t_file,
      @t_from            = @w_sp_name,
      @t_debug           = @t_debug,
      @t_trn             = @t_trn,
      @i_operacionpf     = @w_operacionpf,
      @i_fecha_proceso   = @w_fecha_hoy ,
      @i_secuencia       = @w_mm_secuencia ,
      @i_sub_secuencia   = @w_mm_sub_secuencia,
      @i_benefi          = @w_benef_chq,
      @i_en_linea        = @i_en_linea,
      @i_retiene_capital = @w_retiene_capital,
      @i_emite_orden     = @i_emite_orden,
      @i_fecha_valor     = @w_fecha_valor_cte
   if @w_return <> 0
   begin
      select @w_mensaje = 'Error sp_aplica_mov'
      select @w_error = @w_return
      goto ERROR
   end

   -------------------------------------------------------------------------
   -- Interface para emision de cheque de gerencia con Servicios bancarios
   -- Se envia a SBA de acuerdo al producto de la forma de pago
   -------------------------------------------------------------------------
   select
      @w_producto_fpago = fp_producto,
      @w_area_contable  = fp_area_contable
   from   pf_fpago
   where  fp_mnemonico = @w_mm_producto
   if @@error <> 0
   begin
      select @w_error = 141111
      goto ERROR
   end

   if (@w_producto_fpago = 42)
   begin
      ----------------------------------------------------
      -- Tomar la descripcion del beneficiario del cheque
      ----------------------------------------------------
      select @w_descripbenef     = ec_descripcion
      from   pf_emision_cheque
      where ec_operacion        = @w_operacionpf
      and   ec_tran             = @t_trn
      and   ec_secuencia        = @w_mm_secuencia
      and   ec_sub_secuencia    = @w_mm_sub_secuencia

      if @w_area_contable is null
      begin
         select @w_area_contable = td_area_contable
         from   pf_tipo_deposito
         where  td_mnemonico = @w_toperacion
         if @@error <> 0
         begin
            select @w_error = 141115
            goto ERROR
         end
      end

      exec @w_idlote = cob_interfase..sp_isba_cseqnos          -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos
         @i_tabla     = 'sb_identificador_lotes',
         @o_siguiente = @w_numero out

      select
         @w_campo47  = tn_descripcion,
         @w_concepto = substring(tn_descripcion,1,25)
      from   cobis..cl_ttransaccion
      where  tn_trn_code = @w_mm_tran

      select @w_campo48 = 'DEPOSITO A PLAZO ' + @w_num_banco

      select @w_campo1 = 'PFI'

      if @w_mm_producto = @w_cheque_ger
         select @w_campo40 = 'E'

      ------------------------------------------------------------------
      -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
      ------------------------------------------------------------------
      select @w_conceptosb = convert(tinyint,codigo)
      from   cobis..cl_catalogo
      where  tabla in (select codigo
                       from   cobis..cl_tabla
                       where  tabla = 'sb_conceptos_implot')
      and    valor  = 'DPF'

      -- INICIO - GAL 07/SEP/2009 - INTERFAZ - CHQCOM

      if @w_mm_producto in (@w_mpago_chqcom , @w_cheque_ger)
      begin
         -- OBTENER DATOS DEL TITULAR DEL CREDITO
         select @w_campo1 = en_tipo_ced + '-' + en_ced_ruc,
                @w_campo2 = en_nomlar
         from   cobis..cl_ente
         where  en_ente = @w_ente

         -- OBTENER DATOS DEL BENEFICIARIO
         if @w_origen_ben = 'M'
	         begin
		         select @w_campo3     = en_tipo_ced + '-' + en_ced_ruc,
		                @w_beneficiario = en_nomlar,
		                @w_tipo_benef = c_tipo_compania
		         from   cobis..cl_ente
		         where  en_ente = @w_mm_beneficiario
		     end
	     else
	     	begin
			-- ce_secuencial + '-' +
		         select @w_campo3     =  ce_cedula,
		                @w_beneficiario = ce_nombre
		         from   cob_pfijo..pf_cliente_externo 
		         where  ce_secuencial = @w_mm_beneficiario	     	
	     	end

         select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')

         select @w_desc_conc_cancela = valor
         from cobis..cl_tabla T, cobis..cl_catalogo C
         where T.tabla  = 'cc_concepto_emision'
         and   C.tabla  = T.codigo
         and   C.codigo = @w_cod_conc_cancela
         
         
         if @w_mm_producto = @w_mpago_chqcom
         begin
             select 
               	@w_instrumento  = @w_instr_chqcom,
               	@w_subtipo_ins  = @w_mm_subtipo_ins
         end
              
         if @w_mm_producto = @w_cheque_ger 
         begin
             select	
               	@w_instrumento  = @w_instrumento_chger,
               	@w_subtipo_ins  = @w_subtipo_ins_chger 
         end
         
         select
            @w_campo5       = @w_num_banco,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
            @w_campo6       = @w_cod_conc_cancela,                        -- CÓDIGO CONCEPTO DE RENOVACION
            @w_campo7       = @w_desc_conc_cancela,                       -- DESCRIPCION CONCEPTO DE RENOVACION
            @w_campo4	    = @w_beneficiario,
            @w_referencia   = cast(@w_operacionpf as varchar),
            @w_area_origen  = 99
      end
      else
      begin
         select
            @w_beneficiario = @w_descripbenef,
            @w_referencia   = @w_num_banco,
            @w_campo2       = @w_concepto,          -- descripcion de la transaccion
            @w_campo7       = @w_monto_var,         --Saldo Capital
            @w_area_origen  = 90
      end

      exec @w_return = cob_interfase..sp_isba_imprimir_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_imprimir_lotes
         @s_ssn              = @s_ssn,
         @s_user             = @s_user,
         @s_term             = @s_term,
         @s_date             = @s_date,
         @s_srv              = @s_srv,
         @s_lsrv             = @s_lsrv,
         @s_ofi              = @s_ofi,
         @t_debug            = @t_debug,
         @t_trn              = 29334,
         @i_oficina_origen   = @w_ofi_org,           -- @s_ofi
         @i_ofi_destino      = @w_mm_oficina,
         @i_area_origen      = 99,
         @i_func_solicitante = 0,
         @i_fecha_solicitud  = @s_date,
         @i_producto         = 4,
         @i_instrumento      = @w_instrumento,
         @i_subtipo          = @w_subtipo_ins,
         @i_valor            = @w_mm_valor,
         @i_beneficiario     = @w_beneficiario,
         @i_referencia       = @w_referencia,
         @i_tipo_benef       = @w_tipo_benef,
         @i_campo1           = @w_campo1,
         @i_campo2           = @w_campo2,
         @i_campo3           = @w_campo3,
         @i_campo4           = @w_campo4,
         @i_campo5           = @w_campo5,
         @i_campo6           = @w_campo6,
         @i_campo7           = @w_campo7,
         @i_campo8           = @w_campo48,           -- 'DEPOSITO A PLAZO ' + @w_num_banco
         @i_observaciones    = @w_concepto,
         @i_llamada_ext      = 'S',
         @i_concepto         = @w_conceptosb,        -- Catalogo de Servicios bancarios (3)
         @i_fpago            = @w_mm_producto,       -- nuevo requerimiento SBA (nemonico de la forma de pago)
         @i_moneda           = @w_mm_moneda,         -- @w_moneda,
         @i_origen_ing       = '3',
         @i_idlote           = @w_numero,            -- secuencial del seqnos de Servicios bancarios
         @i_cod_ben          = @w_cod_ben,           /*  RLINARES 02222007 */
         @i_orig_ben         = @w_origen_ben,        /*  RLINARES 02222007 */
         @i_estado           = 'D',
         @i_campo21          = 'PFI',
         @i_campo22          = 'D',
         @i_campo40          = @w_campo40,
         @o_idlote           = @w_idlote out,
         @o_secuencial       = @w_secuencial_cheque out

      if @w_return <>0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      -- FIN - GAL 23/SEP/2009 - INTERFAZ - CHQCOM

      ----------------------------------------------------------
      -- Actualizar registro en pf_emision_cheque para que
      -- no pueda ser cargado en pantalla de emision de ordenes
      ----------------------------------------------------------
      update pf_emision_cheque set
         ec_fecha_emision    = @s_date,
         ec_numero           = @w_numero,
         ec_estado           = 'A',
         ec_caja             = 'S',
         ec_secuencial_lote  = @w_secuencial_cheque,        --LIM 12/OCT/2005
         ec_subtipo_ins      = @w_subtipo_ins      --@w_mm_subtipo_ins         -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
      where ec_operacion        = @w_operacionpf
      and   ec_tran             = @t_trn
      and   ec_secuencia        = @w_mm_secuencia
      and   ec_sub_secuencia    = @w_mm_sub_secuencia

      if @@rowcount = 0
      begin
         select @w_error = 145031
         goto ERROR
      end

      -------------------------------------------------------------
      -- Actualizar mm_num_cheque para reverso Servicios Bancarios
      -------------------------------------------------------------
      if @w_mm_producto in (@w_mpago_chqcom, @w_cheque_ger)                -- GAL 08/SEP/2009 - RVVUNICA
      begin
         update pf_mov_monet set
            mm_subtipo_ins     = @w_subtipo_ins,       --@w_mm_subtipo_ins,
            mm_secuencial_lote = @w_secuencial_cheque
         where mm_operacion      = @w_operacionpf
         and   mm_tran           = @t_trn
         and   mm_secuencia      = @w_mm_secuencia
         and   mm_sub_secuencia  = @w_mm_sub_secuencia
      end
      else
      begin
         update pf_mov_monet
         set mm_num_cheque = @w_numero
         where mm_operacion      = @w_operacionpf
         and   mm_tran           = @t_trn
         and   mm_secuencia      = @w_mm_secuencia
         and   mm_sub_secuencia  = @w_mm_sub_secuencia
      end

      if @@error <> 0
      begin
         select @w_error = 145020
         goto ERROR
      end
   end   --if (@w_producto_fpago = 42)

   select @w_total_cancel = @w_total_cancel + @w_mm_valor
end   -- FIN DE WHILE 3

   set rowcount 0

   if @w_pen_monto is not null
      select @w_penal = @w_pen_monto

   if @w_pen_monto is null and @w_pen_porce is null
      select @w_penal = 0

   -------------------------------------------------------------
   -- Se actualiza pf_cancelacion de acuerdo a cotizacion actual
   -------------------------------------------------------------
   if @w_valor_act_tot <> 0 and @w_moneda <> @w_moneda_base
   begin
      update pf_cancelacion
         set ca_valor     = @w_valor_act_tot
       where ca_operacion = @w_operacionpf
         and ca_estado    = 'I'
         and ca_tipo      = @i_tipo
      if @@rowcount = 0
      begin
         select @w_error = 145036
         goto ERROR
      end
   end
   ---------------------------------------------------------
   -- Fin actualizacion pf_cancelacion con cotizacion actual
   ---------------------------------------------------------
   --------------------------------
   -- ACTUALIZACION DE LA OPERACION
   --------------------------------
   select @w_historia = @w_historia + 1,
          @w_estado   = 'CAN'

   if @i_en_linea = 'S'
      select @w_causa_mod = 'CAN'
   else
      select @w_causa_mod = 'TVEN'

   if @v_estado = 'ACT'
   begin
      -------------
      -- Anticipada
      -------------
      if @w_fpago='ANT'
      begin
         ---------
         -- Normal
         ---------
         if @i_tipo = 'N'
            --------------------
            -- Intereses pagados
            --------------------
            select @w_tot_int_pag = @w_total_int_ganado
         else
            -------------
            -- Anticipada
            -------------
            select @w_int_no_ganados = @w_total_int_estimado - @w_total_int_ganado,
                   @w_tipo           = 'I',   -- Descuenta lo no ganado
                   @w_tot_int_pag    = @w_total_int_ganado  -- @i_penalizacion

         select @w_base_imp= 0
      end
      else
      begin
         -----------------
         -- Al vencimiento
         -----------------
         ---------
         -- Normal
         ---------
         if @i_tipo = 'N'
         begin
            select @w_tot_int_pag = @w_total_int_ganado
            select @w_int_no_ganados = @w_total_int_ganado - @w_total_int_pagados  --Int. x pagar
            select @w_base_imp=@w_int_no_ganados

         end
         else
         begin
            -------------------------
            -- Cancelacion Anticipada
            -------------------------
            select @w_int_no_ganados = @w_total_int_ganado - @w_total_int_pagados,
                   @w_tipo           ='T'   --Intereses por pagar
            select @w_tot_int_pag    = @i_int_pagado - @i_penalizacion

            select @w_base_imp=@w_int_no_ganados

         end
      end

      select @w_afec='N'
   end
   else
   -------------------
   -- Estado = VENCIDA
   -------------------
   begin
      /* MVG CAMBIO TOTAL INT GANADO POR TOTAL INT ESTIMADO PARA QUE COINCIDA CON EL FRONT-END */
      select @w_tot_int_pag    = @w_total_int_estimado - @w_total_int_pagados
      select @w_afec           = 'V',
             @w_base_imp       = @w_total_int_estimado - @w_total_int_pagados, --LIM 28/OCT/2005 Global no acepta int. vencidos
             @w_int_no_ganados = @w_total_int_estimado - @w_total_int_pagados



   end

--PRINT 'CANCELOP w_total_int_ganado %1! @w_total_int_pagados %2! i_penalizacion %3! ',@w_total_int_ganado, @w_total_int_pagados, @i_penalizacion
--PRINT 'CANCELOP w_tot_int_pag %1! @w_afec %2! w_base_imp %3! @w_int_no_ganados %4! ',@w_tot_int_pag, @w_afec, @w_base_imp, w_int_no_ganados


   ----------------------------------
   -- CONTABILIZACION DE LA OPERACION
   ----------------------------------
   if @w_mm_producto is not null
   begin
      select @w_fecha  = convert(datetime,convert(varchar,@w_fecha_hoy,101))
      select @w_string = 'Antes de Aplica_conta'

      -- INI  NYM DPF00015 ICA
      select @w_impuesto = 0
      select @w_val_ica = 0

      if @w_retieneimp = 'S' and @w_tipo = 'T'
         select @w_impuesto = @w_total_renta

      if @w_ret_ica = 'S' and @w_tipo = 'T'
         select @w_val_ica = @w_total_ica
      -- FINI  NYM DPF00015 ICA

      select @w_descripcion = 'CANCELACION (' + @i_num_banco + ')'

      --------------------------------------
      -- Cambio para cancelacion Back-Value
      --------------------------------------
      if @i_back_value = 'S'
      begin
         ---------------------------------------------
         -- Calculo de intereses con fecha back-Value
         ---------------------------------------------
         select @w_ajuste_int = @w_int_ganado - @i_int_pagado
         select @w_int_no_ganados = @i_int_pagado

      end

      /* CALCULO EL VALOR A CONTABILIZAR POR EMERGENCIA ECONOMICA GMF */
      exec @w_return = sp_valor_gmf
      @s_date         = @s_date,
      @i_tran         = 14903,
      @i_operacionpf  = @w_operacionpf,
      @i_secuencia    = @w_mm_secuencia,
      @o_valor_iee    = @w_val_gmf out
      
      if @w_return <> 0 goto ERROR
      

	
      if @i_tipo = 'A'
         select @w_int_no_ganados_aux = @w_int_no_ganados
      else
         select @w_int_no_ganados_aux = 0

--print '@i_tipo' + @i_tipo
--print '@w_int_no_ganados_aux' + cast(@w_int_no_ganados_aux as varchar)

exec  sp_aplica_impuestos
@s_ofi	= @w_ofi_org,
--@t_debug	= @t_debug
@i_ente	= @w_ente,
@i_plazo	= @w_op_num_dias,
@i_capital	= @w_monto,
@i_interes	= @w_total_int_estimado,
@i_base_calculo	= @w_op_base_calculo,
@o_retienimp	= @w_retienimp out,
@o_tasa_retencion	= @w_tasa_retencion out,
@o_valor_retencion	= @w_impuesto out

if @w_retienimp = 'S'
    select @w_monto = @w_monto - @w_impuesto


      /* MVG 25/09/2009 CONTABILIZA EMERGENCIA ECONOMICA COMO UN RUBRO MAS */
      exec @w_return = sp_aplica_conta
      @s_date                = @s_date,
      @s_user                = @s_user,
      @s_term                = @s_term,
      @s_ofi                 = @s_ofi,
      @i_fecha               = @w_fecha,
      @i_tran                = @t_trn,
      @i_operacionpf         = @w_operacionpf,
      @i_afectacion          = 'N',             -- N=Normal, R=Reverso
      @i_secuencia           = @w_mm_secuencia,
      @i_valor               = @w_int_no_ganados,
      @i_impuesto            = @w_impuesto,
      @i_ica                 = @w_val_ica,    -- NYM DPF00015 ICA
      @i_monto               = @w_monto,   --CVA May-09-06
      @i_penal               = @w_penal,
      @i_penaliza_capital    = @i_penaliza_capital,
      @i_impuesto_emerg_eco  = @w_val_gmf,  --MVG 25/09/2009
      @i_descripcion    = @w_descripcion,
      @o_comprobante         = @o_comprobante out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      --------------------------------
      -- INSERCION EN PF_RELACION_COMP
      --------------------------------
      insert into pf_relacion_comp values (@i_num_banco,@o_comprobante,@t_trn,'CAN','N', null, 0, @w_fecha)

   end

   ----------------------------------------------------------------------------------------------
   -- Cancelaciones Back Value contabilizacion de Intereses para reverso de residuo de provision
   ----------------------------------------------------------------------------------------------
   if @i_back_value = 'S' and (@w_fecha_ven > @s_date)
   begin

      select @w_ajuste_int_mn = 0 --CVA Nov-16-06

      select @w_contador = 1
      select @w_debcred = convert(char(1),@w_contador),
            @w_asiento = 1
      select @w_codval = '18'
      select @w_descripcion = 'AJUSTE INTERES CANCELACION BACK VALUE (' + @i_num_banco + ')'

      if @w_fecha_ven < @s_date
      begin
            select @w_ajuste_int = @w_prov_vencida
      end

      ------------------------------------
      -- Transformacion a Moneda Nacional
      ------------------------------------
      if @w_moneda = 0
      begin
            select @w_ajuste_int_mn = @w_ajuste_int
            select @w_ajuste_int_me = 0
      end
      else
      begin
            select @w_ajuste_int_mn = @w_ajuste_int*@w_cotizacion
            select @w_ajuste_int_me = @w_ajuste_int
      end

      select @w_codval2 = convert(smallint,@w_codval)

      if @w_ajuste_int_mn <> 0  --CVA Nov-16-06 Si el valor de ajuste es diferente de cero
      begin
         exec @w_return = cob_pfijo..sp_aplica_conta
         @s_date           = @s_date,
         @s_user           = @s_user,
         @s_term           = @s_term,
         @i_fecha          = @s_date,
         @s_ofi            = @s_ofi,
         @i_tran           = 14926,
         @i_oficina_oper   = @w_ofi_org,
         @i_operacionpf    = @w_operacionpf,
         @i_valor          = @w_ajuste_int_mn,
         @i_afectacion     = 'R',  /* N=Normal,  R=Reverso  */
	 @i_descripcion    = @w_descripcion,
         @o_comprobante    = @o_comprobante out
         if @w_return <> 0
         begin
            select @w_error = @w_return
            goto ERROR
         end

         ---------------------------------
         -- Insercion en pf_relacion_comp
         ---------------------------------
         insert into pf_relacion_comp
         values (@i_num_banco, @o_comprobante, 14926, 'CAN', 'N', null, 0, @w_fecha)

      end --CVA Nov-16-06 Si el valor de ajuste es diferente de cero
   end



   --print 'cancelop UPUPUPU @w_impuesto %1! , @w_val_ica %2! ',@w_impuesto, @w_val_ica

   update pf_operacion
      set op_historia           = @w_historia,
          op_estado             = @w_estado,
          op_fecha_mod          = @s_date,
          op_fecha_cancela      = @s_date,
          op_fecha_pg_int       = @s_date,
          op_total_int_pagados  = round (@w_tot_int_pag,@w_numdeci),
          op_causa_mod          = @w_causa_mod,
          op_retienimp          = @w_retieneimp,
          -- NYM DPF00015 ICA
          op_ica                = @w_ret_ica,
          op_total_int_retenido = op_total_int_retenido  + @w_impuesto,
          op_total_ica          = op_total_ica + @w_val_ica,
          op_ult_fecha_cal_tasa = @w_fecha_cal_tasa
          -- NYM DPF00015 ICA
    where op_operacion          = @w_operacionpf
   if @@error <> 0
   begin
      select @w_error = 145001
      goto ERROR
   end

   update pf_cancelacion
      set ca_estado    = 'A',
          ca_fecha_mod = @s_date
    where ca_operacion = @w_operacionpf
      and ca_estado    = 'I'
   if @@error <> 0
   begin
      select @w_error = 145036
      goto ERROR
   end

   --I. CVA May-16-06 Actualizar detalle de producto
   update cobis..cl_det_producto
      set dp_estado_ser = 'C'
   where  dp_cuenta = @w_num_banco
   --F. CVA May-16-06 Actualizar detalle de producto

   if @w_fpago <> 'ANT'
      select @w_int_cancelar = @w_total_int_ganado - @w_total_int_pagados
   else
      select @w_int_cancelar=0


   if @w_retieneimp = 'S' and @w_int_cancelar > 0
   begin
      select @w_int_canc1 = @w_int_cancelar - @w_pen_monto
   end

   if @w_retieneimp='S' and @w_int_vencido > 0
      select @w_impvenc = @w_int_vencido*@w_tasa/100

   select @w_int_cancelar = @w_int_cancelar - @w_impuesto,
          @w_int_vencido  = @w_int_vencido - @w_impvenc

   --select @w_monto_pg_int=@w_monto_pg_int+@w_int_cancelar+@w_int_vencido - @w_pen_monto
   if @i_back_value = 'S'
      select @w_monto_pg_int=@w_monto_pg_int+@i_int_pagado - @w_pen_monto - @w_pen_capital      --LIM 03/NOV/2005
   else
      select @w_monto_pg_int=@w_monto_pg_int+@w_int_cancelar - @w_pen_monto - @w_pen_capital      --LIM 28/OCT/2005 Global no acepta int vencidos
   --------------------------
   -- INSERCION DEL HISTORIAL
   --------------------------
   insert pf_historia (hi_operacion,   hi_secuencial,   hi_fecha,
                       hi_trn_code,    hi_valor,        hi_funcionario,
                       hi_oficina,     hi_fecha_crea,   hi_fecha_mod)
               values (@w_operacionpf, @v_historia,     @s_date,
                       @t_trn,         @w_monto_pg_int, @s_user,
                       @s_ofi,         @s_date,         @s_date)

   if @@error <> 0
   begin
      select @w_error = 143006
      goto ERROR
   end
   ----------------------------------------------
   -- INSERCION DE TRANSACCION DE SERVICIO PREVIA
   ----------------------------------------------
   insert ts_operacion (secuencial,  tipo_transaccion, clase,        usuario,      terminal,
                        srv,         lsrv,             fecha,        num_banco,    operacion,
                        historia,    estado,           causa_mod,    fecha_mod)
                values (@s_ssn,      @t_trn,           'N',          @s_user,      @s_term,
                        @s_srv,      @s_lsrv,          @s_date,      @w_num_banco, @w_operacionpf,
                        @v_historia, @v_estado,        @v_causa_mod, @v_fecha_mod)

   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end

commit tran
------------------------------
-- FIN: CANCELACION DEFINITIVA
------------------------------

return 0

ERROR:
   rollback tran

   if @i_en_linea = 'N'
   begin
      exec sp_errorlog
           @i_fecha   = @s_date,
           @i_error   = @w_error,
           @i_usuario = @s_user,
           @i_tran    = @t_trn,
           @i_descripcion = @w_mensaje,
           @i_cuenta  = @w_num_banco
      return @w_error
   end
   else
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error

      return @w_error
   end
go

