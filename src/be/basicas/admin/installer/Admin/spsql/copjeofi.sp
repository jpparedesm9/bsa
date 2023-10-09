/************************************************************************/
/*	Archivo:		copjeofi.sp				*/
/*	Stored procedure:	sp_cop_jerar_oficina			*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 09-Sep-1994					*/
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
/*	Este programa procesa la copia de jerarquia departamental de	*/
/*	una oficina existente a una oficina nueva			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	09/Sep/94	C.Rodriguez 	Emision inicial                 */
/*	02/May/95	S. Vinces       Admin Distribuido               */
/************************************************************************/
use cobis
go


if exists (select * from sysobjects where name = 'sp_cop_jerar_oficina')
   drop proc sp_cop_jerar_oficina
go

create proc sp_cop_jerar_oficina (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
	@i_filial	    	tinyint = null,
	@i_oficina_ant	    	smallint = null,
	@i_oficina_nueva	smallint = null,
	@i_central_transmit	varchar(1) = null
)
as
declare
       @w_sp_name	       	varchar(32),
       @w_today                	datetime,
       @w_var                  	int,
       @w_aux		       	tinyint,	
       @w_codigo               	int,
       @w_filial               	tinyint,
       @w_oficina_ant	       	smallint,
       @w_oficina_nueva	       	smallint,
       @w_return	       	int,
       @w_server_logico    	varchar(10),
       @w_num_nodos        	smallint,    
       @w_contador          	smallint,    
       @w_cmdtransrv            varchar(65),
       @w_nt_nombre             varchar(30),
       @w_clave		        int

select @w_today = @s_date
select @w_sp_name = 'sp_cop_jerar_oficina'


/* ** Copiar ** */
if @t_trn = 15105
	begin

		/* La oficina anterior debe tener departamentos */

		select  de_departamento 
    		  from  cl_departamento
		 where  de_oficina = @i_oficina_ant

  		if @@rowcount = 0
  			begin
      				exec sp_cerror  @t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 151055
	  				/*	'Oficina anterior no tiene departamentos'*/
      				return 1
  			end

		/* La oficina nueva no debe tener departamentos */

		select  de_departamento 
    		  from  cl_departamento
   		 where  de_oficina = @i_oficina_nueva

  		if @@rowcount <> 0
  			begin
      				exec sp_cerror  @t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 151056
	  				/*	'Oficina nueva ya tiene departamentos'*/
      				return 1
  			end

		/* chequeo de claves fornaneas */

  		if not exists   ( select  of_filial
		   		    from  cl_oficina
   				   where  of_filial = @i_filial
 		      		     and  of_oficina = @i_oficina_ant)
  			begin
      				exec sp_cerror @t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101016
	   				/*	'No existe oficina'*/
      				return 1
  			end

  		if not exists   ( select  of_filial
		   		    from  cl_oficina
   				   where  of_filial = @i_filial
 		      		     and  of_oficina = @i_oficina_nueva)
  			begin
      				exec sp_cerror @t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101016
	   				/*	'No existe oficina'*/
      				return 1
  			end


 	begin tran

	insert into cl_departamento_tmp 
	select * from cl_departamento where de_oficina = @i_oficina_ant

  	if @@error != 0
  		begin
     			exec sp_cerror 	@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 103004
				/*	'Error en creacion de departamento'*/
     			return 1
  		end

	update cl_departamento_tmp
	   set de_oficina=@i_oficina_nueva
	 where de_oficina=@i_oficina_ant

  	if @@error != 0
  		begin
     			exec sp_cerror 	@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 103004
				/*	'Error en creacion de departamento'*/
     			return 1
  		end

	update cl_departamento_tmp
	   set de_o_oficina=@i_oficina_nueva
	 where de_o_oficina=@i_oficina_ant

  	if @@error != 0
  		begin
     			exec sp_cerror 	@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 103004
				/*	'Error en creacion de departamento'*/
     			return 1
  		end

	insert into cl_departamento 
	select * from cl_departamento_tmp

  	if @@error != 0
  		begin
     			exec sp_cerror 	@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 103004
				/*	'Error en creacion de departamento'*/
     			return 1
  		end

	delete cl_departamento_tmp

  	if @@error != 0
  		begin
     			exec sp_cerror 	@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 103004
				/*	'Error en creacion de departamento'*/
     			return 1
  		end


 	commit tran

 	return 0
	end
else
	begin
		exec sp_cerror  @t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151051
	   	/*  'No corresponde codigo de transaccion' */
		return 1
	end
go

