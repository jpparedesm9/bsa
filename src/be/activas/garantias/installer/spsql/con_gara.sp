/************************************************************************/
/*	Archivo: 	        con_gara.sp  			        */
/*	Stored procedure:       sp_consulta_garantia                    */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de la situacion y valor de una garantia                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995  L.Castellanos        Emision Inicial			*/
/*      Dic/2002  JVelandia            titulo de valor actual           */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_consulta_garantia')
    drop proc sp_consulta_garantia
go
create proc sp_consulta_garantia (
   @t_trn                smallint    = null,
   @s_date               datetime    = null,
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_tipo               descripcion = null,
   @i_custodia           int         = null, 
   @i_cliente            int         = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               descripcion,
   @w_custodia           int,
   @w_estado             catalogo,
   @w_valor_inicial      money,
   @w_valor_actual       money,
   @w_moneda             tinyint,
   @w_cliente            int,
   @w_descripcion        varchar(255),
   @w_error		 int,
   @w_abier_cerrada      char(1) 

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_consulta_garantia'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19214 and @i_operacion = 'S') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
   set rowcount 20
   select
   "OFICINA"     = cu_sucursal,
   "GARANTIA"     = cu_custodia,
   "TIPO"         = cu_tipo,
   "ESTADO"       = cu_estado,
   "CLASE"        = cu_abierta_cerrada,
   "DESCRIPCION"  = cu_descripcion, 
   "VALOR GARANTIA" = cu_valor_inicial,
   "MONEDA"       = cu_moneda
   from cu_custodia,cu_cliente_garantia
   where  cu_filial   = @i_filial
   and  cu_filial     = cg_filial
   and  cu_sucursal   = cg_sucursal
   and  cu_tipo       = cg_tipo_cust
   and  cu_custodia   = cg_custodia
   and  cg_ente       = @i_cliente
   and  ((cu_sucursal > @i_sucursal or (cu_sucursal = @i_sucursal
         and cu_tipo > @i_tipo) 
   or   (cu_sucursal = @i_sucursal and cu_tipo = @i_tipo and 
                   cu_custodia > @i_custodia)) 
                   or @i_custodia is null)  

   if @@rowcount = 0
      print 'NO EXISTEN REGISTROS'
   return 1 
end
go 