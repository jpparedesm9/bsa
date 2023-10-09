/************************************************************************/
/*      Archivo:                archbanc.sp                             */
/*      Stored procedure:       sp_archivo_banco                        */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           O. Escand¢n                             */
/*      Fecha de escritura:     03-MAR-1999                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Maneja la asociaci¢n de las cuentas de una empresa consolidadora*/
/*	a una empresa subsidiaria.					*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        	AUTOR           RAZON                           */
/*      03/MAR/1999  	O. Escand¢n     Emision Inicial                 */
/*      06/JUN/2008     Martha Rey A.   Optimización Conciliac. Bancaria*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_archivo_banco')
	drop proc sp_archivo_banco  

go
create proc sp_archivo_banco   (
	@s_ssn			  int 		= null,
	@s_date			  datetime 	= null,
	@s_user			  login 		= null,
	@s_term			  descripcion 	= null,
	@s_corr			  char(1) 	= null,
	@s_ssn_corr		  int 		= null,
        @s_ofi		  smallint 	= null,
	@t_rty			  char(1) 	= null,
        @t_trn		  smallint 	= 602,
	@t_debug          char(1) 	= 'N',
	@t_file           varchar(14) 	= null,
	@t_from           varchar(30) 	= null,
	@i_modo			  int		= null,
	@i_operacion      char(1) 	= null,
	@i_empresa  	  tinyint 	= null,
	@i_banco 		  char(3) 	= null,
	@i_campo  		  char(3) 	= null,
	@i_inicio   	  smallint 	= null,
	@i_final		  smallint	= null,
	@i_tipo_registro  tinyint   = null
)
as 
declare
	@w_return       int,
	@w_sp_name      varchar(32)

select @w_sp_name = 'sp_archivo_banco'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6241 or @i_operacion <> 'U') and
   (@t_trn <> 6242 or @i_operacion <> 'Q') 
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror 
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_empresa	= @i_empresa,
		i_banco		= @i_banco,
		i_campo		= @i_campo,
		i_inicio	= @i_inicio,
		i_final		= @i_final

	exec cobis..sp_end_debug
end

	
if @i_operacion = 'U'
begin
	update cb_archivo_banco set  ab_inicio 	= @i_inicio,
			   	                 ab_fin     = @i_final
    where  ab_empresa       = @i_empresa
	  and  ab_banco         = @i_banco
	  and  ab_campo         = @i_campo
	  and  ab_tipo_registro = @i_tipo_registro
	return 0
end

if @i_operacion = 'Q'
begin
	select ab_campo,
		   cb_nombre, 
		   ab_inicio,
		   ab_fin
	  from cb_archivo_banco,
		   cb_campos_banco
	 where ab_empresa       = @i_empresa
	   and ab_banco	        = @i_banco
	   and ab_tipo_registro = @i_tipo_registro
	   and cb_codigo        = ab_campo
       and cb_tipo_registro = @i_tipo_registro
	if @@rowcount = 0
	begin
		insert into cb_archivo_banco 
		select @i_empresa,
			@i_banco,
			cb_codigo,
			0,
			0,
			@i_tipo_registro
		from cb_campos_banco  
		where cb_tipo_registro = @i_tipo_registro
	end
	return 0
end
go
