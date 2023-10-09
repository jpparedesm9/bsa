/************************************************************************/
/*      Archivo:                proycuot.sp                             */
/*      Stored procedure:       sp_proyeccion_cuota                     */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           R Garces                                */
/*      Fecha de escritura:     Ene 1998                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Simula la ejecucion del batch hasta una fecha dada y retorna        */
/*  los valores a pagar en esa fecha                                    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_proyeccion_cuota')
    drop proc sp_proyeccion_cuota 
go

create proc sp_proyeccion_cuota (
@s_user             varchar(14)  = null,
@s_date             datetime     = null,
@s_ofi              smallint     = null,
@s_term             varchar (30) = null,          
@i_banco            varchar(24)  = null,
@i_fecha            datetime     = null,
@i_debug            char(1)      = null,
@i_tipo_cobro       char(1)      = null,
@i_dividendo        int          = 0,
@i_tipo_proyeccion  char(1)      = null,
@i_formato_fecha    int          = null, 
@i_monto_pago       money        = null,
@i_tasa_prepago     float        = 0,
@i_dias_vence       int          = 0,
@i_extracto         char(1)      = 'N',      -- JAR REQ 175 Pequeña Empresa
@i_proy             char(1)      = 'S',      -- JAR REQ 175 Pequeña Empresa
@o_saldo            money        = null out, -- JAR REQ 175 Pequeña Empresa
@o_saldo_prox       money        = null out  -- JAR REQ 175 Pequeña Empresa
)
as

declare
@w_return             int,
@w_sp_name            varchar(32),
@w_error              int,
@w_estado_op          smallint,
@w_operacionca        int,
@w_fecha_calculada    varchar(10),
@w_fecha_ven          datetime,
@w_ult_moneda         smallint,
@w_concepto_cap       varchar(10),
@w_moneda_nacional    smallint,
@w_decimales          char(1),
@w_oficina_op         smallint,
@w_decimales_nacional tinyint,
@w_op_moneda          smallint,
@w_cliente            int,
@w_cotizacion_hoy     float,
@w_fecha_ult_proceso  datetime,
@w_nombre             varchar(64),
@w_decimales_op       tinyint,
@w_periodo_int        smallint,
@w_tdividendo         varchar(10),
@w_dias_anio          smallint,
@w_base_calculo       char(1),
@w_cod_cliente        int,
@w_tipo_cobro         char(1),
@w_num_periodo_d      smallint,
@w_pago_caja          char(1),
@w_periodo_d          varchar(10),
@w_migrada            varchar(24),
@w_estado             smallint,
@w_clase              varchar(10),
@w_toperacion         varchar(10),
@w_cedula             varchar(30),
@w_monto              money,
@w_monto_max          money,
@w_valor_vencido      money,
@w_fp                 datetime,
@w_saldo_op           money,
@w_dias_proyeccion    int,
@w_sector             catalogo,
@w_est_vigente        tinyint,
@w_est_vencido        tinyint,
@w_est_cancelado      tinyint,
@w_est_novigente      tinyint,
@w_est_credito        tinyint,
@w_est_castigado      tinyint,
@w_est_suspenso       tinyint,
@w_num_dec            tinyint,
@w_tasa_comprecan     float,
@w_iva_comprecan      float,
@w_dividendo_medio    smallint,
@w_mul_precan         money, 
@w_total_precan       money,
@w_dias_prestamo      int,
@w_limite_comprecan   int,
@w_cobrar_comprecan   char(1),
@w_comprecan          varchar(10),
@w_comprecan_ref      catalogo,
@w_iva_comprecan_ref  catalogo


   
   
/* CREACION DE TABLAS TEMPORALES USADAS POR EL PROCESO BATCH */
create table #rubro_mora (ro_concepto  varchar(10))

create table #ca_operacion_aux (
op_operacion          int,
op_banco              varchar(24),
op_toperacion         varchar(10),
op_moneda             tinyint,
op_oficina            smallint,
op_oficial            smallint,
op_fecha_ult_proceso  datetime,
op_dias_anio          int,
op_estado             int,
op_sector             varchar(10),
op_cliente            int,
op_fecha_liq          datetime,
op_fecha_ini          datetime,
op_dias_clausula      int,
op_calificacion       char(1),
op_clase              varchar(10),
op_base_calculo       char(1) null,
op_periodo_int        smallint,
op_tdividendo         varchar(10),
op_causacion          char(1) null,
op_est_cobranza       varchar(10) null,
op_monto              money null,
op_fecha_fin          datetime,
op_numero_reest       int  null,
op_num_renovacion     int  null,
op_destino            varchar(10),
op_tramite            int,
op_renovacion         char(1),
op_gar_admisible      char(1),
op_tipo               char(1),
op_edad               int,
op_periodo_cap        smallint,
op_plazo              smallint,
op_tplazo             varchar(10),
op_tipo_amortizacion  varchar(10),
op_opcion_cap         char(1),
op_reestructuracion   char(1),
op_clausula_aplicada  char(1),
op_naturaleza         char(1),
op_fecha_prox_segven  datetime  null,
op_suspendio          char(1)  null,
op_fecha_suspenso     datetime null
)

select @w_sp_name = 'sp_proyeccion_cuota'

select 
@w_estado_op          = op_estado,
@w_operacionca        = op_operacion,
@w_op_moneda          = op_moneda,
@w_oficina_op         = op_oficina,
@w_cliente            = op_cliente,
@w_nombre             = op_nombre,
@w_periodo_int        = op_periodo_int,
@w_tdividendo         = op_tdividendo,
@w_dias_anio          = op_dias_anio,
@w_base_calculo       = op_base_calculo,
@w_tipo_cobro         = op_tipo_cobro,
@w_pago_caja          = op_pago_caja,
@w_migrada            = isnull(op_migrada,op_banco),
@w_estado             = op_estado,
@w_clase              = op_clase,   
@w_toperacion         = op_toperacion,
@w_cod_cliente        = op_cliente,
@w_periodo_d          = op_tdividendo,
@w_num_periodo_d      = op_periodo_int,
@w_sector             = op_sector,
@w_fecha_ult_proceso  =  op_fecha_ult_proceso,
@w_dias_prestamo      = datediff(dd,op_fecha_ini,op_fecha_ult_proceso) 
from ca_operacion
where op_banco = @i_banco


/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_credito    = @w_est_credito   out

if @@error <> 0 return 708201
               

--- DECIMALES
exec sp_decimales
@i_moneda    = @w_op_moneda,
@o_decimales = @w_num_dec out               
     
/* CONTROLES ANTES DE INICIAR LA PROYECCION DE CUOTA */                 
if @w_estado_op in (@w_est_novigente,@w_est_cancelado,@w_est_suspenso,@w_est_credito) return  710334

if @w_fecha_ult_proceso > @i_fecha  return  724641  --NO SE PERMITEN CONSULTAS AL PASADO 

begin tran  -- evitar que los cambios sean permanentes

if @w_fecha_ult_proceso < @i_fecha begin
   
   /* EJECUCION DEL BATCH HASTA LA FECHA INDICADA */
   exec @w_error     = sp_batch
   @s_user           = @s_user,
   @s_term           = @s_term,
   @s_date           = @s_date,
   @s_ofi            = @s_ofi,
   @i_en_linea       = 'N',
   @i_banco          = @i_banco,
   @i_siguiente_dia  = @i_fecha,
   @i_pry_pago       = 'S'

   if @w_error <> 0 goto ERROR
     
end


if @i_tipo_cobro = 'A' begin 

   select @w_monto =  isnull(sum(case when am_acumulado + am_gracia - am_pagado < 0 then 0 else am_acumulado + am_gracia - am_pagado end),0)         -- REQ 175: PEQUEÑA EMPRESA
   from  ca_amortizacion with (nolock), ca_dividendo with (nolock)
   where am_operacion = @w_operacionca
   and di_operacion = am_operacion
   and di_estado  in (@w_est_vencido,@w_est_vigente )
   and am_dividendo = di_dividendo
      
   
end else begin   

   select 
   @w_monto =  isnull(sum(am_cuota - am_pagado + am_gracia),0)
   from  ca_amortizacion with (nolock), ca_dividendo with (nolock)
   where am_operacion = @w_operacionca
   and di_operacion = am_operacion
   and di_estado   in (@w_est_vencido,@w_est_vigente )
   and am_dividendo = di_dividendo
   
end 

select @w_saldo_op = isnull(sum(case when am_acumulado + am_gracia - am_pagado < 0 then 0 else am_acumulado + am_gracia - am_pagado end),0)
from ca_amortizacion with (nolock)
where am_operacion = @w_operacionca
and am_estado   <> @w_est_cancelado

/* DETERMINAR SI EXISTE MULTA POR PRECANCELACIÓN */

/*SI SE PRECANCELA EL PRESTAMOS ANTES DEL 50% DE LAS CUOTAS SE PAGA UNA MULTA*/
select @w_limite_comprecan = pa_int 
from cobis..cl_parametro 
where pa_nemonico ='NCMPRE'

select @w_comprecan    = 'COMPRECAN', @w_cobrar_comprecan = 'N' 

if @w_dias_prestamo > @w_limite_comprecan  select @w_cobrar_comprecan = 'S'
else select @w_cobrar_comprecan = 'N'

if @w_cobrar_comprecan = 'S' begin

   select @w_dividendo_medio = max(di_dividendo)/2 
   from cob_cartera..ca_dividendo 
   where di_operacion = @w_operacionca

   if exists (select 1 from ca_dividendo 
   where di_operacion = @w_operacionca
   and   di_dividendo = @w_dividendo_medio
   and   di_fecha_ven >= @w_fecha_ult_proceso)
      select @w_cobrar_comprecan = 'S' 
   else
      select @w_cobrar_comprecan = 'N' 
   
end


if  @w_cobrar_comprecan = 'S' 
begin
   
   select
   @w_comprecan_ref   = ru_referencial
   from   cob_cartera..ca_rubro
   where  ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_op_moneda
   and    ru_concepto   = @w_comprecan 
   
   if @@rowcount = 0 begin
      select @w_error = 701178
      goto ERROR
   end
   
   /* DETERMINAR LA TASA DE LA COMISION POR PRECANCELACIÓN */
   select 
   @w_tasa_comprecan  = vd_valor_default / 100
   from   ca_valor, ca_valor_det
   where  va_tipo   = @w_comprecan_ref
   and    vd_tipo   = @w_comprecan_ref
   and    vd_sector = @w_sector /* sector comercial */
   
   if @@rowcount = 0 begin
       select @w_error = 701085
       goto ERROR
   end

   select
   @w_iva_comprecan_ref   = ru_referencial
   from   cob_cartera..ca_rubro
   where  ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_op_moneda
   and    ru_concepto   = 'IVA_COMPRE'
   
   if @@rowcount = 0 begin
      select @w_error = 701178
      goto ERROR
   end
   
   /* DETERMINAR LA TASA DE LA COMISION POR PRECANCELACIÓN */
   select 
   @w_iva_comprecan  = vd_valor_default / 100
   from   ca_valor, ca_valor_det
   where  va_tipo   = @w_iva_comprecan_ref
   and    vd_tipo   = @w_iva_comprecan_ref
   and    vd_sector = @w_sector /* sector comercial */
   
   if @@rowcount = 0 begin
       select @w_error = 701085
       goto ERROR
   end
   
end

 /*CALCU:AR EL VALOR DE LA COMISION POR PRECANCELACIÓN Y SU RESPECTIVO IVA */
select @w_mul_precan   =  round(@w_saldo_op * @w_tasa_comprecan, @w_num_dec) 
select @w_mul_precan   = @w_mul_precan + round(@w_mul_precan * @w_iva_comprecan, @w_num_dec)
select @w_total_precan = @w_saldo_op + isnull(@w_mul_precan,0)
   

select @w_valor_vencido = isnull(sum(am_cuota - am_pagado + am_gracia),0)
from  ca_amortizacion with (nolock), ca_dividendo with (nolock)
where am_operacion = @w_operacionca
and   di_operacion = am_operacion
and   di_estado    = @w_est_vencido
and   am_dividendo = di_dividendo 
 
rollback tran  -- evitar que los cambios sean permanentes

/*CONSULTA DE LOS DATOS GENERADOS*/
create table #ca_datos_tmp (
cedula       varchar(30) null,
fecha_cal    varchar(10) null,
monto_vig    money       null,
monto_ven    money       null)

select @w_cedula = en_ced_ruc
from  cobis..cl_ente
where en_ente  = @w_cliente

select @w_fecha_calculada = convert(varchar(10),@i_fecha,@i_formato_fecha)

insert into #ca_datos_tmp  values (
@w_cedula,@w_fecha_calculada, @w_monto, @w_valor_vencido )

select 
'CEDULA/RUC'         = isnull(cedula,''),
'FECHA DE CALCULO '  = fecha_cal,
'MONTO (VIG + VENC)' = isnull(monto_vig,0),             
'MONTO VENCIDO'      = isnull(monto_ven,0)     
from #ca_datos_tmp   

select @w_total_precan 
   

return 0

ERROR:
   exec cobis..sp_cerror 
   @t_debug='N',
   @t_file='',  
   @t_from=@w_sp_name,
   @i_num = @w_error
   return @w_error
go
