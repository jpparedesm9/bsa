/*************************************************************************/
/*	Archivo: 		conver.sp		 		 */
/*	Stored procedure: 	sp_conversion_moneda	        	 */
/*	Base de datos:  	cob_cartera				 */
/*	Producto: 		Cartera					 */
/*	Disenado por:  			                                 */
/*	Fecha de escritura: 	    					 */
/*************************************************************************/
/*				IMPORTANTE				 */
/*	Este programa es parte de los paquetes bancarios propiedad de	 */
/*	"MACOSA"							 */
/*	Su uso no autorizado queda expresamente prohibido asi como	 */
/*	cualquier alteracion o agregado hecho por alguno de sus		 */
/*	usuarios sin el debido consentimiento por escrito de la 	 */
/*	Presidencia Ejecutiva de MACOSA o su representante.		 */
/*************************************************************************/  
/*				PROPOSITO				 */
/*      Permite consultar la cotizacion de la moneda asi como convertir  */
/*      a monto en moneda legal.					 */
/*************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_conversion_moneda')
        drop proc sp_conversion_moneda
go

create proc sp_conversion_moneda
@s_date                 datetime,
@i_opcion               char(1)  = 'L',
@i_moneda_monto		tinyint  = null,
@i_moneda_resultado	tinyint  = null,
@i_monto		money 	 = null,
@i_fecha                datetime = null, 
@o_monto_resultado	money 	 = null out,
@o_tipo_cambio          float 	 = null out
as
declare
@w_sp_name		descripcion,
@w_return		int,
@w_num_dec		smallint,
@w_moneda_n		tinyint,
@w_num_dec_n		smallint,
@w_cot_ori		money,
@w_cot_des		float,
@w_monto_ori_pes	money,
@w_monto_pes_des	money


/** SELECCION DE VARIABLES **/
select @w_sp_name = 'sp_conversion_moneda'

if @i_opcion = 'L' begin

   if @i_moneda_monto = @i_moneda_resultado begin
      select @o_monto_resultado = @i_monto
      select @o_tipo_cambio = 1.0
      return 0
   end
   
   -- INICIALIZACION DE VARIABLES
   if @i_fecha is null
      select @i_fecha = fc_fecha_cierre
      from   cobis..ba_fecha_cierre
      where  fc_producto = 7


   select @w_cot_ori = 1,
          @w_cot_des = 1

   exec @w_return = sp_decimales
   @i_moneda       = @i_moneda_resultado,
   @o_decimales    = @w_num_dec out,
   @o_mon_nacional = @w_moneda_n out,
   @o_dec_nacional = @w_num_dec_n out
  
   if @w_return != 0
      return @w_return
 
   -- SELECCION DE COTIZACIONES
   exec sp_buscar_cotizacion
        @i_moneda     = @i_moneda_monto,
        @i_fecha      = @i_fecha,
        @o_cotizacion = @w_cot_ori output
   
   exec sp_buscar_cotizacion
        @i_moneda     = @i_moneda_resultado,
        @i_fecha      = @i_fecha,
        @o_cotizacion = @w_cot_des output

   /** CONVERSION DE MONTOS **/
  

   /* De monto origen a pesos */
   select @w_monto_ori_pes = round(@i_monto*@w_cot_ori,@w_num_dec_n)

   /** De pesos a monto destino */
   select @w_monto_pes_des = round(@w_monto_ori_pes / @w_cot_des, @w_num_dec)  
 
      
   /** RETORNO DE VALORES **/
   select @o_monto_resultado = @w_monto_pes_des
   select @o_tipo_cambio = @w_cot_ori / @w_cot_des


end --@i_opcion = 'L'

return 0

go
