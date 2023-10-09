/************************************************************************/
/*	Archivo: 	        recuper1.sp                             */ 
/*	Stored procedure:       sp_recuper1                             */ 
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de la descripcion y la existencia de las Garantias     */
/*      para las Recuperaciones de los vencimientos de una Garantia     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995  L.Castellanos      Emision Inicial            	*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_recuper1')
    drop proc sp_recuper1
go
create proc sp_recuper1  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               varchar(64) = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_producto           char(64) = null,
   @i_modo               smallint = null,
   @i_cliente            int = null,
   @i_ente               int = null,
   @i_filial 		 tinyint = null,
   @i_sucursal		 smallint = null,
   @i_tipo_cust		 varchar(64) = null,
   @i_custodia 		 int = null,
   @i_garante  		 int = null,
   @i_opcion             tinyint = null,
   @i_codigo_externo     varchar(64) = null,
   @i_operacion          cuenta      = null,
   @i_formato_fecha      int         = null,
   @i_recuperacion       smallint    = null


)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_contador           tinyint

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_recuper1'
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19574 and @i_operacion = 'S')      
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
      exec @w_return = sp_tipo_custodia
      @i_tipo = @i_tipo_cust,
      @t_trn  = 19123,
      @i_operacion = 'V',
      @i_modo = 0
      if @w_return <> 0 
      begin
         return 1 
      end 

      exec @w_return = sp_custopv
      @i_filial     = @i_filial,
      @i_sucursal   = @i_sucursal,
      @i_tipo       = @i_tipo_cust,
      @i_custodia   = @i_custodia,
      @t_trn        = 19565,
      @i_operacion  = 'B',
      @i_modo       = 0
 
      if @w_return <> 0 
      begin
      /* Error de ejecucion  
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901005 */
         return 1 
      end 
     
      exec @w_return   = sp_recuperacion
      @i_filial        = @i_filial,
      @i_sucursal      = @i_sucursal,
      @i_tipo_cust     = @i_tipo_cust,
      @i_custodia      = @i_custodia,
      @i_recuperacion  = @i_recuperacion,
      @i_formato_fecha = 101,
      @t_trn           = 19024,
      @i_operacion     = 'S',
      @i_modo          = @i_modo 

      if @w_return <> 0 
      begin
      /* Error de ejecucion  
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 */
         return 1 
      end 
end
go