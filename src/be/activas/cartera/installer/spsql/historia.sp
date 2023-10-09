/************************************************************************/
/*   Archivo:              historia.sp                                  */
/*   Stored procedure:     sp_historial                                 */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         Fabian de la Torre                           */
/*   Fecha de escritura:   Ene. 1998                                    */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Guarda historicos para reversas                                    */
/*                               MODIFICACIONES                         */
/*   FECHA        AUTOR          RAZON                                  */
/*   13/MAY/2005  Fabian Quintero No respaldar las cuotas canceladas    */
/*   09/AGO/2005  Elcira Pelaez   No recuperar historia de la tabla de  */
/*                                capitalizaziones ca_acciones          */
/*      10/OCT/2005    FDO CARVAJAL    DIFERIDOS REQ 389                */
/*   10/NOV/2005  Elcira Pelaez   Respaldar tabla Documenos descontados */
/*   22/Nov/2005  Ivan Jimenez    REQ 379 Traslado de Intereses         */
/*   SEP 2006     FQ              Optimizacion 152                      */
/*   May 2007     Fabian Quintero Defecto 8236                          */
/*   Oct 2007     Elcira Pelaez   Defecto 8895 ca_ultima_tasa_op_his    */
/*                                quitar                                */
/*   05/12/2016   R. Sánchez      Modif. Apropiación                    */
/*   06/Dic/2016  I. Yupa         AJUSTES CONTABLES MEXICO              */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_historial')
   drop proc sp_historial
go

create proc sp_historial
   @i_operacionca     int,
   @i_secuencial   int = null
as
declare 
   @w_tipo_op           char(1),
   @w_dividendo_desde   smallint,
   @w_moneda            tinyint

select @w_tipo_op = isnull(op_tipo,'N'),
       @w_moneda  = op_moneda
from   ca_operacion (nolock)
where  op_operacion = @i_operacionca

-- INICIAR RESPALDO DE INFORMACION
if @w_moneda = 2    ---SOLO PARA MONEDA UVR
begin
   insert ca_correccion_his with (rowlock)
   select @i_secuencial, *
   from   ca_correccion (nolock)
   where  co_operacion = @i_operacionca
end

insert ca_operacion_his with (rowlock)
select @i_secuencial, * 
from   ca_operacion (nolock)
where  op_operacion = @i_operacionca

if @@error <> 0
   return 710261

insert ca_rubro_op_his with (rowlock)
select @i_secuencial, *
from   ca_rubro_op (nolock)
where  ro_operacion  = @i_operacionca

if @@error <> 0
   return 710272

-- BUSCAR EL DIVIDENDO DESDE EL CUAL SE VA A RESPALDAR
select @w_dividendo_desde = 0

if exists(select 1
          from   ca_operacion (nolock)
          where  op_operacion = @i_operacionca
          and    op_tipo     = 'O')
   select @w_dividendo_desde = 0
ELSE
begin
   select @w_dividendo_desde = isnull(min(di_dividendo), 0) - 1
   from   ca_dividendo (nolock)
   where  di_operacion = @i_operacionca
   and    di_estado in (2, 1)
end

insert ca_dividendo_his with (rowlock)
select @i_secuencial, *
from   ca_dividendo (nolock)
where  di_operacion   = @i_operacionca
and    di_dividendo > @w_dividendo_desde

if @@error <> 0
   return 710263

insert ca_amortizacion_his with (rowlock)
select @i_secuencial, *
from   ca_amortizacion (nolock)
where  am_operacion  = @i_operacionca
and    am_dividendo > @w_dividendo_desde
       
if @@error <> 0
   return 710264

insert ca_cuota_adicional_his with (rowlock)
select @i_secuencial, *
from   ca_cuota_adicional (nolock)
where  ca_operacion  = @i_operacionca

if @@error <> 0
   return 710265

insert ca_valores_his with (rowlock)
select @i_secuencial, *
from   ca_valores (nolock)
where  va_operacion  = @i_operacionca

if @@error <> 0
   return 710267

insert ca_amortizacion_ant_his with (rowlock)
select *,@i_secuencial         -- MPO Ref. 026 02/21/2002
from   ca_amortizacion_ant (nolock)
where  an_operacion  = @i_operacionca

if @@error <> 0
   return 710259

-- INICIO FCP 10/OCT/2005 - REQ 389
insert ca_diferidos_his with (rowlock)
select @i_secuencial, *
from   ca_diferidos (nolock)
where  dif_operacion  = @i_operacionca

if @@error <> 0
   return 710580

-- FIN FCP 10/OCT/2005 - REQ 389

insert ca_facturas_his with (rowlock)
select @i_secuencial, *
from   ca_facturas (nolock)
where  fac_operacion  = @i_operacionca

if @@error <> 0
   return 708154   
 
-- INICIO REQ 379 IFJ 22/Nov/2005
insert ca_traslado_interes_his with (rowlock)
select @i_secuencial,*
from   ca_traslado_interes (nolock)
where  ti_operacion  = @i_operacionca

if @@error <> 0
   return 711006
   
-- FIN REQ 379 IFJ 22/Nov/2005   
   
--Inicio de apropiación
-- ca_comision_diferida
insert ca_comision_diferida_his with (rowlock)
select @i_secuencial,*
from   ca_comision_diferida (nolock)
where  cd_operacion  = @i_operacionca

if @@error <> 0   return 724588 
--Fin de apropiación   
   
-- Seguros asociados a una obligación
   
-- ca_seguros
insert ca_seguros_his with (rowlock)
select @i_secuencial,*
from   ca_seguros (nolock)
where  se_operacion  = @i_operacionca

if @@error <> 0
   return 708231
   
-- ca_seguros_det
insert ca_seguros_det_his with (rowlock)
select @i_secuencial,*
from   ca_seguros_det (nolock)
where  sed_operacion  = @i_operacionca

if @@error <> 0
   return 708232      

-- ca_seguros_can
insert ca_seguros_can_his with (rowlock)
select @i_secuencial,*
from   ca_seguros_can (nolock)
where  sec_operacion  = @i_operacionca

if @@error <> 0 
begin
   print 'historia.sp: NO FUE POSIBLE GUARDAR HISTORICOS DE SEGUROS CANCELADOS'   
   return 708232      
end

--HISTORICOS DIAS DE MORA
insert ca_operacion_ext_his with (rowlock)
select @i_secuencial,*
from   ca_operacion_ext (nolock)
where  oe_operacion  = @i_operacionca
if @@error <> 0 
begin
   print 'historia.sp: NO FUE POSIBLE GUARDAR HISTORICOS DE DIAS MORA'   
   return 724596
end

return 0
go
