/************************************************************************/
/*      Archivo:                NIIF_pfijo.sp                           */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           jose Molano                             */
/*      Fecha de escritura:     05/21/2014                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*  extraer los CDTS, para interface de balance de apertura para NIIF   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR                    RAZON                       */
/*  Mayo/21/2014   Jose Molano           Creacion Inicial NR 429        */
/*  Ago /04/2014   Alejandra Celis       Modifica Calulo Intereses      */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_niif_pfijo' and type = 'P') 
   drop proc sp_niif_pfijo
go

create proc sp_niif_pfijo
as
declare
@w_contador   int,
@w_interes    money,
@w_fecha_ven  datetime,
@w_monto      money,
@w_fecha_crea datetime,
@w_operacion  varchar(24),
@w_cuotas     int,
@w_fecha      datetime,
@w_plazo      tinyint

select @w_contador   = 0
select @w_interes    = 0
select @w_fecha_ven  = '01/01/1900'
select @w_monto      = 0
select @w_fecha_crea = '01/01/1900'
select @w_fecha      = '01/01/1900'
select @w_plazo      = 1

set nocount on

begin tran

delete cob_externos..ex_int_tablaDesarrolloDetIF
from cob_externos..ex_int_tablaDesarrolloDetIF,
     cob_externos..ex_int_operacionesIF
where io_CodigoInstrumento       in (14, 31)
and   it_Identificador_Operacion = io_Identificador_operacion
if @@ERROR <> 0 begin
   print 'Error al borrar ex_int_operacionesIF'
   rollback tran
   goto final
end

delete cob_externos..ex_int_operacionesIF
where io_CodigoInstrumento in (14, 31)
if @@ERROR <> 0 begin
   print 'Error al borrar ex_int_operacionesIF'
   rollback tran
   goto final
end

select 
fecha      = convert(varchar(10),dp_fecha_apertura,111),
producto   = (case when  dp_plazo_dias < 180  then 31 
                   when (dp_plazo_dias >= 180 and dp_plazo_dias < 360) then 32
                   when (dp_plazo_dias >= 360 and dp_plazo_dias < 540) then 33
                   else 34 end ),
monto      = dp_monto,
documento  = isnull((select en_ced_ruc from cobis..cl_ente where en_ente = dp_cliente),''),
operacion  = dp_banco,
indicador  = 1,
costo_adic = convert(money, 0),
tasa       = dp_tasa,
cuotas     = dp_num_cuotas,
moneda     = 'COP',
tipo_tasa  = convert(tinyint, 0),
tipo_doc   = isnull((select en_tipo_ced from cobis..cl_ente where en_ente = dp_cliente),''),
empresa    = 1,
tipo_cl    = (select (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end) from cobis..cl_ente
             where en_ente = dp_cliente)
into #operacion_cdt
from cob_conta_super..sb_dato_pasivas
where dp_aplicativo = 14
and   dp_fecha      = '12/31/2013'
and   dp_estado     = 1

if @@ERROR <> 0 begin
   print 'Error al insertar #operacion_cdt'
   rollback tran
   goto final
end



update #operacion_cdt set
producto  = (case when (producto = 31 and tipo_cl = 'PA' ) then 301
                 when (producto = 31 and tipo_cl <>'PA'  ) then 302
                 when (producto = 32 and tipo_cl ='PA'   ) then  303
                 when (producto = 32 and tipo_cl <>'PA'  ) then 304
                 when (producto = 33                     ) then 305
                 when (producto = 34 and tipo_cl ='PA'   ) then 306
                 when (producto = 34 and tipo_cl <>'PA'  ) then 307 else null end)
     
if @@ERROR <> 0 begin
   print 'Error al  actualizar Producto'
   rollback tran
   goto final
end


update #operacion_cdt set
costo_adic = isnull(cp_costo, 0)
from #operacion_cdt,
     cob_externos..ex_costos_pfijo
where operacion    = cp_cdt
if @@ERROR <> 0 begin
   print 'Error al al actualizar costos'
   rollback tran
   goto final
end

update #operacion_cdt set
tipo_tasa = case when isnull(td_tasa_variable, 'N') = 'N' then 0 when isnull(td_tasa_variable, 'N') = 'S' then 1 end
from #operacion_cdt,
     cob_pfijo..pf_operacion,
     cob_pfijo..pf_tipo_deposito
where operacion    = op_num_banco
and   td_mnemonico = op_toperacion
if @@ERROR <> 0 begin
   print 'Error al al actualizar tipo tasa'
   rollback tran
   goto final
end

insert into cob_externos..ex_int_operacionesIF
select 
fecha,      producto,    monto,
documento,  tipo_doc,    operacion,
indicador,  costo_adic,  tasa,
cuotas,     moneda,      tipo_tasa,
empresa
from #operacion_cdt
if @@ERROR <> 0 begin
   print 'Error al insertar en ex_int_operacionesIF'
   rollback tran
   goto final
end

insert cob_externos..ex_int_tablaDesarrolloDetIF
select 
operacion,
1,
convert(varchar(10), op_fecha_ven, 111),
op_monto + op_int_estimado,
op_monto,
op_int_estimado,
0
from cob_pfijo..pf_operacion,
     #operacion_cdt
where op_num_banco = operacion
and   op_fpago     = 'VEN'
if @@ERROR <> 0 begin
   print 'Error al insertar en ex_int_tablaDesarrolloDetIF'
   rollback tran
   goto final
end

-- EXTRAE LOS CDTS CON PAGO PERIODICO
select operacion, cuotas
into #oper_periodica
from cob_pfijo..pf_operacion,
     #operacion_cdt
where op_num_banco = operacion
and   op_fpago     = 'PER'
if @@ERROR <> 0 begin
   print 'Error al insertar en ex_int_tablaDesarrolloDetIF'
   rollback tran
   goto final
end

-- CICLO POR CADA CDT PERIODICA
while 1 = 1 begin
   select @w_contador   = 0
   select @w_interes    = 0
   select @w_fecha_ven  = '01/01/1900'
   select @w_monto      = 0
   select @w_fecha_crea = '01/01/1900'
   select @w_operacion  = ''
   select @w_cuotas     = 0
   select @w_plazo      = 1
   
   select top 1
   @w_operacion = operacion,
   @w_cuotas    = cuotas
   from #oper_periodica
   order by operacion
   if @@rowcount = 0 begin
      break
   end

   delete #oper_periodica
   where operacion = @w_operacion
      
   select 
   @w_interes    = op_total_int_estimado/@w_cuotas,
   @w_fecha_ven  = op_fecha_ven,
   @w_monto      = op_monto,
   @w_fecha_crea = op_fecha_crea,
   @w_plazo      = case when op_ppago = 'M' then 1 when op_ppago = 'T' then 3 end
   from cob_pfijo..pf_operacion
   where op_num_banco = @w_operacion
   if @@rowcount = 0 begin
      print 'No existe operacion ' + @w_operacion
      rollback tran
      goto final
   end
   
   while @w_contador < @w_cuotas begin
      select @w_contador = @w_contador + 1
      
      if @w_contador = @w_cuotas begin
         -- INSERTA LA ULTIMA CUOTA DEL CDT
         insert cob_externos..ex_int_tablaDesarrolloDetIF 
         values (
         @w_operacion,            @w_contador,        convert(varchar(10), dateadd(dd, -1, @w_fecha_ven),111),
         @w_monto + @w_interes,   @w_monto,           @w_interes,
         0)
         if @@error <> 0 begin
            print 'Error al insertar ex_int_tablaDesarrolloDetIF (1)'
            rollback tran
            goto final
         end
      end
      else begin
      -- INSERTA LAS CUOTAS DEL CDT MENOS LA ULTIMA
         select @w_fecha = dateadd(dd, -1, dateadd(mm, @w_contador*@w_plazo, @w_fecha_crea))
         
         insert cob_externos..ex_int_tablaDesarrolloDetIF 
         values (
         @w_operacion, @w_contador, convert(varchar(10), @w_fecha, 111),
         @w_interes,   0,           @w_interes,
         @w_monto)
         if @@error <> 0 begin
            print 'Error al insertar ex_int_tablaDesarrolloDetIF (2)'
            rollback tran
            goto final
         end
      end
   end
end

if @@TRANCOUNT > 0 begin
   commit tran
end

return 0

final:

return 1

go
