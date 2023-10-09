

/*************************************************************************/
/*   Archivo:              sp_consulta_prestamo              			 */
/*   Stored procedure:     sp_consulta_prestamo.sp            			 */
/*   Base de datos:        cob_cartera		                             */
/*   Producto:             clientes                                  	 */
/*   Disenado por:         jlsdv                                         */
/*   Fecha de escritura:   Agosto 2019                                   */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*  				Mostrar prestamos como creditos activos              */
/*						tenga el cliente en la entidad               	 */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA            AUTOR                RAZON                        */
/*  19/Ago/2019    Jose Sanchez      Emision inicial                     */
/*  05/Mar/2020    Paul Ortiz        Corregir errores de garantia        */
/*  04/Abr/2020    Sonia Rojas       Corregir error movimientos          */
/*  12/Oct/2021    Alexander Inca    Socio Comercial                     */
/*  07/May/2022    AGO               Proyeccion de cuota LCR con         */
/*                                   accesorios                          */
/*  16/May/2022    Dario Cumbal      #183730 - Presenta Op. Anulada      */
/*  25/Ene/2023    ACH               ERR#200870 Lote 12 Cartera - Opera- */
/*                                   ciones a futuro. Val. Prod. bancario*/
/*************************************************************************/
use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_consulta_prestamo')
    drop proc sp_consulta_prestamo
go

create proc sp_consulta_prestamo (
   @i_cliente       int,
   @i_operacion     char(1) = 'H', -- H: Home, E: Elavon
   @i_op_operacion  int = null,
   @i_toperacion    varchar(64) = null
)
as
declare 
@w_sp_name				varchar(100),
@w_operacion			int,
@w_toperacion			varchar(64),
@w_producto				varchar(64),
@w_monto_a_pagar		money,
@w_fecha_de_pago		datetime,
@w_liquida_con			money,
@w_cuotas_vencidas	    int,
@w_grupo				varchar(64),
@w_tipo_cobis			char(2),
@w_permite_pago         char(1),
@w_permite_disp         char(1),
@w_servicio             int,
@w_fecha_ult_acceso     datetime,
@w_estado               tinyint,
@w_banco                char(24),
@w_inst_proc            int,
-- REVOLVENTE
@w_monto_linea_credito	money,
@w_disponible			money,
@w_utilizado			money,
@w_pago_minimo			money,
@w_pago_total			money,
@w_referencia_pago	    varchar(64),
@w_numero_convenio	    int,
@w_param_umbral 		money,
@w_fecha_proceso 		datetime,
@w_saldo_capital 		money,
@w_id_corresp       	int,
@w_sp_referencia 		varchar(100),
-- GARANTIA
@w_tramite				int,
@w_referencia_grupal	varchar(15),
-- ERRORES
@w_error            	int,
@w_correo_cli           varchar(254),
@w_otro_valor           char(1),
@w_valor_min_pago       money,
@w_promo                char(1),
@w_moneda               tinyint,
@w_nem_moneda           varchar(10),
@w_referencia       	int,
@w_cod_grupo       	    int,
@w_op_hija			    int,
@w_est_vigente          int,
@w_est_vencida          int,
@w_factor			    float,
--SOCIO COMERCIAL
@w_nem_socio            char(10),
@w_es_socio_com         char(1) = 'N',
@w_monto_en_proceso     money , 
@w_fecha_pago           datetime , 
@w_op_estado            int , 
@w_saldo_pry            money ,
@w_fecha_ven            datetime 

select @w_sp_name = 'sp_consulta_prestamo'

--Inicio Caso#200870
if exists (select 1
from   cobis..cl_pro_moneda,  cobis..cl_producto
where  pm_producto = pd_producto 
and    pd_abreviatura = 'CCA'
and    pm_moneda      = 0
and    pm_tipo        = 'R'
and    pm_estado <> 'V') begin 
    print 'Error 6900070 Producto bancario deshabilitado'
	select @w_error =  6900070
	goto ERROR	
end
--Fin Caso#200870

-- tabla final de prestamos 
create table #prestamos
(  
   secuencial		int identity(1,1),  
   operacion		int			 null,
   tipo_operacion varchar(64) null,
   banco         char(24),
   inst_proc     int,
   permite_pago  varchar(1) null,
   permite_disp  varchar(1) null,  
   etiqueta		varchar(64) null,  
   valor			varchar(64) null
)

-- tabla final de #movimiento_prestamo 
create table #movimiento_prestamo  
(  
   id_movimiento		int identity(1,1),  
   sec_movimiento		int null,
   operacion			int null,  
   tipo_operacion		varchar(64) null,  
   tipo_movimiento	varchar(64) null,  
   fecha_movimiento	varchar(64) null, 
   valor_movimiento	varchar(255) null,
   estado_trn			varchar(64) null,
   -- ------------------------------
   consecutivo       int   null,
   linea             int   null,
	fecha_str         varchar(8)  null,
   referencia           varchar(10) null
)
   
--FECHA ULTIMO ACCESO
select @w_servicio = pa_tinyint
from cobis..cl_parametro 
where pa_nemonico = 'B2CSBV'
and   pa_producto = 'BVI'

select @w_fecha_ult_acceso = il_fecha_in
from cob_bvirtual..bv_in_login, cob_bvirtual..bv_login, cob_bvirtual..bv_ente
where il_login    = lo_login
and   en_ente     = lo_ente
and   lo_servicio = @w_servicio
and   en_ente_mis = @i_cliente

-- CORREO ELECTRONICO
select @w_correo_cli = di_descripcion 
from cobis..cl_direccion 
where di_tipo = 'CE' and di_ente = @i_cliente

-- REFERENCIA
select 
@w_id_corresp    	= co_id,  
@w_sp_referencia 	= co_sp_generacion_ref
from cob_cartera..ca_corresponsal
where co_nombre		= 'SANTANDER'

--ESTADOS CARTERA
exec @w_error   = sp_estados_cca
@o_est_vigente  = @w_est_vigente out,
@o_est_vencido  = @w_est_vencida out
   
if @i_operacion = 'H'
begin
   -- FECHA PROCESO
   select @w_fecha_proceso = fp_fecha
   from cobis..ba_fecha_proceso

   -- LISTA GRUPALES
   select dc_referencia_grupal banco
   into #opers_grp
   from ca_operacion, ca_det_ciclo 
   where op_operacion = dc_operacion
   and op_toperacion in ('GRUPAL')
   and op_cliente 	= @i_cliente
   and op_estado <> 3
   
   -- select * from #opers_grp

   create index oper_grp_idx1 on #opers_grp(banco)

   select
      op_operacion,  op_banco,      op_cliente, 
      op_tramite, 	op_toperacion, op_monto, 
      op_nombre,     op_estado,     op_promocion,
      op_moneda
   into #lista_grupales_individuales
   from ca_operacion inner join #opers_grp
   on op_banco = banco

   -- LISTA INDIVIDUALES
   insert into #lista_grupales_individuales
   select
      op_operacion,  op_banco,      op_cliente, 
      op_tramite, 	op_toperacion, op_monto, 
      op_nombre,     op_estado,     op_promocion,
      op_moneda
   from ca_operacion 
   where op_toperacion in ('INDIVIDUAL')
   and op_cliente = @i_cliente
   and op_estado not in (0,3,6)

   -- LISTA REVOLVENTE
   select
      op_operacion, 	op_banco, 		op_cliente, 
      op_tramite, 	op_toperacion, op_monto,
      op_moneda,     op_monto_aprobado
   into #lista_revolvente
   from ca_operacion 
   where op_tipo_amortizacion = 'ROTATIVA'
   and @w_fecha_proceso between op_fecha_ini and op_fecha_fin
   and op_cliente = @i_cliente

   -- GRUPALES
   select @w_operacion = 0

   -- select * from #lista_grupales_individuales

   while (1=1) begin 
      select top 1 
      @w_operacion 	= op_operacion,
      @w_grupo		   = concat(concat(op_cliente,' - '), op_nombre),
      @w_cod_grupo   = op_cliente,
      @w_toperacion	= op_toperacion,
      @w_estado      = op_estado,
      @w_banco       = op_banco,
      @w_tramite     = op_tramite,
      @w_promo       = op_promocion,
      @w_moneda      = op_moneda
      from #lista_grupales_individuales
      where op_operacion > @w_operacion
      order by op_operacion asc
      if @@rowcount = 0 break

      select top 1 @w_inst_proc = io_id_inst_proc 
      from cob_workflow..wf_inst_proceso
      where io_campo_3 = @w_tramite
      order by io_id_inst_proc desc

      -- PRODUCTO
      if @w_toperacion = 'GRUPAL'
      begin
         if @w_promo = 'N'
         begin
            select @w_producto = 'GRUPAL TRADICIONAL'
         end
         else if @w_promo = 'S'
         begin
            select @w_producto = 'GRUPAL ANIMATE'
         end
         else
         begin
            --select @w_producto = 'GRUPAL TU NEGOCIO'
            select @w_producto = 'GRUPAL TRADICIONAL'
         end
      end
      
      -- MONEDA
      select @w_nem_moneda = mo_nemonico 
      from cobis..cl_moneda 
      where mo_moneda = @w_moneda

      -- MONTO A PAGAR
      select 
      @w_monto_a_pagar 	= isnull(sum(am_cuota - am_pagado), 0) 
      from ca_amortizacion, ca_dividendo 
      where am_operacion 	= @w_operacion
      and am_operacion	= di_operacion
      and am_dividendo 	= di_dividendo 
      and di_estado 		in (1,2)
      
      if (@w_monto_a_pagar = 0) 
      begin
         select @w_monto_a_pagar = isnull(sum(am_cuota - am_pagado), 0)
         from ca_amortizacion
         where am_dividendo = (	select top 1 di_dividendo from ca_dividendo 
                           where di_operacion = @w_operacion 
                           and di_fecha_ini > @w_fecha_proceso
                           and di_estado in (1,0) )
         and am_operacion = @w_operacion
      end 

      -- CUOTAS VENCIDAS
      select @w_cuotas_vencidas = count(di_operacion) from ca_dividendo where di_operacion = @w_operacion and di_estado = 2

      -- FECHA DE PAGO
      select @w_fecha_de_pago = @w_fecha_proceso
      select top 1 @w_fecha_de_pago = di_fecha_ven from ca_dividendo where di_operacion = @w_operacion and di_estado in (1,0)
      if (@w_cuotas_vencidas > 0) 
      begin
         select @w_fecha_de_pago = @w_fecha_proceso 
      end

      -- LIQUIDA CON 
      select @w_liquida_con = isnull(sum(am_acumulado - am_pagado), 0)
      from cob_cartera..ca_amortizacion
      where am_operacion = @w_operacion

      select 
         @w_permite_pago = 'S',
         @w_permite_disp = 'N'
      
      -- GRUPO / INDIVIDUAL 
      select @w_tipo_cobis = 'PG'
      
      -- INDIVIDUAL
      if @w_toperacion = 'INDIVIDUAL' begin
         select 
		 @w_grupo      = null,
         @w_tipo_cobis = 'PI',
         @w_referencia = @w_operacion,
		 @w_producto   = 'INDIVIDUAL'
      end
      else
      begin
         select @w_referencia = @w_cod_grupo
      end
      
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= @w_tipo_cobis,
      @i_id_referencia  = @w_referencia,
      @i_fecha_lim_pago = @w_fecha_proceso,
      @o_referencia     = @w_referencia_pago out

      if @w_error <> 0 begin
         goto ERROR
      end

      -- CONVENIO	 
      select  @w_numero_convenio = ctr_convenio
      from ca_corresponsal_tipo_ref
      where ctr_tipo_cobis = @w_tipo_cobis
      and ctr_co_id =  @w_id_corresp
      
      -- PRESTAMOS
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'PRODUCTO',        @w_producto)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'MONTO A PAGAR',   '$ ' + convert(varchar, @w_monto_a_pagar) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'FECHA DE PAGO',   convert(varchar, @w_fecha_de_pago, 103))
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'CUOTAS VENCIDAS', @w_cuotas_vencidas)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'LIQUIDA CON',     '$ ' + convert(varchar, @w_liquida_con) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'REFERENCIA DE PAGO', @w_referencia_pago)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'NRO CONVENIO',    @w_numero_convenio)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, @w_permite_pago, @w_permite_disp, 'GRUPO',           @w_grupo)
      
      -- movimiento prestamo grupales
      
      insert into #movimiento_prestamo
      select top 20
      'Secuencial'	= co_secuencial,
      'Operacion'    = @w_operacion, 
      'TipoOperacion'= @w_toperacion,
      'TipoMov'		= 'PAG',
      'FechaMov'		= convert(varchar,co_fecha_valor,103),
      'ValorMov'		= '$ ' + convert(varchar, co_monto) + ' ' + @w_nem_moneda,
      'EstadoTrn'		= 'CON',
      null,null,null,null
      from cob_cartera..ca_corresponsal_trn 
      where co_codigo_interno = @w_operacion
      and co_estado = 'P'
      and co_accion = 'I'
      and co_error_id = 0
	  order by co_fecha_valor desc
      
   end

   -- REVOLVENTE
   select 
      @w_producto = '',          @w_fecha_de_pago = null, 
      @w_referencia_pago = '',   @w_numero_convenio = 0,
      @w_banco = '',             @w_inst_proc = null, 
      @w_tramite = null,         @w_operacion = 0

   -- PARAMETRO UMBRAL
   select @w_param_umbral = pa_money
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'LCRUMB'
   and    pa_producto = 'CCA'

   select @w_param_umbral = isnull(@w_param_umbral, 100)

   while (1=1) begin 
      select top 1 
      @w_operacion 		= op_operacion,
      @w_toperacion 		= op_toperacion,
      @w_monto_linea_credito 	= op_monto_aprobado,
      --@w_utilizado      = op_monto_aprobado,  
      @w_moneda         = op_moneda,
      
      @w_banco          = op_banco,
      @w_tramite        = op_tramite
      from #lista_revolvente
      where op_operacion > @w_operacion
      order by op_operacion asc
      if @@rowcount = 0 break
      
      select top 1 @w_inst_proc = io_id_inst_proc 
      from cob_workflow..wf_inst_proceso
      where io_campo_3 = @w_tramite
      order by io_id_inst_proc desc

      -- PRODCUTO
      select @w_producto = 'LINEA DE CREDITO REVOLVENTE'
      
      -- MONEDA
      select @w_nem_moneda = mo_nemonico 
      from cobis..cl_moneda 
      where mo_moneda = @w_moneda
      
      -- MONTO UTILIZADO
      select @w_utilizado = sum(am_cuota-am_pagado)
      from cob_cartera..ca_amortizacion
      where am_operacion = @w_operacion
      and   am_concepto  = 'CAP'
	  
	  select @w_monto_en_proceso = sum(isnull(dp_monto_aprobado,0)) --Monto pendiente de aplicacion socio comercial
      from ca_desembolsos_pendientes,
	  ca_operacion
	  where op_operacion = @w_operacion
	  and   op_banco     = dp_banco
	  and   dp_estado    <> 'P'
	  
	  select @w_utilizado = @w_utilizado + isnull(@w_monto_en_proceso,0)
	  
      -- MONTO DISPONIBLE
      select @w_disponible = @w_monto_linea_credito - @w_utilizado
      if @w_disponible < 0
      begin
         select @w_disponible = 0
      end

      -- CUOTAS VENCIDAS
      select @w_cuotas_vencidas = count(di_operacion) from ca_dividendo where di_operacion = @w_operacion and di_estado = 2
      
      -- PAGO TOTAL
      select @w_pago_total = isnull(sum(am_acumulado - am_pagado), 0)
      from cob_cartera..ca_amortizacion
      where am_operacion = @w_operacion

      if @w_pago_total < 0 select @w_pago_total = 0
      
      -- PAGO MINIMO 
      select @w_pago_minimo = isnull(sum(am_cuota - am_pagado), 0)
      from ca_amortizacion, ca_dividendo
      where am_operacion = @w_operacion
      and am_operacion   = di_operacion
      and am_dividendo   = di_dividendo
      and (di_estado     = 2 or (di_estado = 1 and di_fecha_ven = @w_fecha_proceso ))
	  
	
      select @w_fecha_de_pago  = @w_fecha_proceso
	  select @w_op_estado = op_estado , @w_fecha_ven = op_fecha_fin from ca_operacion where op_operacion = @w_operacion

     
  
      
     if @w_pago_minimo = 0 begin  --VALOR A PROYECTAR  EN CASO DE NO EXIGIBLES
	 
	    select @w_fecha_de_pago  = dateadd(dd,1,@w_fecha_proceso)

		exec @w_error  = cob_cartera..sp_lcr_calc_corte
		@i_operacionca   = @w_operacion,
		@i_fecha_proceso = @w_fecha_de_pago,
		@o_fecha_corte   = @w_fecha_de_pago out

	 
		 --PAGO MINIMO 
	    select @w_saldo_capital = sum(am_cuota - am_pagado) 
	    from ca_amortizacion
	    where am_operacion = @w_operacion
	    and am_concepto = 'CAP'
   
	    if  @w_saldo_capital < @w_param_umbral select @w_pago_minimo  = @w_saldo_capital 
        else begin 
		
		    --ESTA PROYECCION REALIZA UN FV A LA FECHA DE CORTE SIGUIENTE
            --Y REALIZA EL CALCULO DE LA CUOTA CON EL PROGRAMA QUE GENERA LA CUOTA sp_lcr_crear_cuota
            --QUE YA INCLUYE EL CALCULO DEL PAG MINIMO CON LA REGLA DE LCRPAGMIN	
		    exec @w_error       = sp_lcr_proyeccion_cuota
            @i_banco            = @w_banco,
            @i_fecha_valor      = @w_fecha_de_pago,
            @i_proy             = 'S',
            @o_saldo_prox       = @w_saldo_pry        out 
		    if @w_error <> 0  goto ERROR
         
		
         select @w_pago_minimo = @w_saldo_pry
	  
		if @w_pago_minimo < @w_param_umbral select @w_pago_minimo = @w_param_umbral
    
     end 
  
   end 
       if @w_op_estado= 3 select @w_fecha_de_pago = @w_fecha_ven
	  
      -- REFERENCIA DE PAGO
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= 'PI',
      @i_id_referencia  	= @w_operacion,
      @i_fecha_lim_pago 	= @w_fecha_proceso,
      @o_referencia     	= @w_referencia_pago out

      if @w_error <> 0 begin
         goto ERROR
      end

      -- CONVENIO	 
      select  @w_numero_convenio = ctr_convenio
      from ca_corresponsal_tipo_ref
      where ctr_tipo_cobis = 'PI'
      and ctr_co_id =  @w_id_corresp

      -- PRESTAMOS
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'PRODUCTO',               @w_producto)
      
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'VALOR LINEA DE CREDITO', '$ ' + convert(varchar, @w_monto_linea_credito) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'DISPONIBLE',             '$ ' + convert(varchar, @w_disponible) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'UTILIZADO',              '$ ' + convert(varchar, @w_utilizado) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'FECHA DE PAGO',          convert(varchar, @w_fecha_de_pago, 103))
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'PAGO MÍNIMO',            '$ ' + convert(varchar, @w_pago_minimo) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'PAGO TOTAL',             '$ ' + convert(varchar, @w_pago_total) + ' ' + @w_nem_moneda)    -- '$ ' + convert(varchar, @w_pago_total) + ' ' + @w_nem_moneda)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'REFERENCIA DE PAGO',     @w_referencia_pago)
      insert into #prestamos values (@w_operacion, @w_toperacion, @w_banco, @w_inst_proc, 'S', 'S', 'NRO CONVENIO',           @w_numero_convenio)
      
      -- MOVIMIENTO PRESTAMOS REVOLVENTE 
      insert into #movimiento_prestamo
      select distinct top 20
      'Secuencial'	= tr_secuencial,
      'Operacion'		= tr_operacion,
      'TipoOperacion' = @w_toperacion,
      'TipoMov'		= tr_tran,
      'FechaMov'		= convert(varchar, tr_fecha_mov, 103),	
      'ValorMov'		= '$ ' + convert(varchar, dtr_monto) + ' ' + @w_nem_moneda,
      'EstadoTrn'		= rtrim(tr_estado),
      null,null,null,null
      from ca_transaccion inner join ca_det_trn
      on dtr_operacion = tr_operacion 
      and tr_secuencial = dtr_secuencial
      where tr_operacion = @w_operacion
      and tr_estado <> 'RV'
      and dtr_afectacion =  'D'
      and dtr_monto >0 
	  and dtr_concepto not like '%PAG%'
      and tr_tran        in ('DES', 'PAG')
      and tr_secuencial  >  0
      order by tr_secuencial desc

      update #movimiento_prestamo set 
      consecutivo = sod_consecutivo,
      linea = sod_linea,
      fecha_str = convert(varchar(10),sod_fecha,112)
      from ca_santander_orden_deposito
      where sod_operacion = operacion
      and sod_secuencial= sec_movimiento
      and estado_trn <> 'CON'

      update #movimiento_prestamo
      set referencia= convert(varchar(10),(consecutivo * 10000 + linea))
      from ca_santander_orden_deposito
      where sod_operacion = operacion
      and sod_secuencial= sec_movimiento
      and estado_trn <> 'CON'

      update #movimiento_prestamo
      set estado_trn = 'P' --procesado
      from ca_santander_resultado_desembolso
      where rd_descripcion_referencia = referencia
      and rd_fecha_transferencia= fecha_str
      and (rd_motivo_devolucion = '00' or rd_causa_rechazo = '00')

      update #movimiento_prestamo
      set estado_trn = 'P' --procesado
      where tipo_movimiento = 'PAG'

   end 


   -- GARANTIAS
   select 
      @w_producto = '',       @w_monto_a_pagar = 0,   @w_referencia_pago = '', 
      @w_numero_convenio = 0, @w_grupo = '',          @w_tramite = null,
      @w_inst_proc = 0

   select distinct tg_referencia_grupal banco
   into #opers_gar
   from cob_credito..cr_tramite_grupal 
   where tg_cliente = @i_cliente
                   
   select
      op_operacion,	op_toperacion,	op_tramite,
      op_cliente,		op_nombre,		op_banco,	
      op_estado 
   into #garantias
   from cob_cartera..ca_operacion inner join #opers_gar
   on op_banco = banco
   and op_estado = 0

   -- select * from #garantias
   select @w_operacion = 0
   while (1=1) begin 
      select top 1 
         @w_operacion= op_operacion, 
         @w_tramite  = op_tramite,
         @w_grupo		= concat(concat(op_cliente,' - '), op_nombre),
         @w_banco    = op_banco,
         @w_tramite  = op_tramite
      from #garantias
      where op_operacion > @w_operacion
      order by op_operacion asc

      if @@rowcount = 0 break 

      select @w_producto = 'GARANTIA'
      
      select top 1 @w_inst_proc = io_id_inst_proc 
      from cob_workflow..wf_inst_proceso
      where io_campo_3 = @w_tramite
      order by io_id_inst_proc desc

      -- MONTO A PAGAR
      select @w_monto_a_pagar = sum(gl_monto_garantia)
      from cob_cartera..ca_garantia_liquida 
      where gl_tramite = @w_tramite
      and gl_pag_estado = 'PC'
      
      -- FECHA DE PAGO
      select @w_fecha_de_pago = fp_fecha 
      from cobis..ba_fecha_proceso

      -- REFERENCIA DE PAGO
      select @w_tipo_cobis = 'GL'
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= @w_tipo_cobis,
      @i_id_referencia  = @w_operacion,
      @i_monto          = @w_monto_a_pagar,
      @i_fecha_lim_pago = @w_fecha_de_pago,
      @o_referencia     = @w_referencia_pago out

      if @w_error <> 0 begin
         goto ERROR
      end

      -- CONVENIO	 
      select  @w_numero_convenio = ctr_convenio
      from ca_corresponsal_tipo_ref
      where ctr_tipo_cobis = @w_tipo_cobis
      and ctr_co_id =  @w_id_corresp

      if @w_monto_a_pagar is not null and @w_monto_a_pagar > 0
      begin
         -- GARANTIAS
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'PRODUCTO',          @w_producto)
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'MONTO A PAGAR',     '$ ' + convert(varchar, @w_monto_a_pagar) + ' ' + @w_nem_moneda)
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'FECHA DE PAGO',     convert(varchar, @w_fecha_de_pago, 103))
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'REFERENCIA DE PAGO',@w_referencia_pago)
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'NRO CONVENIO',      @w_numero_convenio)
         insert into #prestamos values (@w_operacion, @w_producto, @w_banco, @w_inst_proc, 'S', 'N', 'GRUPO',             @w_grupo)
      end
      
     
   end
end -- FIN: i_operacion = H

if @i_operacion = 'E'
begin
   select 
   @w_fecha_proceso = fp_fecha 
   from cobis..ba_fecha_proceso
         
   if @i_toperacion = 'GRUPAL' or @i_toperacion = 'INDIVIDUAL'
   begin
      
      select
      @w_operacion   = op_operacion,
      @w_banco       = op_banco,
      @w_cod_grupo   = op_cliente,
      @w_tramite     = op_tramite,
      @w_toperacion  = op_toperacion,
      @w_promo       = op_promocion
      from ca_operacion 
      where op_operacion = @i_op_operacion
      
      -- PRODUCTO
      if @i_toperacion = 'GRUPAL'
      begin
         if @w_promo = 'N'
         begin
            select @w_producto = 'GRUPAL TRADICIONAL'
         end
         else if @w_promo = 'S'
         begin
            select @w_producto = 'GRUPAL ANIMATE'
         end
         else
         begin
            --select @w_producto = 'GRUPAL TU NEGOCIO' -- Este Producto aun no existe
            select @w_producto = 'GRUPAL TRADICIONAL'
         end
      end

      -- LIQUIDA CON 
      select @w_liquida_con = isnull(sum(am_acumulado - am_pagado), 0)
      from cob_cartera..ca_amortizacion
      where am_operacion = @i_op_operacion
	  
	 -- PAGO SUGERIDO
	  select 
	  @w_monto_a_pagar 	= isnull(sum(am_cuota - am_pagado), 0) 
	  from ca_amortizacion, ca_dividendo 
	  where am_operacion 	= @i_op_operacion
	  and am_operacion	= di_operacion
	  and am_dividendo 	= di_dividendo 
	  and (di_estado     = @w_est_vencida or (di_estado = @w_est_vigente and di_fecha_ini <= @w_fecha_proceso))

      
      -- OTRO VALOR
      select @w_otro_valor = 'S'
      
      -- VALOR MINIMO DE PAGO
      select @w_valor_min_pago = 0
      
      -- CUOTAS VENCIDAS
      select @w_cuotas_vencidas = count(di_operacion) from ca_dividendo where di_operacion = @w_operacion and di_estado = @w_est_vencida

      -- FECHA DE PAGO
      select @w_fecha_ult_acceso = @w_fecha_proceso
      select top 1 @w_fecha_ult_acceso = di_fecha_ven from ca_dividendo where di_operacion = @w_operacion and di_estado in (1,0)
      if (@w_cuotas_vencidas > 0) 
      begin
         select @w_fecha_ult_acceso = @w_fecha_proceso 
      end
      
      -- GRUPAL
      select @w_tipo_cobis = 'PG'
      -- INDIVIDUAL
      if @w_toperacion = 'INDIVIDUAL' begin
         select @w_tipo_cobis = 'PI'
         select @w_referencia = @w_operacion
      end
      else
      begin
         select @w_referencia = @w_cod_grupo
      end
      
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= @w_tipo_cobis,
      @i_id_referencia  = @w_referencia,
      @i_fecha_lim_pago = @w_fecha_proceso,
      @o_referencia     = @w_referencia_pago out

      if @w_error <> 0 begin
         goto ERROR
      end
      
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PRODUCTO',            @w_producto)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'LIQUIDA CON',         @w_liquida_con)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PAGO SUGERIDO',       @w_monto_a_pagar)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'OTRO VALOR',          @w_otro_valor)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'VALOR MINIMO DE PAGO',@w_valor_min_pago)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'REFERENCIA DE PAGO',  @w_referencia_pago)
   
   end
   
   if @i_toperacion = 'REVOLVENTE'
   begin
   
      select
         @w_operacion 		= op_operacion,
         @w_banco          = op_banco,
         @w_toperacion 		= op_toperacion,
         @w_monto_linea_credito 	= op_monto_aprobado, 
         @w_tramite        = op_tramite
      from ca_operacion 
      where op_tipo_amortizacion = 'ROTATIVA'
      and @w_fecha_proceso between op_fecha_ini and op_fecha_fin
      and op_cliente = @i_cliente
      and op_operacion = isnull(@i_op_operacion,op_operacion)
   
      select @w_producto = 'LINEA DE CREDITO REVOLVENTE'
      
      -- PAGO TOTAL
      select @w_pago_total = isnull(sum(am_acumulado - am_pagado), 0)
      from cob_cartera..ca_amortizacion
      where am_operacion = @w_operacion

      if @w_pago_total < 0 select @w_pago_total = 0

      -- PARAMETRO UMBRAL
      select @w_param_umbral = pa_money
      from   cobis..cl_parametro with (nolock)
      where  pa_nemonico = 'LCRUMB'
      and    pa_producto = 'CCA'

      select @w_param_umbral = isnull(@w_param_umbral, 100)
      
      -- PAGO MINIMO
      select @w_pago_minimo = isnull(sum(am_cuota - am_pagado), 0)
      from ca_amortizacion, ca_dividendo
      where am_operacion = @w_operacion
      and am_operacion   = di_operacion
      and am_dividendo   = di_dividendo
      and (di_estado     = 2 or (di_estado = 1 and di_fecha_ven = @w_fecha_proceso ))
	  
	   select @w_fecha_pago = @w_fecha_proceso


   
      
    if @w_pago_minimo = 0 begin  --VALOR A PROYECTAR  EN CASO DE NO EXIGIBLES
	
	   select @w_fecha_pago = dateadd(dd,1,@w_fecha_proceso)
   
      exec @w_error  = cob_cartera..sp_lcr_calc_corte
      @i_operacionca   = @w_operacion,
      @i_fecha_proceso = @w_fecha_pago,
      @o_fecha_corte   = @w_fecha_pago out
   
      if @w_error <> 0  goto ERROR

      select @w_op_estado = op_estado , @w_fecha_ven = op_fecha_fin from ca_operacion where op_operacion = @w_operacion
   
   
      if @w_op_estado= 3 select @w_fecha_pago = @w_fecha_ven
  
      --PAGO MINIMO 
      select @w_saldo_capital = sum(am_cuota - am_pagado) 
      from ca_amortizacion
      where am_operacion = @w_operacion
      and am_concepto = 'CAP'
   
     if  @w_saldo_capital < @w_param_umbral select @w_pago_minimo  = @w_saldo_capital 
     else begin 
		
		 --ESTA PROYECCION REALIZA UN FV A LA FECHA DE CORTE SIGUIENTE
         --Y REALIZA EL CALCULO DE LA CUOTA CON EL PROGRAMA QUE GENERA LA CUOTA sp_lcr_crear_cuota
         --QUE YA INCLUYE EL CALCULO DEL PAG MINIMO CON LA REGLA DE LCRPAGMIN	
		 exec @w_error       = sp_lcr_proyeccion_cuota
         @i_banco            = @w_banco,
         @i_fecha_valor      = @w_fecha_pago,
         @i_proy             = 'S',
         @o_saldo_prox       = @w_saldo_pry        out 
		 if @w_error <> 0  goto ERROR
         
		
      
         select @w_pago_minimo = @w_saldo_pry
	  
		if @w_pago_minimo < @w_param_umbral select @w_pago_minimo = @w_param_umbral
    
   end 
  
end 

      -- OTRO VALOR
      select @w_otro_valor = 'S'
      
      -- VALOR MINIMO DE PAGO
      select @w_valor_min_pago = 0
      
      -- CUOTAS VENCIDAS
      select @w_cuotas_vencidas = count(di_operacion) from ca_dividendo where di_operacion = @w_operacion and di_estado = 2

      -- FECHA PAGO
      select @w_fecha_ult_acceso = @w_fecha_proceso
	  
      select top 1 @w_fecha_ult_acceso = di_fecha_ven from ca_dividendo where di_operacion = @w_operacion and di_estado in (1,0)
      if (@w_cuotas_vencidas > 0) 
      begin
         select @w_fecha_ult_acceso = @w_fecha_proceso
      end
         
	  
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= 'PI',
      @i_id_referencia  	= @w_operacion,
      @i_fecha_lim_pago 	= @w_fecha_proceso,
      @o_referencia     	= @w_referencia_pago out

      if @w_error <> 0 begin
         goto ERROR
      end
      
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PRODUCTO',             @w_producto)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PAGO TOTAL',           @w_pago_total)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PAGO MÍNIMO',          @w_pago_minimo)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'OTRO VALOR',           @w_otro_valor)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'VALOR MINIMO DE PAGO', @w_valor_min_pago)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'REFERENCIA DE PAGO', @w_referencia_pago)

   end
   
   if @i_toperacion = 'GARANTIA'
   begin

      select
         @w_operacion   = op_operacion,
         @w_tramite     = op_tramite,
         @w_toperacion  = @i_toperacion, -- 'GARANTIA'
         @w_banco       = op_banco
      from cob_cartera..ca_operacion
      where op_operacion = isnull(@i_op_operacion,op_operacion)
      --and op_cliente = @i_cliente
      
      select @w_producto = 'GARANTIA'

      -- PAGO
      select 
         @w_monto_a_pagar = sum(gl_monto_garantia) 
      from cob_cartera..ca_garantia_liquida 
      where gl_tramite = @w_tramite
      and gl_pag_estado = 'PC'
      --and gl_cliente = @i_cliente
      
      -- OTRO VALOR
      select @w_otro_valor = 'N'
      
      -- VALOR MINIMO DE PAGO
      select @w_valor_min_pago = 0
      
      -- FECHA DE PAGO
      select @w_fecha_proceso = fp_fecha 
      from cobis..ba_fecha_proceso
      
      -- REFERENCIA DE PAGO
      select @w_tipo_cobis = 'GL'
      exec @w_error 		= @w_sp_referencia
      @i_tipo_tran 		= @w_tipo_cobis,
      @i_id_referencia  = @w_operacion,
      @i_monto          = @w_monto_a_pagar,
      @i_fecha_lim_pago = @w_fecha_proceso,
      @o_referencia     = @w_referencia_pago out
      
      select @w_fecha_ult_acceso = @w_fecha_proceso

      if @w_error <> 0 begin
         goto ERROR
      end
      
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PRODUCTO',            @w_producto)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'PAGO',                @w_monto_a_pagar)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'VALOR MINIMO DE PAGO',@w_valor_min_pago)
      insert into #prestamos values(@w_operacion, @w_toperacion, @w_banco, '', '', '', 'REFERENCIA DE PAGO',  @w_referencia_pago)
      
   end

end -- FIN: i_operacion = E

-- ========================================

-- Result set #prestamos
select 
'OPERACION' 	= operacion, 
'TIPOOPERACION'= tipo_operacion,
'BANCO'        = banco,
'INST_PROC'    = inst_proc,
'PERMITEPAGO'  = permite_pago,
'PERMITEDISPERSION' = permite_disp,
'ETIQUETA' 		= etiqueta, 
'VALOR'			= valor
from #prestamos

-- Result set #movimiento_prestamo
select 
'OPERACION' 		= operacion, 
'TIPOOPERACION'		= tipo_operacion, 
'TIPOMOVIMIENTO' 	= (case tipo_movimiento when 'DES' then 'DISPOSICION' else 'PAGO REALIZADO EXITOSAMENTE' end),
'FECHAMOVIMIENTO' 	= fecha_movimiento,
'VALORMOVIMIENTO' 	= valor_movimiento,
'ESTADOTRN'			= (case estado_trn when 'ING' then 'P' when 'CON' then 'F' when 'P' then 'F' end)
from #movimiento_prestamo 

--162334. Preexistencia. Corrección Fecha Último acceso
select TOP 2 il_fecha_in into #ultimo_acceso
from cob_bvirtual..bv_ente,
cob_bvirtual..bv_in_login_his 
where en_ente = il_cliente
and   en_ente_mis = @i_cliente
order by il_fecha_in desc

select @w_fecha_ult_acceso = min(il_fecha_in) from #ultimo_acceso
	   
-- Validación si es parte de socio comercial o no
select @w_nem_socio = ea_colectivo  from cobis..cl_ente_aux where ea_ente = @i_cliente

if exists (select 1 from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_socio_comercial') and codigo = @w_nem_socio and estado = 'V' )
begin
  select @w_es_socio_com = 'S'
end

select 'FECHAULTIMOACCESO' = @w_fecha_ult_acceso,
       'CORREOELECTRONICO' = @w_correo_cli,
       'SOCIOCOMERCIAL'    = @w_es_socio_com

return 0

ERROR:
return @w_error

go
