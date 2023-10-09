/************************************************************************/
/*	Archivo: 	        codext.sp                               */ 
/*	Stored procedure:       sp_codigo_externo                       */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*			        Milena Gonzalez                         */ 
/*	Fecha de escritura:     Dic-20-00  				*/
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
/*	Permite consultar el codigo externo de una garantia y lo retorna*/
/*      en una variable de salida.                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_codigo_externo')
    drop proc sp_codigo_externo
go
create proc sp_codigo_externo    (
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_filial             tinyint = null,
   @i_sucursal           smallint = null,
   @i_tipo_cust               varchar(64) = null,
   @i_garantia           int = null,
   @o_codigo_externo     varchar(64) = null out
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
   @w_compuesto          varchar(64) ,
   @w_ceros              varchar(10),
   @w_codigo_externo     varchar(64)

/* Codigos de Transacciones                                */

if (@t_trn <> 19909) 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/*Validacion de campos nulos*/
if @i_sucursal is null or
   @i_tipo_cust is null or
   @i_garantia is null
   begin
      print 'No se pudo generar el CODIGO DE LA GARANTIA'
      return 1
   end
  

   select @o_codigo_externo = cu_codigo_externo
   from   cob_custodia..cu_custodia
   where  cu_filial = @i_filial
     and  cu_sucursal = @i_sucursal
     and  cu_tipo     = @i_tipo_cust
     and  cu_custodia = @i_garantia
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901036
      return 1 
   end
   set rowcount 0
   
select @o_codigo_externo
return 0
go
