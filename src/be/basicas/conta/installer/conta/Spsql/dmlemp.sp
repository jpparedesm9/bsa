/************************************************************************/
/*	Archivo: 		dmlemp.sp				*/
/*	Stored procedure: 	sp_dmlemp 				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento al catalogo de Empresas                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	14/Mar/1995	M.Suarez        Debe Crear secuencia para cada  */
/*                                      empresa nueva                   */
/*	15/Nov/1995	J.Linero        Personalizacion COFIANDINA      */
/*	22/Ene/1997	F.Salgado	Personalizacion CajaCoop	*/
/*					FS001: Ampliar campo abreviatu- */
/*					ra a char(16)			*/
/*					Inclusion de registro cb_tercero*/ 
/*					en cb_seqnos			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_dmlemp')
	drop proc sp_dmlemp     

go
create proc sp_dmlemp     (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 603,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_descripcion	descripcion = null,
	@i_ruc		char(10) = null,
	@i_replegal	descripcion = null,
	@i_contgen	descripcion = null,
	@i_moneda_base	tinyint  = null,
	@i_direccion	char(120) = null,
	@i_abreviatura	char(16) = null, /* FS001 */	
	@i_revisor 	descripcion = null,
	@i_matcontgen 	char(10) = null,
	@i_matrevisor 	char(10) = null,
	@i_emprevisor	descripcion = null,
	@i_nit_emprev varchar (160)=null,
	@i_mat_emprev	char(13)=null
)
as 
declare @w_today 	datetime,  	/* fecha del dia */ 
	@w_return	int,		/* valor que retorna */ 
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de empresa */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una empresa */

	@w_empresa	tinyint ,	/* codigo de empresa */
	@w_descripcion	descripcion ,	/* descripcion       */	
	@w_ruc		char(10) ,	/* numero de ruc     */
	@w_replegal	descripcion ,	/* representante legal*/
	@w_contgen	descripcion ,	/* contador general  */
	@w_matcontgen	char(10),       /* Matricula del Contador Gral */
	@w_revisor 	descripcion ,	/* Revisor Cofiandina   */
	@w_matrevisor	char(10),       /* Matricula del Revisor */
	@w_direccion	char(120),
	@w_moneda_base	tinyint,
	@w_abreviatura	char(16),	/* FS001 */
     

	@w_strsigue	char(4),
	@w_longitud	tinyint,
	@w_nmoneda	descripcion,
	@w_ntipo	descripcion,
	@w_mascara	char(16),	/* mascara de niveles de organizacion*/
	@w_rows		int,
	@w_flag1	int ,
	@w_contador	int,
	@w_nivel_plan	int

select @w_today = getdate()
select @w_sp_name = 'sp_dmlemp'

/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6031 and @i_operacion = 'I') or
   (@t_trn <> 6032 and @i_operacion = 'U') or
   (@t_trn <> 6033 and @i_operacion = 'D') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_descripcion	= @i_descripcion,
		i_ruc		= @i_ruc,
		i_replegal	= @i_replegal,
		i_contgen	= @i_contgen,
		i_moneda_base	= @i_moneda_base ,
		i_matcontgen	= @i_matcontgen,
		i_revisor	= @i_revisor,
		i_matrevisor	= @i_matrevisor


	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = em_empresa,
		@w_descripcion = em_descripcion,
		@w_ruc	= em_ruc,
		@w_replegal = em_replegal,
		@w_contgen = em_contgen,
		@w_direccion = em_direccion,
		@w_moneda_base = em_moneda_base,
		@w_abreviatura = em_abreviatura,
		@w_nmoneda = mo_descripcion ,
                @w_matcontgen = em_matcontgen,
                @w_revisor    = em_revisor   ,
                @w_matrevisor = em_matrevisor
	from cob_conta..cb_empresa,cobis..cl_moneda
	where em_empresa = @i_empresa and
	      mo_moneda = em_moneda_base 
	
	if @@rowcount > 0 
		select @w_existe = 1
	else 
		select @w_existe = 0
end
	
	


/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	if NOT EXISTS (select * from cobis..cl_moneda   
			where mo_moneda = @i_moneda_base
		      )
	begin
		/* 'No existe el codigo de moneda especificado' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601094
		return 1
	end

	if @i_operacion = 'I'
	begin
        	if EXISTS (select em_ruc from cb_empresa
	  		   where em_ruc = @i_ruc
		  	  )
		begin
			/* 'Codigo de empresa ya existe           ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601003
			return 1
		end
	end
end

/* Insercion de empresas */
/*************************/

if @i_operacion = 'I'
begin
	exec @w_return = cob_conta..sp_cseqnos @i_tabla = 'cb_empresa',
			@o_siguiente = @w_siguiente out
	if @w_return <> 0
		return @w_return
	else
		select @w_siguiente

	if @w_existe = 1 
	begin
		/* 'Codigo de empresa ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601002
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_empresa
			(em_empresa,            em_descripcion,                em_ruc,
			 em_replegal,    		em_contgen,                    em_direccion,                  
			 em_moneda_base,  	    em_abreviatura,                em_matcontgen,
			 em_revisor, 		    em_matrevisor,                 em_emp_revisor,
			 em_nit_emprev,		    em_mat_revisor)		
    values (@w_siguiente,           @i_descripcion,               @i_ruc, 
            @i_replegal,			@i_contgen,                   @i_direccion, 
            @i_moneda_base,			@i_abreviatura,               @i_matcontgen,
			@i_revisor,             @i_matrevisor,                @i_emprevisor,
			@i_nit_emprev,          @i_mat_emprev)
			
		if @@error <> 0 
		begin
			/* 'Error en Insercion de Empresa         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603001
			return 1
		end
		exec @w_return = cob_conta..sp_asoemp
			@s_ssn,@s_date,@s_user,@s_term,@s_corr,@s_ssn_corr,
			@s_ofi,@t_rty,6261,
			'N',NULL,NULL,@i_operacion,NULL,@w_siguiente,
			@i_descripcion

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de tablas relacionadas con el catalogo de empresas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603030
			return 1
		end

		/****************************************/
		exec @w_return = cob_conta..sp_cseqnos 
                                 @i_tabla = 'cb_comprobante',
                                 @i_empresa = @w_siguiente,
                                 @i_pkey  = 'co_comprobante',
                                 @i_operacion = 'I'

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de secuencias' */
			return 1
		end
		exec @w_return = cob_conta..sp_cseqnos 
                                 @i_tabla = 'cb_comp_tipo',
                                 @i_empresa = @w_siguiente,
                                 @i_pkey  = 'ct_comp_tipo',
                                 @i_operacion = 'I'

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de secuencias' */
			return 1
		end

		exec @w_return = cob_conta..sp_cseqnos 
                                 @i_tabla = 'cb_item',
                                 @i_empresa = @w_siguiente,
                                 @i_pkey  = 'it_item',
                                 @i_operacion = 'I'

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de secuencias' */
			return 1
		end

		exec @w_return = cob_conta..sp_cseqnos 
                                 @i_tabla = 'cb_temporal',
                                 @i_empresa = @w_siguiente,
                                 @i_pkey  = 'sec_tempo',
                                 @i_operacion = 'I'

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de secuencias' */
			return 1
		end

		exec @w_return = cob_conta..sp_cseqnos 
                                 @i_tabla = 'cb_tercero',
                                 @i_empresa = @w_siguiente,
                                 @i_pkey  = 'te_cons',
                                 @i_operacion = 'I'

		if @w_return <> 0
		begin
			/* 'error en la insercion automatica de secuencias' */
			return 1
		end
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_empresa
		values (@s_ssn,          @t_trn,          'N',         @s_date,
		        @s_user,         @s_term,         @s_ofi,      @w_siguiente,
		        @i_ruc,          @i_descripcion,  @i_replegal, @i_contgen,
		        @i_moneda_base,  @i_direccion,    @i_emprevisor,@i_nit_emprev,
		        @i_mat_emprev)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

	commit tran
return 0
end

/* Actualizacion de empresas  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de empresa a actualizar NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605001
		return 1
	end


	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_empresa
		set 	em_descripcion = @i_descripcion,
			em_ruc = @i_ruc,
			em_replegal    = @i_replegal,
			em_contgen     = @i_contgen,
			em_moneda_base = @i_moneda_base,
			em_direccion   = @i_direccion,
			em_abreviatura = @i_abreviatura,
			em_matcontgen  = @i_matcontgen,
			em_revisor     = @i_revisor,
			em_matrevisor  = @i_matrevisor,
            em_emp_revisor = @i_emprevisor,
			em_nit_emprev  = @i_nit_emprev,          
			em_mat_revisor = @i_mat_emprev			
		where em_empresa = @i_empresa	

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Empresa     ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605002
			return 1
		end

                /* Actualizacion de la descripcion de la oficina 255 */

		exec @w_return = cob_conta..sp_asoemp
			@s_ssn,@s_date,@s_user,@s_term,@s_corr,@s_ssn_corr,
			@s_ofi,@t_rty,6262,
			@t_debug,NULL,NULL,@i_operacion,NULL,@i_empresa,
			@i_descripcion

		if @w_return <> 0
		begin
			/* 'error en la modificacion automatica de tablas relacionadas con el catalogo de empresas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603030
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_empresa
		values (@s_ssn,          @t_trn,          'N',         @s_date,
		        @s_user,         @s_term,         @s_ofi,      @w_siguiente,
		        @i_ruc,          @i_descripcion,  @i_replegal, @i_contgen,
		        @i_moneda_base,  @i_direccion,    @i_emprevisor,@i_nit_emprev,
		        @i_mat_emprev)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
		insert into ts_empresa
		values (@s_ssn,          @t_trn,          'N',         @s_date,
		        @s_user,         @s_term,         @s_ofi,      @w_siguiente,
		        @i_ruc,          @i_descripcion,  @i_replegal, @i_contgen,
		        @i_moneda_base,  @i_direccion,    @i_emprevisor,@i_nit_emprev,
		        @i_mat_emprev)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

	commit tran
	return 0
end

/* Eliminacion de empresas  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de empresa a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607001
		return 1
	end

	begin tran
--		exec @w_return = cob_conta..sp_delpgen
--		@s_ssn,@s_date,@s_user,@s_term,@s_corr,@s_ssn_corr,
--		@s_ofi,@t_rty,6078,
--		null,null,null,'R',0,@i_empresa,null,null,null

--		if @w_return <> 0
--		begin
--			/* 'Error en eliminacion de cuentas al eliminar Empresa' */
--			exec cobis..sp_cerror
--			@t_debug = @t_debug,
--			@t_file	 = @t_file,
--			@t_from	 = @w_sp_name,
--			@i_num	 = 607091
--			return 1
--		end

		delete cb_oficina
		where of_empresa = @i_empresa
		if @w_return <> 0
		begin
			/* 'Error en eliminacion de Oficinas al eliminar empresa' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607092
			return 1
		end

		exec @w_return = cob_conta..sp_organizacion
		@s_ssn,@s_date,@s_user,@s_term,@s_corr,@s_ssn_corr,
		@s_ofi,@t_rty,6058,
		null,null,null,'R',0,@i_empresa,null,null 

		if @w_return <> 0
		begin
		/* 'Error en eliminacion de organizacion al eliminar Empresa' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607089
			return 1
		end
	/* Eliminacion de las areas y nivel_areas */
		delete cb_area
		where ar_empresa = @i_empresa
		if @w_return <> 0
		begin
			/* 'Error en eliminacion de Areas al eliminar empresa'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607088
			return 1
		end

		exec @w_return = cob_conta..sp_nivel_area
		@s_ssn,@s_date,@s_user,@s_term,@s_corr,@s_ssn_corr,
		@s_ofi,@t_rty,6508,
		null,null,null,'R',0,@i_empresa,null,null 

		if @w_return <> 0
		begin
		/* 'Error en eliminacion de organizacion al eliminar Empresa' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607075
			return 1
		end
	
       	/* Si codigo de empresa existe en catalogo plan general de cuentas
	   No se puede eliminar la empresa */

     		if EXISTS (select pg_empresa
			from cob_conta..cb_plan_general
			where pg_empresa = @i_empresa
			)
		begin
		/* 'Codigo de empresa relacionado con CUENTAS ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607003
			return 1
		end

       	/* Si codigo de empresa existe en catalogo  de cuentas
	   No se puede eliminar la empresa */

     		if EXISTS (select cu_empresa
			from cob_conta..cb_cuenta
			where cu_empresa = @i_empresa
			)
		begin
		/* 'Codigo de empresa relacionado con CUENTAS ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607003
			return 1
		end

       	/* Si codigo de empresa existe en catalogo organizacion
	   No se puede eliminar la empresa */

     		if EXISTS (select or_empresa
			from cob_conta..cb_organizacion
			where or_empresa = @i_empresa
			)
		begin
		/* 'Codigo de empresa relacionado con ORGANIZACION ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607004
			return 1
		end

	/*  Eliminacion del registro  */
	/********************************/


  		delete cob_conta..cb_empresa
		where em_empresa = @i_empresa

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Empresa     ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607002
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_empresa
		values (@s_ssn,          @t_trn,          'N',         @s_date,
		        @s_user,         @s_term,         @s_ofi,      @w_siguiente,
		        @i_ruc,          @i_descripcion,  @i_replegal, @i_contgen,
		        @i_moneda_base,  @i_direccion,    @i_emprevisor,@i_nit_emprev,
		        @i_mat_emprev)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

	commit tran
	return 0
end

go
