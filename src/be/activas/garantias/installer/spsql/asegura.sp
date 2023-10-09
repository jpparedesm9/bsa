/************************************************************************/
/*	Archivo: 	        asegura.sp                              */
/*	Stored procedure:       sp_asegura                              */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Ximena Vega A.                          */
/*	Fecha de escritura:     Agosto - 1999 				*/
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
/*      Permite consultar yo buscar las aseguradoras para polizas       */     
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_asegura')
    drop proc sp_asegura
go
create proc sp_asegura (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_aseguradora        varchar (10) = null,
   @i_param1             descripcion = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_rowcount		 int 

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_asegura'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19884 and @i_operacion = 'A')or
   (@t_trn <> 19884 and @i_operacion = 'V')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
--    @t_debug = @t_debug,
--    @t_file  = @t_file, 
    @t_from  = @w_sp_name,

    @i_num   = 1901006
    return 1 
end

 /* Todos los datos de la tabla */
 /*******************************/

if @i_operacion = 'A'
begin
   set rowcount 20
   if @i_aseguradora is null
      select @i_aseguradora = convert(varchar,@i_param1)
   if @i_modo = 0
   begin
      select 
      "CODIGO"      =  A.codigo,
      "DESCRIPCION" =  A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where
      B.tabla = 'cu_des_aseguradora'
      and   A.tabla = B.codigo   
      order by  A.valor
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
   else
   begin
      select A.codigo,A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_des_aseguradora'
      and A.tabla = B.codigo
      and A.valor > @i_param1 or @i_param1 is null
      order by A.valor
      set transaction isolation level read uncommitted
   end
end
if @i_operacion = 'V'
begin
      set rowcount 0
      select A.valor 
   from cobis..cl_catalogo A, cobis..cl_tabla B
   where B.tabla = 'cu_des_aseguradora'
   and   A.tabla = B.codigo 
   and A.codigo = @i_aseguradora 
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

      if @w_rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901005
         return 1 
      end 
end

go