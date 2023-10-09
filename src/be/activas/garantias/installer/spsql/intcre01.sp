/************************************************************************/
/*	Archivo: 	        intcre01.sp                             */ 
/*	Stored procedure:       sp_intcre01                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Enero-1996  				*/
/************************************************************************/
/* 				IMPORTANTE				*/
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
/*	Dado el cliente entrega el total de garantias y otras           */
/*	operaciones, suma de garantias vigentes,propuestas y excepc.    */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Ene/1996   L. Castellanos     Emision Inicial			*/
/*      15/Abr/1998  J. C. Crespo     Aumento de variable de output     */
/*      24/oCT/2002  Gonzalo S.       Nueva Operacion "A"               */ 	
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_intcre01')
drop proc sp_intcre01
go
create proc sp_intcre01  (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,	--no se ocupa
   @i_cliente            int = null, 
   @i_grupo              int = null,
   @i_tipo 		 tinyint = null,	--no se ocupa
   @i_codigo_externo     varchar(64) = null,	--no se ocupa
   @i_opcion             tinyint = null,
   @o_valor1             money = null out
)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_error              int,
   @w_cliente            int,
   @w_nombre             varchar(64),
   @w_apellido1          varchar(64),
   @w_apellido2          varchar(64),
   @w_contador           tinyint,
   @w_ayer               datetime,
   @w_valor              money,
   @w_gar                varchar(64),
   @w_gac                varchar(64),
   @w_gargpe		 varchar(30),  /*GSR 24/oct/2002 */
   @w_avales		 varchar(30),
   @w_c01		 varchar(30),
   @w_docume		 varchar(30),
   @w_vcuacc		 varchar(30),
   @w_garesp		 varchar(30),
   @w_pid_cus		 int
   
select 	@w_pid_cus = @@spid * 100   

select @w_today   = @s_date
select @w_sp_name = 'sp_intcre01'
select @w_ayer    = convert(char(10),dateadd(dd,-1,@s_date),101)

delete cu_cotiz_custo where sesion = @w_pid_cus 



/***********************************************************/
/* CODIGO DE TRANSACCIONES                                */

if (@t_trn <> 19494 and (@i_operacion = 'S' or @i_operacion = 'A'))
begin
   select @w_error = 1901006
   goto error
end


insert into cu_cotiz_custo
(moneda, cotizacion,sesion)               
select
cv_moneda, cv_valor, @w_pid_cus
from cob_conta..cb_vcotizacion a 
where cv_fecha =(select max(cv_fecha)
                 from cob_conta..cb_vcotizacion b 
                 where a.cv_moneda = b.cv_moneda)
and cv_fecha <= @w_today
if @@error <> 0
  begin
      /* NO HAY COTIZACION */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101091
      return 1
   end


if @i_operacion = 'A'
begin
   select @w_gargpe = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'GARGPE' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_avales = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'AVALES' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_c01 = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'C01' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_docume = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'DOCUME' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_vcuacc = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'VCUACC' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_garesp = pa_char
   from cobis..cl_parametro 
   where pa_nemonico = 'GARESP' 
   and pa_producto = 'GAR'
   set transaction isolation level read uncommitted

   select @w_gargpe
   select @w_avales
   select @w_c01
   select @w_docume
   select @w_vcuacc
   select @w_garesp
   
end


  
if @i_operacion = 'S'
begin
   select @w_gar = pa_char + '%' -- TIPOS GARANTIA
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico   = 'GAR'
   set transaction isolation level read uncommitted

   select @w_gac = pa_char + '%' -- TIPOS GARANTIA AL COBRO
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico   = 'GAC'
   set transaction isolation level read uncommitted

   if @i_opcion = 1        -- TOTAL GARANTIAS ADECUADAS POR CLIENTE
   begin
      select @o_valor1      = sum(cu_valor_inicial * isnull(cotizacion,1))
      from cu_custodia,cu_cliente_garantia,
           cu_cotiz_custo
      where cg_ente         = @i_cliente
      and cu_codigo_externo = cg_codigo_externo
      and cu_garante        is null    -- Excluye garantes personales
      and cu_clase_custodia = 'I' 
      and cu_estado         = 'V'
      and moneda            = cu_moneda  
      and sesion            = @w_pid_cus
   end  -- FIN OPCION 1      

end

return 0 
error:

   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = @w_error
   return 1  
go