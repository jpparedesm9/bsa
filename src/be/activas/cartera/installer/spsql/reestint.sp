/************************************************************************/
/*   Archivo                 :    reestint.sp                           */
/*   Stored procedure        :    sp_reestructuracion_int               */
/*   Base de datos           :    cob_cartera                           */
/*   Producto                :    Cartera                               */
/*   Disenado por            :    Zoila Bedon                           */
/*   Fecha de escritura      :    Agosto 99                             */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Realiza la reestructuracion de una operacion a partir de su        */
/*   respectiva temporal                                                */
/************************************************************************/  
/*                            CAMBIOS                                   */
/*  FECHA          AUTOR            CAMBIO                              */
/*  OCT-2010       Elcira Pelaez    Transaccion RES y Diferidos NR059   */
/*                                  Depende de la  incidencia 11931     */
/* MAY-12-20       ANDY GONZALEZ    REQ 138837 DESPLAZAMIENTO F2        */
/************************************************************************/ 


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_reestructuracion_int')
   drop proc sp_reestructuracion_int
go

---Inc 32184  Sep-21 -2011   partiendo de la version  30

create proc sp_reestructuracion_int
   @s_user                   login        = null,
   @s_term                   varchar(30)  = null,
   @s_sesn                   int          = null,
   @s_date                   datetime     = null,
   @s_ofi                    smallint     = null,
   @i_banco                  cuenta       = null,
   @i_upd_clientes           char(1)      = null,
   @i_num_reest              char(1)      = null,
   @i_cotizacion             money        = null,
   @i_op_hija                int          = 0,
   @i_respetar_vencidas      char(1)      = 'N',
   @o_secuencial             int          = null out

as declare    
   @w_sp_name            varchar(30),
   @w_error              int,
   @w_operacionca        int,
   @w_min_div_reest      smallint,
   @w_max_div_reest      smallint,
   @w_secuencial         int,
   @w_toperacion         catalogo,
   @w_moneda             tinyint,
   @w_oficina            smallint,
   @w_fecha_ini          datetime,
   @w_fecha_ult_proceso  datetime,
   @w_saldo_operacion    money,
   @w_gerente            smallint,
   @w_op_calificacion    char(1),
   @w_op_gar_admisible   char(1),
   @w_op_estado          tinyint,
   @w_est_suspenso       tinyint,
   @w_est_novigente      tinyint,
   @w_est_vigente        tinyint,
   @w_est_vencido        tinyint,
   @w_est_cancelado      tinyint,
   @w_di_fecha_ini       datetime,
   @w_dias_div           int,
   @w_base_calculo       char(1),
   @w_gracia_div_ini     float,
   @w_concepto_int       catalogo,
   @w_commit             char(1),
   @w_plazo              smallint,
   @w_param_IVAHOB       catalogo,
   @w_param_IVAFNG       catalogo,
   @w_param_HONABO       catalogo,
   @w_param_COMFNG       catalogo,
   @w_param_SEDEVE       catalogo,
   @w_param_FSAMIN       catalogo,
   @w_concepto_cap       catalogo,
   @w_num_dec            tinyint,
   @w_num_dec_n          smallint,
   @w_moneda_n           smallint,
   @w_cotizacion_dia     float,
   @w_total_diferido     money,
   @w_total_capitalizado money,
   @w_codvalor           int,
   @w_codvalor_hi        int,
   @w_est_diferido       tinyint,
   @w_concepto           catalogo,
   @w_orden              smallint,
   @w_gracia_int         smallint,                                     -- REQ 175: PEQUEÑA EMPRESA
   @w_gracia_cap         smallint,
   @w_operacionca_dif    int,
   @w_valores_acumulado  char(1),
   @w_abd_concepto       catalogo,
   @w_oficina_op         int,
   @w_max_div            int,
   @w_saldo_compensar    money 
      
-- VARIABLES INICIALES 
select 
@w_sp_name        = 'sp_reestructuracion_int',
@w_commit         = 'N',
@w_valores_acumulado = 'N'

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_novigente  = @w_est_novigente out                       

if @w_error <> 0 goto ERROR

select 
@w_operacionca          = op_operacion,
@w_moneda               = op_moneda,
@w_oficina              = op_oficina,
@w_fecha_ult_proceso    = op_fecha_ult_proceso,
@w_gerente              = op_oficial,
@w_op_calificacion      = isnull(op_calificacion, 'A'),
@w_op_gar_admisible     = isnull(op_gar_admisible, 'O'),
@w_op_estado            = op_estado,
@w_oficina_op           = op_oficina
from  ca_operacion
where op_banco = @i_banco

select 
@w_toperacion           = opt_toperacion,
@w_fecha_ini            = opt_fecha_ini,
@w_base_calculo         = opt_base_calculo,
@w_base_calculo         = opt_base_calculo,
@w_gracia_int           = opt_gracia_int,                               -- REQ 175: PEQUEÑA EMPRESA
@w_gracia_cap           = opt_gracia_cap                                -- REQ 175: PEQUEÑA EMPRESA
from  ca_operacion_tmp
where opt_banco = @i_banco



---COTIZACION DEL DIA
exec sp_buscar_cotizacion
    @i_moneda     = @w_moneda,
    @i_fecha      = @w_fecha_ult_proceso,
    @o_cotizacion = @w_cotizacion_dia out
    
select @w_cotizacion_dia = isnull(@w_cotizacion_dia,1)    
        
---DECIMALES

exec @w_error = sp_decimales
     @i_moneda       = @w_moneda,
     @o_decimales    = @w_num_dec out,
     @o_mon_nacional = @w_moneda_n out,
     @o_dec_nacional = @w_num_dec_n out
     
if @w_error <> 0 
begin
   goto ERROR
end

select @w_num_dec  = isnull(@w_num_dec,0)
if @w_moneda = 2
   select @w_num_dec_n = 2
     
---CONCEPTO CAPITAL D LA OPERACION

select @w_concepto_cap = ro_concepto
from ca_rubro_op
where ro_operacion = @w_operacionca
and   ro_tipo_rubro = 'C'

-- DETERMINAR EL SALDO DE LA OPERACION 
select @w_saldo_operacion = sum(am_acumulado - am_pagado)
from   ca_amortizacion
where  am_operacion = @w_operacionca
---PARAMETROS GENERALES

select @w_param_IVAHOB = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAHOB'

select @w_param_IVAFNG = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAFNG'

select @w_param_HONABO = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'HONABO'

select @w_param_COMFNG = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'

select @w_param_SEDEVE = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'SEDEVE'

select @w_param_FSAMIN = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'FSAMIN'


if @i_respetar_vencidas = 'N' begin 
  
   select
   @w_min_div_reest = min(di_dividendo), 
   @w_max_div_reest = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @w_operacionca
   and   di_estado in (@w_est_vigente, @w_est_vencido) 
   
end else begin 

   select
   @w_min_div_reest = min(di_dividendo), 
   @w_max_div_reest = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @w_operacionca
   and   di_estado    = @w_est_vigente 


end   
   
   

select @w_concepto_int = ro_concepto
from ca_rubro_op
where ro_operacion = @w_operacionca
and   ro_tipo_rubro = 'I'

select @w_gracia_div_ini = 0

select @w_gracia_div_ini = isnull(sum(am_gracia),0)
from ca_amortizacion
where am_operacion = @w_operacionca
and   am_dividendo = @w_max_div_reest
and   am_concepto  = @w_concepto_int
and   am_gracia   <> 0.0

/* DETERMINAR CUAL ES LA ULTIMA CUOTA A REESTRUCTURAR */
if exists (select 1 from ca_dividendo
where  di_operacion = @w_operacionca
and    di_dividendo = @w_max_div_reest
and    di_fecha_ini = @w_fecha_ini)
begin
  select @w_valores_acumulado = 'N'
  if exists (select 1 from ca_amortizacion,ca_rubro_op
			   where am_operacion = @w_operacionca
			   and   am_dividendo = @w_max_div_reest 
			   and   am_acumulado > 0
			   and   am_operacion = ro_operacion
			   and   am_concepto = ro_concepto
			   and   ro_tipo_rubro not in('C','I'))
   begin
     select @w_valores_acumulado = 'N'
   end	
   
   ---LOS VALORES PAGADOS DE LA CUOTA NRo.1 EL MISMO DIA DELA 
   ---CRECION DEBEN REAPLICADOS DESPUES DE REESTRUCTURAR
   ---POR QUE NO HAY CUOTA DONDE PONERLOS  SOLO SE VELVE A RECUPERAR
   ---EL RUBRO QUE NACE ACUMULADO COMO EL SEGURO

   if exists (select 1 from ca_amortizacion,ca_rubro_op
			   where am_operacion = @w_operacionca
			   and   am_dividendo = @w_max_div_reest 
			   and   am_pagado    > 0
			   and   am_operacion = ro_operacion
			   and   am_concepto = ro_concepto
			   and   ro_tipo_rubro in('C','I')
			   and   @i_respetar_vencidas = 'N')
   begin
      PRINT 'reestint.sp EL mismo dia de la creacion tien pago de capital, reversarlo y aplicarlo despue de Reetructurar'
      select @w_error = 710039
      goto ERROR
   end			   
			   
      
   -- ANTES DE RETROCEDER UNA CUOTA RESCATO LOS VALORES DE LOS PAGOS 
   -- DE RUBROS QUENACEN ACUMULADOS EN LA CUOTA VIGENTE Nro. 1
   

   select 
   operacion = am_operacion, 
   dividendo = @w_max_div_reest, ---En este caso la cuota es la Nro.1
   concepto  = am_concepto,
   pagado    = sum(am_pagado),
   acumulado = sum(am_acumulado)
   into #pagos
   from ca_amortizacion
   where am_operacion = @w_operacionca
   and   am_dividendo = @w_max_div_reest 
   and   (am_pagado    > 0 or am_acumulado > 0 ) 
   group by am_operacion, am_dividendo, am_concepto
   
  
   
   
   select 
   @w_max_div_reest = @w_max_div_reest - 1,
   @w_dias_div      = -999
   
   if @w_max_div_reest < 0 begin
      select @w_error = 701191  -- no se puede reestructurar el dia del desembolso
      goto ERROR
   end
end else begin

   select @w_di_fecha_ini = di_fecha_ini
   from   ca_dividendo
   where  di_operacion = @w_operacionca
   and    di_dividendo = @w_max_div_reest

   select @w_dias_div = datediff(dd, @w_di_fecha_ini, @w_fecha_ini)

   if @w_base_calculo = 'E' begin
      exec @w_error    = sp_dias_base_comercial
      @i_fecha_ini = @w_di_fecha_ini,
      @i_fecha_ven = @w_fecha_ini,
      @i_opcion    = 'D',
      @o_dias_int  = @w_dias_div out

      if @w_error <> 0 goto ERROR
   end
   
end

---AJUSTAR EL NUMERO DE CUOTA DE LAS TABLAS TEMPORALES 
update ca_dividendo_tmp set
dit_estado = @w_est_vigente
where dit_operacion = @w_operacionca
and   dit_dividendo = 1

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end



update ca_dividendo_tmp set
dit_dividendo = dit_dividendo + @w_max_div_reest
where dit_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end

update ca_cuota_adicional_tmp set
cat_dividendo = cat_dividendo + @w_max_div_reest
where cat_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end

update ca_amortizacion_tmp set
amt_acumulado = case when ro_provisiona = 'S' and ro_tipo_rubro <> 'C' then 0 else amt_cuota    end,
amt_estado    = case when @w_op_estado = @w_est_vencido then @w_est_suspenso  else @w_op_estado end
from ca_rubro_op
where amt_operacion  = ro_operacion
and   amt_concepto   = ro_concepto
and   amt_operacion  = @w_operacionca
and   ro_operacion   = @w_operacionca
and   amt_dividendo  = 1

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end


if @w_op_estado not in (@w_est_vigente, @w_est_vencido) begin

   update ca_amortizacion_tmp set 
   amt_estado = @w_op_estado
   from  ca_rubro_op
   where amt_operacion  = @w_operacionca
   and   ro_operacion   = @w_operacionca
   and   ro_concepto    = amt_concepto
   and   ro_tipo_rubro in ('C','I')

   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end

end

update ca_amortizacion_tmp set
amt_dividendo = amt_dividendo + @w_max_div_reest
where amt_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end

exec @w_secuencial = sp_gen_sec
@i_operacion       = @w_operacionca

select @o_secuencial = @w_secuencial


/*INICIAR DESDE ESTE PUNTO LA ATOMICIDAD DE LA TRANSACCION */
if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end

-- OBTENER RESPALDO ANTES DE LA REESTRUCTURACION
exec @w_error = sp_historial
@i_operacionca = @w_operacionca,
@i_secuencial  = @w_secuencial

if @w_error <> 0  goto ERROR




if @w_valores_acumulado = 'S'
begin
   ---ESTOS VALORES SE PONEN EN 0 POR QUE NO SE DEBEN CAPITALIZAR SON DE LA CUOTA 1
   ---Y SE ESTA REESTRUCTURANDO EL DIA DEL DESEMBOLSO
   update ca_amortizacion
   set am_acumulado = am_pagado
   from ca_amortizacion,ca_rubro_op
   where am_operacion = @w_operacionca
   and   am_dividendo = @w_max_div_reest 
   and   am_acumulado > 0
   and   am_operacion = ro_operacion
   and   am_concepto = ro_concepto
   and   ro_tipo_rubro not in('C','I')
   
   --- REVERSAR LO GENERADO EN LA FECHA
   update ca_transaccion_prv
   set tp_estado = 'RV'
   where tp_operacion = @w_operacionca
   and  tp_estado = 'ING'
   
end
   
update ca_datos_reestructuraciones_cca
set res_secuencial_res = @w_secuencial
where res_secuencial_res = -999999
and res_operacion_cca = @w_operacionca

-- TRANSACCION CONTABLE 
insert into ca_transaccion (
tr_secuencial,      tr_fecha_mov,         tr_toperacion,
tr_moneda,          tr_operacion,         tr_tran,
tr_en_linea,        tr_banco,             tr_dias_calc,
tr_ofi_oper,        tr_ofi_usu,           tr_usuario,
tr_terminal,        tr_fecha_ref,         tr_secuencial_ref,
tr_estado,          tr_gerente,             tr_calificacion,
tr_gar_admisible,   tr_observacion,       tr_comprobante,
tr_fecha_cont,      tr_reestructuracion)
values (
@w_secuencial,      @s_date,              @w_toperacion,
@w_moneda,          @w_operacionca,       'RES',
'S',                @i_banco,             0,
@w_oficina,         @s_ofi,               @s_user,
@s_term,            @w_fecha_ult_proceso, 0,
'ING',               @w_gerente,          @w_op_calificacion,
@w_op_gar_admisible,'REESTRUCTURACION',   0,
'',                 '')

if @@error <> 0 begin
   print 'Error en Ingreso de transaccion de Reestructuracion'
   select @w_error = 708165
   goto ERROR
end

-- ACTUALIZACION DE CLIENTES
if @i_upd_clientes = 'S' begin
   exec @w_error  = sp_cliente
   @t_debug        = 'N',
   @t_file         = '',
   @t_from         = @w_sp_name,
   @s_date         = @s_date,
   @i_usuario      = @s_user,
   @i_sesion       = @s_sesn,
   @i_banco        = @i_banco,
   @i_operacion    = 'U'

   if @w_error <> 0 goto ERROR
end                

-- SI NO EXISTEN DIVIDENDOS, LA REESTRUCTURACION SOLO INVOLUCRO CAMBIO DE DEUDORES
if not exists (select 1 from ca_dividendo_tmp
where dit_operacion = @w_operacionca) 
   return 0


---REGISTRO EL TOTAL CAPITALIZADO 
select @w_total_capitalizado = 0

--CUANDO SE RESPETA LAS CUOTAS VENCIDAS NO HAY CAPITALIZACION 
if @i_respetar_vencidas = 'N' begin 

   select @w_total_capitalizado = isnull(sum(am_acumulado - am_pagado),0)
   from ca_amortizacion, ca_rubro_op
   where am_operacion   = @w_operacionca
   and   ro_operacion   = @w_operacionca
   and   am_concepto    = ro_concepto
   --and   @i_op_hija     = 0
   and   ro_tipo_rubro <> 'C'
   and   (am_acumulado - am_pagado) > 0
 
end 

if @w_dias_div = -999  and @w_total_capitalizado > 0
begin
 ---CONTROL MIENTRAS SE DEFINE KAPITLIZACION EN LA PRIMERA CUOTA
 PRINT 'reestint.sp  Atencion En la Primera Cuota no se puede capitalizar Valores' + CAST (@w_total_capitalizado as varchar)
 select @w_error = 708197
 goto ERROR
end

select @w_codvalor = 0
select @w_codvalor = (co_codigo * 1000) + (1 * 10)
from ca_concepto
where co_concepto = @w_concepto_cap

--PRINT 'reestint.sp  Atencion capitalizado este valor: ' + CAST (@w_total_capitalizado as varchar) 

if @w_total_capitalizado >  0 
begin

    insert into  ca_det_trn
    select 
    @w_secuencial,    @w_operacionca,         am_dividendo,
    am_concepto,      (case when am_estado = @w_est_cancelado and am_gracia < 0 then @w_est_vigente else am_estado end),                               -- REQ 175: PEQUEÑA EMPRESA
    am_periodo,       (co_codigo * 1000) + ((case when am_estado = @w_est_cancelado and am_gracia < 0 then @w_est_vigente else am_estado end) * 10),   -- REQ 175: PEQUEÑA EMPRESA
    (am_acumulado - am_pagado),
    round(((am_acumulado - am_pagado)* @w_cotizacion_dia), 0),
    0,                @w_cotizacion_dia,      'N',
    'C',              '',                     'DETALLE REESTRUCTURACION',
    0
    from ca_amortizacion, ca_rubro_op, ca_concepto
    where am_operacion   = @w_operacionca
    and   ro_operacion   = @w_operacionca
    --  and   am_estado     <> @w_est_cancelado        REQ 175: PEQUEÑA EMPRESA
    and   am_concepto    = ro_concepto
    and   am_concepto    = co_concepto
    and   ro_tipo_rubro <> 'C'
    and   (am_acumulado - am_pagado) > 0            -- REQ 175: PEQUEÑA EMPRESA
    
    
    if @@error <> 0 begin
       PRINT 'reestint.sp Error Insertando detalle de reestructuracion Todos los rubros <> CAP'
       select @w_error = 708166
       goto ERROR
    end


	insert ca_det_trn (
	dtr_secuencial,       dtr_operacion,            dtr_dividendo,
	dtr_concepto,         dtr_estado,               dtr_periodo,         
	dtr_codvalor,         dtr_monto,                dtr_monto_mn,        
	dtr_moneda,           dtr_cotizacion,           dtr_tcotizacion,     
	dtr_afectacion,       dtr_cuenta,               dtr_beneficiario,    
	dtr_monto_cont
	)
	values
	(
	@w_secuencial,        @w_operacionca,           1,
	@w_concepto_cap,      1,                        0,
	@w_codvalor,          @w_total_capitalizado,    round(( @w_total_capitalizado * @w_cotizacion_dia) ,0),
	0,                    @w_cotizacion_dia,        'N',
	'D',                  '',                       'TOTAL CAPITALIZADO',
	0
	)
	if @@error <> 0 begin
	   PRINT 'reestint.sp Error Insertando en ca_det_trn Total reestructurado <> CAP'
	   select @w_error = 708166
	   goto ERROR
	end
	
	
	
	
	
	
	

    if @i_op_hija > 0 begin

       select @w_codvalor_hi = co_codigo * 1000  + 10  + 0 
       from   ca_concepto
       where  co_concepto = @w_concepto_cap

       /* TRANSACCION PARA CONTRAPARTIDA DEL DESEMBOLSO QUE SE HARA AUTOMATICO CUANDO TIENE OPERACION HIJA */
       insert ca_det_trn (
	   dtr_secuencial,       dtr_operacion,            dtr_dividendo,
	   dtr_concepto,         dtr_estado,               dtr_periodo,         
	   dtr_codvalor,         dtr_monto,                dtr_monto_mn,        
	   dtr_moneda,           dtr_cotizacion,           dtr_tcotizacion,     
	   dtr_afectacion,       dtr_cuenta,               dtr_beneficiario,    
	   dtr_monto_cont
       )
	   values
	   (
	   @w_secuencial,        @w_operacionca,           1,
	   @w_concepto_cap,      1,                        0,
	   @w_codvalor_hi,       @w_total_capitalizado*-1,    round(( @w_total_capitalizado * @w_cotizacion_dia) ,0)*-1,
	   0,                    @w_cotizacion_dia,        'N',
	   'C',                  '',                       'CONTRAPARTIDA POR DESEMBOLSO DE OPERACION HIJA',
	   0
 	   )
	   if @@error <> 0 begin
	      PRINT 'reestint.sp Error Insertando en ca_det_trn Total contrapartida por desembolso operacion hija'
	      select @w_error = 708166
	      goto ERROR
	   end

       /* PARAMETRO DE FORMA DE DESEMBOLSO OPERACION HIJA */
       select @w_abd_concepto = pa_char
       from cobis..cl_parametro
       where pa_producto = 'CCA'
       and   pa_nemonico = 'DESREE'

       select @w_codvalor_hi = cp_codvalor 
       from cob_cartera..ca_producto
       where cp_producto = @w_abd_concepto
       

       /* TRANSACCION PARA CONTRAPARTIDA DEL DESEMBOLSO QUE SE HARA AUTOMATICO CUANDO TIENE OPERACION HIJA */
       insert ca_det_trn (
	   dtr_secuencial,       dtr_operacion,            dtr_dividendo,
	   dtr_concepto,         dtr_estado,               dtr_periodo,         
	   dtr_codvalor,         dtr_monto,                dtr_monto_mn,        
	   dtr_moneda,           dtr_cotizacion,           dtr_tcotizacion,     
	   dtr_afectacion,       dtr_cuenta,               dtr_beneficiario,    
	   dtr_monto_cont
       )
	   values
	   (
	   @w_secuencial,        @w_operacionca,           0,
	   @w_abd_concepto,      1,                        0,
	   @w_codvalor_hi,       @w_total_capitalizado,    round(( @w_total_capitalizado * @w_cotizacion_dia) ,0),
	   0,                    @w_cotizacion_dia,        'N',
	   'D',                  '',                       'CONTRAPARTIDA POR DESEMBOLSO DE OPERACION HIJA',
	   0
 	   )
	   if @@error <> 0 begin
	      PRINT 'reestint.sp Error Insertando en ca_det_trn Total contrapartida por desembolso operacion hija'
	      select @w_error = 708166
	      goto ERROR
	   end

    end

	---ACTUALIZAR LA TABLA DE CONTROL CON EL VALOR CAPITALIZADO
	update ca_datos_reestructuraciones_cca
    set res_valor_capitalizado = @w_total_capitalizado
    where res_secuencial_res = @w_secuencial
    and res_operacion_cca = @w_operacionca
	
end
else
begin
	update ca_datos_reestructuraciones_cca
    set res_valor_capitalizado = 0
    where res_secuencial_res = @w_secuencial
    and res_operacion_cca = @w_operacionca
end

-- ACTUALIZACION DE LA OPERACION
update ca_operacion_tmp set
opt_monto          = op_monto,
opt_fecha_ini      = op_fecha_ini,
opt_estado         = op_estado,
opt_monto_aprobado = op_monto_aprobado,
opt_fecha_ult_proceso = op_fecha_ult_proceso
from  ca_operacion 
where opt_operacion = @w_operacionca
and   op_operacion  = @w_operacionca
and   opt_operacion = op_operacion

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end

exec @w_error = sp_pasodef
@i_banco       = @i_banco, 
@i_operacionca = 'S',
@i_rubro_op    = 'S'

if @w_error <> 0  goto ERROR

---REGISTRO VALOR DIFERIDO
select @w_total_diferido = 0
-- OBTENGO DIFERIDO POR CONCEPTO
select
'orden'    = row_number() over(order by am_concepto asc), 
'concepto' = am_concepto,
'total_diferido' = isnull(sum(am_acumulado - am_pagado),0)
into #diferidos
from ca_amortizacion,ca_rubro_op
where am_operacion = @w_operacionca
and  ro_operacion = @w_operacionca
and   am_estado   = @w_est_suspenso
and   am_concepto = ro_concepto
and   ro_tipo_rubro <> 'C'
and am_concepto not in (@w_param_IVAHOB,@w_param_IVAFNG,@w_param_HONABO,@w_param_COMFNG,@w_param_SEDEVE,@w_param_FSAMIN)
and (am_acumulado - am_pagado) > 0
and  @i_respetar_vencidas = 'N'--SI SE RESPETAN LAS CUOTAS VENCIDAS NO HAY DIFERIDOS
group by am_concepto


-- INSERTAR DIFERIDOS POR CONCEPTO
select @w_orden = 1   
   
while 1=1
begin
   select top 1 
   @w_total_diferido = total_diferido,
   @w_concepto       = concepto
   from #diferidos
   where orden = @w_orden
   order by orden asc
   if @@rowcount = 0
      break
   
   if @w_total_diferido > 0
   begin
      select @w_codvalor = 0
      select @w_codvalor = (co_codigo * 1000) + (@w_est_diferido * 10)
      from ca_concepto
      where co_concepto = @w_concepto
      
      insert ca_det_trn (
      dtr_secuencial,       dtr_operacion,       dtr_dividendo,
      dtr_concepto,         dtr_estado,          dtr_periodo,         
      dtr_codvalor,         dtr_monto,           dtr_monto_mn,        
      dtr_moneda,           dtr_cotizacion,      dtr_tcotizacion,     
      dtr_afectacion,       dtr_cuenta,          dtr_beneficiario,    
      dtr_monto_cont
      )
      values
      (
      @w_secuencial,        @w_operacionca,         1,
      @w_concepto,          @w_est_diferido,        0,
      @w_codvalor,          @w_total_diferido,round(( @w_total_diferido * @w_cotizacion_dia) ,0),
      0,                    @w_cotizacion_dia,    'N',
      'D',                  '',                   'TOTAL DIFERIDO',
      0
      )
      if @@error <> 0 begin
         PRINT 'reestint.sp Error Insertando en ca_det_trn_ valor diferido'
         select @w_error = 708166
         goto ERROR
      end
      
      if @i_op_hija > 0 
         select @w_operacionca_dif = @i_op_hija
      else
         select @w_operacionca_dif = @w_operacionca
      
      if exists(select 1 from ca_diferidos where dif_operacion = @w_operacionca_dif and dif_concepto = @w_concepto) begin
         update ca_diferidos set
         dif_valor_total = (dif_valor_total + @w_total_diferido)
         where dif_operacion = @w_operacionca_dif
         and   dif_concepto  = @w_concepto
      end
      else begin
         insert into ca_diferidos (
         dif_operacion, dif_concepto, dif_valor_total,dif_valor_pagado 
         )
         values
         (
         @w_operacionca_dif, @w_concepto, @w_total_diferido, 0
         )
      end
   end 
   
   delete #diferidos where orden = @w_orden
   select @w_orden = @w_orden + 1

end --end while 


if @i_respetar_vencidas = 'N' begin 

   update ca_amortizacion
   set am_pagado =  am_acumulado
   from ca_amortizacion, ca_rubro_op
   where am_operacion   = @w_operacionca
   and   ro_operacion   = @w_operacionca
   and   am_concepto    = ro_concepto
   and   ro_tipo_rubro <> 'C'
   and   (am_acumulado - am_pagado) > 0
   
   if @@error <> 0 begin
      PRINT 'reestint.sp Error Actualizando los valore capitalizados en ca_amortizacion'
      select @w_error = 708166
      goto ERROR
   end

end 
-- Si la reestructuracion solo involucra Capital No contabiliza


        
--- AJUSTAR LA FECHA DE VENCIMIENTO DE LA ULTIMA CUOTA A REESTRUCTURAR 
if @w_dias_div > 0 begin
      
   update ca_dividendo set 
   di_fecha_ven  = @w_fecha_ini,
   di_dias_cuota = @w_dias_div         -- MPO Ref. 025 02/20/2002
   where di_operacion = @w_operacionca
   and   di_dividendo = @w_max_div_reest 
   
   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end
   
end 

--- SI EXISTEN, CANCELAR LAS CUOTAS REESTRUCTURADAS 
---PRINT 'reestint @w_max_div_reest >= @w_min_div_reest' +  CAST (@w_max_div_reest as varchar) + ' @w_min_div_reest: ' + CAST (  @w_min_div_reest as varchar)

if @w_max_div_reest >= @w_min_div_reest  and @i_respetar_vencidas = 'N'
 begin

   --- INI - REQ 175: PEQUEÑA EMPRESA'
   update ca_amortizacion set
   am_cuota     = case 
                  when am_gracia <= 0                           then am_pagado
                  when am_gracia >  0 and am_pagado > am_gracia then am_pagado - am_gracia
                  else 0
                  end,
   am_acumulado = case 
                  when am_gracia <= 0                           then am_pagado
                  when am_gracia  > 0 and am_pagado > am_gracia then am_pagado - am_gracia
                  else 0
                  end,
   am_gracia    = case 
                  when am_gracia > 0 and am_pagado >  am_gracia then am_gracia
                  when am_gracia > 0 and am_pagado <= am_gracia then am_pagado
                  else 0
                  end,
   am_estado    = @w_est_cancelado
   where am_operacion  = @w_operacionca
   and   am_dividendo between @w_min_div_reest and @w_max_div_reest
   
   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end
   
   -- ACTUALIZACION DE CONCEPTOS CON GRACIA CUBIERTOS POR LA REESTRUCTURACION
   update ca_amortizacion set
   am_cuota     = am_pagado,
   am_acumulado = am_pagado,
   am_gracia    = 0
   from ca_amortizacion A
   where am_operacion = @w_operacionca
   and   am_dividendo < @w_min_div_reest
   and   am_gracia    < 0
   and   exists(select 1 from ca_amortizacion 
                where am_operacion = A.am_operacion 
                and   am_concepto  = A.am_concepto
                and   am_gracia    > 0)
   
   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end
   -- FIN - REQ 175: PEQUEÑA EMPRESA
   
   
   update ca_dividendo set  
   di_estado    = @w_est_cancelado,
   di_fecha_can = @w_fecha_ult_proceso
   where  di_operacion = @w_operacionca
   and    di_dividendo between @w_min_div_reest and @w_max_div_reest
   and    di_estado   <> @w_est_cancelado

   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end

end



/* BORRAR LAS CUOTAS QUE VAN A SER REEMPLAZADAS CON LA TABLA DE AMORTIZACION CALCULADA EN TEMPORALES */
delete ca_dividendo
where  di_operacion = @w_operacionca
and    di_dividendo > @w_max_div_reest

if @@error <> 0 begin
   select @w_error = 710003
   goto ERROR
end

delete ca_cuota_adicional
where  ca_operacion = @w_operacionca
and    ca_dividendo > @w_max_div_reest

if @@error <> 0 begin
   select @w_error = 710003
   goto ERROR
end

delete ca_amortizacion
where am_operacion = @w_operacionca
and   am_dividendo > @w_max_div_reest

if @@error <> 0 begin
   select @w_error = 710003
   goto ERROR
end


/* PASAR A TABLAS DEFINITIVAS LA TABLA DE AMORTIZACION GENERADA EN TEMPORALES */
insert into ca_dividendo 
select * from  ca_dividendo_tmp
where  dit_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end

insert ca_cuota_adicional
select * from ca_cuota_adicional_tmp
where  cat_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end

insert ca_amortizacion
select * from ca_amortizacion_tmp
where  amt_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end

if @w_gracia_div_ini <> 0 begin

   update ca_amortizacion set
   am_gracia = -am_acumulado
   from  ca_rubro_op
   where am_operacion  = @w_operacionca
   and   am_dividendo  = @w_max_div_reest
   and   ro_operacion  = @w_operacionca
   and   ro_concepto   = am_concepto
   and   ro_tipo_rubro = 'I'
   
   if @@error <> 0 begin
      select @w_error = 710002
      goto ERROR
   end

end

---RECUPERAR LOS VALORES PAGADOS EN LA CUOTA VIGENTE 
---DESPUES DE TENER LA TABLA DEFINITIVA

if @w_dias_div = -999 
begin  
   ---EL RUBRO QUE SE HABIA PAGADO ANTES ENLAPRIMERA CUOTA DEBE QUEDAR IGUAL POR QUE YA SE PAGO
   ---Y LA REESTRUCTURACION  NACE NUEVAMENTE DESDE LA CUOTA NRO. 1
   if exists (select 1 from #pagos
  		      where operacion = @w_operacionca
  		      and   (pagado > 0 or acumulado >0 ))
   begin   
 
      --RECUPERAMOS LOS VALORES DEVENGADOS Y PAGADOS DE LA CUOTA VIGENTE PARA RUBROS DISTINTO DE CAP
      update ca_amortizacion set
	  am_cuota     = case when am_cuota     > pagado then am_cuota     else pagado end ,
      am_acumulado = case when am_acumulado > pagado then am_acumulado else pagado end ,
      am_pagado    = pagado
      from #pagos
      where am_operacion = operacion
      and   am_dividendo = dividendo
      and   am_concepto  = concepto
      and   am_concepto not in ('CAP')
      and   am_secuencia = 1
      
      if @@error <> 0 begin
         PRINT 'reestint.sp Error recuperando valore pagados '
        select @w_error = 710002
        goto ERROR
      end
   
      --RECUPERAMOS LOS VALORES  PAGADOS ANTICIPADAMENTE POR EL CLIENTE 
	  
      update ca_amortizacion set
      am_cuota     = am_cuota     + pagado,
	  am_acumulado = am_acumulado + pagado,
	  am_pagado    = am_pagado    + pagado
      from #pagos
      where am_operacion = operacion
      and   am_dividendo = dividendo
      and   am_concepto  = concepto
      and   am_concepto = 'CAP'
      and   am_secuencia = 1
      
      if @@error <> 0 begin
          PRINT 'reestint.sp Error recuperando valore pagados '
         select @w_error = 710002
         goto ERROR
      end
   
   
   end
 
end

update ca_rubro_op set
ro_porcentaje     = rot_porcentaje,
ro_porcentaje_aux = rot_porcentaje_aux,
ro_porcentaje_efa = rot_porcentaje_efa,
ro_redescuento    = rot_redescuento,
ro_intermediacion = rot_intermediacion
from  ca_rubro_op_tmp
where ro_operacion  = @w_operacionca
and   ro_operacion  = rot_operacion
and   ro_concepto   = rot_concepto
and   ro_tipo_rubro = 'I'

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR
end

-- Actualizar nuevo plazo de la Obligación - Incluye cantidad de dividendos anteriores a la fecha de reest mas el plazo dado a al reest
select @w_plazo = max(di_dividendo)
from ca_dividendo
where di_operacion = @w_operacionca

update ca_operacion
set op_plazo = @w_plazo
where op_operacion = @w_operacionca

if @@error <> 0 or @@rowcount = 0 or @w_plazo <= 0 begin 
   select @w_error = 701061
   goto ERROR
end



if @w_commit = 'S' begin
   commit tran
   select @w_commit = 'S'
end

return 0  

ERROR:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

return @w_error
        
go
