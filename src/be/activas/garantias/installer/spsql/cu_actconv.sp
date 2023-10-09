/*cu_actconv.sp****************************************************/
/*  Archivo:            cu_actconv.sp                             */
/*  Stored procedure:   sp_actualiza_convenios                    */
/*  Base de datos:      cob_custodia                              */ 
/*  Producto:           Credito                                   */
/*  Disenado por:       Luis Ponce                                */
/*  Fecha de escritura: 13-Dic-2010                               */
/******************************************************************/
/*                      IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA', representantes exclusivos para el Ecuador de        */
/*  AT&T GIS  .                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                      PROPOSITO                                 */
/*  Este programa hace mantenimiento a la tabla                   */
/*  cu_convenios_garantia de cob_custodia, que guarda los tipos   */
/*  de garantias con los convenios tipo USAID                     */
/******************************************************************/
/*                    MODIFICACIONES                              */
/*  FECHA       AUTOR                 RAZON                       */
/*  13/Dic/10   Alfredo Zuluaga       Emision Inicial             */
/*                                                                */
/*  Estados de gp_procesado:                                      */
/*  R    -Reservado                                               */
/*  U    -Utilizado                                               */
/*  null -Inicial                                                 */
/******************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_convenios')
   drop proc sp_actualiza_convenios
go

create proc sp_actualiza_convenios(
@i_param1             varchar(255)

)
as

declare
@i_fecha              datetime,
@w_sp_name            varchar(25),
@w_msg                varchar(255),
@w_tipo_garantia      varchar(64),
@w_codigo_convenio    varchar(10),
@w_moneda             smallint,
@w_monto              money,
@w_monto_mn           money,
@w_monto_aumento      money,
@w_saldo_disponible   money,
@w_valor_utilizado    money,
@w_valor_reservado    money,
@w_valor_rv           money,
@w_estado             varchar(10),
@w_valor_rechazos     money,
@w_fecha_cotizacion   datetime,
@w_valor_cotiz        money,
@w_valor_utiliza_N    money,
@w_valor_utiliza_R    money


select @i_fecha = convert(datetime, @i_param1)

select @w_sp_name = 'sp_actualiza_convenios'


--Actualiza Valores para Convenio USAID
select tipo = cg_tipo_garantia, convenio=cg_codigo_convenio, moneda = cg_moneda
into #temporal
from cu_convenios_garantia
where cg_estado = 'V'

select @w_fecha_cotizacion = max(ct_fecha)
from cob_conta..cb_cotizacion, #temporal
where ct_moneda = moneda
and   moneda    <> 0

select @w_valor_cotiz = ct_valor 
from cob_conta..cb_cotizacion, #temporal
where ct_moneda = moneda
and   ct_fecha  = @w_fecha_cotizacion
and   moneda    <> 0

------------------------------------------------------PROCESO RESERVADO------------------------------------------

--Buscar el valor para Reservar de Tramites con garantia USAID Hoy (pasan de valor disponible a valor reservado)
select @w_valor_reservado = isnull(sum(cu_valor_actual),0)
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta,
     cob_custodia..cu_custodia
where op_estado    in (99,0)
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   gp_fecha_mod <= @i_fecha
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado is null

--Tramites con garantia USAID Hoy (pasan de valor disponible a valor reservado)
update cob_credito..cr_gar_propuesta set
gp_procesado = 'R'
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_custodia..cu_custodia
where op_estado    in (99,0)
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   gp_fecha_mod <= @i_fecha
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado is null

if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cr_gar_propuesta> (1)'
   goto ERRORFIN
end

--Aumenta el valor Reservado
update cu_convenios_garantia set
cg_valor_reservado  = isnull(cg_valor_reservado,0) + isnull(@w_valor_reservado,0)  
from #temporal
where cg_tipo_garantia   = tipo
and   cg_codigo_convenio = convenio
and   cg_estado          = 'V'
         
if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (2)'
   goto ERRORFIN
end

--Baja el valor disponible
update cu_convenios_garantia set
cg_saldo_disponible  = isnull(cg_saldo_disponible,0) - (isnull(@w_valor_reservado,0) / @w_valor_cotiz)
from #temporal
where cg_tipo_garantia   = tipo
and   cg_codigo_convenio = convenio
and   cg_estado          = 'V'
         
if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (3)'
   goto ERRORFIN
end



------------------------------------------------------PROCESO UTILIZADO------------------------------------------

--Buscar el valor para Utilizar el valor de Tramites con garantia USAID Hoy (valores no reservados)
select @w_valor_utiliza_N = isnull(sum(cu_valor_actual),0)
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta,
     cob_custodia..cu_custodia
where op_estado    = 1
and   op_fecha_liq = @i_fecha
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado is null

--Buscar el valor para Utilizar el valor de Tramites con garantia USAID Hoy (valores reservados)
select @w_valor_utiliza_R = isnull(sum(cu_valor_actual),0)
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta,
     cob_custodia..cu_custodia
where op_estado    = 1
and   op_fecha_liq = @i_fecha
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado = 'R'

-- Sumar Valores Utilizados
select @w_valor_utilizado = isnull(@w_valor_utiliza_R,0) + isnull(@w_valor_utiliza_N,0)

--Tramites con garantia USAID Hoy (pasan de valor reservado a valor utilizado)
update cob_credito..cr_gar_propuesta set
gp_procesado = 'U'
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_credito..cr_gar_propuesta,
     cob_custodia..cu_custodia
where op_estado    = 1
and   op_fecha_liq = @i_fecha
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado in (null, 'R')

if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cr_gar_propuesta> (4)'
   goto ERRORFIN
end

--Baja valor del Reservado
update cu_convenios_garantia set
cg_valor_reservado  = isnull(cg_valor_reservado,0) - isnull(@w_valor_utiliza_R,0)  
from #temporal
where cg_tipo_garantia   = tipo
and   cg_codigo_convenio = convenio
and   cg_estado          = 'V'
         
if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (5)'
   goto ERRORFIN
end

--Baja el valor disponible
update cu_convenios_garantia set
cg_saldo_disponible  = isnull(cg_saldo_disponible,0) - (isnull(@w_valor_utiliza_N,0) / @w_valor_cotiz)
from #temporal
where cg_tipo_garantia   = tipo
and   cg_codigo_convenio = convenio
and   cg_estado          = 'V'

--Aumentar el valor utilizado
update cu_convenios_garantia set
cg_valor_utilizado  = isnull(cg_valor_utilizado,0) + isnull(@w_valor_utilizado,0)  
from #temporal
where cg_tipo_garantia   = tipo
and   cg_codigo_convenio = convenio
and   cg_estado          = 'V'
         
if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (6)'
   goto ERRORFIN
end


------------------------------------------------------TRAMITES RECHAZADOS----------------------------------------

select @w_valor_rechazos = sum(cu_valor_actual)
from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_custodia..cu_custodia, cob_credito..cr_gar_propuesta
where op_tramite   = tr_tramite
and   tr_estado    = 'Z'
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   cu_tipo      in (select tipo from #temporal)
and   tr_fecha_apr = @i_fecha
and   gp_procesado is not null

select @w_valor_rechazos = isnull(@w_valor_rechazos, 0)

if @w_valor_rechazos > 0 begin

   update cob_credito..cr_gar_propuesta set
   gp_procesado = null
   from cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_custodia..cu_custodia, cob_credito..cr_gar_propuesta
   where op_tramite   = tr_tramite
   and   tr_estado    = 'Z'
   and   op_tramite   = gp_tramite
   and   gp_garantia  = cu_codigo_externo
   and   cu_tipo      in (select tipo from #temporal)
   and   tr_fecha_apr = @i_fecha
   and   gp_procesado is not null

   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (8)'
      goto ERRORFIN
   end

   --Baja valor del Reservado
   update cu_convenios_garantia set
   cg_valor_reservado  = isnull(cg_valor_reservado,0) - isnull(@w_valor_rechazos,0)  
   from #temporal
   where cg_tipo_garantia   = tipo
   and   cg_codigo_convenio = convenio
   and   cg_estado          = 'V'
         
   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (9)'
      goto ERRORFIN
   end

   --Aumento el valor disponible
   update cu_convenios_garantia set
   cg_saldo_disponible  = isnull(cg_saldo_disponible,0) + (isnull(@w_valor_rechazos,0) / @w_valor_cotiz)
   from #temporal
   where cg_tipo_garantia   = tipo
   and   cg_codigo_convenio = convenio
   and   cg_estado          = 'V'
         
   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (10)'
      goto ERRORFIN
   end
end


------------------------------------------------------REVERSAS DE CARTERA----------------------------------------

--Buscar Reversados sin Volver a Aplicar en el dia de proceso
select secuencial = isnull(max(tr_secuencial),0), banco = tr_banco, estado = tr_estado
into #temporal_rv
from cob_cartera..ca_transaccion
where tr_tran       = 'DES'
and   tr_fecha_mov  = @i_fecha
group by tr_banco, tr_estado

select * 
into #reversados
from #temporal_rv
where estado = 'RV'

select @w_valor_rv = sum(cu_valor_actual)
from #reversados, cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_custodia..cu_custodia, cob_credito..cr_gar_propuesta
where op_banco     = banco
and   op_tramite   = tr_tramite
and   tr_estado    not in ('Z')
and   op_tramite   = gp_tramite
and   gp_garantia  = cu_codigo_externo
and   cu_tipo      in (select tipo from #temporal)
and   gp_procesado is not null

select @w_valor_rv = isnull(@w_valor_rv,0)

if @w_valor_rv > 0 begin

   update cob_credito..cr_gar_propuesta set
   gp_procesado = null
   from #reversados, cob_cartera..ca_operacion, cob_credito..cr_tramite, cob_custodia..cu_custodia, cob_credito..cr_gar_propuesta
   where op_banco     = banco
   and   op_tramite   = tr_tramite
   and   tr_estado    not in ('Z')
   and   op_tramite   = gp_tramite
   and   gp_garantia  = cu_codigo_externo
   and   cu_tipo      in (select tipo from #temporal)
   and   gp_procesado is not null

   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (11)'
      goto ERRORFIN
   end

   --Baja valor del Utilizado
   update cu_convenios_garantia set
   cg_valor_utilizado  = isnull(cg_valor_utilizado,0) - isnull(@w_valor_rv,0)  
   from #temporal
   where cg_tipo_garantia   = tipo
   and   cg_codigo_convenio = convenio
   and   cg_estado          = 'V'
         
   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (12)'
      goto ERRORFIN
   end

   --Aumento el valor disponible
   update cu_convenios_garantia set
   cg_saldo_disponible  = isnull(cg_saldo_disponible,0) + (isnull(@w_valor_rv,0) / @w_valor_cotiz)
   from #temporal
   where cg_tipo_garantia   = tipo
   and   cg_codigo_convenio = convenio
   and   cg_estado          = 'V'
         
   if @@error <> 0 begin
      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> (13)'
      goto ERRORFIN
   end
end


--Actualiza Cotizacion del Dia
update cob_custodia..cu_convenios_garantia set
cg_monto_mn         = cg_monto * ct_valor
from cob_conta..cb_cotizacion
where ct_moneda = cg_moneda
and   ct_fecha  in (select max(ct_fecha)
                    from cob_conta..cb_cotizacion, cob_custodia..cu_convenios_garantia
                    where ct_moneda = cg_moneda
                    and   cg_moneda <> 0)
and   cg_moneda <> 0

if @@error <> 0 begin
   select @w_msg = 'Error Actualizando Convenios <cg_monto_mn, cg_saldo_disponible> '
   goto ERRORFIN
end


return 0


ERRORFIN:

if @@trancount > 0 rollback tran

select @w_msg   = @w_sp_name + ' --> ' + @w_msg

insert into cu_errorlog
values (@i_fecha, 'cusbatch', 19000, 'Convenios (USAID)', @w_msg)

return 1

go



/*

exec sp_actualiza_convenios
@i_param1 = '10/26/2010'


truncate table cu_convenios_garantia

select * from cu_convenios_garantia

truncate table cobis..in_login


select gp_procesado,* from cob_credito..cr_gar_propuesta
where gp_tramite = 66890

select * from cu_errorlog
where er_fecha_proc = '10/26/2010'

update cob_credito..cr_gar_propuesta set
gp_procesado = null,
gp_fecha_mod = '10/26/2010'
where gp_tramite = 66890

update cob_custodia..cu_custodia  set
cu_tipo = 2405,
cu_valor_actual = 10000000
where cu_codigo_externo = '040181200000304'

update cob_cartera..ca_operacion set
op_estado = 0
where op_tramite = 66890


select * from cob_custodia..cu_custodia
where cu_codigo_externo = '040181200000304'


*/