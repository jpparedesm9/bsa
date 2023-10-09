/************************************************************************/
/*	Archivo: 	        sucursal.sp                             */ 
/*	Stored procedure:       sp_sucursal                             */ 
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
/*	Consulta de las Descripciones y la existencia de sucursales     */
/*	y filiales                                                      */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/*      Mar/2003        Milena G.    Cambio Estructura Oficinas Banco   */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_sucursal')
    drop proc sp_sucursal
go
create proc sp_sucursal(
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
   @i_filial             tinyint = null,
   @i_oficina            smallint = null,
   @i_cond1              varchar(10)  = null,
   @i_sucursal           smallint = null,
   @i_param1             varchar(10) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_error              int,         
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_oficina            smallint,
   @w_sucursal           smallint, 
   @w_subtipo            char(1),
   @w_nombre             varchar(25),
   @w_rowcount           int

select @w_today = @s_date
select @w_sp_name = 'sp_sucursal'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19130 and @i_operacion = 'Q') or
   (@t_trn <> 19131 and @i_operacion = 'F') or
   (@t_trn <> 19132 and @i_operacion = 'O') 

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
      /* Chequeo de Existencias */
      /**************************/

   select @w_subtipo = of_subtipo
   from   cobis..cl_oficina
   where  of_filial = @i_filial
   and    of_oficina = @i_oficina
   set transaction isolation level read uncommitted

     select
     @w_oficina  = of_oficina,
     @w_sucursal = of_oficina,
     @w_filial   = of_filial,
     @w_subtipo  = of_subtipo,
     @w_nombre   = of_nombre
     from cobis..cl_oficina 
     where of_filial = @i_filial
     and of_oficina = @i_oficina
     select @w_rowcount = @@rowcount
     set transaction isolation level read uncommitted

     if @w_rowcount > 0
        select @w_existe = 1
     else
        select @w_existe = 0

    if @w_existe = 1
    begin
      if @w_subtipo = 'S'
         select @w_oficina
      else
         select @w_sucursal 
    end
      select @w_nombre
end 


if @i_operacion = 'O'    
begin
   set rowcount 20
   if @i_sucursal is null
      select @i_sucursal = convert(smallint,@i_param1)

   select "CODIGO" = of_oficina, "SUCURSAL"= of_nombre
     from cobis..cl_oficina
   where of_filial  = convert(tinyint,@i_cond1)
     and of_subtipo = 'S'       
     and (of_oficina > @i_oficina or  @i_oficina is null) 
   order by of_filial,of_oficina
   select @w_rowcount = @@rowcount
     set transaction isolation level read uncommitted

     if @w_rowcount = 0
      if @i_oficina is null /* Modo 0 */
      begin
         select @w_error  = 1901003
         goto ERROR
      end
      else
      begin
         select @w_error  = 1901004
         goto ERROR
      end
end

if @i_operacion = 'F'    
begin
   select of_nombre
     from cobis..cl_oficina
    where of_oficina = @i_oficina
      and of_filial  = @i_filial
      and of_subtipo = 'S'
      --and a_sucursal is null
	select @w_rowcount = @@rowcount
     set transaction isolation level read uncommitted

     if @w_rowcount = 0
  begin
     select @w_error = 1901005
     goto ERROR
  end
end
return 0
ERROR:  
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
go