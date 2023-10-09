/*************************************************************************/
/*	Archivo:		moneda_cr.sql	                 	 */
/*	Stored procedure:	sp_moneda_cr				 */
/*	Base de datos:		cobis                                    */
/*	Producto: 	        CLIENTES                                 */
/*	Disenado por:  	        Pedro Rafael Montenegro Rosales          */
/*	Fecha de escritura:	10/Ago/2012                              */
/*********************************************************************** */
/*				IMPORTANTE                               */
/*********************************************************************** */
/*	Este programa es parte de los paquetes bancarios propiedad de    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la        */
/*	"NCR CORPORATION".			                         */
/*	Su uso no autorizado queda expresamente prohibido asi como       */
/*	cualquier alteracion o agregado hecho por alguno de sus          */
/*	usuarios sin el debido consentimiento por escrito de la          */
/*	Presidencia Ejecutiva de MACOSA o su representante.              */
/*********************************************************************** */
/*				PROPOSITO	                         */
/*********************************************************************** */
/*	Este stored procedure es un sp interceptor para las acciones de	 */
/*	consulta del catalogo de moneda					 */
/*				MODIFICACIONES                           */
/*	FECHA		AUTOR		RAZON		NEMONICO         */
/*  11-04-2016  BBO          Migracion Sybase-Sqlserver FAL             */
/*************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_moneda_cr')
   drop proc sp_moneda_cr
go

create proc sp_moneda_cr
(
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(32) 	= NULL,
	@s_date			datetime 	= NULL,
	@s_srv			varchar(30) 	= NULL,
	@s_lsrv			varchar(30) 	= NULL, 
	@s_rol			smallint 	= NULL,
	@s_ofi			smallint 	= NULL,
	@s_org_err		char(1) 	= NULL,
	@s_error		int 		= NULL,
	@s_sev			tinyint 	= NULL,
	@s_msg			descripcion 	= NULL,
	@s_org			char(1) 	= NULL,
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= null,

	@t_show_version		bit         	= 0, -- Mostrar la version del programa  --(PRMR STANDAR)

        @i_operacion		char(2),
        @i_modo			tinyint 	= null,
        @i_tipo			char(2) 	= null,
        @i_moneda		tinyint 	= null
)
as
declare @w_sp_name	varchar(32)

select @w_sp_name = 'sp_moneda_cr'

	/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
	if @t_show_version = 1
	begin
		print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
		return 0
	end


	/* Search */
	if @i_operacion = 'S'
	begin
		if @t_trn = 1555
		begin
			set rowcount 20
			if @i_modo = 0
				select  'Codigo' = mo_moneda,
					'Moneda' = convert(char(20),mo_descripcion),
					'Simbolo'= mo_simbolo,
					'Nemonico'= mo_nemonico,		   
					'Cod. Pais' =  mo_pais,
					'Pais' =convert(char(20),pa_descripcion),
					'Estado' = mo_estado,
					'Decimales' = mo_decimales, 
					'Cod. Cta Unico' = mo_cod_ctaunico
				from   cl_moneda, cl_pais
				where  pa_pais = mo_pais
				order  by mo_moneda
   		else
   		if @i_modo = 1
				select  'Codigo' = mo_moneda,
					'Moneda' = convert(char(20),mo_descripcion),
					'Simbolo'= mo_simbolo,
					'Nemonico'= mo_nemonico,		   
					'Cod. Pais' =  mo_pais,
					'Pais' =convert(char(20),pa_descripcion),
					'Estado' = mo_estado,
					'Decimales' = mo_decimales, 
					'Cod. Cta Unico' = mo_cod_ctaunico
				from   cl_moneda, cl_pais
				where  pa_pais = mo_pais
          			and  mo_moneda > @i_moneda
				order  by mo_moneda

	        if @@rowcount = 0
		begin
        		exec sp_cerror
		                @t_debug        = @t_debug,
                		@t_file         = @t_file,
		                @t_from         = @w_sp_name,
                		@i_num          = 101000
			        /*    'No existe dato en catalogo'*/
			return 101000
		end

		set rowcount 0
		return 0
	end
	else
	begin
		exec sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151051
			/*  'No corresponde codigo de transaccion' */
		return 151051
	end
end


go
