/************************************************************************/
/*	Archivo: 	        tipobien.sp                             */ 
/*	Stored procedure:       sp_tipo_bien                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Laura Alvarado                          */
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
/*	Muestra el codigo y descripcion de los Tipos de Bienes          */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1998   L. Alvarado       Emision Inicial                    */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_tipo_bien')
    drop proc sp_tipo_bien
go
create proc sp_tipo_bien (
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
   @w_existe             tinyint,      /* existe el registro*/
   @w_rowcount           int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_tipo_bien'

 /* Primeros 20 registros de la tabla */
 /*************************************/


if @i_modo = 0
begin
   set rowcount 20
   select 
   "CODIGO"      =  A.codigo,
   "DESCRIPCION" =  A.valor 
   from cobis..cl_catalogo A, cobis..cl_tabla B
   where A.codigo >= @i_criterio1 or @i_criterio1 is null
   and   B.tabla = 'cu_tipo_bien'
   and   A.tabla = B.codigo   
   order by A.codigo
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0
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
   "CODIGO"      =  A.codigo,
   "DESCRIPCION" =  A.valor 
   from cobis..cl_catalogo A, cobis..cl_tabla B
   where A.codigo > @i_criterio1 or @i_criterio1 is null
   and   B.tabla = 'cu_tipo_bien'
   and   A.tabla = B.codigo   
   order by A.codigo
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end


go