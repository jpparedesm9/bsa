/************************************************************************/
/*	Archivo: 		industriac.sp                           */
/*	Stored procedure: 	sp_industriac                           */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTABILIDAD                            */
/*	Disenado por:           Wladimir Ruiz G.                        */
/*	Fecha de escritura:     07/Mayo/2004                            */
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/* Permite obtener un secuencial cuando se ejecuta un certificado en la */
/* las hojas Excel de Contabilidad.                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	07-Mayo-04	W. Ruiz 	Tuning				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_industriac')
	drop proc sp_industriac
go

create proc sp_industriac (	
        @s_ssn                  int             = NULL,
        @s_user                 login           = NULL,
        @s_term                 varchar(30)     = NULL,
        @s_date                 datetime        = NULL,
        @s_sesn                 int             = NULL,
        @s_ssn_branch           int             = null, 
        @s_srv                  varchar(30)     = NULL,
        @s_lsrv                 varchar(30)     = NULL,
        @s_ofi                  smallint        = NULL,
        @s_rol                  smallint        = NULL,
        @t_debug                char(1)         = 'N',
        @t_file                 varchar(10)     = NULL,
        @t_from                 varchar(32)     = NULL,
        @t_trn                  smallint        = NULL,                              
        @i_fecha_ini            datetime        = NULL,
	@i_fecha_fin            datetime        = NULL 	
)
as


/*DECLARACION DE VARIABLES TEMPORALES*/
declare @w_sp_name              varchar(32),
        @w_return		int,      
        @w_fecha_ini            datetime, 
	@w_fecha_fin            datetime,
	@w_oficina              smallint,
	@w_area                 smallint,
	@w_anio                 tinyint,
	@w_mes                  tinyint,
	@w_partanio             varchar(5),	
	@w_tipoid               varchar(10),
        @w_ced_ruc              varchar(20),
        @w_ente                 int,
        @w_nom_ente             varchar(50),
        @w_batch                int,
        @saldo                  money,
        @w_cuenta               cuenta_contable



/*INICIALIZACION DE VARIABLES TEMPORALES*/
select @w_sp_name    = 'sp_industriac'



	select @w_batch = ba_batch
	from cobis..ba_batch
	where ba_nombre = 'INDUSTRIA Y COMERCIO'
	if @@rowcount = 0
	begin
	    	exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                       		      @t_from=@w_sp_name, @i_num = 601159
    		return  1
	end


	set rowcount 1
		select  @w_oficina = in_oficina, 
		        @w_tipoid  = in_tipodoc,
		        @w_ced_ruc = in_identi 			
		from cob_conta..cb_induscomer
		order by in_oficina
	set rowcount 0

	
	select  @w_mes  = DATEPART(month, @i_fecha_fin)
	select  @w_partanio = SUBSTRING (convert (varchar(5), DATEPART(year, @i_fecha_fin) ), 3, 2)
	select  @w_anio= convert(tinyint,@w_partanio)	


	while 1=1
	  begin                	  

		
		declare cursor_cuenta cursor
		for select cp_cuenta
			from cob_conta..cb_cuenta_proceso
			where cp_proceso = @w_batch
			order by cp_cuenta

		open  cursor_cuenta
		fetch cursor_cuenta into @w_cuenta				
  		  		
  		WHILE @@fetch_status =0
		begin
					
			if @@fetch_status = -1
			begin
				close cursor_producto
				deallocate cursor_producto
				raiserror (N'200001 - Fallo lectura del cursor', 16, 1)
				return 0
			end          	
  
                       
		        --------------------------------------------------
		  	--PERMITE OBTENER SALDOS DE LAS DIFERENTES CUENTAS
	  		--------------------------------------------------	                  
                	exec	@saldo       = sp_saldo
	                        @t_trn	     =6005,
				@i_empresa   =1,
				@i_oficina   =@w_oficina,
				@i_area	     =255,
				@i_fecha     =@i_fecha_fin,
				@i_cuenta    =@w_cuenta,
				@i_operacion ='K',
				@i_anio	     =@w_anio,
                        	@i_mes	     =@w_mes,
				@i_fecha_ant =@i_fecha_ini				
								
	        	------------------------------------------	
			--PERMITE OBTENER INFORMACION DEL TERCERO
			------------------------------------------
			exec	sp_terceros
				@t_trn	       =6991,
				@i_operacion   ='Q',
				@i_empresa     =1,
				@i_ced_ruc     =@w_ced_ruc,
				@i_tipoid      =@w_tipoid,
				@i_modo	       =1,
				@o_ente	       =@w_ente out,
	                        @o_nom_ente    =@w_nom_ente out											


			-----------------------------------------------	
			--BORRADO DE REGISTRO EN LA TABLA cb_induscomer
			-----------------------------------------------	
                        delete cb_ifiduscomer

		        --------------------------------------------	
			--INSERTA REGISTRO EN LA TABLA cb_induscomer
			--------------------------------------------    	    	    	  								
			insert into cb_ifiduscomer (if_oficina, if_cuenta   ,if_cod_ente,if_nom_ente,	
				                    if_valor  ,	if_fecha_ini,if_fecha_fin            
				                   )
				           values  (@w_oficina, @w_cuenta   ,@w_ente    ,@w_nom_ente,
						    @saldo    , @i_fecha_ini,@i_fecha_ini            
						   )			           
			if @@error <> 0 
         	  	begin
         			/* Error en insercion de registro */
             			exec cobis..sp_cerror
             			@t_debug = @t_debug,
             			@t_file  = @t_file, 
             			@t_from  = @w_sp_name,
             			@i_num   = 601162 
             			return 1 
         	  	end						         	  	


		end --WHILE @@fetch_status =0

		
				
		set rowcount 1
			select  @w_oficina = in_oficina, 
		        	@w_tipoid  = in_tipodoc,
		        	@w_ced_ruc = in_identi 			
			from cob_conta..cb_induscomer
			where   in_oficina > @w_oficina
			order by in_oficina
			if @@rowcount = 0 
			 begin
			   set rowcount 0					
			   break			
			 end   			
		set rowcount 0					

	  end 	--FIN WHILE


return 0
go

