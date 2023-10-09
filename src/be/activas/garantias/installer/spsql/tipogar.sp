/************************************************************************/
/*	Archivo: 	        moneda.sp                               */ 
/*	Stored procedure:       sp_moneda                               */ 
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

if exists (select 1 from sysobjects where name = 'sp_tipo_gar')
    drop proc sp_tipo_gar
go
create proc sp_tipo_gar (
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
   @i_modo               smallint = null,
   @i_moneda             tinyint = null,
   @i_param1             descripcion = null,
   @i_criterio1          varchar(10) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint      /* existe el registro*/

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_tipo_gar'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19150 and @i_operacion = 'A')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

 /* Todos los datos de la tabla */
 /*******************************/
   set rowcount 20
   select "CODIGO" = tc_tipo, "DESCRIPCION" = tc_descripcion
   from cob_custodia..cu_tipo_custodia
   order by tc_tipo 
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
go

