/************************************************************************/
/*	Archivo: 	        estperfi.sp                             */ 
/*	Stored procedure:       sp_est_perfil                           */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           MVI                             	*/
/*	Fecha de escritura:     Sept-1999  				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de Codigo y Descripcion de los estados de las GAR      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		    RAZON			*/
/*	Sep/1999   Ma.del Pilar Vizuete  Emision Inicial                */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_est_perfil')
    drop proc sp_est_perfil
go
create proc sp_est_perfil (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = 'S',
   @i_modo               smallint = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint      /* existe el registro*/

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_est_perfil'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn = 19872 and @i_operacion = 'S')
begin
if @i_modo = 0
begin
   select 
   "CODIGO"      = rtrim(ltrim(eg_estado)), --+';'+ rtrim(ltrim(A.codigo)),
   "DESCRIPCION" = rtrim(ltrim(eg_descripcion)) --+';'+ rtrim(ltrim(A.valor))
   from --cobis..cl_catalogo A, cobis..cl_tabla B,
        cob_custodia..cu_estados_garantia  
   --where B.tabla = 'cu_clase_custodia'
   --and   A.tabla = B.codigo
   --order by eg_estado, A.codigo
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
   return 0
end
end
go