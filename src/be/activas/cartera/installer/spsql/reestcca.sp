/********************************************************************/
/*  Archivo:            reestcca.sp                                 */
/*  Stored procedure:   sp_reestructuracion_cca                     */
/*  Base de datos:      cob_cartera                                 */
/*  Producto:           Cartera                                     */
/*  Disenado por:       RRB                                         */
/*  Fecha de escritura: Abr 09                                      */
/********************************************************************/
/*                             IMPORTANTE                           */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  'MACOSA'.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno de sus         */
/*  usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de MACOSA o su representante.             */
/********************************************************************/  
/*                              PROPOSITO                           */
/*  Stored procedure autorizado por Cartera para restructurar       */
/*  un prestamo desde otro modulo cobis                             */
/* 04/10/2010        Yecid Martinez     Fecha valor baja Intensidad */
/*                                      NYMR 7x24                   */
/* 22/Feb/2011        Johan Ardila      REQ 246 - Reestructuraciones*/
/* MAR-2011          Elcira Pelaez B    Recalculo FNG despues de    */
/*                                      la Reestructuracion cuando  */
/*                                      el saldo ya esta definido   */
/* MAR-2015          Elcira Pelaez B    NR.436. BANCAMIA            */
/* MAY-12-2020       ANDY GONZALEZ      REQ 138837 DESPLAZAMIENTO F2*/
/********************************************************************/

use cob_cartera
go
set ansi_warnings off
go
if exists (select 1 from sysobjects where name = 'sp_reestructuracion_cca')
   drop proc sp_reestructuracion_cca
go

---NR.436 NORMALIZACION MAR.26.2015

create proc sp_reestructuracion_cca 
   @s_user               login        = null,
   @s_term              varchar(30)  = null,
   @s_sesn               int          = null,
   @s_date               datetime     = null,
   @s_ofi                smallint     = null,
   @i_banco              cuenta       = null,
   @i_anterior           cuenta       = null,
   @i_migrada            cuenta       = null,
   @i_tramite            int          = null,
   @i_cliente            int          = null,
   @i_nombre             descripcion  = null,
   @i_sector             catalogo     = null,
   @i_toperacion         catalogo     = null,
   @i_oficina            smallint     = null,
   @i_moneda             tinyint      = null,
   @i_comentario         varchar(255) = null,
   @i_oficial            smallint     = null,
   @i_fecha_ini          datetime     = null,
   @i_fecha_fin          datetime     = null,
   @i_fecha_ult_proceso  datetime     = null,
   @i_fecha_liq          datetime     = null,
   @i_fecha_reajuste     datetime     = null,
   @i_monto              money        = null,
   @i_monto_aprobado     money        = null,
   @i_destino            catalogo     = null,
   @i_lin_credito        cuenta       = null,
   @i_ciudad             int          = null,
   @i_periodo_reajuste   smallint     = null,
   @i_reajuste_especial  char(1)      = null,
   @i_tipo               char(1)      = null,
   @i_forma_pago         catalogo     = null,
   @i_cuenta             cuenta       = null,
   @i_dias_anio          smallint     = null,
   @i_tipo_amortizacion  varchar(10)  = null,
   @i_cuota_completa     char(1)      = null,
   @i_tipo_cobro         char(1)      = null,
   @i_tipo_reduccion     char(1)      = null,
   @i_aceptar_anticipos  char(1)      = null,
   @i_precancelacion     char(1)      = null,
   @i_tipo_aplicacion    char(1)      = null,
   @i_tplazo             catalogo     = null,
   @i_plazo              int          = null,
   @i_tdividendo         catalogo     = null,
   @i_periodo_cap        int          = null,
   @i_periodo_int        int          = null,
   @i_dist_gracia        char(1)      = null,
   @i_gracia_cap         int          = null,
   @i_gracia_int         int          = null,
   @i_dia_fijo           int          = null,
   @i_cuota              money        = null,
   @i_evitar_feriados    char(1)      = null,
   @i_renovacion         char(1)      = null,
   @i_mes_gracia         tinyint      = null,
   @i_formato_fecha      int          = 101, 
   @i_upd_clientes       char(1)      = null,
   @i_dias_gracia        smallint     = null,
   @i_reajustable        char(1)      = null,
   @i_clase_cartera      catalogo     = null,
   @i_origen_fondos      catalogo     = null,
   @i_dias_clausula      int          = null,
   @i_reestructuracion   char(1)      = null,
   @i_convierte_tasa     char(1)      = null,
   @i_tramite_nuevo      int          = null,
   @i_paso               Char(1)      = null, -- (S) Simulacion – (D) Defintiva - (C) Consulta - (T) Borra Temporales - (P) Valida Pago
   @i_pago               Char(1)      = null, -- (S) Exige Pago – (N) No Exige Pago
   @i_tasa               float        = -1,   -- Nueva tasa Efectiva
   @i_dividendo          int          = null,
   @i_opcion             tinyint      = null,
   @i_concepto           catalogo     = '',
   @i_fecha_fija_pago    Char(1)      = null,
   @i_bloquear_salida    char(1)      = 'N',
   @i_validar_cuota      char(1)      = 'N',
   @i_batch              char(1)      = 'N',
   @i_respetar_vencidas  char(1)      = 'N'
   
   
as declare  
   @w_sp_name            varchar(30),
   @w_operacionca        int,
   @w_max_sec_rec        int,
   @w_ro_porcentaje      float,
   @w_dias_anio          smallint,
   @w_tdividendo         char(1),
   @w_ro_fpago           char(1),
   @w_rot_num_dec        tinyint,
   @w_error              int,
   @w_filas_rubros       int,
   @w_primer_des         int,
   @w_bytes_env          int,
   @w_filas              int,
   @w_buffer             int,
   @w_count              int,
   @w_monto              money,
   @w_concepto           catalogo, 
   @w_dividendo_ini      int,
   @w_estado             tinyint,
   @w_est_vigente        tinyint,
   @w_est_vencido        tinyint,
   @w_fecha_ult_pago     smalldatetime,
   @w_fecha_ult_proceso  smalldatetime,
   @w_cuota_inicial      money,
   @w_cuota_reest        float,
   @w_dias_pago          tinyint,
   @w_cuota_res          money,
   @w_max_tram_rees      int,
   @w_val_pend           money,
   @w_tramite            int,
   @w_monto_cap          money,
   @w_parametro_fng      catalogo,
   @w_di_dividendo       int,
   @w_secuencial         int,
   @w_tramite_reest      int,
   @w_cod_gar_fng        catalogo,
   @w_monto_hisrorico    money,
   @w_diff               money,
   @w_max_div_reest      smallint,                       -- REQ 175: PEQUEÑA EMPRESA
   @w_divini_reg         smallint,                       -- REQ 175: PEQUEÑA EMPRESA
   @w_opcion_cap         char(1),                         -- REQ 175: PEQUEÑA EMPRESA
   @w_tiene_fng          char(1),
   @w_op_hija            int,
   @w_secuencial_res     int,
   @w_banco_hija         cuenta,
   @w_monto_otros        money,
   @w_cuota              money,
   @w_div_vigente        int,
   @w_fecha_hoy          datetime,
   @w_cap_pagado         money ,
   @w_val_capitalizar    money,
   @w_op_monto           money,
   @w_secuencial_trn     int,
   @w_saldo_antes        money,
   @w_saldo_ok           money,
   @w_monto_amor         money,
   @w_min_div_reest      smallint,
   @w_co_categoria       char(1),
   @w_cap_amor_antes     money,
   @w_est_novigente      tinyint,
   @w_est_suspenso       tinyint,
   @w_plazo_tramite      int,
   @w_tplazo_inicial     char(1),
   @w_tplazo_tmp         char(1),
   @w_op_cuota_tmp       money,   
   @w_cambio_rubros      tinyint,
   @w_con_r              catalogo,
   @w_con_t              catalogo,
   @w_linea_hija         catalogo,
   @w_toperacion         catalogo,
   @w_tipo               char(1),
   @w_total_capitalizado money,
   @w_tr_sujcred         catalogo,
   @w_superior_fng       char(10),
   @w_tdividendo_org     catalogo,
   @w_tasa_org           float,
   @w_tr_tipo_cuota      catalogo,
   @w_rfechant           char(1),
   @w_cliente_victima    char(1),
   @w_op_cliente         int,
   @w_parametro_VHV      catalogo,
   @w_commit             char(1),
   @w_fecha_proceso      datetime, 
   @w_moneda             int ,
   @w_fecha_fin          datetime
   
--- VARIABLES INICIALES 
select   
@w_sp_name            = 'sp_reestructuracion_cca',
@w_buffer             = 2500,   --TAMANIO MAXIMO DEL BUFFER DE RED
@w_cambio_rubros      = 0,
@w_op_hija            = 0,
@w_monto_otros        = 0,
@w_val_pend           = 0,
@w_total_capitalizado = 0,
@w_commit             = 'N'

select @w_fecha_hoy = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7

if @s_date is null
select  @s_date = @w_fecha_hoy
        
--- MAXIMO % NUEVA PARA CUOTA 
select @w_cuota_reest = pa_float
from cobis..cl_parametro
where pa_nemonico = 'MPNC'
and pa_producto = 'CCA'

--- MINIMO DIAS PARA PAGO 
select @w_dias_pago = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MDPP'
and pa_producto = 'CCA'

--- PARAMETRO PARA REALIZAR REESTRUCTURACION CON FECHA OPERACION <> FECHA DE PROCESO 
select @w_rfechant = pa_char
from cobis..cl_parametro
where pa_nemonico = 'RFECHA'
and pa_producto = 'CCA'

--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_suspenso   = @w_est_suspenso  out

if @w_error <> 0 goto ERROR


select 
@w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 

           
  
select 
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_operacionca       = op_operacion,
@w_estado            = op_estado,
@w_op_monto          = op_monto,
@w_tramite_reest     = op_tramite,
@w_toperacion        = op_toperacion,
@w_op_cliente        = op_cliente,
@w_tramite           = op_tramite,
@w_cuota_inicial     = op_cuota,
@w_tplazo_inicial    = op_tplazo,
@w_moneda            = op_moneda,
@i_toperacion        = isnull(@i_toperacion,        op_toperacion),
@i_anterior          = isnull(@i_anterior,          op_anterior),          
@i_migrada           = isnull(@i_migrada,           op_migrada),           
@i_tramite           = isnull(@i_tramite,           op_tramite),           
@i_cliente           = isnull(@i_cliente,           op_cliente),           
@i_nombre            = isnull(@i_nombre,            op_nombre),            
@i_sector            = isnull(@i_sector,            op_sector),            
@i_toperacion        = isnull(@i_toperacion,        op_toperacion),        
@i_oficina           = isnull(@i_oficina,           op_oficina),           
@i_moneda            = isnull(@i_moneda,            op_moneda),            
@i_comentario        = isnull(@i_comentario,        op_comentario),        
@i_oficial           = isnull(@i_oficial,           op_oficial),           
@i_fecha_ini         = isnull(@i_fecha_ult_proceso, op_fecha_ult_proceso), 
@i_fecha_fin         = isnull(@i_fecha_fin,         op_fecha_fin),         
@i_fecha_ult_proceso = isnull(@i_fecha_ult_proceso, op_fecha_ult_proceso), 
@i_fecha_liq         = isnull(@i_fecha_liq,         op_fecha_liq),         
@i_fecha_reajuste    = isnull(@i_fecha_reajuste,    op_fecha_reajuste),    
@i_monto             = isnull(@i_monto,             op_monto),             
@i_monto_aprobado    = isnull(@i_monto_aprobado,    op_monto_aprobado),    
@i_destino           = isnull(@i_destino,           op_destino),           
@i_lin_credito       = isnull(@i_lin_credito,       op_lin_credito),       
@i_ciudad            = isnull(@i_ciudad,            op_ciudad),            
@i_periodo_reajuste  = isnull(@i_periodo_reajuste,  op_periodo_reajuste),  
@i_reajuste_especial = isnull(@i_reajuste_especial, op_reajuste_especial), 
@i_tipo              = isnull(@i_tipo,              op_tipo),              --(Hipot/Redes/Normal)
@i_forma_pago        = isnull(@i_forma_pago,        op_forma_pago),        
@i_cuenta            = isnull(@i_cuenta,            op_cuenta),            
@i_dias_anio         = isnull(@i_dias_anio,         op_dias_anio),         
@i_tipo_amortizacion = isnull(@i_tipo_amortizacion, op_tipo_amortizacion), 
@i_cuota_completa    = isnull(@i_cuota_completa,    op_cuota_completa),    
@i_tipo_cobro        = isnull(@i_tipo_cobro,        op_tipo_cobro),        
@i_tipo_reduccion    = isnull(@i_tipo_reduccion,    op_tipo_reduccion),    
@i_aceptar_anticipos = isnull(@i_aceptar_anticipos, op_aceptar_anticipos), 
@i_precancelacion    = isnull(@i_precancelacion,    op_precancelacion),    
@i_tipo_aplicacion   = isnull(@i_tipo_aplicacion,   op_tipo_aplicacion),   
@i_tplazo            = isnull(@i_tplazo,            op_tplazo),            
@i_plazo             = isnull(@i_plazo,             op_plazo),             
@i_tdividendo        = isnull(@i_tdividendo,        @w_tr_tipo_cuota),        
@i_periodo_cap       = isnull(@i_periodo_cap,       op_periodo_cap),       
@i_periodo_int       = isnull(@i_periodo_int,       op_periodo_int),       
@i_dist_gracia       = isnull(@i_dist_gracia,       op_dist_gracia),       
@i_gracia_cap        = isnull(@i_gracia_cap,        op_gracia_cap),        
@i_gracia_int        = isnull(@i_gracia_int,        op_gracia_int),        
@i_dia_fijo          = isnull(@i_dia_fijo,          op_dia_fijo),          
@i_cuota             = isnull(@i_cuota,             0),             
@i_evitar_feriados   = isnull(@i_evitar_feriados,   op_evitar_feriados),   
@i_renovacion        = isnull(@i_renovacion,        op_renovacion),        
@i_mes_gracia        = isnull(@i_mes_gracia,        op_mes_gracia),        
@i_upd_clientes      = isnull(@i_upd_clientes,      'N'),      
@i_reajustable       = isnull(@i_reajustable ,      op_reajustable ),      
@i_dias_gracia       = isnull(@i_dias_gracia,       0),       
@i_clase_cartera     = isnull(@i_clase_cartera,     op_clase),     
@i_origen_fondos     = isnull(@i_origen_fondos,     op_origen_fondos),     
@i_dias_clausula     = isnull(@i_dias_clausula,     op_dias_clausula),     
@i_convierte_tasa    = isnull(@i_convierte_tasa,    op_convierte_tasa),
@w_opcion_cap        = op_opcion_cap,
@w_tdividendo_org    = op_tdividendo,
@w_dias_anio         = op_dias_anio   -- REQ 175: PEQUEÑA EMPRESA
from ca_operacion
where op_banco = @i_banco

if @@rowcount = 0 begin
   select @w_error = 70008
   goto ERROR   
end    
   

   
if @i_paso = 'S' begin

   if not exists (select 1 from ca_operacion_tmp where opt_operacion = @w_operacionca ) begin
   
      ---PASAR A TEMPRALES CON LOS ULTIMOS DATOS    
      exec @w_error       = sp_pasotmp
      @s_term             = @s_term,
      @s_user             = @s_user,
      @i_banco            = @i_banco,
      @i_operacionca      = 'S',
      @i_dividendo        = 'S',
      @i_amortizacion     = 'S',
      @i_cuota_adicional  = 'S',
      @i_rubro_op         = 'S',
      @i_nomina           = 'S' 
      
      if @w_error <> 0 goto ERROR
	  
   end
   
   
   exec @w_error          = sp_operacion_tmp
   @s_user                = @s_user,
   @s_sesn                = @s_sesn,
   @s_date                = @s_date,
   @i_operacion           = 'U',
   @i_operacionca         = @w_operacionca ,
   @i_banco               = @i_banco ,
   @i_anterior            = @i_anterior,
   @i_migrada             = @i_migrada,
   @i_tramite             = @i_tramite,
   @i_cliente             = @i_cliente,
   @i_nombre              = @i_nombre,
   @i_sector              = @i_sector,
   @i_toperacion          = @i_toperacion,
   @i_oficina             = @i_oficina,
   @i_moneda              = @i_moneda, 
   @i_comentario          = @i_comentario,
   @i_oficial             = @i_oficial,
   @i_fecha_ini           = @i_fecha_ini,
   @i_fecha_fin           = @i_fecha_fin,
   @i_fecha_ult_proceso   = @i_fecha_ult_proceso,
   @i_fecha_liq           = @i_fecha_liq,
   @i_fecha_reajuste      = @i_fecha_reajuste, 
   @i_monto               = @i_monto, 
   @i_monto_aprobado      = @i_monto_aprobado,
   @i_destino             = @i_destino,
   @i_lin_credito         = @i_lin_credito,
   @i_ciudad              = @i_ciudad,
   @i_estado              = @w_estado,
   @i_periodo_reajuste    = @i_periodo_reajuste,
   @i_reajuste_especial   = @i_reajuste_especial,
   @i_tipo                = @i_tipo, 
   @i_forma_pago          = @i_forma_pago,
   @i_cuenta              = @i_cuenta,
   @i_dias_anio           = @i_dias_anio, 
   @i_tipo_amortizacion   = @i_tipo_amortizacion,
   @i_cuota_completa      = @i_cuota_completa,
   @i_tipo_cobro          = @i_tipo_cobro,
   @i_tipo_reduccion      = @i_tipo_reduccion,
   @i_aceptar_anticipos   = @i_aceptar_anticipos,
   @i_precancelacion      = @i_precancelacion,
   @i_tipo_aplicacion     = @i_tipo_aplicacion,
   @i_tplazo              = @i_tplazo,
   @i_plazo               = @i_plazo,
   @i_tdividendo          = @i_tdividendo,
   @i_periodo_cap         = @i_periodo_cap,
   @i_periodo_int         = @i_periodo_int,
   @i_dist_gracia         = @i_dist_gracia,
   @i_gracia_cap          = @i_gracia_cap,
   @i_gracia_int          = @i_gracia_int,
   @i_dia_fijo            = @i_dia_fijo,
   @i_cuota               = @i_cuota,
   @i_evitar_feriados     = @i_evitar_feriados,
   @i_renovacion          = @i_renovacion,
   @i_mes_gracia          = @i_mes_gracia,
   @i_reajustable         = @i_reajustable,
   @i_dias_clausula       = null, 
   @i_recalcular          = null,
   @i_tipo_empresa        = 1, 
   @i_tipo_crecimiento    = 'A',   
   @i_grupal              = 'S'

   
   if @w_error <> 0 goto ERROR
   
   
  /* GENERACION DE LA TABLA DE AMORTIZACION */
   exec @w_error       = sp_gentabla
   @i_operacionca      = @w_operacionca,
   @i_tabla_nueva      = 'S',
   @i_actualiza_rubros = 'N',
   @o_fecha_fin        = @w_fecha_fin out
   
   if @w_error <> 0 goto ERROR
   
   
   
end

if @i_paso = 'P' begin -- (P) Valida Pago
   
   -- validar si el cliente realizo pago dentro del plazo establecido
   if @i_pago = 'S' begin
      select @w_fecha_ult_pago = isnull(max(ab_fecha_pag),'01/01/1900')
      from ca_abono
      where ab_operacion = @w_operacionca
      and ab_estado = 'A'
   end

   if datediff(dd,@w_fecha_ult_pago,@w_fecha_ult_proceso) > @w_dias_pago begin
      select @w_error = 722109    
      goto ERROR
   end
end

if @i_paso = 'D' begin -- (D) Defintiva 
   


   --INICIO ATOMICIDAD
   if @@trancount = 0 begin  
      select @w_commit = 'S'
      begin tran 
   end

  
     
    --- REESTRUCTURAR LA OPERACION ORIGINAL 
   exec @w_error = sp_reestructuracion_int
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_sesn              = @s_sesn,
   @s_date              = @s_date,
   @s_ofi               = @s_ofi,
   @i_banco             = @i_banco,
   @i_respetar_vencidas = @i_respetar_vencidas,
   @i_num_reest         = 'S',
   @o_secuencial        = @w_secuencial_trn out
   
   if @w_error <> 0 goto ERROR

   
   update ca_operacion set
   op_numero_reest    = isnull(op_numero_reest,0) + 1,
   op_toperacion      = @i_toperacion,
   op_estado          = @w_est_vigente,
   --op_monto           = @w_op_monto,
   op_estado_cobranza = 'NO'
   where op_banco     = @i_banco 
   
   if @@error <> 0 begin
      select @w_error = 705007
      goto ERROR
   end
   
    ---ANALIZAR DATOS REGISTRADOS PAR ACONTABILIDAD
	select @w_div_vigente = di_dividendo
	from   ca_dividendo
	where  di_operacion   = @w_operacionca
	and    di_estado      = @w_est_vigente

	   
   update ca_amortizacion
   set am_estado = @w_est_vigente
   where am_operacion = @w_operacionca
   and am_dividendo   = @w_div_vigente
   
   update ca_amortizacion
   set am_estado = 0
   where am_operacion = @w_operacionca
   and am_dividendo   > @w_div_vigente
   

   
   	if exists ( select 1
               from ca_desplazamiento
               where de_operacion = @w_operacionca
               and   de_estado = 'A'
               and   @w_fecha_ult_proceso between de_fecha_ini and de_fecha_fin ) begin 
				  
				  
         exec sp_desplazamiento
         @i_banco        = @i_banco , 
         @i_cliente      = @w_op_cliente,
         @i_fecha_valor  = @w_fecha_ult_proceso,
         @i_cuotas       = 0,  
         @i_archivo      = 'REEST',  		 
         @o_error        = @w_error out  

         if @w_error  <> 0 goto ERROR		 
				  
				  		  
   end 

	
 
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      commit tran
   end



end

if @i_paso in ('C') begin -- (C) Consulta tabla amortizacion 

   select 
   @w_operacionca = opt_operacion,
   @w_monto       = opt_monto
   from ca_operacion_tmp
   where opt_banco = @i_banco
   
   select  @w_monto
   
   --SOLO PARA LA PRIMERA TRANSMISION 
   if @i_dividendo = 0 begin
   
      --- RUBROS QUE PARTICIPAN EN LA TABLA 
      select rot_concepto, co_descripcion, rot_tipo_rubro,rot_porcentaje
      from ca_rubro_op_tmp, ca_concepto
      where rot_operacion = @w_operacionca
      and   rot_fpago    in ('P','A','M','T')
      and   rot_concepto = co_concepto
      order by rot_concepto

      select @w_filas_rubros = @@rowcount
      
      if @w_filas_rubros < 10 
         select @w_filas_rubros = @w_filas_rubros + 3

      select @w_bytes_env    = @w_filas_rubros * 90  --83  --BYTES ENVIADOS

      select @w_primer_des = min(dm_secuencial)
      from   ca_desembolso
      where  dm_operacion  = @w_operacionca

      select dtr_dividendo, sum(dtr_monto),'D' ---DESEMBOLSOS PARCIALES
      from   ca_det_trn, ca_transaccion, ca_rubro_op_tmp
      where  tr_banco      = @i_banco 
      and    tr_secuencial = dtr_secuencial
      and    tr_operacion  = dtr_operacion
      and    dtr_secuencial <> @w_primer_des
      and    rot_operacion = @w_operacionca
      and    rot_tipo_rubro= 'C'
      and    tr_tran    = 'DES'
      and    tr_estado    in ('ING','CON')
      and    rot_concepto  = dtr_concepto 
      group by dtr_dividendo
      union
      select dtr_dividendo, sum(dtr_monto),'R'       ---REESTRUCTURACION
      from ca_det_trn, ca_transaccion, ca_rubro_op_tmp
      where  tr_banco      = @i_banco 
      and   rot_operacion = @w_operacionca
      and   rot_concepto  = dtr_concepto 
      and   rot_tipo_rubro= 'C'
      and   tr_tran      = 'RES'
      and   tr_estado    in ('ING','CON')
      and   tr_secuencial = dtr_secuencial
      and   tr_operacion  = dtr_operacion
      group by dtr_dividendo

      select @w_filas_rubros = @@rowcount
      
      select @w_bytes_env    = @w_bytes_env + (@w_filas_rubros * 13)

      select dit_dias_cuota
      from ca_dividendo_tmp 
      where dit_operacion = @w_operacionca
      and   dit_dividendo > @i_dividendo 
      order by dit_dividendo

      select @w_filas = @@rowcount
            
      select @w_bytes_env  = @w_bytes_env + (@w_filas * 4) --1) 
   end

   if @i_opcion = 0 begin
 
      if @i_dividendo = 0 begin
         select @w_count = (@w_buffer - @w_bytes_env) / 38  
      end
      else select @w_count = @w_buffer / 38
      set rowcount @w_count

      --- FECHAS DE VENCIMIENTOS DE DIVIDENDOS Y ESTADOS
      select convert(varchar(10),dit_fecha_ven,@i_formato_fecha),   substring(es_descripcion,1,20),
             0,dit_prorroga
      from ca_dividendo_tmp, ca_estado
      where dit_operacion = @w_operacionca
      and   dit_dividendo > @i_dividendo 
      and   dit_estado    = es_codigo

      order by dit_dividendo

      select @w_filas = @@rowcount
      select @w_bytes_env    =  (@w_filas * 38)

      select @w_count
   end
   else begin
      select 
      @w_filas = 0,
      @w_count = 1,
      @w_bytes_env = 0
   end

   if @w_filas < @w_count begin
      declare @w_total_reg int
         
      select @w_total_reg = count(distinct convert(varchar, dit_dividendo) + rot_concepto)
      from  ca_rubro_op_tmp                          
               inner join ca_dividendo_tmp on
                          (dit_dividendo > @i_dividendo
                     or   (dit_dividendo = @i_dividendo
                     and  rot_concepto > @i_concepto)) 
                     and  rot_operacion = @w_operacionca
                     and  rot_fpago    in ('P','A','M','T')   ---XSA adiciona fpago='M'  28/May/99 
                     and  dit_operacion  = @w_operacionca
                           left outer join ca_amortizacion_tmp on
                                          rot_concepto  = amt_concepto
                                    and   dit_dividendo = amt_dividendo
                                    and   amt_operacion = @w_operacionca
      
      select @w_count = (@w_buffer - @w_bytes_env) / 21  -- Esta linea antes era 21, se cambio a 21 
                                                         -- Para corregir una consulta puntual  def.5043
      if @i_dividendo > 0 and @i_opcion = 0
         select @i_dividendo = 0
         
      set rowcount @w_count
      
      select dit_dividendo,rot_concepto,
      convert(float, sum( isnull(amt_cuota,0) + isnull(amt_gracia,0))) 
      from ca_rubro_op_tmp
           inner join ca_dividendo_tmp on           
                  (dit_dividendo > @i_dividendo
                  or    (dit_dividendo = @i_dividendo 
                  and rot_concepto > @i_concepto)) 
                  and   rot_operacion = @w_operacionca                  
                  and   rot_fpago in ('P','A','M','T')  
                  and   dit_operacion  = @w_operacionca                           
                        left outer join ca_amortizacion_tmp on
                              rot_concepto  = amt_concepto
                              and   dit_dividendo = amt_dividendo
                              and amt_operacion = @w_operacionca      
                                      group by dit_dividendo,rot_concepto
                                      order by dit_dividendo,rot_concepto
       
         if @w_total_reg = @w_count 
            select @w_count = @w_count + 1
     
      select @w_count 
   end
end

if @i_paso in ('T') begin -- (T) Borra Temporales 

   --- BORRAR TABLAS TEMPORALES 
   exec @w_error    = sp_borrar_tmp_int
   @s_user           = @s_user,
   @s_sesn           = @s_sesn,
   @s_term           = @s_term,
   @i_banco          = @i_banco
   
   if @w_error <> 0 goto ERROR
end

if @i_paso in ('R') begin -- (R) Consulta Datos de la Reestruturacion 
 
   EXEC @w_error = sp_validar_fecha
      @s_user                  = @s_user,
      @s_term                  = @s_term,
      @s_date                  = @s_date ,
      @s_ofi                   = @s_ofi,
      @i_operacionca           = @w_operacionca,
      @i_debug                 = 'N' 

      if @w_error <> 0 
      begin

         goto ERROR
      end


   select @w_max_tram_rees = 0
   select @w_max_tram_rees = isnull(max(tr_tramite),0)
   from cob_credito..cr_tramite
   where tr_numero_op_banco  =  @i_banco
   and   tr_tipo             =  'E' --REESTRUCTURACION
   and   tr_estado           =  'A' --APROBADO
   
   if @w_max_tram_rees > 0
   begin
   select @w_tr_sujcred = tr_sujcred
   from cob_credito..cr_tramite
   where tr_tramite = @w_max_tram_rees
   end
   ELSE
   begin
      select @w_error = 701187
      goto ERROR 
   end

   ---validacion de tramite on la fecha
   select @w_max_tram_rees = 0
   select @w_max_tram_rees = isnull(max(tr_tramite),0)
   from cob_credito..cr_tramite
   where tr_numero_op_banco  =  @i_banco
   and   tr_tipo             =  'E' --REESTRUCTURACION
   and   tr_estado           =  'A' --APROBADO
   and  (  
        (datediff(dd,tr_fecha_apr,@w_fecha_ult_proceso) >= 0)  or (@w_tr_sujcred = @w_parametro_VHV)
        )
   
   if exists (select 1 from cob_credito..cr_tramite a, ca_transaccion b
              where a.tr_tramite         = @w_max_tram_rees
              and   b.tr_banco           = @i_banco
              and   b.tr_tran            = 'RES'
              and   b.tr_estado         <> 'RV'
              and   b.tr_secuencial       >= 0 ---18722              
              and   a.tr_numero_op_banco = b.tr_banco
              and   datediff(dd,tr_fecha_apr,tr_fecha_ref) > 0  
              
             )
       or @w_max_tram_rees = 0
   begin
       print 'reestcca.sp (2)'
      select @w_error = 701187
      goto ERROR 
   end
   else begin
      select             
      tr_plazo,  
      'N',  
      tr_tasa_reest,  
      tr_tipo_plazo,  
      tr_fecha_fija,  
      tr_dia_pago,
      tr_tipo_cuota,
      op_nombre     
      from   cob_credito..cr_tramite, ca_operacion
      where  tr_tipo            = 'E' --REESTRUCTURACION
      and    tr_estado          = 'A' --APROBADO
      and    tr_numero_op_banco = @i_banco
      and    op_banco = @i_banco
      and    tr_tramite = @w_max_tram_rees
   end
end


return 0

ERROR:

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end 


return @w_error


