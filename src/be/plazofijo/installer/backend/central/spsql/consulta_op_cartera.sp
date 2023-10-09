/************************************************************************/
/*	Archivo:		conopcar.sp.				*/
/*	Stored procedure:	sp_consulta_op_cartera              	*/
/*	Base de datos:		cob_pfijo                               */
/*	Producto: Plazo Fijo                     			*/
/*	Disenado por:  Ximena Cartagena					*/
/*	Fecha de escritura: 13-Ago-2006					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa la consulta de operaciones                */
/*									*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/* Ago/13/05	  Gabriela Arboleda   Emision Inicial                   */ 
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_op_cartera')
   drop proc sp_consulta_op_cartera
go

create proc sp_consulta_op_cartera(
   @s_ssn          int         = null,
   @s_user         login       = null,
   @s_term         varchar(30) = null,
   @s_date         datetime    = null,
   @s_srv          varchar(30) = null,
   @s_lsrv         varchar(30) = null,
   @s_ofi          smallint    = null,
   @s_org          char(1)     = null,
   @t_debug        char(1)     = 'N',
   @t_file         varchar(10) = null,
   @t_from         varchar(32) = null,
   @t_trn          int         = null,
   @i_operacion    char(1)     = 'H',
   @i_producto     tinyint     = null,
   @i_cliente      int         = null,
   @i_cuenta       cuenta      = null,
   @i_modo         int         = null,
   @i_moneda       int,
   @i_fecha_proceso datetime   = null)
with encryption
as
declare
   @w_return      int,
   @w_sp_name     varchar(32),
   @w_operacionca int,		--LIM 17/ENE/2006
   @w_monto       money		--LIM 17/ENE/2006
        


select @w_sp_name = 'sp_consulta_op_cartera'

if @t_trn <> 14993
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 161500
   return 1
end

if @i_operacion = 'H'
begin   
   exec @w_return    = cob_interfase..sp_icartera
        @i_operacion = 'E',
        @i_cliente   = @i_cliente,
        @i_moneda    = @i_moneda,
        @i_modo      = @i_modo,
        @i_cuenta    = @i_cuenta
		
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1
      return 1
   end
end
else
if @i_operacion = 'O' and @i_producto = 7		--LIM 17/ENE/2006 Obtiene No. OP. Cartera
begin
   
   exec @w_return      = cob_interfase..sp_icartera
        @i_operacion   = 'D',
        @i_cuenta      = @i_cuenta,
		@o_operacionca = @w_operacionca out
		
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1
      return 1
   end

   if @i_modo = 0
   begin
      exec @w_return    = cob_interfase..sp_icartera
           @i_operacion = 'F',
		   @o_monto     = @w_monto out
		   
      if @w_return <> 0
	  begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 1
         return 1
      end
   end
   else
   if @i_modo = 1
   begin   
      exec @w_return    = cob_interfase..sp_icartera
           @i_operacion = 'F',
		   @o_saldo     = @w_monto out
		   
      if @w_return <> 0
	  begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 1
         return 1
      end
   end
   select @w_monto
end
else 
begin
   exec @w_return    = cob_interfase..sp_icartera
        @i_operacion = 'E',
		@i_cuenta    = @i_cuenta,
        @i_moneda    = @i_moneda,
        @i_modo      = 3        
		
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1
      return 1
   end
end


return 0
go

