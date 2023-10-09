/************************************************************************/
/*	Archivo: 		imptosdeptales.sp                       */
/*	Stored procedure: 	sp_imptosdeptales     			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Jose Orlando Forero                   	*/
/*	Fecha de escritura:     25-Noviembre-2002			*/
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
/*	Mantenimiento al catalogo de Impuestos Departamentales.         */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_imptosdeptales')
	drop proc sp_imptosdeptales
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_imptosdeptales(
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_codigo		char(4) = null,
	@i_descripcion		varchar(255) = null,
	@i_base_ini		money = 0,
	@i_base_fin		money = 0,
	@i_porcentaje		float = 0,
	@i_depto		int = null,
	@i_debcred		char(1) = null,
	@i_siguiente            int = null,
	@i_ofic_destino		smallint = null,
	@i_cuenta		cuenta=null,
	@i_codig_est		varchar(10)=null
)
as

declare
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_asociada	varchar(10),
	@w_ciudad	smallint,
	@w_exento	tinyint,
	@w_depto	int,
	@w_oficina_admin smallint,
	@w_ciudad_admin int
	
select @w_sp_name = 'sp_imptosdeptales'


if (@t_trn <> 6252 and @i_operacion = 'I') or
   (@t_trn <> 6253 and @i_operacion = 'U') or
   (@t_trn <> 6254 and @i_operacion = 'D') or
   (@t_trn <> 6255 and @i_operacion = 'A') or
   (@t_trn <> 6256 and @i_operacion = 'V') or
   (@t_trn <> 6256 and @i_operacion = 'S') or
   (@t_trn <> 6999 and @i_operacion = 'Z') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_modo 		= @i_modo,
		i_codigo 	= @i_codigo,
		i_base_ini	= @i_base_ini,
		i_base_fin	= @i_base_fin,
		i_porcentaje	= @i_porcentaje,
		i_depto		= @i_depto,
		i_debcred	= @i_debcred
	exec cobis..sp_end_debug
end



if @i_operacion = 'I'
begin
	if exists (select 1 from cb_imptos_deptales, cobis..cl_provincia
		where id_empresa = @i_empresa
		and id_codigo = @i_codigo
		and id_debcred = @i_debcred
		and id_depto = @i_depto
		and id_depto = pv_provincia
		and pv_pais = 1
		and pv_estado = 'V')
	begin
		/* 'Ya existe provincia' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151073
		return 1
	end
	else
	begin
		insert into cb_imptos_deptales
			(id_empresa,id_codigo,id_debcred,id_depto,id_descripcion,
			id_base_ini,id_base_fin,id_porcentaje)
		values
			(@i_empresa,@i_codigo,@i_debcred,@i_depto,@i_descripcion,
			@i_base_ini,@i_base_fin,@i_porcentaje)
		if @@error <> 0 
		begin
			/* 'Error en creacion de departamento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 103043
			return 1
		end
	end
	return 0
end



if @i_operacion = 'U'
begin
	if exists (select 1 from cb_imptos_deptales, cobis..cl_provincia
		where id_empresa = @i_empresa
		and id_codigo = @i_codigo
		and id_depto = @i_depto
		and id_depto = pv_provincia
		and pv_pais = 1
		and pv_estado = 'V')
	begin
		update cb_imptos_deptales
		set	id_descripcion	= @i_descripcion,
			id_base_ini	= @i_base_ini,
			id_base_fin	= @i_base_fin,
			id_porcentaje	= @i_porcentaje
		where id_empresa = @i_empresa
		and id_codigo = @i_codigo
		and id_debcred = @i_debcred
		and id_depto = @i_depto
		if @@error <> 0 
		begin
			/* 'Error en actualizacion de departamento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 105038
			return 1
		end
	end
	else
	begin
		/* 'No existe dato en catalogo' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 101000
		return 1
	end
	return 0
end



if @i_operacion = 'D'
begin
	if exists (select 1 from cb_imptos_deptales, cobis..cl_provincia
		where id_empresa = @i_empresa
		and id_codigo = @i_codigo
		and id_debcred = @i_debcred
		and id_depto = @i_depto
		and id_depto = pv_provincia
		and pv_pais = 1
		and pv_estado = 'V')
	begin
		delete cb_imptos_deptales
		where id_empresa = @i_empresa
		and id_codigo = @i_codigo
		and id_debcred = @i_debcred
		and id_depto = @i_depto
		if @@error <> 0 
		begin
			/* 'Error en eliminacion de departamento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 107004 --107043
			return 1
		end
	end
	else
	begin
		/* 'No existe dato en catalogo' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 101000
		return 1
	end
	return 0
end



if @i_operacion = 'A'
begin

	create table #imptos_deptales
	    (   id_secuencial   numeric(10,0) identity not null,
	        id_codigo       catalogo,        
		id_descripcion  descripcion,     
		id_base_ini     money,           
		id_base_fin     money,           
		id_porcentaje   float,           
		id_depto        int,             
		pv_descripcion  varchar(64),
		id_debcred      char        
	    )			
	
	insert into #imptos_deptales
		select distinct 
		'CODIGO'	= id_codigo,
		'DESCRIPCION'	= id_descripcion,
		'BASE INI'	= id_base_ini,
		'BASE FIN'	= id_base_fin,
		'PORCENTAJE'	= id_porcentaje,
		'COD. DEPTO'	= id_depto,
		'DEPARTAMENTO'	= pv_descripcion,
		'DEB/CRED'	= id_debcred
		from cb_imptos_deptales, cobis..cl_provincia
		where id_empresa = @i_empresa
		and id_depto = pv_provincia
		and pv_pais = 1
		and pv_estado = 'V'
		order by id_codigo,id_debcred,id_depto				
	
	
	set rowcount 20
	if @i_modo = 0
	begin				
		select 		
			'CODIGO'	= id_codigo,
			'DESCRIPCION'	= id_descripcion,
			'BASE INI'	= id_base_ini,
			'BASE FIN'	= id_base_fin,
			'PORCENTAJE'	= id_porcentaje,
			'COD. DEPTO'	= id_depto,
			'DEPARTAMENTO'	= pv_descripcion,
			'DEB/CRED'	= id_debcred,
                	'Secuencial'    = convert(int,id_secuencial)
		from #imptos_deptales
		order by id_secuencial				
		
	end
	else
	begin			
	
		select 		
			'CODIGO'	= id_codigo,
			'DESCRIPCION'	= id_descripcion,
			'BASE INI'	= id_base_ini,
			'BASE FIN'	= id_base_fin,
			'PORCENTAJE'	= id_porcentaje,
			'COD. DEPTO'	= id_depto,
			'DEPARTAMENTO'	= pv_descripcion,
			'DEB/CRED'	= id_debcred,
                	'Secuencial'    = convert(int,id_secuencial)
		from #imptos_deptales		
		where convert(int,id_secuencial) > @i_siguiente
		order by id_secuencial				
						
	end
	set rowcount 0
	return 0
end



if @i_operacion = 'V'
begin
	/* VALIDACION DE DATOS */
	if @i_empresa  is NULL or
	   @i_codigo   is NULL or
	   @i_debcred  is NULL or
	   @i_depto    is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

	select id_descripcion
	from cob_conta..cb_imptos_deptales
	where id_empresa = @i_empresa
	and id_codigo = @i_codigo
	and id_debcred = @i_debcred
	and id_depto = @i_depto
	if @@rowcount = 0
	begin
		/* 'Registro No Existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601159
		return 1
	end
end

set rowcount 0

if @i_operacion = 'S'
begin
	select distinct id_descripcion
	from cob_conta..cb_imptos_deptales
	where id_empresa = @i_empresa
	and id_codigo = @i_codigo
	if @@rowcount = 0
	begin	/* 'Registro No Existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601159
		return 1
	end
end

/*****OPERANCION Z***/

if @i_operacion = 'Z'

begin
        set rowcount 20
	 select @w_oficina_admin = re_ofadmin
             from cob_conta..cb_relofi,cobis..cl_oficina
             where
                re_ofconta = @i_ofic_destino
                and re_ofadmin = of_oficina
                and of_subtipo = 'O' 
	              
	if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 607132
                return 1
             end

         /* averigua la ciudad de la oficina admin  */

	select @w_ciudad_admin = of_ciudad
           from cobis..cl_oficina
           where
              of_oficina = @w_oficina_admin
	
	if @@rowcount = 0
    	   begin
         /*  No existen registros */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 601159
             return 1
           end
           
	select @w_depto= ci_provincia
	from cobis..cl_ciudad
	where ci_ciudad= @w_ciudad_admin
	and ci_estado='V'
	
	if @@rowcount = 0
	   begin
           /*No existen registros */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 601159
             return 1
           end
	
	--print 'oficina admin:%1! - ciudad:%2! provincia:%3!', @w_oficina_admin , @w_ciudad_admin, @w_depto
	if @i_modo = 0
	begin
	set rowcount 20
	select 
	'CODIGO'= 	  b.id_codigo,
	'DESCRIPCION'= 	  substring(b.id_descripcion,1,30),
	'BASE INICIAL'=	  convert(money, b.id_base_ini),
	'BASE FINAL'=	  convert(money, b.id_base_fin),
	'PORCENTAJE'= 	  b.id_porcentaje,
	'DEPARTAMENTO'=   b.id_depto,
	'DESCRIP.DEPTO '= substring(a.pv_descripcion,1,20)
	from cobis..cl_provincia a, cob_conta..cb_imptos_deptales b, cb_cuenta_proceso c
	where c.cp_empresa=b.id_empresa
		and b.id_empresa=@i_empresa
		and b.id_codigo=convert(char(10), c.cp_condicion)
		and b.id_codigo>='0'
		and b.id_depto=a.pv_provincia
		and id_debcred=@i_debcred
		and b.id_depto = @w_depto
		and a.pv_provincia=@w_depto
		and c.cp_cuenta=@i_cuenta
		and a.pv_provincia=b.id_depto
		and cp_proceso=6004
		order by b.id_codigo

	     if @@rowcount = 0
    	     begin
            /*No existen registros */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601159
              return 1
             end
	end
	if @i_modo = 1
	begin
	set rowcount 20
	select
	        'CODIGO'= 	  b.id_codigo,
		'DESCRIPCION'= 	  substring(b.id_descripcion,1,30),
		'BASE INICIAL'=	  convert(money, b.id_base_ini),
		'BASE FINAL'=	  convert(money, b.id_base_fin),
		'PORCENTAJE'= 	  b.id_porcentaje,
		'DEPARTAMENTO'=	  b.id_depto,
		'DESCRIP.DEPTO'= substring(a.pv_descripcion,1,20)
	from cobis..cl_provincia a, cob_conta..cb_imptos_deptales b, cb_cuenta_proceso c
	where c.cp_empresa=b.id_empresa
		and b.id_empresa=1
		and b.id_codigo=convert(varchar(10), c.cp_condicion)
		and b.id_codigo>=@i_codig_est
		and b.id_depto=a.pv_provincia
		and b.id_depto = @w_depto
		and b.id_debcred=@i_debcred
		and a.pv_provincia=@w_depto
		and c.cp_cuenta=@i_cuenta
		and a.pv_provincia=b.id_depto
		and cp_proceso=6004
	order by b.id_codigo
	
	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
              end  
        end    
        if @i_modo = 2
        begin
	set rowcount 20
	select 
	'CODIGO'= 	  b.id_codigo,
	'DESCRIPCION'= 	  substring(b.id_descripcion,1,30),
	'BASE INICIAL'=	  convert(money, b.id_base_ini),
	'BASE FINAL'=	  convert(money, b.id_base_fin),
	'PORCENTAJE'= 	  b.id_porcentaje
	from cobis..cl_provincia a, cob_conta..cb_imptos_deptales b, cb_cuenta_proceso c
	where c.cp_empresa=b.id_empresa
		and b.id_empresa=@i_empresa
		and b.id_codigo=convert(char(10), c.cp_condicion)
		and b.id_codigo=@i_codigo
		and b.id_depto=a.pv_provincia
		and id_debcred=@i_debcred
		and b.id_depto = @w_depto
		and a.pv_provincia=@w_depto
		and c.cp_cuenta=@i_cuenta
		and a.pv_provincia=b.id_depto
		and cp_proceso=6004
	order by b.id_codigo

        if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
         end 
      end
             
	return 0
end

go
