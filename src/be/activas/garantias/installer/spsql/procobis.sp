/************************************************************************/
/*	Archivo: 	        procobis.sp                             */ 
/*	Stored procedure:       sp_pro_cobis                            */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Luis Castellanos/Rodrigo Garces     	*/
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
/*	Consulta de Productos Cobis                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_pro_cobis')
    drop proc sp_pro_cobis
go
create proc sp_pro_cobis      (
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
   @i_producto		 tinyint = null,
   @i_param1             descripcion = null,
   @i_cond1              descripcion = null,
   @i_param2             descripcion = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_abreviatura        char(3),
   @w_rowcount           int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_pro_cobis'

/***********************************************************/
/* Codigos de Transacciones                                */
if @i_operacion = 'V'
begin
   select pd_descripcion
     from cobis..cl_producto
    where pd_producto = @i_producto
    select @w_rowcount = @@rowcount
    set transaction isolation level read uncommitted

         if @w_rowcount = 0
         begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1901005
           return 1 
         end
end

if @i_operacion = 'A'
begin 
   set rowcount 20
   select "NUMERO PRODUCTO" = pd_producto,
          "NOMBRE PRODUCTO" = substring(pd_descripcion,1,30)
     from cobis..cl_producto
    where (pd_producto > convert(tinyint,@i_param1) or @i_param1 is null)
    set transaction isolation level read uncommitted
end


if @i_operacion = 'O'
begin
   set rowcount 20
   select "PRODUCTO"  = tr_producto,"SECUENCIAL"=tr_numero_op,
          "OPERACION" = tr_numero_op_banco
     from cobis..cl_producto,cob_credito..cr_tramite
    where pd_producto = convert(tinyint,@i_cond1) 
      and pd_abreviatura = tr_producto
      and tr_numero_op is not null
      and (tr_numero_op > convert(int,@i_param2) or @i_param1 is null)  
   order by tr_numero_op
end
go