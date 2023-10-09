/************************************************************************/
/*  Archivo:            cuota.sp                                        */
/*  Stored procedure:   sp_cuota                                        */
/*  Base de datos:      cob_cartera                                     */
/*  Producto:           Cartera                                         */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA".                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR            RAZON                              */
/*  08/Nov/2016     J. Salazar       Migracion Cobis Cloud              */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cuota')
	drop proc sp_cuota
go

create proc sp_cuota
   @i_operacion    int,
   @i_actualizar   char(1) = 'N',
   @o_cuota        money   = NULL  out
as 
declare
   @w_error          int,
   @w_cuota          money,
   @w_di_dividendo   int

-- Obtiene minimo dividendo por estado
select estado = di_estado, dividendo = min(di_dividendo) 
into #estados
from cob_cartera..ca_dividendo with (nolock)
where di_operacion = @i_operacion
group by di_estado

if @@rowcount = 0 
   return 724528 -- Error al calcular nueva cuota pactada

-- Obtiene maximo dividendo de los minimos obtenidos
select @w_di_dividendo = max(dividendo) 
from #estados

-- Obtiene valor de cuota basada en concepto de Capital e Interes
select @w_cuota = sum(am_cuota) 
from ca_amortizacion with (nolock), ca_rubro_op with (nolock)
where am_operacion = @i_operacion
and   am_dividendo = @w_di_dividendo
and   am_operacion = ro_operacion
and   am_concepto  = ro_concepto
and   ro_tipo_rubro in ('C', 'I')

if @i_actualizar = 'S' begin 
   update ca_operacion set 
   op_cuota = @w_cuota
   where op_operacion = @i_operacion
   
   if @@rowcount = 0 
      return 724529 -- Error al actualizar nueva cuota pactada
end

select @o_cuota = @w_cuota

return 0
go

