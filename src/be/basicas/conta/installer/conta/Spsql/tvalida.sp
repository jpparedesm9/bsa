/************************************************************************/
/*	Archivo: 		tvalida.sp			        */
/*	Stored procedure: 	sp_tvalidacion 				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marta Elena Segura                     	*/
/*	Fecha de escritura:     03-Marzo-1999 				*/
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
/*	Este programa es el encargado de la validaci¢n de cuentas	*/ 
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	03/Mar/1999	Juan C. G¢mez	Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_tvalidacion')
	drop proc sp_tvalidacion  

go

create proc sp_tvalidacion (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
	@s_ofi		smallint = null,
	@t_rty		char(1) = null,
	@t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1)  = null,
	@i_comprobante 	int = null,
	@i_empresa 	tinyint = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_empresa	tinyint,
	@w_cuenta	cuenta,
	@w_cta_asoc	cuenta,
	@w_comprobante	int,
	@w_asiento	smallint,
	@w_cuenta2	varchar(2),
	@w_debe		money,
	@w_haber	money,
	@w_debe_me	money,
	@w_haber_me	money,
	@w_debe2	money,	--JCG10
	@w_haber2	money,	--JCG10
	@w_debe_me2	money,	--JCG10
	@w_haber_me2	money	--JCG10

select @w_today = getdate()
select @w_sp_name = 'sp_tvalidacion'

if (@t_trn <> 6239 and @i_operacion = 'V') 
begin
	/*Tipo de transaccion no corresponde*/ 
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
		i_operacion	= @i_operacion
	exec cobis..sp_end_debug
end

if @i_operacion = 'V'
begin
	begin tran

--	declare cursor_ctas_asoc cursor for 
    	select 	ca_empresa, ca_cuenta, ca_cta_asoc
    	into #cuenta_asocia
    	from 	cb_cuenta_asociada
    	where	ca_empresa = @i_empresa
		and ca_proceso = 6029
    
--    	open cursor_ctas_asoc 

--    	fetch cursor_ctas_asoc into @w_empresa, @w_cuenta, @w_cta_asoc

--    	while @@fetch_status = 0
        while 1 = 1
    	begin
    	set rowcount 1
    	select @w_empresa = ca_empresa, 
    	       @w_cuenta  = ca_cuenta, 
    	       @w_cta_asoc= ca_cta_asoc
    	from #cuenta_asocia
    	order by ca_cuenta
    	
    	if @@rowcount = 0
    	    break
    	
    	delete from #cuenta_asocia
    	where ca_empresa = @w_empresa 
    	  and ca_cuenta  = @w_cuenta
    	  and ca_cta_asoc = @w_cta_asoc
    	
    	set rowcount 0       
		/* inicializa variables de creacion */
		select @w_comprobante = @i_comprobante,@w_cuenta2=@w_cta_asoc,
			@w_debe = 0, @w_haber = 0, @w_debe_me = 0, @w_haber_me=0

		select 	@w_comprobante = tct_comp_tipo,
			@w_debe = isnull(sum(tct_debe),0), @w_haber = isnull(sum(tct_haber),0),
			@w_debe_me = isnull(sum(tct_debe_me),0), @w_haber_me = isnull(sum(tct_haber_me),0)
		from	cb_tdet_comptipo
		where	tct_empresa = @i_empresa and
			tct_cuenta like (ltrim(rtrim(@w_cta_asoc)) + '%') and
			tct_comp_tipo = @i_comprobante
		group by tct_comp_tipo
			
		select @w_cuenta2 = @w_cta_asoc
		--print 'comprobante %1!', @w_comprobante
		--print 'cuenta asociada %1! debe %2! haber %3!',@w_cta_asoc,@w_debe, @w_haber
		if not exists (select tv_cuenta1 from cb_tvalidacion_tipo where
				tv_empresa = @i_empresa and tv_comprobante = @i_comprobante and 
				tv_cuenta1 = @w_cta_asoc)
		begin
			insert into cb_tvalidacion_tipo (tv_empresa,tv_comprobante,tv_cuenta1,
					 tv_valor_cuenta1_mn_debe,tv_valor_cuenta1_mn_haber,
					 tv_valor_cuenta1_me_debe,tv_valor_cuenta1_me_haber)
			values 		(@i_empresa,@w_comprobante,@w_cta_asoc,
					 @w_debe,@w_haber,
					 @w_debe_me,@w_haber_me)
			if @@error <> 0 
        		begin
         			/* Error en insercion de registro */
             			exec cobis..sp_cerror
             			@t_debug = @t_debug,
	        		@t_file  = @t_file, 
        			@t_from  = @w_sp_name,
             			@i_num   = 601161
				goto error
		        end
		end

		/* inicializa variables de creacion */
		select @w_cuenta2 = @w_cuenta
		select @w_comprobante = @i_comprobante,@w_cuenta2=@w_cuenta,
			@w_debe2 = 0, @w_haber2 = 0, @w_debe_me2 = 0, @w_haber_me2=0
	
		select 	@w_comprobante = tct_comp_tipo,
			@w_debe2 = isnull(sum(tct_debe),0), @w_haber2 = isnull(sum(tct_haber),0),
			@w_debe_me2 = isnull(sum(tct_debe_me),0), @w_haber_me2 = isnull(sum(tct_haber_me),0)
		from	cb_tdet_comptipo
		where	tct_empresa = @i_empresa and
			tct_cuenta like (rtrim(ltrim(@w_cuenta)) + '%') and
			tct_comp_tipo = @i_comprobante
		group by tct_comp_tipo --, tct_cuenta
		
		--print 'cuenta proceso %1! debe %2! haber %3!',@w_cuenta, @w_debe2, @w_haber2
		update cb_tvalidacion_tipo set tv_cuenta2 = @w_cuenta, 
				tv_valor_cuenta2_mn_debe = @w_debe2 + isnull(tv_valor_cuenta2_mn_debe,0),
				tv_valor_cuenta2_mn_haber = @w_haber2 + isnull(tv_valor_cuenta2_mn_haber,0),
				tv_valor_cuenta2_me_debe = @w_debe_me2 + isnull(tv_valor_cuenta2_me_debe,0),
				tv_valor_cuenta2_me_haber = @w_haber_me2 + isnull(tv_valor_cuenta2_me_haber,0)
		where 	tv_empresa = @i_empresa and
			tv_comprobante = @i_comprobante and 
			tv_cuenta1 = @w_cta_asoc

		if @@error <> 0 
       		begin
       			/* Error en actualizacion de registro */
        		exec cobis..sp_cerror
       			@t_debug = @t_debug,
       			@t_file  = @t_file, 
       			@t_from  = @w_sp_name,
       			@i_num   = 601162
			goto error
         	end
		--else	--JCG10
		--begin
			/* Error en la validaci¢n */
       			/*exec cobis..sp_cerror
     			@t_debug = @t_debug,
       			@t_file  = @t_file, 
       			@t_from  = @w_sp_name,
       			@i_num   = 603069
			goto error
		end*/
--		fetch cursor_ctas_asoc into @w_empresa, @w_cuenta, @w_cta_asoc
	end
	
	commit tran
	
--	close cursor_ctas_asoc

--    	deallocate cursor_ctas_asoc
	/** Se realiza la validaci¢n MES001 **/
	IF exists ( select 1 from cb_tvalidacion_tipo where
		tv_empresa = @i_empresa and
		tv_comprobante = @i_comprobante and
		(tv_valor_cuenta2_mn_debe <> tv_valor_cuenta1_mn_haber or
		tv_valor_cuenta2_mn_haber <> tv_valor_cuenta1_mn_debe or
		tv_valor_cuenta2_me_debe <> tv_valor_cuenta1_me_haber or
		tv_valor_cuenta2_me_haber <> tv_valor_cuenta1_me_debe))
	begin
		/* Error en la validaci¢n */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 603069

/*		delete from cb_tvalidacion_tipo where
		tv_empresa = @i_empresa and
		tv_comprobante = @i_comprobante
		return 1 */
	end			
	
end
select * from cb_tvalidacion_tipo where
	tv_empresa = @i_empresa and
	tv_comprobante = @i_comprobante
return 0

error:
	rollback
--	close cursor_ctas_asoc
--    	deallocate cursor_ctas_asoc
	return 1

go

