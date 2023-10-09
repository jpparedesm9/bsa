/************************************************************************/
/*      Archivo:                paga_int.sp                             */
/*      Stored procedure:       sp_paga_int                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ricardo Alvarez                         */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                                                                      */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea el procedimiento de pago de intereses          */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*     FECHA         AUTOR              RAZON                           */
/*     22/MAY-2009   Ericka Rodriguez   Ajuste Version Unica            */
/*     12/Ene-2017   Jorge Salazar      DPF-H94952 MANEJO RETENCIONES MX*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_paga_int' and type = 'P')
   drop proc sp_paga_int
go

create proc sp_paga_int
   @s_ssn               int             = NULL,
   @s_user              login           = NULL,
   @s_term              varchar(30)     = NULL,
   @s_date              datetime        = NULL,
   @s_srv               varchar(30)     = NULL,
   @s_lsrv              varchar(30)     = NULL,
   @s_ofi               smallint        = 1,--xca
   @s_rol               smallint        = NULL,
   @t_debug             char(1)         = 'N',
   @t_file              varchar(10)     = NULL,
   @t_from              varchar(32)     = NULL,
   @t_trn               int             = NULL,
   @i_fecha_proceso     datetime,
   @i_num_banco         cuenta,
   @i_op_fecha_pg_int   datetime        = NULL
with encryption
as
declare
   @w_sp_name                      descripcion,
   @w_return                       int,
   @w_count                        int,
   @w_fecha_hoy                    datetime,
   @w_fecha_temp                   datetime,
   @w_secuencia                    int,
   @w_secuencial                   int,
   @w_contor                       int,
   @w_error                        int,
   @w_tran_pin                     int,
   @w_money                        money,
   @w_monto_mov                    money,
   @w_total_monto                  money,
   @w_numdeci                      tinyint,
   @w_usadeci                      char(1),
   /* Variables para pf_operacion */
   @w_num_banco                    cuenta,
   @w_imp_retenido                 money,
   @w_imp                          money,
   @w_op_impuesto                  money,
   @w_op_operacion                 int,
   @w_num_dias                     smallint,
   @w_tasa                         float,
   @w_tasa1                        float,
   @w_moneda                       tinyint,
   @w_monto                        money,
   @w_monto_pg_int                 money,
   @w_int_ganado                   money,
   @w_int_estimado                 money,
   @w_int_pagados                  money,
   @w_pago_interes                 money,
   @w_int                          money,
   @w_int_provision                money,
   @w_total_int_pagados            money,
   @w_total_int_ganados            money,
   @w_total_intereses              money,
   @w_op_int_ganado                money,
   @w_diferen                      money,
   @w_fpago                        catalogo,
   @w_producto                     catalogo,
   @w_renova_todo                  char(1),
   @w_dia                          tinyint,
   @w_historia                     smallint,
   @w_tcapitalizacion              catalogo,
   @w_fecha_valor                  datetime,
   @w_fecha_ven                    datetime,
   @w_op_fecha_pg_int              datetime,
   @w_fecha_ult_pg_int             datetime,
   @w_fecha_mod                    datetime,
   @w_tasa_variable                char(1),
   @w_tasa_efec_anual              float,
   @w_toperacion                   catalogo,
   @w_tasa_nom_temp                float,
   @w_tasa_efec_temp               float,
   @w_ult_tasa_nom                 float,
   @w_ult_tasa_efec_anual          float,
   @w_ult_periodo                  int,
   @v_monto_pg_int                 money,
   @v_monto                        money,
   @v_int_ganado                   money,
   @v_int_provision                money,
   @v_int_estimado                 money,
   @v_int_pagados                  money,
   @v_total_int_pagados            money,
   @v_op_fecha_pg_int              datetime,
   @v_fecha_ult_pg_int             datetime,
   @v_historia                     int,
   @v_fecha_mod                    datetime,
   @w_pt_tipo_cuenta_ach           char(1),
   @w_pt_cod_banco_ach             smallint,
   @w_pt_beneficiario              int,
   @w_pt_tipo                      catalogo,
   @w_pt_forma_pago                catalogo,
   @w_pt_cuenta                    cuenta,
   @w_pt_monto                     money,
   @w_porcen_int                   decimal(30,22),
   @w_pt_secuencia                 int,
   @w_pt_moneda_pago               smallint,
   @w_pt_benef_chq                 varchar(255),
   @w_pt_tipo_cliente              char(1),
   @w_pt_oficina                   int,
   --Variables para comprobante de retencion
   @w_ofi_org                      smallint,
   --Variables de pf_cuotas
   @w_cu_valor                     money,
   @w_cu_cuota                     int,
   @w_monto_capitalizar            money,
   @w_mensaje                      descripcion, --CVA Oct-13-05
   @w_mensaje_1                    varchar(100), --CVA Oct-13-05
   @w_op_fecha_ult_pago_int_ant    datetime,
   @w_valor_cap                    money,
   @w_valor                        money,
   @w_descripcion                  descripcion,
   @w_fecha                        datetime,
   @o_comprobante                  int,
   -- Varibles para inactivacion
   @w_flag_pago                    char(1), --CVA Oct-21-05
   @w_op_tipo_plazo                catalogo,
   @w_penalizacion                 money,
   @w_descuadre                    cuenta,  --CVA Oct-13-05
   @w_monto_acum                   money,
   @w_imp_acum                     money,
   @w_cu_valor_cuota               money,
   @w_cu_fecha_pago                datetime,
   -- INI NYM DPF00015 ICA
   @w_retienimp                    char(1),
   @w_ret_ica                      char(1),
   @w_tasa_retencion               decimal(30,6),
   @w_tasa_ica                     decimal(30,6),
   @w_base_ret                     money,
   @w_base_ica                     money,
   @w_mm_ica                       money,
   @w_ente                         int,
   @w_val_ica                      money,
   @w_ica                          money,
   @w_total_renta                  money,
   @w_total_ica                    money,
   @w_total_intereses_bruto        money,
   @w_tran_abierta                 char(1),
   @w_op_dias_reales               char(1),
   @w_ppago                        char(1),
   @w_base_calculo                 smallint,
   @w_op_dia_pago                  smallint,
   @w_cu_valor_cuota_ant           money,
   @w_total_int_estimado           money,
-- INI NYM DPF00015 ICA
   @w_valor_iee                    money,
   @w_embargo                      char(1),
   @w_pg_cli                       catalogo,
   @w_nomlar                       varchar(64), 
   @w_sec                          int, --SECUENCIAL DETALLE PAGO 
   @w_dif                          decimal(15,2),
   @w_par_pago                     varchar(20),
   @w_nchg                         varchar(20),
   @w_nchc                         varchar(20)

select
   @w_sp_name      = 'sp_paga_int',
   @w_flag_pago    = 'N',
   @w_pago_interes = 0,
   @w_tran_abierta = 'N',
   @w_embargo      = 'N'

select @w_tran_pin=  14905

if @t_trn <> @w_tran_pin
begin
   return 141018
end


-- Busca nemonico de parametro valor por pagar 

select @w_par_pago = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'NVXP'

select @w_nchg = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'NCHG'

select @w_nchc = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
   and pa_nemonico = 'CHQCOM'



select @w_ult_periodo = 0
select @w_monto_capitalizar = 0

select @w_fecha_hoy = convert(datetime,convert(varchar,@i_fecha_proceso,101))

--CAPTURA DE PARAMETRO DE FORMA DE PAGO DEL RESTO DE INTERESES AL CLIENTE, EN CASO DE EMBARGO
select @w_pg_cli = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'MPICLE'

if @@rowcount = 0
begin
   select @w_error =  141244
   goto ERROR
end

select @w_num_banco               = op_num_banco,
     @w_op_operacion              = op_operacion,
     @w_num_dias                  = op_num_dias,
     @w_tasa                      = op_tasa,
     @w_monto                     = op_monto,
     @w_monto_pg_int              = op_monto_pg_int,
     @w_int_ganado                = op_int_ganado,
     @w_int_estimado              = op_int_estimado,
     @w_int_pagados               = op_int_pagados,
     @w_int_provision             = op_int_provision,
     @w_total_int_pagados         = op_total_int_pagados,
     @w_total_int_ganados         = op_total_int_ganados,
     @w_fpago                     = op_fpago,
     @w_historia                  = op_historia,
     @w_secuencia                 = op_mon_sgte,
     @w_tcapitalizacion           = op_tcapitalizacion,
     @w_fecha_valor               = op_fecha_valor,
     @w_fecha_ven                 = op_fecha_ven,
     @w_fecha_mod                 = op_fecha_mod,
     @w_op_fecha_pg_int           = convert(datetime,convert(varchar,op_fecha_pg_int,101)),
     @w_fecha_ult_pg_int          = op_fecha_ult_pg_int,
     @w_renova_todo               = op_renova_todo,
     @w_ofi_org                   = op_oficina,
     @w_moneda                    = op_moneda,
     @w_tasa_variable             = op_tasa_variable,
     @w_toperacion                = op_toperacion,
     @w_tasa_efec_anual           = op_tasa_efectiva,
     @w_op_tipo_plazo             = op_tipo_plazo,
     @w_op_fecha_ult_pago_int_ant = op_fecha_ult_pago_int_ant,
     @w_op_impuesto               = op_impuesto,
     @w_ente                      = op_ente,          -- NYM DPF00015 ICA
     @w_op_dias_reales            = op_dias_reales,
     @w_ppago                     = op_ppago,
     @w_base_calculo              = op_base_calculo,
     @w_op_dia_pago               = op_dia_pago,
     @w_total_int_estimado        = op_total_int_estimado
from cob_pfijo..pf_operacion
where op_num_banco    = @i_num_banco

if @@rowcount = 0
begin
   select @w_mensaje = 'paga_int.sp No existe DPF:' + @i_num_banco
   select @w_error = 141218, @w_num_banco = @i_num_banco
   goto ERROR
end


if @w_fpago = 'PER'
begin
   select @w_cu_valor    = cu_valor_cuota,
          @w_cu_cuota    = cu_cuota
   from cob_pfijo..pf_cuotas
   where cu_operacion    = @w_op_operacion
   and   cu_fecha_pago   = @i_op_fecha_pg_int
   and   cu_estado       = 'V'

   if @@rowcount = 0
   begin
      select @w_mensaje = 'paga_int.sp No hay cuota vigente para fecha de pago:' + convert(varchar(10),@w_op_fecha_pg_int,101)
      select @w_error = 141218, @w_num_banco = @i_num_banco
      goto ERROR
   end
end


select @s_ofi            = @w_ofi_org
select @w_tasa_nom_temp  = @w_tasa
select @w_tasa_efec_temp = @w_tasa_efec_anual


select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and   pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

select @w_fecha_ven            = convert(datetime,convert(varchar,@w_fecha_ven,101)),
       @w_op_fecha_pg_int      = convert(datetime,convert(varchar,@w_op_fecha_pg_int,101)),
       @v_monto_pg_int         = @w_monto_pg_int,
       @w_imp_retenido         = 0,
       @v_int_ganado           = @w_int_ganado,
       @v_int_provision        = @w_int_provision,
       @v_int_estimado         = @w_int_estimado,
       @v_int_pagados          = @w_int_pagados,
       @v_total_int_pagados    = @w_total_int_pagados,
       @v_op_fecha_pg_int      = @w_op_fecha_pg_int,
       @v_fecha_ult_pg_int     = @w_fecha_ult_pg_int,
       @v_historia             = @w_historia,
       @v_fecha_mod            = @w_fecha_mod,
       @v_monto                = @w_monto,
       -- NYM DPF00015 ICA
       @w_imp_retenido         = 0,
       @w_val_ica              = 0,
       @w_monto_acum           = 0,
       @w_total_renta          = 0,
       @w_total_ica            = 0
       -- NYM DPF00015 ICA

-- Toma valor para distribucion de pago
select @w_count = count(1),
       @w_money = sum(dp_monto)
from pf_det_pago
where dp_operacion    = @w_op_operacion
and   dp_tipo        in ('INT','INTV')
and   dp_estado       = 'I'
and   dp_estado_xren  = 'N'   -- No debe totalizar el valor de instruccion de renovacion


--*--*-*-*-*-*  VALIDACIONES  *--*-*-*-*-*--
-- print 'A:%1! o B:%2! y C:%3! o D:%4!, E:%5! y F:%6!',@w_total_intereses, @w_total_int_pagados, @w_total_int_ganados, @w_cu_valor, @w_int_estimado, @w_int_ganado

select @w_dif = 0
select @w_dif = @w_int_estimado - @w_int_ganado
if @w_dif <> 0 and abs(@w_dif) <= 5
	if @w_dif > 0
		select @w_int_ganado = @w_int_ganado + abs(@w_dif)
	else
		select @w_int_ganado = @w_int_ganado - abs(@w_dif)

select @w_total_intereses       = @w_int_ganado - @w_int_pagados       -- VALOR A PAGAR
select @w_total_intereses_bruto = @w_total_intereses                   -- NYM DPF00015 ICA


print 'paga int w_total_intereses ' +  cast( @w_total_intereses as varchar )
print 'paga int w_total_int_pagados ' +  cast( @w_total_int_pagados as varchar )
print 'paga int w_total_int_ganados ' +  cast( @w_total_int_ganados as varchar )
print 'paga int w_cu_valor ' +  cast( @w_cu_valor as varchar )
print 'paga int w_int_estimado ' +  cast( @w_int_estimado as varchar )
print 'paga int w_int_ganado ' +  cast( @w_int_ganado as varchar )
print 'paga int w_fpago ' +  cast( @w_fpago as varchar )


if    round(@w_total_intereses,@w_numdeci) < 0
   or round(@w_total_int_pagados,@w_numdeci) > round(@w_total_int_ganados,@w_numdeci)
   or ( round(@w_cu_valor,@w_numdeci)       <> round(@w_int_estimado,@w_numdeci) and @w_fpago = 'PER' )
   or round(@w_int_estimado,@w_numdeci)     <> round(@w_int_ganado,@w_numdeci)
begin
   select @w_mensaje = 'paga_int.sp Data inconsistente para operacion:' + @i_num_banco
   select @w_error = 149100, @w_num_banco = @i_num_banco
   goto ERROR
end
--*--*-*-*-*-*  VALIDACIONES  *--*-*-*-*-*--

-- INI NYM DPF00015 ICA
exec  @w_return = cob_pfijo..sp_aplica_impuestos
   @s_ofi              = @s_ofi,
   @t_debug            = @t_debug,
   @i_ente             = @w_ente,
   @i_plazo            = @w_num_dias,
   @i_capital          = @w_monto,
   @i_interes          = @w_total_intereses,
   @i_base_calculo     = @w_base_calculo,
   @o_retienimp        = @w_retienimp      out,
   @o_tasa_retencion   = @w_tasa_retencion out,
   @o_valor_retencion  = @w_imp_retenido   out
if @@error <> 0
begin
   select @w_error = 141140
   goto ERROR
end

select @w_total_intereses =  @w_total_intereses - @w_imp_retenido - @w_val_ica

-- FIN NYM DPF00015 ICA


print 'paga int w_retienimp ' +  cast( @w_retienimp as varchar )
print 'paga int w_total_intereses ' +  cast( @w_total_intereses as varchar )
print 'paga int w_tasa_retencion ' +  cast( @w_tasa_retencion as varchar )
print 'paga int w_ret_ica ' +  cast( @w_ret_ica as varchar )
print 'paga int w_tasa_ica ' +  cast( @w_tasa_ica as varchar )
print 'paga int w_imp_retenido ' +  cast( @w_imp_retenido as varchar )
print 'paga int w_val_ica ' +  cast( @w_val_ica as varchar )


if  @w_money  is null
     select @w_money = 0

if @w_fecha_hoy = @w_op_fecha_pg_int                  --*-* SI ES FECHA DE PAGO DE INTERES
begin

   if @w_tcapitalizacion = 'S'
      select @w_producto='CAP'

   if @w_renova_todo = 'S'
      select @w_producto = 'PFI'

   if @@trancount = 0 begin --SI YA SE INICIO LA TRANSACCION EN PROGRAMA PADRE NO DEBE INICIARSE OTRA
      begin tran
      select @w_tran_abierta = 'S'
   end

   if (@w_tcapitalizacion = 'S' and @w_fecha_ven >= @w_fecha_hoy) or (@w_renova_todo='S') --29-Abr-99 xca B067
   begin
      if (@w_op_fecha_pg_int = @w_fecha_ven) and (@w_fpago = 'PER')
      begin
         select @w_ult_tasa_nom = @w_tasa
         select @w_ult_tasa_efec_anual = @w_tasa_efec_anual
         select @w_tasa = @w_tasa_nom_temp
         select @w_tasa_efec_anual = @w_tasa_efec_temp
      end

      select @w_money = @w_total_intereses

      select @w_total_renta  = @w_imp_retenido    -- VUNYM%


      exec @w_return = sp_debita_int
      @s_ssn              = @s_ssn,
      @s_user             = @s_user,
      @s_ofi              = @s_ofi,
      @s_date             = @s_date,
      @s_term             = @s_term,
      @s_srv              = @s_srv,
      @t_debug            = @t_debug,
      @t_trn              = @t_trn,
      @i_secuencia        = @w_secuencia,
      @i_sub_secuencia    = 1,
      @i_num_banco        = @w_num_banco,
      @i_monto            = @w_total_intereses,
      @i_producto         = @w_producto,
      @i_fecha_proceso    = @w_fecha_hoy,
      @i_cuenta           = @w_num_banco,
      @i_en_linea         = 'N',
      @i_beneficiario     = @w_ente,               -- GAL 18/SEP/2009 - RVVUNICA
      @i_paga_int         = 'S', --CVA Oct-21-05
      @i_fecha_ult_pg_int = @w_fecha_ult_pg_int, --CVA Oct-25-05
      @i_impuesto         = @w_imp_retenido,  -- NYM DPF00015 ICA
      @i_ica              = @w_val_ica,    -- NYM DPF00015 ICA
      @o_mensaje          = @w_mensaje out        --CVA Jun-29-06

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      if @w_producto = 'CAP' or @w_producto = 'PFI'
      begin
         --print 'moneycapitailz %1 ',@w_money
         select @w_monto_capitalizar = @w_monto_capitalizar + @w_total_intereses -- @w_total_renta - @w_total_ica
      end

   end  --SI CAPITALIZA
   else -- Si no Capitaliza o @w_renova_todo = N
   begin
   
      /* SE VERIFICA SI LA OPERACION TIENE EMBARGOS PARA LOS INTERESES */
      if exists(select 1 
      from  pf_bloqueo_legal 
      where bl_operacion = @w_op_operacion 
      and   bl_estado = 'I'
      and   isnull(bl_valor_int_embgdo_banco, 0) - isnull(bl_valor_int_embgdo_aplicado, 0) > 0)
      begin
      
         /* GENERO UN VXP PARA EL CLIENTE */
         select @w_nomlar = en_nomlar
         from   cobis..cl_ente
         where  en_ente = @w_ente
      
         exec @w_error = sp_embargo_int
         @s_date      = @w_fecha_hoy,
         @i_operacion = @w_op_operacion,
         @i_ente      = @w_ente,
         @i_nomlar    = @w_nomlar,
         @i_oficina   = @w_ofi_org,
         @i_moneda    = @w_moneda,
         @i_monto_int = @w_total_intereses_bruto,
         @i_fpago	  = @w_fpago
         
         if @w_error <> 0 goto ERROR
         
         select @w_embargo = 'S'
      end
   
      select
      @w_contor           = 0,
      @w_pt_beneficiario  = 0,
      @w_pt_secuencia     = 0,
      @w_monto_acum       = 0,
      @w_total_renta      = 0,                          -- GAL 15/SEP/2009 - RVVUNICA
      @w_total_ica        = 0                           -- GAL 15/SEP/2009 - RVVUNICA

      select @w_count = count(1)
      from pf_det_pago
      where dp_operacion   = @w_op_operacion
      and   dp_tipo       in ('INT','INTV')
      and   dp_estado      = 'I'
      and   dp_estado_xren = 'N'

      while @w_contor < @w_count
      begin
         set rowcount 1
         select @w_pt_beneficiario = dp_ente,
         @w_pt_tipo         = dp_tipo,
         @w_pt_secuencia    = dp_secuencia,
         @w_pt_forma_pago   = dp_forma_pago,
         @w_pt_cuenta       = dp_cuenta,
         @w_pt_monto        = dp_monto,
         @w_pt_moneda_pago  = dp_moneda_pago,
         @w_pt_benef_chq    = dp_descripcion,
         @w_pt_tipo_cliente = dp_tipo_cliente,
         @w_pt_oficina      = dp_oficina,
         @w_pt_tipo_cuenta_ach = dp_tipo_cuenta_ach,
         @w_pt_cod_banco_ach   = dp_cod_banco_ach
         from pf_det_pago
         where dp_operacion   = @w_op_operacion
         and   dp_secuencia   > @w_pt_secuencia
         and   dp_tipo       in ('INT','INTV') --CVA Oct-15-05 INTV
         and   dp_estado      = 'I'
         and   dp_estado_xren = 'N'
         order by dp_secuencia

         if @@rowcount = 0
            break

         set rowcount 0

         if @w_tcapitalizacion = 'S'
            select @w_pt_forma_pago='CAP'

	 
	 -- Si es cheque de gerencia o cheque comercial
	 -- y el beneficairio esta en listas Inhibitorias se 
	 -- cambia medio de pago a VXP para que se pague en linea con un beneficiario adecuado.
	 
	 print ' @w_pt_beneficiario ' +  cast(@w_pt_beneficiario as varchar)
	 print ' @w_pt_forma_pago ' +  cast(@w_pt_forma_pago as varchar)
	 print ' @w_nchg ' +  cast(@w_nchg as varchar)
	 print ' @w_nchc ' +  cast(@w_nchc as varchar)

	 if @w_pt_forma_pago in (@w_nchg,@w_nchc) begin
	    if exists (      
	    select 	1
      	    from 	cobis..cl_ente,
			cobis..cl_refinh
      	    where en_ente 		= @w_pt_beneficiario 
      	    and	en_mala_referencia 	= 'S'
	    and	in_tipo_ced 		= en_tipo_ced
	    and	in_ced_ruc 		= en_ced_ruc
	    ) begin
               select @w_mensaje_1 = 'Aplica_inst_can. Se cambio medio de pago '+  @w_pt_forma_pago + '  a VXP por que Ente: ' + cast(@w_pt_beneficiario as varchar) + ' Esta en Ref.Inhibitorias'
               select @w_pt_forma_pago = @w_par_pago
               exec sp_errorlog
                    @i_fecha   = @s_date,
                    @i_error   = 0,
                    @i_usuario = @s_user,
                    @i_tran    = @t_trn,
                    @i_descripcion = @w_mensaje_1,
                    @i_cuenta  = @w_num_banco
      	    end
         end

         select @w_porcen_int= convert(float, @w_pt_monto) / convert(float, @w_money)

         select @w_monto_mov  = round ((@w_total_intereses * @w_porcen_int), @w_numdeci)

         select @w_imp       = round(@w_imp_retenido * @w_porcen_int,  @w_numdeci)

         if  @w_contor = (@w_count - 1 ) and @w_contor > 0
         begin
            select @w_monto_mov = @w_total_intereses - @w_monto_acum

            select @w_imp    = @w_imp_retenido - @w_total_renta
            -- print 'montovov %1!', @w_monto_mov
         end

         --  print 'totintr %1!, montmov %2!', @w_monto_acum, @w_monto_mov
         if (@w_op_fecha_pg_int = @w_fecha_ven) and (@w_fpago = 'PER'or @w_fpago = 'VEN') --CVA Oct-15-05
         begin
            select @w_ult_tasa_nom          = @w_tasa
            select @w_ult_tasa_efec_anual   = @w_tasa_efec_anual
            select @w_tasa                  = @w_tasa_nom_temp
            select @w_tasa_efec_anual       = @w_tasa_efec_temp
         end

         exec @w_return = sp_debita_int
         @s_ssn              = @s_ssn,
         @s_user             = @s_user,
         @s_ofi              = @s_ofi,
         @s_date             = @s_date,
         @s_term             = @s_term,
         @s_srv              = @s_srv,
         @t_debug            = @t_debug,
         @t_trn              = @t_trn,
         @i_secuencia        = @w_secuencia,
         @i_sub_secuencia    = @w_contor,
         @i_num_banco        = @w_num_banco,
         @i_monto            = @w_monto_mov,       -- valor leido de pf_det_pago
         @i_producto         = @w_pt_forma_pago,
         @i_fecha_proceso    = @w_fecha_hoy,
         @i_cuenta           = @w_pt_cuenta,
         @i_en_linea         = 'N',
         @i_beneficiario     = @w_pt_beneficiario,
         @i_moneda_pago      = @w_pt_moneda_pago,
         @i_benef_chq        = @w_pt_benef_chq,
         @i_tipo_cliente     = @w_pt_tipo_cliente,
         @i_oficina          = @w_pt_oficina,
         @i_cod_banco_ach    = @w_pt_cod_banco_ach,
         @i_tipo_cuenta_ach  = @w_pt_tipo_cuenta_ach,
         @i_paga_int         = 'S', --CVA Oct-21-05
         @i_fecha_ult_pg_int = @w_fecha_ult_pg_int, --CVA Oct-25-05
         @i_impuesto         = @w_imp,      -- NYM DPF00015 ICA
         @i_ica              = @w_ica,      -- NYM DPF00015 ICA
         @o_mensaje          = @w_mensaje out        --CVA Jun-29-06

         if @w_return <> 0
         begin
            select @w_error = @w_return
            goto ERROR
         end

         select
         @w_contor       = @w_contor + 1,
         @w_monto_acum   = @w_monto_acum + @w_monto_mov,
         @w_total_renta  = @w_total_renta + @w_imp    -- NYM DPF00015 ICA


         if @w_pt_forma_pago = 'CAP' or @w_pt_forma_pago = 'PFI'
           select  @w_monto_capitalizar = @w_monto_capitalizar + @w_monto_mov  -- @w_total_renta - @w_total_ica    GAL 15/SEP/2009 - RVVUNICA


      end -- END WHILE

      set rowcount 0
      
   end   /* Si no Capitaliza o @w_renova_todo = N */

   select @w_valor = @w_total_intereses_bruto --@w_money  -- NYM DPF00015

   if @w_tcapitalizacion = 'S'
          select    @w_descripcion = 'CAPITALIZACION (' + @w_num_banco + ')',
                    @w_valor_cap = @w_money
   else
          select    @w_descripcion = 'PAGO DE INTERESES (' + @w_num_banco + ')',
                    @w_valor_cap = 0

   select @w_fecha = convert(datetime,convert(varchar,@w_fecha_hoy,101))


   if @w_valor > 0
   begin
      /* CALCULO EL VALOR A CONTABILIZAR POR EMERGENCIA ECONOMICA GMF */
      exec @w_error = sp_valor_gmf
      @s_date         = @s_date,
      @i_tran         = 14905,
      @i_operacionpf  = @w_op_operacion,
      @i_secuencia    = @w_secuencia,
      @o_valor_iee    = @w_valor_iee out

      if @w_error <> 0 goto ERROR

      exec @w_error = cob_pfijo..sp_aplica_conta
      @s_date               = @s_date,
      @s_user               = @s_user,
      @s_term               = @s_term,
      @s_ofi                = @s_ofi,
      @i_fecha              = @w_fecha,
      @i_tran               = @t_trn,
      @i_oficina_oper       = @w_ofi_org,
      @i_operacionpf        = @w_op_operacion,
      @i_afectacion         = 'N',
      @i_descripcion        = @w_descripcion,
      @i_valor              = @w_valor,
      @i_valor_cap          = @w_valor_cap,
      @i_secuencia          = @w_secuencia,
      @i_impuesto_emerg_eco = @w_valor_iee,
      @i_impuesto           = @w_total_renta,   -- NYM DPF00015 ICA
      @i_ica                = @w_total_ica,     -- NYM DPF00015 ICA
      @o_comprobante        = @o_comprobante out

      if @w_error <> 0 goto ERROR

      insert into pf_relacion_comp values (
      @w_num_banco, @o_comprobante, @t_trn,
      'PAGINT',     'N',            null,
      0,            @s_date)

      if @@error <> 0 begin
         select @w_error = 143054
         goto ERROR
      end
  end


   --++ ACTUALIZACION DE DATOS DE LA OPERACION --++++++++++++++++++++++++++--++++++++++++++++++++++++++--++++++++++++++++++++++++++

   select @w_fecha_ult_pg_int = @w_fecha_hoy

   if @w_tcapitalizacion = 'S'
          select @w_monto_pg_int = @w_monto_pg_int + @w_total_intereses


   if @w_fpago = 'PER'
   begin
          update pf_cuotas                        --*-* ACTUALIZA CUOTA ACTUAL COMO PAGADA
          set cu_estado = 'P'
          where cu_operacion       = @w_op_operacion
               and cu_fecha_pago   = @w_op_fecha_pg_int
               and cu_estado       = 'V'

          if @@error <> 0 or @@rowcount <> 1
          begin
               select @w_error = 145054
               select @w_mensaje = 'paga_int.sp Error al actualizar cuota'
               goto ERROR
          end

          if @w_op_fecha_pg_int < @w_fecha_ven    --*-* SI NO ES EL ULTIMO PAGO DE INTERES OBTIENE VALOR DE SIGUIENTE CUOTA
          begin

           -- Busca siguiente cuota de pago
             set rowcount 1
             select    @w_cu_valor_cuota    = cu_valor_cuota,
                       @w_cu_fecha_pago     = cu_fecha_pago
             from pf_cuotas
             where cu_operacion       = @w_op_operacion
             and cu_fecha_pago   > @w_op_fecha_pg_int
             and cu_estado = 'V'

             if @@rowcount <> 1
             begin
                select @w_error = 145054      --**-*MENSAJE NO EXISTE CUOTA PARA SIGUIENTE PERIODO
                select @w_mensaje = 'paga_int.sp No existe cuota para siguiente periodo'
                goto ERROR
             end

             -- Actualizacion de detalle de pagos
             -------------------------------------
             update pf_det_pago
             set dp_monto = round( (@w_cu_valor_cuota * dp_porcentaje / 100.00), @w_numdeci)
             where dp_operacion = @w_op_operacion
                  and  dp_tipo in('INT','INTV')
                  and  dp_estado_xren = 'N'
                  and  dp_estado      = 'I'

             if @w_count > 1     -- Si hay mas de un detalle de pago
             begin
                select @w_money = sum(dp_monto)
                from pf_det_pago
                where dp_operacion   = @w_op_operacion
                and   dp_tipo       in ('INT','INTV')
                and   dp_estado_xren = 'N'
                and   dp_estado      = 'I'
                and   dp_secuencia   < @w_count

                update pf_det_pago
                set  dp_monto = @w_cu_valor_cuota - @w_money
                where dp_operacion   = @w_op_operacion
                and   dp_tipo       in ('INT','INTV')
                and   dp_estado_xren = 'N'
                and   dp_estado      = 'I'
                and   dp_secuencia   = @w_count
             end
          end
          else -- Si es la ultima cuota deja los valores originales de interes estimado y proximo pago de interes
             select @w_cu_valor_cuota = @w_int_estimado,
                    @w_cu_fecha_pago  = @w_op_fecha_pg_int

          -- Actualiza datos de la operacion
          ---------------------------------------------

             update pf_operacion
             set  op_total_int_pagados   = @w_total_int_pagados +  @w_total_intereses_bruto,
                  op_fecha_ult_pg_int    = op_fecha_pg_int,
                  op_monto_pg_int        = @w_monto_pg_int,
                  op_monto               = @w_monto_pg_int,         --*-*
                  op_int_ganado          = 0,
                  op_int_pagados         = 0,
                  op_fecha_mod           = @s_date,
                  op_historia            = @v_historia + 1,
                  op_mon_sgte            = @w_secuencia + 1,
                  ---------------------------------------------
                  op_fecha_total         = @w_cu_fecha_pago,        --*-*
                  op_int_estimado        = @w_cu_valor_cuota,       -- actualiza interes estimado                ==> OK
                  op_fecha_pg_int        = @w_cu_fecha_pago,
                  -- NYM DPF00015 ICA
                  op_retienimp           = @w_retienimp,
                  op_ica                 = @w_ret_ica,
                  op_total_int_retenido  = op_total_int_retenido + @w_total_renta,
                  op_total_ica           = op_total_ica + @w_total_ica,
                  op_total_int_estimado  = @w_total_int_estimado
                  -- NYM DPF00015 ICA
             where op_operacion = @w_op_operacion
             if @@error <> 0
             begin
                  /*exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 145001
                  */
                  select @w_error = 145054                  -- GAL 01/SEP/2009 - RVVUNICA
                  goto ERROR
             end
          end --Si el producto es PER

     if @w_fpago  = 'VEN'
     begin
          update pf_operacion
          set  op_total_int_pagados   = @w_total_int_pagados +  @w_total_intereses_bruto,
               op_fecha_ult_pg_int    = op_fecha_pg_int,
               op_monto_pg_int        = @w_monto_pg_int,
               op_monto               = @w_monto_pg_int,         --*-*
               op_int_ganado          = 0,
               op_int_pagados         = 0,
               op_fecha_mod           = @s_date,
               op_historia            = @v_historia + 1,
               op_mon_sgte            = @w_secuencia + 1,
               ---------------------------------------------
               op_fecha_total         = @w_op_fecha_pg_int,       --*-*
               -- NYM DPF00015 ICA
               op_retienimp           = @w_retienimp,
               op_ica                 = @w_ret_ica,
               op_total_int_retenido  = op_total_int_retenido + @w_total_renta,
               op_total_ica           = op_total_ica + @w_total_ica
               -- NYM DPF00015 ICA
          where op_operacion = @w_op_operacion

          if @@error <> 0
          begin
               select @w_error = 145001
               goto ERROR
          end
     end
--------------------------------------------------------------------------------------------------------------------------------------------
     select @w_monto_capitalizar = @w_monto_capitalizar +  @v_monto --CVA Set-19-05

     if @v_fecha_ult_pg_int = @w_fecha_valor and @w_fpago = 'PER' --CVA Nov-13-05
          select @v_fecha_ult_pg_int = NULL

     if @v_fecha_ult_pg_int = @w_fecha_valor and @w_fpago = 'VEN' --CVA Nov-13-05
          select @v_fecha_ult_pg_int = NULL

     if @w_op_fecha_ult_pago_int_ant IS  NOT  NULL
     begin
          if @w_op_fecha_ult_pago_int_ant >= @v_fecha_ult_pg_int and @w_op_fecha_ult_pago_int_ant <= @w_op_fecha_pg_int
               select @v_fecha_ult_pg_int = @w_op_fecha_ult_pago_int_ant
     end
     
     select @w_secuencial = max(hi_secuencial)
     from   pf_historia
     where  hi_operacion  = @w_op_operacion
     
     if @w_secuencial >= @v_historia begin
        
        select @v_historia = @w_secuencial + 1
        
        update pf_operacion
        set    op_historia = @v_historia + 1
        where op_operacion = @w_op_operacion
        
        if @@error <> 0 begin
           select @w_error = 145001
           goto ERROR
        end
        
     end    

     insert pf_historia
          (hi_operacion,   hi_secuencial, hi_fecha,
          hi_trn_code,     hi_valor,      hi_funcionario,
          hi_oficina,      hi_fecha_crea, hi_fecha_mod,
          hi_saldo_capital, hi_fecha_anterior, hi_secuencia)
     values (@w_op_operacion, @v_historia,   @s_date,
          @t_trn,          @w_total_intereses,      @s_user,
          @s_ofi,          @s_date,       @s_date,
          @w_monto_capitalizar, @v_fecha_ult_pg_int, @w_secuencia)
     if @@error <> 0
     begin
          select @w_error = 143006
          goto ERROR
     end

     if @w_monto_pg_int = @v_monto_pg_int
          select @w_monto_pg_int = NULL, @v_monto_pg_int = NULL
     if @w_int_estimado = @v_int_estimado
          select @w_int_estimado = NULL, @v_int_estimado = NULL
     if @w_total_int_pagados = @v_total_int_pagados
          select @w_total_int_pagados = NULL, @v_total_int_pagados = NULL
     --if @w_op_fecha_pg_int = @v_op_fecha_pg_int
     --     select @w_op_fecha_pg_int = NULL, @v_op_fecha_pg_int = NULL
     if @w_fecha_ult_pg_int = @v_fecha_ult_pg_int
          select @w_fecha_ult_pg_int = NULL, @v_fecha_ult_pg_int = NULL
     if @w_historia = @v_historia
          select @w_historia = NULL, @v_historia = NULL
     if @w_int_pagados = @v_int_pagados
          select @w_int_pagados = NULL, @v_int_pagados = NULL

     insert ts_operacion (secuencial,           tipo_transaccion,   clase,               usuario,          terminal,
          srv,                  lsrv,               fecha,               num_banco,        operacion,
          monto_pg_int,         int_ganado,         int_provision,       int_estimado,     int_pagados,
          total_int_pagados,    fecha_pg_int,       fecha_ult_pg_int,    historia,         fecha_mod,       mon_sgte,
          tasa)
     values (@s_ssn,            @t_trn,            'P',                  @s_user,          @s_term,
          @s_srv,               @s_lsrv,            @s_date,             @w_num_banco,     @w_op_operacion,
          @v_monto_pg_int,      @v_int_ganado,      @v_int_provision,    @v_int_estimado,  @v_int_pagados,
          @v_total_int_pagados, @v_op_fecha_pg_int, @v_fecha_ult_pg_int, @v_historia,      @v_fecha_mod,    @w_secuencia,
          @w_tasa)
     if @@error <> 0
     begin
          select @w_error = 143005
          goto ERROR
     end

      if @w_embargo = 'S' and @w_fpago = 'PER' 
      begin

         /* INSERCION DETALLE DE PAGO INTERESES */
         select @w_sec = isnull(max(dp_secuencia), 0) + 1
         from   pf_det_pago
         where  dp_operacion = @w_op_operacion

         set rowcount 0
         
         update	pf_det_pago
         set	dp_estado = 'E'
         where  dp_operacion = @w_op_operacion
         
         if @@error <> 0 begin
            select @w_error = 147038
            goto ERROR
         end

         insert into pf_det_pago(
         dp_operacion,       dp_secuencia,       dp_ente,           
         dp_forma_pago,      dp_tipo,            dp_moneda_pago,     
         dp_monto,           dp_porcentaje,      dp_estado_xren,    
         dp_estado,          dp_fecha_crea,      dp_fecha_mod,      
         dp_descripcion,     dp_oficina,         dp_tipo_cliente,    
         dp_benef_chq      )
         values(
         @w_op_operacion,       @w_sec,             @w_ente,
         @w_pg_cli,             'INT',              @w_moneda,
         @w_cu_valor_cuota, 100,                'N',
         'I',                   @s_date,            @s_date,
         @w_nomlar,             @w_ofi_org,         'M',
         @w_ente)
         
         if @@error <> 0 begin
            select @w_error = 143038
            goto ERROR
         end         

             set rowcount 1

      end

   if @w_tran_abierta = 'S' begin
      commit tran    --*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*
      select @w_tran_abierta = 'N'
   end



--print 'pagaint @i_fecha_proceso ' + cast(@i_fecha_proceso as varchar)
print 'OPERACION ..............' + @i_num_banco + ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
   -----------------------------------------------------------------------
   -- Llamada a proceso de Recalculo de intereses con nueva tasa flotante
   -----------------------------------------------------------------------
print '@w_op_fecha_pg_int:' + cast(@w_op_fecha_pg_int as varchar) + ' @w_fecha_ven:' + cast(@w_fecha_ven as varchar)
   if @w_op_fecha_pg_int < @w_fecha_ven
   begin
print 'PAGA_INT  ==> CAMBIA TASA...'
      Begin tran
      print '@i_fecha_proceso ' + cast (@i_fecha_proceso as varchar) + cast ( @w_op_operacion as varchar)

         exec @w_return        = cob_pfijo..sp_calcula_int_tasavar
              @s_ssn           = @s_ssn,
              @s_user          = @s_user,
              @s_term          = @s_term,
              @s_date          = @i_fecha_proceso,
              @s_srv           = @s_srv,
              @s_lsrv          = @s_lsrv,
              @t_debug         = @t_debug,
              @t_file          = @t_file,
              @t_trn           = 14948,
              @i_operacion     = 'U',
              @i_fecha_proceso = @i_fecha_proceso,
              @i_op_operacion  = @w_op_operacion

         if @w_return <> 0
         begin
            print 'bt_fidia.sp ERROR EN CALC_TASA_VAR' + '@w_return ' + cast(@w_return as varchar  )
            select @w_error   = 149049,
            @w_mensaje = 'bt_india.sp ERROR SP_INICIO_DE_DIA',
            @w_pago_interes = 'N'
            goto ERROR
         end
      Commit tran
   end

end --FECHA DE PAGO DE INTERES

return  0

ERROR:

     print 'paga_int.sp Registra bloque de error %1!'+cast( @w_error as varchar)

     if @w_tran_abierta = 'S'
        rollback tran

     exec sp_errorlog
        @i_fecha        = @s_date,
        @i_error        = @w_error,
        @i_usuario      = @s_user,
        @i_tran         = @t_trn,
        @i_cuenta       = @i_num_banco,
        @i_descripcion  = @w_mensaje,   --CVA Oct-13-05
        @i_cta_pagrec   = @w_descuadre  --CVA Oct-13-05

     return @w_error
go
