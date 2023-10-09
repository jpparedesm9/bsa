/************************************************************************/
/*   Archivo:              rubroibc.sp                                  */
/*   Stored procedure:     sp_rubro_control_ibc                         */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         P.Narvaez                                    */
/*   Fecha de escritura:    26/Mayo/98                                  */
/************************************************************************/
/*   IMPORTANTE                                                         */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*   FECHA                   AUTOR                        RAZON         */  
/*   Enero 2003              XMA            Controla si el rubro que    */
/*                                 estoy insertando o modificando, junto*/
/*      con el total de rubros tipo interes a cobrar,  no sobrepasan el */
/*      1.5*IBC (Actualizacion de Rubros)                               */
/*      02/28/2003              Julio C Quintero    Cambio de Control de*/
/*                                                  Tasa IBC por TLU    */
/*                                                                      */
/************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_rubro_control_ibc')
   drop proc sp_rubro_control_ibc
go

create proc sp_rubro_control_ibc
   @i_operacionca     int,
   @i_concepto        catalogo,
   @i_porcentaje      float,
   @i_periodo_o       char(1)  = null,
   @i_modalidad_o     char(1)  = null,
   @i_num_periodo_o   smallint = 1
as
declare
   @w_return               int,
   @w_porcentaje           float,
   @w_forma_pago           char(1),
   @w_modalidad            char(1),
   @w_periodicidad         char(1),
   @w_periodicidad_anual   varchar(30),
   @w_tasa_efe_anual       float,
   @w_ibc                  float,
   @w_diferencia           float,
   @w_tasa_total_efe       float,
   @w_tasa                 float,
   @w_concepto             catalogo,
   @w_dias_anio            smallint,
   @w_base_calculo         char(1),
   @w_valor_aplicar        catalogo,
   @w_tasa_referencial     varchar(10),
   @w_sector               catalogo,
   @w_factor               float,
   @w_signo                char(1),
   @w_valor_referencial    float,
   @w_fecha_ult_proc       datetime,
   @w_moneda               tinyint,
   @w_tasa_ibc             varchar(30),
   @w_ibc_final            float,
   @w_decimales_ibc        smallint,
   @w_moneda_uvr           tinyint,
   @w_moneda_local         tinyint,
   
   @w_op_clase             char,
   @w_rowcount             int

select @w_tasa_total_efe = 0

-- PERIODICIDAD ORIGEN DE LA OPERACION ES LA PERIODICIDAD
-- ORIGEN DE LOS RUBROS EXISTENTES
select @w_periodicidad   = opt_tdividendo,
       @w_dias_anio      = opt_dias_anio,
       @w_base_calculo   = opt_base_calculo,
       @w_sector         = opt_sector,
       @w_moneda         = opt_moneda,
       @w_fecha_ult_proc = opt_fecha_ult_proceso,
       @w_op_clase       = opt_clase
from   ca_operacion_tmp
where  opt_operacion = @i_operacionca

if @@rowcount = 0 
begin
   -- LAS OPERACIONES CUANDO SE DESEMBOLSAN POR REDESCUENTO, NO ESTAN EN TEMPORALES
   select @w_periodicidad   = op_tdividendo,
          @w_dias_anio      = op_dias_anio,
          @w_base_calculo   = op_base_calculo,
          @w_sector         = op_sector,
          @w_moneda         = op_moneda,
          @w_fecha_ult_proc = op_fecha_ult_proceso,
          @w_op_clase       = op_clase
   from   ca_operacion
   where  op_operacion = @i_operacionca
   
   if @@rowcount = 0
      return 701050
end

-- DECIMALES PARA IBC
select @w_decimales_ibc = vd_num_dec
from   ca_valor_det
where  vd_tipo   = 'TLU' 
and    vd_sector = @w_sector

if @@rowcount = 0  
   return 710076

-- MONEDA UVR
select @w_moneda_uvr = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0  
   return 710076

-- CONSULTA CODIGO DE MONEDA LOCAL
select  @w_moneda_local = pa_tinyint
from    cobis..cl_parametro
where   pa_nemonico = 'MLO'
and     pa_producto = 'ADM'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0  
   return 710076

-- PERIODICIDAD ANUAL
select  @w_periodicidad_anual = pa_char
from    cobis..cl_parametro
where   pa_nemonico = 'PAN' --PERIODICIDAD ANUAL
and     pa_producto = 'CCA'
set transaction isolation level read uncommitted

if @w_moneda = @w_moneda_local or @w_moneda = @w_moneda_uvr
begin
   select  @w_tasa_ibc = pa_char 
   from    cobis..cl_parametro
   where   pa_nemonico = 'TLU' --TASA LIMITE DE USURA
   and     pa_producto = 'CCA' --'ADM'  DESCOMENTAR CON EL ADMIN
   set transaction isolation level read uncommitted
end
ELSE
begin
   select  @w_tasa_ibc = pa_char
   from    cobis..cl_parametro
   where   pa_nemonico = 'TLUEX' -- TASA LIMITE DE USURA MONEDA EXT.
   and     pa_producto = 'CCA' --'ADM'  DESCOMENTAR CON EL ADMIN
   set transaction isolation level read uncommitted
end

select @w_tasa_ibc = rtrim(@w_tasa_ibc) ---+ @w_op_clase


-- OBTENER EL VALOR DEL TLU EN EFECTIVO ANUAL
exec @w_return = sp_tasa
     @i_codigo          = @w_tasa_ibc,
     @i_sector          = @w_sector,
     @i_fecha_ult_proc  = @w_fecha_ult_proc,
     @i_dias_anio       = @w_dias_anio,
     @i_base_calculo    = @w_base_calculo,
     @i_efe_anual       = 'S',
     @o_valor           = @w_ibc out

if @w_return <> 0 
begin
   return @w_return
end
if not exists (select 1
               from   ca_rubro_op_tmp
               where  rot_operacion = @i_operacionca
               and    rot_concepto  = @i_concepto)
   select @i_concepto = null -- INSERTAR: SUMO EL RUBRO A MODIFICAR AL TOTAL DE LA TASA

-- OBTENCION DE LA TASA TOTAL EN EFECTIVO ANUAL A COBRAR

select @w_tasa_total_efe = isnull(sum(rot_porcentaje_efa),0)
from   ca_rubro_op_tmp
where  rot_operacion   = @i_operacionca
and    rot_tipo_rubro  = 'I'

if @@rowcount = 0  or @w_tasa_total_efe = 0
begin
  select @w_tasa_total_efe = isnull(sum(ro_porcentaje_efa),0)
  from   ca_rubro_op
  where  ro_operacion   = @i_operacionca
  and    ro_tipo_rubro  = 'I'
end

--PRINT 'rubroibc.sp  @w_tasa_total_efe  y  @w_ibc ' + cast(@w_tasa_total_efe as varchar) + ' ' + cast(@w_ibc as varchar)

select @w_tasa = round( @w_tasa_total_efe, @w_decimales_ibc)                 

-- TASA DE INTERES SUPERA EL MAXIMO PERMITIDO
select @w_diferencia = @w_tasa - @w_ibc

if @w_tasa > @w_ibc
begin
   PRINT 'rubroibc.sp IBC menor que la Tasa (  @w_tasa   -- @w_ibc) ' + cast(@w_tasa as varchar) + ' ' + cast(@w_ibc as varchar)
   return 710094 
end

-- TASA DE INTERES NEGATIVA
if @w_tasa < 0
begin
   print 'rubroibc.sp Tasa negativa, Revisar La parametrizacion de la referencial y los puntos asignados'
   return 710119
end

return 0

go
