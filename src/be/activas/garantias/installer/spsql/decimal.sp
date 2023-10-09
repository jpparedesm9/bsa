/************************************************************************/
/*	Archivo: 	        decimal.sp                              */ 
/*	Stored procedure:       sp_decimales                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa verifica el numero de decimales                   */
/*	                                                                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_decimales')
    drop proc sp_decimales
go
create proc sp_decimales  (
   @i_filial             tinyint = null,
   @i_sucursal           smallint = null,
   @i_tipo               descripcion = null,
   @i_custodia           int = null,
   @i_codigo_externo     descripcion = null,
   @i_moneda             tinyint = null,
   @o_decimales          tinyint = null out
)
as

declare
   @w_decimales          char(1),
   @w_moneda             tinyint

if @i_moneda is not null
   select @w_moneda = @i_moneda
else
   if @i_codigo_externo is not null
      select @w_moneda = cu_moneda
        from cu_custodia
       where cu_codigo_externo = @i_codigo_externo
   else
      select @w_moneda = cu_moneda
        from cu_custodia
       where cu_filial         = @i_filial
         and cu_sucursal       = @i_sucursal
         and cu_tipo           = @i_tipo
         and cu_custodia       = @i_custodia

select @w_decimales = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda

if @w_decimales = "S"
begin
   select @o_decimales = pa_tinyint
     from cobis..cl_parametro
    where pa_nemonico = "NDE"
      and pa_producto = "CCA"
     set transaction isolation level read uncommitted

   if @@rowcount = 0
     begin
        exec cobis..sp_cerror 
                      @t_from = 'sp_decimales', @i_num = 708130
        return 1
     end
end
else
   select @o_decimales = 0                                      

go