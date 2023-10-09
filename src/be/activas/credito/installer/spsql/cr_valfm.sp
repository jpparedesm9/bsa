/*  Base de datos:      cob_credito                                     */
/*  Producto:           Tramites                                        */
/*  Disenado por:       Igmar Berganza                                  */
/*  Fecha de escritura: 03-Ago-2015                                     */
/*  nombre fisico:      cr_valfm                                        */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Stored Procedure para validar segun el monto del tramite verificar  */
/*  si sobrepasa el numero de SMV parametrizado en la tabla T301        */
/************************************************************************/
USE cob_credito
go
if exists (select 1 from sysobjects where name = 'sp_val_monto_finagro')
   drop proc sp_val_monto_finagro
go
CREATE proc sp_val_monto_finagro(  
	@i_monto           money       = null,
   @i_linea           catalogo    = null,
   @i_cliente         int         = null,
	@o_retorno         int         output    
)  
  
as  
declare  
   @w_sp_name                   varchar(60),
   @w_par_monto                 money, 
   @w_monto_inf                 money,
   @w_monto_sup                 money,
   @w_saldo_cap                 money

select @w_sp_name = 'sp_val_monto_finagro' 
select @o_retorno = 0

if @i_monto is null
begin
   --print 'NO EXISTE MONTO PARA EL TRAMITE ENVIADO'    
   select @o_retorno = 2101280
   return 2101280
end	   

-- Lectura Parametro SMV
select @w_par_monto = pa_money
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'SMV'

if @@rowcount = 0 begin
   --print 'ERROR AL LEER PARAMETRO GENERAL PARA OBTENER SMV'
   select @o_retorno = 2609958   
   return 2609958
end

select @w_monto_inf = CONVERT(INT,monto_inf),
       @w_monto_sup = CONVERT(INT,monto_sup)
from cob_credito..cr_corresp_sib s, cobis..cl_tabla t, cobis..cl_catalogo c  
where s.descripcion_sib = t.tabla
and s.tabla             = 'T301'
and t.codigo            = c.tabla      
and c.estado            = 'V'
and c.codigo            = @i_linea

--Calculando montos SMV
select @w_monto_inf = @w_par_monto * @w_monto_inf
select @w_monto_sup = @w_par_monto * @w_monto_sup

-- Obteniendo obligaciones del cliente que sean linea de credito finagro
select w_op = op_operacion
into #op_finagro
from cob_cartera..ca_operacion 
where op_cliente = @i_cliente 
and op_estado in (1,2,4,9)
and op_toperacion in (select c.codigo from cob_credito..cr_corresp_sib s, cobis..cl_tabla t, cobis..cl_catalogo c  
                      where s.descripcion_sib = t.tabla
                      and t.codigo            = c.tabla
                      and s.tabla             = 'T301'
                      and c.estado            = 'V')

select @w_saldo_cap = isnull(sum(am_cuota - am_pagado),0)
from cob_cartera..ca_amortizacion 
where am_operacion in (select w_op from #op_finagro)
and am_concepto = 'CAP'

select @w_saldo_cap = isnull(@w_saldo_cap,0) + isnull(@i_monto,0)

if @w_saldo_cap < @w_monto_inf or @w_saldo_cap > @w_monto_sup
begin
   --print 'El monto solicitado excede el límite de endeudamiento del cliente' 
   select @o_retorno = 2101281	   
   return 2101281
end

return 0

go
