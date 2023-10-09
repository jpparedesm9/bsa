/************************************************************************/
/*	Archivo: 	        monperfi.sp                             */ 
/*	Stored procedure:       sp_moneda_gar                           */ 
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de Moneda y Descripcion manejados por COBIS            */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995   L. Castellanos     Emision Inicial                   */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_moneda_gar')
    drop proc sp_moneda_gar
go
create proc sp_moneda_gar (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_moneda             tinyint = null,
   @i_criterio1          varchar(10) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint      /* existe el registro*/

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_moneda_gar'


/* Codigos de Transacciones                                */

 /* Primeros 20 registros de la tabla */
 /*************************************/


if @i_modo = 0
begin
   set rowcount 20
   select
   "CODIGO" = mo_moneda,
   "DESCRIPCION" = mo_descripcion
   from cobis..cl_moneda  
   where mo_moneda >= convert(tinyint,@i_criterio1) or @i_criterio1 is null
   order by mo_moneda
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end


if @i_modo = 1
begin
   set rowcount 20
   select
   "CODIGO" = mo_moneda,
   "DESCRIPCION" = mo_descripcion
   from cobis..cl_moneda  
   where mo_moneda > convert(tinyint,@i_criterio1) or @i_criterio1 is null
   order by mo_moneda
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end

go