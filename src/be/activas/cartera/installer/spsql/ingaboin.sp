/************************************************************************/
/*   Archivo:                    ingaboin.sp                            */
/*   Stored procedure:           sp_ing_abono_int                       */
/*   Base de datos:              cob_cartera                            */
/*   Producto:                   Cartera                                */
/*   Disenado por:               R. Garces                              */
/*   Fecha de escritura:         Feb. 1995                              */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Ingreso de abonos                                                  */ 
/*   S: Seleccion de negociacion de abonos automaticos                  */
/*   Q: Consulta de negociacion de abonos automaticos                   */
/*   I: Insercion de abonos                                             */
/*   U: Actualizacion de negociacion de abonos automaticos              */
/*   D: Eliminacion de negociacion de abonos automaticos                */
/************************************************************************/
/*                             ACTUALIZACIONES                          */
/*     FECHA        AUTOR                  ACTUALIZACION                */
/*  12/08/2019    A.ORTIZ    Forma de pago garantia liq                 */
/*  16/06/2022    ACH        REQ #185234-se agrega func para Individual */
/************************************************************************/

use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_ing_abono_int')
   drop proc sp_ing_abono_int
go


create proc sp_ing_abono_int
   @s_user                     login        = null,
   @s_term                     varchar(30)  = null,
   @s_date                     datetime     = null,
   @s_ssn                      int          = null,
   @s_srv                      varchar(30)  = null, 
   @s_sesn                     int          = null,
   @s_ofi                      smallint     = null,
   @s_rol		               smallint     = null, --Req00212 Pequeña Empresa	
   @i_accion                   char(1),     
   @i_banco                    cuenta,      
   @i_secuencial               int          = NULL,
   @i_tipo                     char(3)      = NULL,
   @i_fecha_vig                datetime     = NULL,
   @i_ejecutar                 char(1)      = 'N',
   @i_retencion                smallint     = NULL,
   @i_cuota_completa           char(1)      = NULL,   
   @i_anticipado               char(1)      = NULL,   
   @i_tipo_reduccion           char(1)      = NULL, 
   @i_proyectado               char(1)      = NULL,
   @i_tipo_aplicacion          char(1)      = NULL,
   @i_prioridades              varchar(255) = NULL,
   @i_en_linea                 char(1)      = 'S',
   @i_tasa_prepago             float        =  0,
   @i_verifica_tasas           char(1)      = null, 
   @i_dividendo                smallint,
   @i_bv                       char(1)      = null,
   @i_calcula_devolucion       char(1)      = NULL,
   @i_no_cheque                int          = NULL,  
   @i_cuenta                   cuenta       = NULL,  
   @i_mon                      smallint     = NULL,  
   @i_cheque                   int          = null,
   @i_cod_banco                catalogo     = null,
   @i_beneficiario             varchar(50)  = NULL,
   @i_cancela                  char(1)      = NULL,
   @i_renovacion               char(1)      = NULL,
   @i_solo_capital             char(1)      = 'N',
   @i_valor_multa              money        = 0,
   @o_secuencial_ing           int          = NULL out
   
as

declare 
@w_sp_name                    descripcion,
@w_return                     int,
@w_fecha_hoy                  datetime,
@w_est_vigente                tinyint,
@w_est_no_vigente             tinyint,
@w_est_vencido                tinyint,
@w_est_cancelado              tinyint,
@w_operacionca                int,
@w_causacion                  char(1),
@w_moneda                     tinyint,
@w_secuencial                 int,
@w_estado                     tinyint,
@w_fecha_ult_proceso          datetime,
@w_fecha                      datetime,
@w_secuencial_ing             int,
@w_i                          int,
@w_j                          int,
@w_k                          int,
@w_concepto_aux               catalogo,
@w_valor                      varchar(20),
@w_error                      int,
@w_numero_recibo              int,
@w_tasa_prestamo              float,
@w_periodicidad               catalogo,
@w_dias_anio                  smallint,
@w_base_calculo               char(1),
@w_fpago                      char(1),
@w_fecha_ult_proc             datetime,
@w_tipo                       varchar(1),
@w_descripcion                varchar(60),
@w_acepta_pago                char(1),
@w_moneda_nacional            tinyint,
@w_cotizacion_hoy             money,
@w_prepago_desde_lavigente    char(1),
@w_ab_dias_retencion          smallint,
@w_parametro_control          catalogo,
@w_dias_retencion             smallint,
@w_forma_pago                 catalogo,
@w_operacion_alterna          int,
@w_num_dec_op                 smallint,
@w_rowcount                   int,
@w_secuencial_pag             int,    -- ITO 10/02/2010
@w_extraordinario             char(1),
@w_ccuenta					  cuenta,
@w_saldo_cap				  money,
@w_msg                        varchar(100),
@w_monto_mpg				  money,
@w_tramite                    int,--porCaso#185234
@w_cliente_op                 int,
@w_monto_garantia			  money,
@w_toperacion                 varchar(10) 

select   @w_sp_name = 'sp_ing_abono_int'

-- CODIGO DE LA MONEDA LOCAL
select @w_moneda_nacional = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

select @w_est_no_vigente  = isnull(es_codigo, 255)
from ca_estado
where rtrim(ltrim(es_descripcion)) = 'NO VIGENTE'

select @w_est_vigente  = isnull(es_codigo, 255)
from ca_estado
where rtrim(ltrim(es_descripcion)) = 'VIGENTE'

select @w_est_vencido  = isnull(es_codigo, 255)
from ca_estado
where rtrim(ltrim(es_descripcion)) = 'VENCIDO'

select @w_est_cancelado  = isnull(es_codigo, 255)
from ca_estado
where rtrim(ltrim(es_descripcion)) = 'CANCELADO'

select @i_prioridades = isnull(@i_prioridades, '')



-- INGRESO DEL PAGO 
if @i_accion = 'I' begin

   select 
   @w_operacionca             = op_operacion,
   @w_moneda                  = op_moneda,
   @w_estado                  = op_estado,
   @w_fecha_ult_proceso       = op_fecha_ult_proceso,
   @w_periodicidad            = op_tdividendo,
   @w_dias_anio               = op_dias_anio,
   @w_base_calculo            = op_base_calculo,
   @w_tipo                    = op_tipo,   
   @w_prepago_desde_lavigente = op_prepago_desde_lavigente,
   @w_toperacion              = op_toperacion
   from   ca_operacion
   where  op_banco  = @i_banco

   if @@rowcount = 0  return 701025

   
   select @w_acepta_pago = es_acepta_pago
   from ca_estado
   where es_codigo = @w_estado
   
   if @w_acepta_pago = 'N'
      return 701117

   select @w_fecha_hoy = @w_fecha_ult_proceso
   
   -- DETERMINAR EL VALOR DE COTIZACION DEL DIA 
   if @w_moneda = @w_moneda_nacional
      select @w_cotizacion_hoy = 1.0
   else
   begin
      exec sp_buscar_cotizacion
      @i_moneda     = @w_moneda,
      @i_fecha      = @w_fecha_ult_proceso,
      @o_cotizacion = @w_cotizacion_hoy output
   end

   -- CALCULAR TASA DE INTERES PRESTAMO
   select 
   @w_tasa_prestamo = isnull(sum(ro_porcentaje),0),
   @w_fpago         = ro_fpago
   from ca_rubro_op
   where ro_operacion  = @w_operacionca
   and   ro_tipo_rubro = 'I'
   and   ro_fpago     in ('A','P','T')
   group by ro_fpago

   if @w_fpago = 'P' select @w_fpago = 'V'
  
   select @i_tasa_prepago = @w_tasa_prestamo 

   -- SI ES UN PAGO DESDE EL FRONT-END, GENERAR EL SECUENCIAL DE INGRESO 
   if @i_secuencial is null
   begin
   
      exec @w_secuencial_ing = sp_gen_sec
      @i_operacion      = @w_operacionca
      
      -- ITO 10/02/2010
      exec @w_secuencial_pag = sp_gen_sec
      @i_operacion      = @w_operacionca
      -- FIN ITO 10/02/2010
   
   end
   else
      select @w_secuencial_ing = @i_secuencial 

   select @o_secuencial_ing = @w_secuencial_ing
 
   -- GENERACION DEL NUMERO DE RECIBO 

   exec @w_return = sp_numero_recibo
   @i_tipo    = 'P',
   @i_oficina = @s_ofi, 
   @o_numero  = @w_numero_recibo out

   if @w_return != 0  return @w_return
   
   select @w_concepto_aux = abdt_concepto,@w_monto_mpg = abdt_monto_mpg
   from  cob_cartera..ca_abono_det_tmp
   where abdt_user = @s_user
   and   abdt_sesn = @s_sesn

   --Si hay garantias liquidas se llena esta tabla
   select @w_cliente_op = cu_garante
   from cob_custodia..cu_custodia
   where cu_codigo_externo = @i_cuenta
   
   --porCaso#185234
   if (@w_toperacion = 'GRUPAL') begin
      select @w_tramite = tg_tramite
      from   cob_credito..cr_tramite_grupal
      where  tg_operacion = @w_operacionca
	  
      select @w_monto_garantia = gl_monto_garantia from ca_garantia_liquida 
      where gl_cliente = @w_cliente_op
      and   gl_tramite = @w_tramite
   
   end else begin
      select @w_tramite = op_tramite
      from   cob_cartera..ca_operacion
      where  op_operacion = @w_operacionca
      
      select @w_monto_garantia = gl_monto_garantia 
      from ca_garantia_liquida 
      where gl_cliente = @w_cliente_op
      and   gl_tramite = @w_tramite
   end	   

   if @w_concepto_aux = 'GAR_DEB' 
   begin
		if @w_monto_mpg < @w_monto_garantia or @w_monto_mpg > @w_monto_garantia
		 begin 
			return 710611
		end
	end

   -- INSERCION DE CA_ABONO 
   insert into ca_abono (
   ab_operacion,          ab_fecha_ing,                ab_fecha_pag,
   ab_cuota_completa,     ab_aceptar_anticipos,        ab_tipo_reduccion,
   ab_tipo_cobro,         ab_dias_retencion_ini,       ab_dias_retencion,
   ab_estado,             ab_secuencial_ing,           ab_secuencial_rpa,
   ab_secuencial_pag,     ab_usuario,                  ab_terminal,
   ab_tipo,               ab_oficina,                  ab_tipo_aplicacion,
   ab_nro_recibo,         ab_tasa_prepago,             ab_dividendo,
   ab_calcula_devolucion, ab_prepago_desde_lavigente,  ab_extraordinario)
   values (
   @w_operacionca,        @w_fecha_hoy,                @i_fecha_vig,
   @i_cuota_completa,     @i_anticipado,               @i_tipo_reduccion,
   @i_proyectado,         @i_retencion,                @i_retencion,
   'ING',                 @w_secuencial_ing,           0,
   @w_secuencial_pag,     @s_user,                     @s_term,                -- @w_secuencial_pag por 0
   @i_tipo,               @s_ofi,                      @i_tipo_aplicacion,
   @w_numero_recibo,      @i_tasa_prepago,             @i_dividendo,
   @i_calcula_devolucion, @w_prepago_desde_lavigente,  @i_solo_capital)

   select @w_concepto_aux = abdt_concepto,@w_monto_mpg = abdt_monto_mpg
   from  ca_abono_det_tmp
   where abdt_user = @s_user
   and   abdt_sesn = @s_sesn
   
   if @w_concepto_aux = 'GAR_DEB'
   begin
	select @w_ccuenta = gp_garantia 
		from cob_cartera..ca_operacion co,
		cob_credito..cr_gar_propuesta gp
		where co.op_tramite = gp.gp_tramite
		and co.op_banco = @i_banco
		
		select @i_cuenta = @w_ccuenta
   end
   
    if @w_concepto_aux = 'FALLECIDO'
	  begin
		exec sp_qr_pagos
			@i_banco = @i_banco,
			@i_formato_fecha = 103,
			@i_cancela = 'N',
			@o_saldo_cap = @w_saldo_cap out

		if @w_monto_mpg < @w_saldo_cap or @w_monto_mpg > @w_saldo_cap
			begin
			if @@rowcount = 0 begin
					select 
					@w_error = 710611,
					@w_msg = 'ERROR: EL IMPORTE NO COINCIDE CON EL TOTAL DEL LIQUIDA CON $ '+cast(@w_saldo_cap as varchar)
					goto ERROR
				end
			end
      end
   
   -- INSERCION DE CA_DET_ABONO LEYENDO DE CA_DET_ABONO_TMP 
   insert into ca_abono_det(
   abd_secuencial_ing,    abd_operacion,               abd_tipo,  
   abd_concepto,          abd_cuenta,                  abd_beneficiario,            
   abd_monto_mpg,         abd_monto_mop,               abd_monto_mn,                
   abd_cotizacion_mpg,    abd_cotizacion_mop,          abd_moneda,                  
   abd_tcotizacion_mpg,   abd_tcotizacion_mop,         abd_cheque,                  
   abd_cod_banco,         abd_inscripcion,             abd_carga,                   
   abd_porcentaje_con)
   select
   @w_secuencial_ing,     @w_operacionca,              abdt_tipo,
   abdt_concepto,         isnull(@w_ccuenta,abdt_cuenta),isnull(abdt_beneficiario,''), 
   abdt_monto_mpg,        abdt_monto_mop,              abdt_monto_mn,               
   abdt_cotizacion_mpg,   abdt_cotizacion_mop,         abdt_moneda,                 
   abdt_tcotizacion_mpg,  abdt_tcotizacion_mop,        abdt_cheque,                 
   abdt_cod_banco,        abdt_inscripcion,            abdt_carga,                  
   abdt_porcentaje_con
   from  ca_abono_det_tmp
   where abdt_user = @s_user
   and   abdt_sesn = @s_sesn
   
   -- INSERCION DE LAS PRIORIDADES DE PAGO, QUE VIENEN EN UN STRING 
   
   select @w_concepto_aux = ''
   while @i_prioridades <> '' 
   begin
      set rowcount 1
      select @w_concepto_aux = ro_concepto
      from   ca_rubro_op
      where  ro_operacion = @w_operacionca
      and    ro_fpago     <> 'L'
      and    ro_concepto  > @w_concepto_aux
      order  by ro_concepto

      set rowcount 0
     
      select @w_k = charindex(';',@i_prioridades)

      if @w_k = 0 
      begin
         select @w_k = charindex('#',@i_prioridades)

         if @w_k = 0
            select @w_valor = substring(@i_prioridades, 1, datalength(@w_valor))
         else
            select @w_valor = substring(@i_prioridades, 1, @w_k-1)

         if exists(select 1 from ca_abono_prioridad
         where ap_secuencial_ing = @w_secuencial_ing 
         and   ap_operacion      = @w_operacionca
         and   ap_concepto       = @w_concepto_aux)
         begin
            delete ca_abono_prioridad
            where ap_secuencial_ing = @w_secuencial_ing 
            and   ap_operacion = @w_operacionca
            and   ap_concepto = @w_concepto_aux
            
            select @w_descripcion = @i_prioridades + '-' + @w_valor
            
            insert into ca_errorlog (
            er_fecha_proc, er_error,  er_usuario,
            er_tran,       er_cuenta, er_descripcion )
            values (
            @w_fecha_hoy,  999999,    @s_user,
            0,             @i_banco,  @w_descripcion )
         end

         
         if @w_valor is null or @w_valor = '' or @w_concepto_aux = '' 
         begin
            select @w_descripcion = @i_prioridades + '-' + @w_valor
            
            insert into ca_errorlog (
            er_fecha_proc,er_error,  er_usuario,
            er_tran,      er_cuenta, er_descripcion)
            values (
            @w_fecha_hoy, 999999,    @s_user,
            0,            @i_banco,  @w_descripcion )
         end

          
         insert into ca_abono_prioridad
         values (@w_secuencial_ing,@w_operacionca,@w_concepto_aux,convert(int,@w_valor))

         if @@error != 0 
         begin           
            --PRINT 'ingaboin.sp error insertando en ca_abono_prioridad a secuencial_ing ' + cast(@w_secuencial_ing as varchar) + ' @w_concepto_aux ' + cast(@w_concepto_aux as varchar) + ' @w_valor '+ cast(@w_valor as varchar)
            return 710001
         end

         select @w_i = @w_i + 1,
         @w_j = 1

         break
      end   --if @w_k = 0 
      else 
      begin
         select @w_valor = substring (@i_prioridades, 1, @w_k-1)

         if exists(select 1 from ca_abono_prioridad
         where ap_secuencial_ing = @w_secuencial_ing 
         and   ap_operacion = @w_operacionca
         and   ap_concepto = @w_concepto_aux)
         begin
            select @w_descripcion = @i_prioridades + '-' + @w_valor
            
            insert into ca_errorlog (         
            er_fecha_proc, er_error,  er_usuario,
            er_tran,       er_cuenta, er_descripcion )
            values (
            @w_fecha_hoy,  999999,    @s_user,
            0,             @i_banco,  @w_descripcion )
         end
         
         
         if @w_valor is null or @w_valor = ''  or @w_concepto_aux = '' 
         begin
         
            select @w_descripcion = @i_prioridades + '-' + @w_valor
            
            insert into ca_errorlog (
            er_fecha_proc, er_error,  er_usuario,
            er_tran,       er_cuenta, er_descripcion)
            values (
            @w_fecha_hoy,  999999,    @s_user,
            0,             @i_banco,  @w_descripcion)
         end
            
         insert into ca_abono_prioridad
         values (@w_secuencial_ing,@w_operacionca,@w_concepto_aux,convert(int,@w_valor))
         
         if @@error != 0 return 710001
         
         select @w_j = @w_j + 1
         select @i_prioridades = substring(@i_prioridades, @w_k +1,datalength(@i_prioridades) - @w_k)
      end     
   end   ---while @i_prioridades <> '' 
   


   ---NR 296
   ---Si la forma de pago es la parametrizada por el usuario CHLOCAL
   ---y el credito es clase O rotativo, se debe colocar unos dias de retencion al 
   -- Pago apra que solo se aplique pasado este tiempo
   
   select @w_forma_pago = abd_concepto
   from ca_abono_det
   where abd_operacion = @w_operacionca
   and abd_secuencial_ing = @w_secuencial_ing
   
   
   select  @w_parametro_control =  pa_char 
   from cobis..cl_parametro
   where pa_nemonico = 'FPCHLO'
   and pa_producto = 'CCA'
   set transaction isolation level read uncommitted
      
      
   if @w_tipo = 'O' and @w_forma_pago =  @w_parametro_control
   begin
      
      select @w_ab_dias_retencion = @i_retencion
      
      select  @w_dias_retencion =  pa_smallint
      from cobis..cl_parametro
      where pa_nemonico = 'DCHLO'
      and pa_producto = 'CCA'
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted
      
      if @w_rowcount = 0
         select  @w_dias_retencion = 0
      
      select    @w_ab_dias_retencion  = @w_dias_retencion,
                @i_retencion =  @w_ab_dias_retencion
      
      update ca_abono
      set ab_dias_retencion = @w_ab_dias_retencion,
          ab_dias_retencion_ini = @w_ab_dias_retencion
      where ab_operacion = @w_operacionca
      and  ab_secuencial_ing = @w_secuencial_ing
   
                
   end         

   --- NR 296
   /* -- Inicio -- Smora REQ.455
   select @w_operacion_alterna = oa_operacion_alterna
   From ca_operacion_alterna
   Where oa_operacion_original = @w_operacionca
   
   if @@rowcount != 0
   begin
      exec @w_error = sp_decimales
           @i_moneda       = @w_moneda,
           @o_decimales    = @w_num_dec_op out
      
      if @w_error != 0 
          return  @w_error
      
      exec @w_error = sp_dividir_pago_alterna
      @i_operacion_original = @w_operacionca,
      @i_operacion_alterna  = @w_operacion_alterna,
      @i_secuencial_ing     = @w_secuencial_ing,
      @i_num_dec            = @w_num_dec_op
      
      if @w_error != 0  return  @w_error
   end
   -- Fin -- Smora REQ.455
   */
      
   -- CREACION DEL REGISTRO DE PAGO
   if (@i_fecha_vig = @w_fecha_hoy) and (@i_ejecutar = 'S')          --Aplicar en linea  
   begin 

      exec @w_return    = sp_registro_abono
      @s_user           = @s_user,
      @s_term           = @s_term,
      @s_date           = @s_date,
      @s_ofi            = @s_ofi,
      @s_ssn            = @s_ssn,
      @s_sesn           = @s_sesn,
      @s_srv            = @s_srv,            
      @i_secuencial_ing = @w_secuencial_ing,
      @i_secuencial_pag = @w_secuencial_pag,           -- ITO 11/02/2010
      @i_operacionca    = @w_operacionca,
      @i_en_linea       = @i_en_linea,
      @i_fecha_proceso  = @i_fecha_vig,
      @i_no_cheque      = @i_no_cheque,
      @i_cuenta         = @i_cuenta,   
      @i_mon            = @i_mon,      
      @i_dividendo      = @i_dividendo,
      @i_cotizacion     = @w_cotizacion_hoy
       
      if @w_return != 0 return @w_return  
   
      
       -- APLICACION EN LINEA DEL PAGO SIN RETENCION 
      if @i_retencion = 0  and @w_tipo <> 'D'
      begin  --(1)
         exec @w_return    = sp_cartera_abono
         @s_user           = @s_user,
         @s_srv            = @s_srv,            
         @s_term           = @s_term,
         @s_date           = @s_date,
         @s_sesn           = @s_sesn,
         @s_ssn            = @s_ssn,
         @s_ofi            = @s_ofi,
         @s_rol		   = @s_rol,
         @i_secuencial_ing = @w_secuencial_ing,
         @i_operacionca    = @w_operacionca,
         @i_fecha_proceso  = @i_fecha_vig,
         @i_en_linea       = @i_en_linea,
         @i_no_cheque      = @i_no_cheque,   
         @i_cuenta         = @i_cuenta,      
         @i_dividendo      = @i_dividendo,
         @i_cancela        = @i_cancela,
         @i_renovacion     = @i_renovacion,
         @i_cotizacion     = @w_cotizacion_hoy,
         @i_valor_multa    = @i_valor_multa 
   
         if @w_return !=0  return @w_return
   
      end ---(FIN de ejecuta sp_cartera_abono (1)
      else
      if @w_tipo = 'D'
      begin
         exec @w_return    = sp_cartera_abono_dd
         @s_user           = @s_user,
         @s_srv            = @s_srv,            
         @s_term           = @s_term,
         @s_date           = @s_date,
         @s_sesn           = @s_sesn,
         @s_ssn            = @s_ssn,
         @s_ofi            = @s_ofi,
         @i_secuencial_ing = @w_secuencial_ing,
         @i_operacionca    = @w_operacionca,
         @i_fecha_proceso  = @i_fecha_vig,
         @i_en_linea       = @i_en_linea,
         @i_no_cheque      = @i_no_cheque,
         @i_cotizacion     = @w_cotizacion_hoy
   
         if @w_return !=0 
             return @w_return           
      end
   end
end  -- operacion I 

/*consulta cuantos pagos grupales de un credito estan pendientes de aplicar*/
if @i_accion = 'G'
begin
    select @w_operacionca = op_operacion
    from ca_operacion
    where op_banco = @i_banco
    
    select 
    numero_pagos = count(1),
    monto        = sum(co_monto)
    from ca_corresponsal_trn 
    where 
    co_codigo_interno = @w_operacionca 
    and co_tipo       = 'PG' 
    and co_estado     = 'I'
    and co_accion     = 'I'
end

return 0

ERROR: 
	exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file = null,
     @t_from  = @w_sp_name,
     @i_num = @w_error,
	 @i_msg = @w_msg

return @w_error

go
