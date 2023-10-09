/************************************************************************/
/*  Base de datos:          cob_cartera                                 */
/*  Producto:               Cartera                                     */
/*  Disenado por:           kvizcaino                                   */
/*  Fecha de escritura:     28/03/2022                                  */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*  Devolver datos referencia generica                                  */
/************************************************************************/  
/*                        MOFICACIONES                                  */
/*  FECHA              AUTOR                   RAZON                    */
/*  28/03/2022         KVI          Version Inicial                     */
/************************************************************************/  
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_devolver_datos_ref_generica')
	drop proc sp_devolver_datos_ref_generica
GO

create proc sp_devolver_datos_ref_generica(
    @s_ssn              int                = null,
    @s_user             login              = null,
    @s_sesn             int                = null,
    @s_term             varchar(30)        = null,
    @s_date             datetime           = null,
    @s_srv              varchar(30)        = null,
    @s_lsrv             varchar(30)        = null,
    @s_ofi              smallint           = null,
    @s_servicio         int                = null,
    @s_rol              smallint           = null,
    @s_culture          varchar(10)        = null,
    @s_org              char(1)            = null,
    @i_operacion        char(1),
	@i_referencia       varchar(255),                 -- referencia que recibe del corresponsal
    @i_corresponsal     varchar(30),                  -- nombre del corresponsal
    @i_token            varchar(255)       = null,
    @o_partial          char(1)            = ''  out, -- parcial (P) o total (T)   
    @o_monto_min        money              = 0   out,
    @o_monto_max        money              = 0   out,
    @o_comision         money              = 0   out,
    @o_saldo_exigible   money              = 0   out,
    @o_tipo_tran        char(2)            = ''  out,
    @o_cuenta           varchar(30)        = ''  out, -- numero de cuenta del cliente
    @o_nombre           varchar(125)       = ''  out, -- nombre del cliente
    @o_status           varchar(30)        = ''  out, -- estado del credito (cancelado, bloqueado, etc)
    @o_codigo_err       varchar(50)        = ''  out, -- codigo del error esperado por el corresponsal
    @o_mensaje_err      varchar(100)       = ''  out, -- mensaje de error 
    @o_monto_liquidar   money              = 0   out  -- Monto liquidar	
)
as
declare 
@w_error                    int,
@w_sp_name                  varchar(30),
@w_msg                      varchar(255),
@w_tipo_tran                varchar(30),  -- (GL) Garantia Líquida, (PG) Préstamo Grupal, (PI) Préstamo Individual,                                    -- (PR) Precancelación, (CG)Cancelacción de Crédito Grupal, (CI)Cancelación de Crédito Individual
@w_codigo_interno            varchar(30), -- codigo de tramite o codigo de grupo segun el tipo de transaccion 
@w_sp_val_corresponsal       varchar(50), -- nombre del sp que ejecuta la validacion para el corresponsal
@w_tramite                  int, 
@w_grupo                    int,          -- de @w_codigo_interno
@w_monto_pagado             money,        -- monto registrado en el tanqueo que no se ha procesado
@w_limite_min               money,        -- parametro minino de pago configurado para el corresponsal
@w_limite_max               money,        -- parametro maximo de pago configurado para el corresponsal
@w_fecha_proceso            datetime, 
@w_saldo_exigible           money,        -- monto pendiente de pago a la fecha de proceso
@w_saldo_precancelar        money,        -- valor para precancelar el prestamo
@w_saldo_precancelar_com    money,
@w_saldo_exigible_com       money,        -- saldo exigible COMISION MORA
@w_max_ciclo                int,          -- maximo ciclo del grupo
@w_banco                    cuenta,
@w_operacion                int,
@w_est_vigente              int,
@w_est_vencido              int,
@w_est_cancelado            int,
@w_fecha_valor              datetime,     -- devuelve la referencia
@w_monto                    money,        -- devuelve la referencia
@w_id_corresponsal          varchar(10),
@w_cliente                  int,
@w_fecha_pago_str           char(10),
@w_tipo                     char(2),
@w_tramite_grupal           int,
@w_token_validacion         varchar(255),
@w_fecha_vencimiento        datetime,
@w_estado                   int,          -- estado de la operacion
@w_total_precancelar        money,
@w_total_exigible           MONEY,
@w_toperacion               VARCHAR(255),
@w_error_tmp                int, 
@w_monto_seg                money,
@w_pagado_seg               varchar(2),
@w_fecha_liq                datetime,
@w_precancela_dias          int,
@w_monto_seguro_basico      money,
@w_monto_gar_liquida        money,
@w_es_hija                  varchar(1)  


select @w_sp_name = 'sp_devolver_datos_ref_generica'

select @w_es_hija = 'N'

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

--BUSCA SP PARA VALIDAR REFERENCIA, DEPENDIENDO DEL CORRESPONSAL
select  
@w_sp_val_corresponsal = co_sp_validacion_ref,
@w_id_corresponsal     = co_id,
@w_token_validacion    = co_token_validacion
from ca_corresponsal 
where co_nombre = @i_corresponsal 

--si no existe el corresponsal en la tabla--
if @@rowcount = 0
begin 
   select 
   @w_error = 70305,
   @w_msg   = 'ERROR: NO EXISTE EL CORREPONSAL PARAMETRIZADO'
   goto ERROR_FIN
end

exec @w_error   = sp_estados_cca
@o_est_vigente  = @w_est_vigente    out,
@o_est_vencido  = @w_est_vencido    out,
@o_est_cancelado= @w_est_cancelado  out

--si falla la consulta de estados--
if @w_error <> 0
begin 
   SELECT
   @w_error = 70306,
   @w_msg = 'ERROR: ERROR AL CONSULTAR ESTADOS DE CARTERA'
   goto ERROR_FIN
end
   
--DATOS PRINCIPALES   
select @w_codigo_interno = rg_codigo_interno, 
       @w_tipo_tran = rg_tipo
from cob_cartera..ca_referencia_generica 
where rg_referencia = @i_referencia

if exists (select 1 from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
           where op_operacion = tg_operacion 
           and op_operacion = @w_codigo_interno)
begin
  select @w_es_hija = 'S'
end


--BUSCAR LIMITE MINIMO Y MAXIMO POR CORRESPONSAL Y TIPO DE TRANSACCION
select  
@w_limite_max = cl_limite_max,
@w_limite_min = cl_limite_min
from ca_corresponsal_limites 
where cl_corresponsal_id = @w_id_corresponsal
and cl_tipo_tran         = @w_tipo_tran

--SI NO EXISTE LAS ENTRADAS PARA EL CORRESPONSAL EN LA TABLA
if @@rowcount = 0
begin 
   select 
   @w_error = 70303,
   @w_msg   = 'ERROR: NO EXISTE CONFIGURACION PARA LIMITES DE PAGO'
   goto ERROR_FIN
end
   
select @o_tipo_tran = @w_tipo_tran

select 
@o_partial     = 'P',
@o_codigo_err  = '00', --codigo del error esperado por el corresponsal
@o_mensaje_err = 'TRANSACCION EXITOSA'


------ CONSULTA DE PAGO O CANCELACION GRUPAL PADRE----------
if  (@w_tipo_tran = 'PG' or @w_tipo_tran = 'CG') and @w_es_hija = 'N'
begin
   select  
   @w_banco          = op_banco,
   @w_toperacion     = op_toperacion
   from  ca_operacion 
   where op_operacion = @w_codigo_interno
 
   if @@rowcount = 0 begin 
       select
       @w_error = 70301,
       @w_msg = 'ERROR: NO EXISTE PRESTAMO GRUPAL'
       goto ERROR_FIN
   end
  
   select  
   @w_grupo     = dc_grupo,
   @w_max_ciclo = isnull(dc_ciclo_grupo,0) 
   from cob_cartera..ca_det_ciclo 
   where dc_referencia_grupal = @w_banco 

   select @o_cuenta = isnull(@i_referencia,'')
    
   select @o_nombre = cob_conta_super.dbo.fn_formatea_ascii_ext(gr_nombre,'AN')
   from cobis..cl_grupo
   where gr_grupo = @w_grupo
 
   select operacion = op_operacion,  banco=op_banco,  oficina = op_oficina, fecha_ult_proceso= op_fecha_ult_proceso, cliente = op_cliente, estado = op_estado  
   into #prestamos_grupo  
   from cob_cartera..ca_operacion
   where op_estado <>  @w_est_cancelado
   and op_operacion in (select dc_operacion from ca_det_ciclo where dc_grupo = @w_grupo and dc_ciclo_grupo = @w_max_ciclo )

   /* *********** LLEVAR A LA OPERCIONES A LA FECHA DE PROCESO ******************/
   declare cursor_fecha_valor cursor for select banco
   from #prestamos_grupo
   where fecha_ult_proceso <> @w_fecha_proceso
   for read only
 
   open cursor_fecha_valor
   fetch cursor_fecha_valor into @w_banco
  
   while @@fetch_status = 0  begin

      exec  @w_error = sp_fecha_valor 
      @s_date        = @w_fecha_proceso,
      @s_user        = @s_user,
      @s_term        = @s_term,
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha_proceso,
      @i_fecha_valor = @w_fecha_proceso,
      @i_banco       = @w_banco,
      @i_secuencial  = 1,
      @i_operacion   = 'F'
         
      if @w_error != 0 begin
         select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)
         close cursor_fecha_valor
         deallocate cursor_fecha_valor
         goto ERROR_FIN      
      end
      fetch cursor_fecha_valor into @w_banco
   end

   close cursor_fecha_valor
   deallocate cursor_fecha_valor

    --Saldo que debe cancelar al dia de hoy(fecha_proceso), por cuotas vencidas o cuotas vigentes que deben pagarse hoy(fecha_proceso) 
    select 
    @w_saldo_exigible     = isnull(sum(case when am_concepto not in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
    @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
    @w_estado =  min(estado)
	from  #prestamos_grupo, ca_dividendo, ca_amortizacion
    where am_operacion = di_operacion
    and   am_dividendo = di_dividendo
    and   am_operacion = operacion
    and   (di_estado = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
	   
    if @w_saldo_exigible = 0 begin
      select 
      @w_saldo_exigible     = isnull(sum(case when am_concepto not in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
      @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
      @w_fecha_vencimiento  = max(di_fecha_ven),
      @w_estado =  min(estado)
	  from  ca_dividendo, ca_amortizacion, #prestamos_grupo
      where am_operacion = di_operacion
      and   am_operacion = operacion
      and   am_dividendo = di_dividendo
      and   am_operacion = operacion
      and   di_estado    = @w_est_vigente 
    end
    select @o_status = case @w_estado when 2 then 'VENCIDA' when 3 then 'CANCELADA' else 'ACTIVA' end   
    	  
	---Saldo para precancelar el credito (INCLUYE MORA)
	select 
	@w_saldo_precancelar     = isnull(sum(case when am_acumulado + am_gracia>am_pagado then am_acumulado + am_gracia - am_pagado else 0 end),0),
	@w_saldo_precancelar_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0)
	from  #prestamos_grupo, ca_dividendo, ca_amortizacion
    where am_operacion = di_operacion
    and   am_dividendo = di_dividendo
    and   am_operacion = operacion 
    and   di_estado <> @w_est_cancelado
      
    ------PAGOS REGISTRADOS Y NO APLICADOS DE LA TABLA DE TANQUEO-------
   select @w_monto_pagado   = 0
  
end------ FIN CONSULTA DE PAGO O CANCELACION GRUPAL----------


------ CONSULTA DE PAGO O CANCELACION GRUPAL HIJA----------
if  (@w_tipo_tran = 'PG' or @w_tipo_tran = 'CG') and @w_es_hija = 'S'
begin
   select  
   @w_banco          = op_banco,
   @w_toperacion     = op_toperacion
   from  ca_operacion 
   where op_operacion = @w_codigo_interno
 
   if @@rowcount = 0 begin 
       select
       @w_error = 70301,
       @w_msg = 'ERROR: NO EXISTE PRESTAMO GRUPAL'
       goto ERROR_FIN
   end
  
   select  
   @w_grupo     = dc_grupo,
   @w_max_ciclo = isnull(dc_ciclo_grupo,0) 
   from cob_cartera..ca_det_ciclo 
   where dc_operacion = @w_codigo_interno 

   select @o_cuenta = isnull(@i_referencia,'')
    
   select @o_nombre = cob_conta_super.dbo.fn_formatea_ascii_ext(gr_nombre,'AN')
   from cobis..cl_grupo
   where gr_grupo = @w_grupo
 
   select operacion = op_operacion,  banco=op_banco,  oficina = op_oficina, fecha_ult_proceso= op_fecha_ult_proceso, cliente = op_cliente, estado = op_estado  
   into #prestamos_hijos 
   from cob_cartera..ca_operacion
   where op_estado <>  @w_est_cancelado
   and op_operacion = @w_codigo_interno 

   /* *********** LLEVAR A LA OPERCIONES A LA FECHA DE PROCESO ******************/
   declare cursor_fecha_valor cursor for select banco
   from #prestamos_hijos
   where fecha_ult_proceso <> @w_fecha_proceso
   for read only
 
   open cursor_fecha_valor
   fetch cursor_fecha_valor into @w_banco
  
   while @@fetch_status = 0  begin

      exec  @w_error = sp_fecha_valor 
      @s_date        = @w_fecha_proceso,
      @s_user        = @s_user,
      @s_term        = @s_term,
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha_proceso,
      @i_fecha_valor = @w_fecha_proceso,
      @i_banco       = @w_banco,
      @i_secuencial  = 1,
      @i_operacion   = 'F'
         
      if @w_error != 0 begin
         select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)
         close cursor_fecha_valor
         deallocate cursor_fecha_valor
         goto ERROR_FIN      
      end
      fetch cursor_fecha_valor into @w_banco
   end

   close cursor_fecha_valor
   deallocate cursor_fecha_valor

    --Saldo que debe cancelar al dia de hoy(fecha_proceso), por cuotas vencidas o cuotas vigentes que deben pagarse hoy(fecha_proceso) 
    select 
    @w_saldo_exigible     = isnull(sum(case when am_concepto not in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
    @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
    @w_estado =  min(estado)
	from  #prestamos_hijos, ca_dividendo, ca_amortizacion
    where am_operacion = di_operacion
    and   am_dividendo = di_dividendo
    and   am_operacion = operacion
    and   (di_estado = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
	   
    if @w_saldo_exigible = 0 begin
      select 
      @w_saldo_exigible     = isnull(sum(case when am_concepto not in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
      @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0),
      @w_fecha_vencimiento  = max(di_fecha_ven),
      @w_estado =  min(estado)
	  from  ca_dividendo, ca_amortizacion, #prestamos_hijos
      where am_operacion = di_operacion
      and   am_operacion = operacion
      and   am_dividendo = di_dividendo
      and   am_operacion = operacion
      and   di_estado    = @w_est_vigente 
    end
    select @o_status = case @w_estado when 2 then 'VENCIDA' when 3 then 'CANCELADA' else 'ACTIVA' end   
    	  
	---Saldo para precancelar el credito (INCLUYE MORA)
	select 
	@w_saldo_precancelar     = isnull(sum(case when am_acumulado + am_gracia>am_pagado then am_acumulado + am_gracia - am_pagado else 0 end),0),
	@w_saldo_precancelar_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0)
	from  #prestamos_hijos, ca_dividendo, ca_amortizacion
    where am_operacion = di_operacion
    and   am_dividendo = di_dividendo
    and   am_operacion = operacion 
    and   di_estado <> @w_est_cancelado
      
    ------PAGOS REGISTRADOS Y NO APLICADOS DE LA TABLA DE TANQUEO-------
   select @w_monto_pagado   = 0
  
end------ FIN CONSULTA DE PAGO O CANCELACION GRUPAL----------


if  @w_tipo_tran = 'PG' 
begin
   select @o_nombre = 'PAGO '+ @w_toperacion+ ' ('+@o_nombre+')'
   
   if @w_monto_pagado > @w_saldo_exigible_com begin
      select 
      @w_saldo_exigible     = @w_saldo_exigible - @w_monto_pagado, 
      @w_saldo_exigible_com = 0  ,
      @w_saldo_precancelar  = @w_saldo_precancelar - @w_monto_pagado 
	  
   end else begin
      select 
      @w_saldo_exigible     = @w_saldo_exigible - @w_monto_pagado, 
      @w_saldo_exigible_com = @w_saldo_exigible_com - @w_monto_pagado,
	  @w_saldo_precancelar  = @w_saldo_precancelar - @w_monto_pagado
	  
   end   
   
   if @w_saldo_exigible <= @w_limite_min begin
      select @o_monto_min = @w_saldo_exigible
   end else begin
      select @o_monto_min = @w_limite_min
   end
        
   if @w_saldo_precancelar > @w_limite_max begin
      select @o_monto_max = @w_limite_max
   end else begin
	  select @o_monto_max = @w_saldo_precancelar
   end     
	 
   select 
   @o_saldo_exigible = @w_saldo_exigible - @w_saldo_exigible_com,
   @o_comision       = @w_saldo_exigible_com
      
 end 
 
 
if  @w_tipo_tran = 'CG' 
begin

   select @o_nombre = 'CANCELACION '+ @w_toperacion +' ('+@o_nombre+')'
   
   if @w_monto_pagado > @w_saldo_precancelar_com begin
      select 
      @w_saldo_precancelar     = @w_saldo_precancelar - @w_monto_pagado, 
      @w_saldo_precancelar_com = 0   
	  
   end else begin
      select 
      @w_saldo_precancelar     = @w_saldo_precancelar     - @w_monto_pagado, 
      @w_saldo_precancelar_com = @w_saldo_precancelar_com - @w_monto_pagado
	  
   end   
   
   if @w_saldo_precancelar > @w_limite_max begin
      select 
	  @o_monto_min = @w_limite_max,
	  @o_monto_max = @w_limite_max
   end else begin
      select 
	  @o_monto_min = @w_saldo_precancelar,
	  @o_monto_max = @w_saldo_precancelar
   end
   
   select 
   @o_saldo_exigible = @w_saldo_precancelar - @w_saldo_precancelar_com,
   @o_comision       = @w_saldo_precancelar_com
end


------ CONSULTA DE PAGO INDIVIDUAL O CANCELACION INDIVIDUAL----------
if  @w_tipo_tran = 'PI' or @w_tipo_tran = 'CI'
begin
   select @w_operacion = convert(int,@w_codigo_interno)

   select @o_cuenta = isnull(@i_referencia,'')
    
   /* *********** LLEVAR A LA OPERACION A LA FECHA DE PROCESO ******************/
   select 
   @w_banco       = op_banco,
   @w_operacion   = op_operacion,
   @w_cliente     = op_cliente,
   @w_toperacion  = op_toperacion,
   @w_estado      = op_estado,
   @w_fecha_liq   = op_fecha_liq
   from cob_cartera..ca_operacion
   where op_estado <>  @w_est_cancelado
   and op_operacion= @w_operacion
  --SMO TEMPORAL PARA QUE DEVUELVA RESULTADOS, estoy desembolsando el mismo dia que consulto
   --and op_fecha_ult_proceso <> @w_fecha_proceso

   if @@rowcount = 0 begin 
       select
       @w_error = 70186,
       @w_msg = 'NO EXISTE EL CRÉDITO RELACIONADO A LA REFERENCIA O NO ACEPTA PAGOS'
       goto ERROR_FIN
   end
   
   select
   @w_monto_seg  = isnull(se_monto,0) - isnull(se_monto_devuelto, 0),
   @w_pagado_seg = isnull(se_estado, 'N')
   from ca_seguro_externo
   where se_operacion = @w_operacion
   and   isnull(se_monto,0) > isnull(se_monto_devuelto, 0)
   
   if (@@rowcount = 0) begin
      select 
	  @w_monto_seg  = 0,
      @w_pagado_seg = 'N'
   end

   select @o_nombre =cob_conta_super.dbo.fn_formatea_ascii_ext(en_nomlar,'AN')
   from cobis..cl_ente
   where en_ente = @w_cliente

   select @w_fecha_valor = @w_fecha_proceso
   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = @s_user,
   @s_term        = @s_term,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_valor,
   @i_banco       = @w_banco,
   @i_secuencial  = 1,
   @i_operacion   = 'F'
         
   if @w_error != 0 begin
      select 
      @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(VARCHAR,@w_fecha_proceso)
      goto ERROR_FIN
   end
	
	---Saldo para precancelar el crédito (NO INCLUYE MORA)
   select 
   @w_saldo_precancelar     = isnull(sum(case when am_acumulado + am_gracia > am_pagado then am_acumulado + am_gracia - am_pagado else 0 end),0),
   @w_saldo_precancelar_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0)
   from  ca_dividendo, ca_amortizacion
   where am_operacion = di_operacion
   and   am_dividendo = di_dividendo
   and   am_operacion = @w_operacion 
   and   di_estado <> @w_est_cancelado
	
   select @w_monto_pagado   = isnull(sum(co_monto),0)
   from cob_cartera..ca_corresponsal_trn
   where co_codigo_interno = @w_operacion 
   and co_estado           = 'I' -- Ingresado sin procesar
   and co_fecha_proceso    = @w_fecha_proceso
   and co_tipo             = @w_tipo_tran   
        
end


if  @w_tipo_tran = 'PI' 
begin

   select @o_nombre = 'PAGO '+ @w_toperacion +' ('+@o_nombre+')'
   --Saldo que debe cancelar al dia de hoy(fecha_proceso), por cuotas vencidas o cuotas vigentes que deben pagarse hoy(fecha_proceso) (NO INCLUYE MORA)
   select   
   @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
   @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0)
   from  ca_dividendo, ca_amortizacion
   where am_operacion = di_operacion
   and   am_dividendo = di_dividendo
   and   am_operacion = @w_operacion
   and   (di_estado = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
   
   select @o_status = case @w_estado when 2 then 'VENCIDA' when 3 then 'CANCELADA' else 'ACTIVA' end
   
   -- Si no tiene ninguna cuota vencida o una cuota vigente que deba pagarse el día de la consulta, devolvemos la cuota vigente 
   if @w_saldo_exigible = 0 begin
      select 
      @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
      @w_saldo_exigible_com = isnull(sum(case when am_concepto     in ('COMMORA','IVA_CMORA') then (am_cuota - am_pagado) else 0 end),0)
	  from  ca_dividendo, ca_amortizacion
      where am_operacion = di_operacion
      and   am_dividendo = di_dividendo
      and   am_operacion = @w_operacion
      and   di_estado    = @w_est_vigente 

   end
   
   if @w_monto_pagado > @w_saldo_exigible_com begin
      select 
      @w_saldo_exigible     = @w_saldo_exigible - @w_monto_pagado, 
      @w_saldo_exigible_com = 0 ,
	  @w_saldo_precancelar  = @w_saldo_precancelar - @w_monto_pagado 
	  
   end else begin
      select 
      @w_saldo_exigible     = @w_saldo_exigible - @w_monto_pagado,
      @w_saldo_exigible_com = @w_saldo_exigible_com - @w_monto_pagado,
	  @w_saldo_precancelar  = @w_saldo_precancelar - @w_monto_pagado
	  
   end   
   
   if @w_saldo_exigible <= @w_limite_min begin
      select @o_monto_min = @w_saldo_exigible
   end else begin
      select @o_monto_min = @w_limite_min
   end
        
   if @w_saldo_precancelar > @w_limite_max begin
      select @o_monto_max = @w_limite_max
   end else begin
	  select @o_monto_max = @w_saldo_precancelar
   end     
	 
   select 
   @o_saldo_exigible = @w_saldo_exigible - @w_saldo_exigible_com,
   @o_comision       = @w_saldo_exigible_com   

end


if @w_tipo_tran = 'CI' begin

   if datediff(dd, @w_fecha_liq, @w_fecha_proceso) <= @w_precancela_dias begin
      if @w_pagado_seg = 'S' begin
         select @w_saldo_precancelar = @w_saldo_precancelar - @w_monto_seg
	  end else begin 
	     select @w_saldo_precancelar = @w_saldo_precancelar
	  end
   end   
   
   select @o_nombre = 'CANCELACION '+ @w_toperacion +' ('+@o_nombre+')'
   
   if @w_monto_pagado > @w_saldo_precancelar_com begin
      select 
      @w_saldo_precancelar     = @w_saldo_precancelar - @w_monto_pagado ,
      @w_saldo_precancelar_com = 0   
	  
   end else begin
      select 
      @w_saldo_precancelar     = @w_saldo_precancelar     - @w_monto_pagado, 
      @w_saldo_precancelar_com = @w_saldo_precancelar_com - @w_monto_pagado
	  
   end   
   
   if @w_saldo_precancelar > @w_limite_max begin
      select 
	  @o_monto_min = @w_limite_max,
	  @o_monto_max = @w_limite_max
   end else begin
      select 
	  @o_monto_min = @w_saldo_precancelar,
	  @o_monto_max = @w_saldo_precancelar
   end
   
   select 
   @o_saldo_exigible = @w_saldo_precancelar - @w_saldo_precancelar_com,
   @o_comision       = @w_saldo_precancelar_com        

end


ERROR_FIN:

IF @w_error <> 0 begin
   select 
   @o_partial           = '',
   @o_monto_min         = 0 ,
   @o_monto_max         = 0 ,
   @o_comision          = 0 ,
   @o_saldo_exigible    = 0 ,
   @o_tipo_tran         = '',
   @o_cuenta            = '',
   @o_nombre            = '',
   @o_status            = '',
   @o_codigo_err        = '',
   @o_mensaje_err       = '',
   @o_monto_liquidar    = 0 
end

select   
@o_codigo_err  = ce_error_codigo, --codigo del error esperado por el corresponsal
@o_mensaje_err = cob_conta_super.dbo.fn_formatea_ascii_ext(ce_error_descripcion,'AN')
from ca_corresponsal_err
where ce_corresponsal_id = @w_id_corresponsal
and ce_error_cobis       = @w_error

if @@rowcount = 0 begin
   select @w_error_tmp = @w_error
   SELECT @w_error = 99 --ERROR GENERICO DE CONSULTA
   
   select   
   @o_codigo_err  = ce_error_codigo, --codigo del error esperado por el corresponsal
   @o_mensaje_err = ce_error_descripcion +' (ERROR:'+ convert(varchar,@w_error_tmp) + ')'
   from ca_corresponsal_err
   where ce_corresponsal_id = @w_id_corresponsal
   and ce_error_cobis       = @w_error
   
   if @@rowcount = 0 begin
      select 
      @o_codigo_err = @w_error,
      @o_mensaje_err = @w_msg +' (ERROR:'+ convert(varchar,@w_error_tmp) + ')'
   end 
end 

return 0

go