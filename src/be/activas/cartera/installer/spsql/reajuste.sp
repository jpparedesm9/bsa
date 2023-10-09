/************************************************************************/
/*   Archivo:                  reajuste.sp                              */
/*   Stored procedure:         sp_reajuste                              */
/*   Base de datos:            cob_cartera                              */
/*   Producto:                 Cartera                                  */
/*   Disenado por:             R Garces                                 */
/*   Fecha de escritura:       Jul. 1997                                */
/************************************************************************/
/*                                IMPORTANTE                            */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                 PROPOSITO                            */
/*   Reajuste  de una operacion especifica                              */
/*   si sp_reajuste_ibc retorna 'N' en w_reajuster  fin proceso         */
/*   FEB-14-2002            RRB         Agregar campos al insert        */
/*                                      en ca_transaccion               */
/*   AGO-15-2002          FQ            Quitar insercion de transaccion */
/*   FEB-21-2005          Elcira Pelaez validar existencia detalle      */
/*                                      de reajuste                     */
/*   MAY-2006        EPB           NR-296                               */
/*   ENE-2007        EPB           DEF-7718                             */
/*   May 2007        FQ            Defecto 8236                         */
/*   NOV-2010        EPB           Controles antes y despues del REJ    */
/*   MAY-2014        EPB           NR. 392 Tabla FLEXIBLE Bancamia      */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_reajuste')
   drop proc sp_reajuste
go

---TIKET 167070 Mayo 2015

create proc sp_reajuste
   @s_user           login,           
   @s_date           datetime,
   @s_ofi            smallint,
   @s_term           varchar(30),
   @i_operacionca    int,
   @i_fecha_proceso  datetime,
   @i_en_linea       char(1),
   @i_fpago          char(1) = null,
   @i_modalidad      char(1) = 'P',
   @i_cotizacion     money,
   @i_num_dec        tinyint,
   @i_concepto_int   catalogo,
   @i_concepto_cap   catalogo,
   @i_moneda_uvr     tinyint,
   @i_moneda_local   tinyint,
   @i_recupera_tasa_inicial  char(1)  = 'N',
   @i_efa_anterior     float = 0
as
declare 
   @w_return               int,
   @w_banco                cuenta,
   @w_toperacion           catalogo,
   @w_oficina              smallint,
   @w_moneda               tinyint,
   @w_tipo_amortizacion    varchar(20),
   @w_cuota                money,
   @w_tdividendo           catalogo,
   @w_dias_anio            smallint,
   @w_periodo_cap          smallint,
   @w_reajuste_especial    char(1),
   @w_secuencial           int,
   @w_dividendo            int,
   @w_base_calculo         char(1),
   @w_recalcular           char(1),
   @w_fecha_prox_rejuste   datetime,
   @w_periodo_int          smallint,
   @w_fecha_ven            datetime,
   @w_operacionca          int,
   @w_reajustar            char(1),
   -- CAUSACION DE PASIVAS
   @w_fecha_a_causar       datetime,
   @w_sector               catalogo,
   @w_fecha_liq            datetime,
   @w_fecha_ini            datetime,
   @w_clausula             catalogo,
   @w_dias_div             int,
   @w_tipo                 catalogo,
   @w_causacion            catalogo,
   @w_oficial              int,
   @w_fecha_ult_proceso    datetime,
   @w_sec_reajuste         int,
   @w_max_ividendo         int,
   @w_efa_anterior         float,
   @w_efa_nuevo            float,
   @w_disminuye_tasa       char(1),
   @w_am_cuota             money,
   @w_am_acumulado         money,
   @w_am_pagado            money,
   @w_observacion          varchar(50),
   @w_estado_op            smallint

-- DATOS DE LA OPERACION
select 
@w_banco              = op_banco,
@w_toperacion         = op_toperacion,
@w_oficina            = op_oficina,
@w_moneda             = op_moneda,
@w_tipo_amortizacion  = op_tipo_amortizacion,
@w_cuota              = op_cuota,
@w_tdividendo         = op_tdividendo,
@w_dias_anio          = op_dias_anio,
@w_periodo_cap        = op_periodo_cap,
@w_periodo_int        = op_periodo_int,
@w_fecha_ven          = op_fecha_fin,
@w_base_calculo       = op_base_calculo,
@w_recalcular         = op_recalcular_plazo,
-- CAUSACION PASIVAS
@w_tipo               = op_tipo,
@w_sector             = op_sector,
@w_fecha_liq          = op_fecha_liq,
@w_fecha_ini          = op_fecha_ini,
@w_clausula           = op_clausula_aplicada,
@w_causacion          = op_causacion,
@w_dias_div           = op_periodo_int,
@w_fecha_ult_proceso  = op_fecha_ult_proceso,
@w_oficial            = op_oficial,
@w_estado_op          = op_estado,
@w_reajuste_especial  = case when isnull(op_reajuste_especial, 'N') = 'S'  then 'S' else 'N' end 
from   ca_operacion with (nolock)
where  op_operacion      = @i_operacionca

if @w_estado_op = 4
  return 701010

---VALIDACIONES ANTES DE REAJUSTAR EL INTERES DE LA CUOTA VIGENTE

-- CONTROL DE DIVIDENDO VIGENTE
select @w_dividendo = di_dividendo
from   ca_dividendo with (nolock)
where  di_operacion = @i_operacionca
and    di_estado    = 1

if @@rowcount = 0 return 0

select @w_am_cuota       = am_cuota,
       @w_am_acumulado   = am_acumulado,
       @w_am_pagado      = am_pagado
from ca_amortizacion with (nolock)
where am_operacion = @i_operacionca
and   am_dividendo = @w_dividendo
and  am_concepto = @i_concepto_int

if @w_am_cuota < @w_am_acumulado
return 724538         

if  @w_am_cuota < @w_am_pagado
return 724539

if    @w_am_acumulado < @w_am_pagado
return 724540         

if (@w_am_cuota < 0) or (@w_am_acumulado < 0) or (@w_am_pagado < 0)
return 724541
           

if @w_tipo = 'R' -- PASIVAS
begin
   
   select @w_fecha_a_causar = dateadd(dd, -1, @i_fecha_proceso)

   update ca_operacion with (rowlock)
   set    op_fecha_ult_causacion =  @w_fecha_a_causar
   where  op_operacion = @i_operacionca      
end


select @w_max_ividendo = max(di_dividendo)
from   ca_dividendo with (nolock)
where  di_operacion = @i_operacionca

if @w_max_ividendo = @w_dividendo and @w_tipo_amortizacion = 'FRANCESA'
   select @w_tipo_amortizacion = 'ALEMANA'


-- SI LA OPERACION VENCE NO NECESITA REAJUSTAR
if @w_fecha_ven = @i_fecha_proceso return 0 

select @w_observacion = 'REAJUSTE DE TASA'
if @i_recupera_tasa_inicial  = 'N'
begin
	--VALIDAR QUE EL REAJSUTE TENGA SU DETALLE
	select 
	@w_sec_reajuste      = re_secuencial,
	@w_reajuste_especial = case when isnull(re_reajuste_especial, 'N') = 'S'  then 'S' else 'N' end
	from ca_reajuste with (nolock)
	where re_operacion = @i_operacionca
	and   re_fecha     = @i_fecha_proceso
	
	if @@rowcount = 0 return 0
	
	if not exists (select 1 from ca_reajuste_det with (nolock)
	where red_operacion  = @i_operacionca
	and   red_secuencial = @w_sec_reajuste)
	   return 703073
end
else
begin
   select @w_observacion = 'RECUPERA LA INCIAL NO REGISTRA EN ca_reajuste',
          @w_sec_reajuste = 0
end

-- GENERA SECUENCIAL PARA TRANSACCION
exec @w_secuencial =  sp_gen_sec
@i_operacion  =  @i_operacionca


--INSERTAR TRANSACCION DE REJ PARA SEGUIMIENTO
exec @w_return  = sp_historial
@i_operacionca  = @i_operacionca,
@i_secuencial   = @w_secuencial

if @w_return <> 0 return @w_return


insert into ca_transaccion (
tr_secuencial,      tr_fecha_mov,        tr_toperacion,
tr_moneda,          tr_operacion,        tr_tran,
tr_en_linea,        tr_banco,            tr_dias_calc,
tr_ofi_oper,        tr_ofi_usu,          tr_usuario,
tr_terminal,        tr_fecha_ref,        tr_secuencial_ref,
tr_estado,          tr_observacion,      tr_gerente,
tr_gar_admisible,   tr_reestructuracion, tr_calificacion,
tr_fecha_cont,      tr_comprobante) 
values(
@w_secuencial,      @s_date,             @w_toperacion,
@w_moneda,          @i_operacionca,      'REJ',
@i_en_linea,        @w_banco,            0,
@w_oficina,         @s_ofi,              @s_user,
@s_term,            @w_fecha_ult_proceso,@w_sec_reajuste,
'NCO',              @w_observacion,      @w_oficial,
'',                 '',                  '',
'01/01/1900',   0)

if @@error <> 0 return 708165

select @w_efa_anterior = 0    
select @w_efa_anterior = isnull(sum(ro_porcentaje_efa),0)
from ca_rubro_op
where ro_operacion = @i_operacionca
and   ro_tipo_rubro  = 'I'

if @w_efa_anterior   = 0
    return 722103

---ESTE SP NO E NECESARIO SI EL CAMBIO DE TASA ES
---RECUPERAR LA TASA QUE SE NEGOCIO CON EL CLIENTE
---SE HACE EN EL FUENTE cambibc.sp
---PRINT 'reajuste.sp @i_recupera_tasa_inicial: ' + CAST(@i_recupera_tasa_inicial as varchar) + '  @i_efa_anterior:  '  + CAST( @i_efa_anterior as varchar)
if @i_recupera_tasa_inicial  = 'N'
begin
	exec @w_return = sp_reajuste_ibc
	@i_operacionca   = @i_operacionca,
	@i_secuencial    = @w_secuencial,
	@i_fecha_proceso = @i_fecha_proceso,
	@i_moneda_uvr    = @i_moneda_uvr,
	@i_moneda_local  = @i_moneda_local,
	@o_reajustar     = @w_reajustar output
	
	if @w_return <> 0 return @w_return
    ---Recuperar la tasa Auxiliar de la Operacion
    update ca_rubro_op
    set ro_porcentaje_aux = ro_porcentaje_efa
    where ro_operacion = @i_operacionca
    and   ro_tipo_rubro  = 'I'
    
end

select @w_efa_nuevo = sum(ro_porcentaje_efa)
from ca_rubro_op
where ro_operacion = @i_operacionca
and   ro_tipo_rubro  = 'I'

if @w_efa_anterior <= @w_efa_nuevo 
   select @w_disminuye_tasa = 'N'
else
begin
   if exists (select 1 from ca_reajuste			           
              where re_operacion =@i_operacionca
               and re_fecha =  @i_fecha_proceso)
    select @w_disminuye_tasa = 'N'           
   else            
    select @w_disminuye_tasa = 'S'
end   

---print 'reajuste.sp @w_efa_anterior ' + cast(@w_efa_anterior as varchar) + ' @w_efa_nuevo : ' + cast (@w_efa_nuevo as varchar) + '@w_disminuye_tasa: ' + cast( @w_disminuye_tasa as varchar)
   

if (@w_tipo_amortizacion = 'ALEMANA' or @w_tipo_amortizacion = 'MANUAL')
begin

   exec @w_return = sp_reajuste_interes 
   @s_user          = @s_user,
   @s_term          = @s_term,
   @s_date          = @s_date,
   @s_ofi           = @s_ofi,
   @i_operacionca   = @i_operacionca,
   @i_fecha_proceso = @i_fecha_proceso,
   @i_num_dec       = @i_num_dec,
   @i_base_calculo  = @w_base_calculo,
   @i_recalcular    = @w_recalcular,
   @i_banco         = @w_banco,
   @i_fpago         = @i_fpago,
   @i_periodo_int   = @w_periodo_int,
   @i_secuencial    = @w_secuencial,
   @i_en_linea      = @i_en_linea,
   @i_tdividendo    = @w_tdividendo,
   @i_disminuye     = @w_disminuye_tasa
   
   if @w_return <> 0 return @w_return
   
end 
if @w_tipo_amortizacion = 'FRANCESA'
begin 

   exec @w_return = sp_reajuste_cuota
   @s_date              = @s_date,
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_ofi               = @s_ofi,
   @i_operacionca       = @i_operacionca,
   @i_banco             = @w_banco,
   @i_cuota             = @w_cuota, 
   @i_dias_anio         = @w_dias_anio,
   @i_reajuste_especial = @w_reajuste_especial,
   @i_num_dec           = @i_num_dec,
   @i_fecha_proceso     = @i_fecha_proceso,
   @i_en_linea          = @i_en_linea,
   @i_dividendo         = @w_dividendo,
   @i_secuencial        = @w_secuencial,
   @i_concepto_cap      = @i_concepto_cap,
   @i_concepto_int      = @i_concepto_int,
   @i_disminuye         = @w_disminuye_tasa
   
   if @w_return <> 0 return @w_return
      
   update ca_amortizacion
   set    am_acumulado =  am_cuota
   where  am_operacion =  @i_operacionca
   and    am_concepto not in ('CAP','INT','IMO')
   and    am_dividendo = @w_dividendo
   
   if @@error <> 0 return 705050
   
end

if @w_tipo_amortizacion = 'FLEXIBLE'
begin 
---   print 'reajuste.sp va para sp_ca_pagflex_reajuste_int'

   exec @w_return = sp_ca_pagflex_reajuste_int
   @s_date              = @s_date,
   @s_user              = @s_user,
   @s_term              = @s_term,
   @s_ofi               = @s_ofi,
   @i_operacionca       = @i_operacionca,
   @i_fecha_proceso     = @i_fecha_proceso,
   @i_banco             = @w_banco,
   @i_disminuye         = @w_disminuye_tasa
   
   if @w_return <> 0 return @w_return

end
   

--ACTUALICACION DE LA FECHA DE PROXIMO REAJUSTE
select @w_fecha_prox_rejuste = min(re_fecha)
from   ca_reajuste with (nolock)
where  re_operacion = @i_operacionca
and    re_fecha     > @i_fecha_proceso

if @w_fecha_prox_rejuste is not null begin

   update ca_operacion with (rowlock)
   set    op_fecha_reajuste = @w_fecha_prox_rejuste
   where  op_operacion      = @i_operacionca
   
   if @@error <> 0 return 710002
   
end

---VALIDACIONES DESPUES DEL REAJUSTE

select @w_am_cuota       = 0,
       @w_am_acumulado   = 0,
       @w_am_pagado      = 0
       
select @w_am_cuota       = am_cuota,
       @w_am_acumulado   = am_acumulado,
       @w_am_pagado      = am_pagado
from ca_amortizacion with (nolock)
where am_operacion = @i_operacionca
and   am_dividendo = @w_dividendo
and  am_concepto = @i_concepto_int

if @w_am_cuota < @w_am_acumulado
return 724542         

if  @w_am_cuota < @w_am_pagado
return 724543

if  @w_am_acumulado < @w_am_pagado
return 724544         

if  (@w_am_cuota < 0) or (@w_am_acumulado < 0) or (@w_am_pagado < 0)
return 724545


return 0

go
