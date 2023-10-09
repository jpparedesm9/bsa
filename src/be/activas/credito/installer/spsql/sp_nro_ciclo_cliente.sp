/****************************************************************/
/*   ARCHIVO:         	sp_nro_ciclo_cliente.sp	         	    */
/*   NOMBRE LOGICO:   	sp_nro_ciclo_cliente                    */
/*   PRODUCTO:        		CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*                                                              */
/*	Se obtiene de sumar los siguientes valores:                 */
/*  - Número de ciclos que el cliente haya tenido en otras      */
/*    entidades                                                 */
/*  - Número de préstamos individuales que el cliente haya      */
/*    terminado de pagar (CANCELADAS) que la persona tenga en la*/
/*	  entidad, sin importar si es en este grupo o si son        */
/*	  créditos grupales o individuales.                         */
/*  - Mas UNO, es decir, si este es el primer crédito que       */
/*	  solicita esta persona, este variable debe valer UNO.      */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   11-May-2017   Sonia Rojas        Emision Inicial.     	    */
/****************************************************************/

use cob_credito
go

IF OBJECT_ID ('dbo.sp_nro_ciclo_cliente') IS NOT NULL
	DROP PROCEDURE dbo.sp_nro_ciclo_cliente
GO

create proc [dbo].[sp_nro_ciclo_cliente](
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_from             varchar(30) = null,   
    @i_cliente          int,
    @o_resultado        int  OUTPUT
)
as
declare @w_sp_name                  varchar(64),
        @w_error                    int,
        @w_grupo                    int,
        @w_num_prestamos            int,
        @w_nro_ciclo_cliente        int,
        @w_codigo_estado            int,       
        @w_num_operaciones          int,
        @w_resultado                int
        
        
select @w_sp_name   = 'sp_nro_ciclo_cliente'
select @w_resultado = 0


SELECT @w_codigo_estado = es_codigo 
from cob_cartera..ca_estado
where es_descripcion    = 'ANULADO'
 

if @i_cliente is null
BEGIN

   select @w_error = 2109003
   
   exec   @w_error  = cobis..sp_cerror
   @t_debug  = 'N',
   @t_file   = '',
   @t_from   = @w_sp_name,
   @i_num    = @w_error
   return @w_error
    
   
END


--Ciclos en otra entidad financieras
select @w_nro_ciclo_cliente = isnull(ea_nro_ciclo_oi,0)
  from cobis..cl_ente_aux
 where ea_ente 				= @i_cliente

--Ciclos en esta entidad financiera, que no esten en estado 'ANULADO'
select @w_num_prestamos = isnull(count(op_operacion),0)
  from cob_cartera..ca_operacion 
 where op_estado 		not in (@w_codigo_estado)
   and op_cliente 		= @i_cliente

if @w_num_prestamos = 0
	select @w_resultado = 1
else
	select @w_resultado = @w_num_prestamos
	--select @w_resultado = @w_nro_ciclo_cliente + @w_num_prestamos	

if @t_debug = 'S'
begin
	print '@w_resultado: ' + convert(varchar, @w_resultado )	
end
	
select @o_resultado  =   @w_resultado 

if @o_resultado is null
begin
	select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
	exec   @w_error  = cobis..sp_cerror
			@t_debug  = 'N',
			@t_file   = '',
			@t_from   = @w_sp_name,
			@i_num    = @w_error
	return @w_error
end

return 0


GO