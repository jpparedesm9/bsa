/************************************************************************/
/*	Archivo: 	        compuest.sp                             */ 
/*	Stored procedure:       sp_compuesto                            */ 
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
/*	Descifra el codigo compuesto de la garantia.                    */
/*                                                                      */
/*				MODIFICACIONES				*/
/*                                                                      */
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		       Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_compuesto')
    drop proc sp_compuesto
go
create proc sp_compuesto  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_compuesto          varchar(64) = null,
   @o_filial             tinyint = null out,
   @o_sucursal           smallint = null out,
   @o_tipo               varchar(64) = null out,
   @o_custodia           int = null out
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_parte              tinyint,
   @w_inicio             tinyint,
   @w_contador           tinyint,
   @w_longitud           tinyint,
   @w_caracter           char(1),
   @w_compuesto          varchar(64), 
   @w_filial             tinyint,  
   @w_sucursal           smallint,
   @w_custodia           int,
   @w_tipo               varchar(64)

select @w_today = @s_date
select @w_sp_name = 'sp_compuesto'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19245 and @i_operacion = 'Q') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'Q'
begin
   select
   @o_filial   = 1,
   @o_sucursal = convert(int,(substring(@i_compuesto,1,5))),
   @o_custodia = convert(int,(substring(@i_compuesto,
                         datalength(@i_compuesto)-6+1,6))),
   @o_tipo     = substring(@i_compuesto,6,datalength(@i_compuesto)-11)

   return 0
end


if @i_operacion = 'S' 
begin
   select 
   @w_filial   = 1,
   @w_sucursal = convert(int,(substring(@i_compuesto,1,5))),
   @w_custodia = convert(int,(substring(@i_compuesto,
                         datalength(@i_compuesto)-6+1,6))),
   @w_tipo     = substring(@i_compuesto,6,datalength(@i_compuesto)-11)

   select
   @w_filial,
   @w_sucursal,
   @w_custodia,
   @w_tipo 
   
   return 0
end
go