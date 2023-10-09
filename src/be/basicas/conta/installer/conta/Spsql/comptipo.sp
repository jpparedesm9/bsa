/************************************************************************/
/*	Archivo: 		comptipo.sp			        */
/*	Stored procedure: 	sp_comp_tipo				*/
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
/*	Copia un comprobante tipo y sus detalles desde las tablas 	*/
/*	temporales a las definitivas y realiza el mantenimiento de las	*/
/*	tablas definitivas						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun.1994	G Jaramillo     Eliminacion de Secciones	*/
/*      13/ENE/1998     Sandra Robayo   Tome las cuentas padre          */
/*	10-Feb-1999	Juan C. G¢mez	Nuevos par metros JCG10		*/	
/*	18-Feb-1999	Juan C. G¢mez	Modificaci¢n en operaciones 	*/
/*					JCG20				*/
/*	10-Mar-1999	O.Escandon	Agregar la operacion 'T'	*/
/*	13/Abr/1999	Juan C. G¢mez	Se comentarea ejecuci¢n de 	*/
/*					error JCG30			*/
/*      21/Jun/1999     Fabio Cardona   Manejo de Terceros desde MIS    */
/*	03/Ago/99	Juan C. G¢mez	Se retorna nuevo campo	JCG40	*/ 
/*					Se aumenta variable		*/ 
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comp_tipo')
	drop proc sp_comp_tipo
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_comp_tipo   (
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
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_comp_tipo	int = null,
	@i_asiento	smallint = null,
	@i_oficina	smallint = null,	--JCG10
	@i_area		smallint = null,	--JCG10
	@i_nombre	varchar(60) = '%'	--JCG10
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	int,
	@w_empresa	tinyint,
	@w_comp_tipo	int,
	@w_oficina_orig smallint,
	@w_area_orig	smallint,
	@w_oficina_dest smallint,
	@w_porcentual	char(1),
        @w_referencia   varchar(10),
	@w_modificable	char(1),    
--	@w_tipo_doc	char(1),          FCC
	@w_ente         int,            --FCC 
	@w_concepto	char(255),
	@w_detalles	int,
	@w_tdet		int,
	@wo_empresa	tinyint,
	@wo_comp_tipo	int,
	@wo_oficina_orig smallint,
	@wo_area_orig	smallint,
	@wo_oficina_dest smallint,
	@wo_porcentual	char(1),
	@wo_modificable	char(1),
	@wo_tipo_doc	char(1),
	@wo_concepto	char(255),
        @wo_referencia  varchar(10),
	@wo_detalles	int,
	@w_noficina_dest descripcion,
	@w_noficina_orig descripcion,
	@w_narea 	descripcion,
        @w_count        int,
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */
	@w_area1	smallint,	--JCG10
	@w_area2	smallint,	--JCG10
	@w_oficina1	smallint,	--JCG10
	@w_oficina2	smallint,	--JCG10

	@w_tipo			char(2),	--FCC
	@w_identifica		char(13),	--JCG40
	@w_cuenta		cuenta,	--JCG20
	@w_concepto2		char(4),	--JCG20
	@w_base			money,	--OJE
	@w_valret		money,	--OJE
	@w_valor_asiento	money,	--OJE
	@w_valor_iva		money,	--OJE
	@w_valor_ica		money,	--OJE
	@w_iva_retenido		money,	--OJE
	@w_con_iva		char(4),	--JCG20
	@w_con_iva_retenido	char(4),	--JCG20
	@w_con_timbre		char(4),	--JCG20
	@w_valor_timbre		money,	--OJE
	@w_codigo_regimen	char(4),	--JCG20
	@w_con_ica		char(4),	--JCG20
	@w_con_ivapagado	char(4),	--JCG20
	@w_valor_ivapagado	money	--OJE
	

select @w_today = getdate()
select @w_sp_name = 'sp_comp_tipo'

/************************************************/
/*  Tipo de Transaccion = 612X 			*/

if (@t_trn <> 6121 and @i_operacion = 'I') or
   (@t_trn <> 6122 and @i_operacion = 'U') or
   (@t_trn <> 6123 and @i_operacion = 'D') or
   (@t_trn <> 6126 and @i_operacion = 'Q') or
   (@t_trn <> 6127 and @i_operacion = 'A') or
   (@t_trn <> 6827 and @i_operacion = 'B') or 
   (@t_trn <> 6828 and @i_operacion = 'C') or
   (@t_trn <> 6126 and @i_operacion = 'T')
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
		i_empresa  	= @i_empresa,
		i_comp_tipo	= @i_comp_tipo    
	exec cobis..sp_end_debug
end


/******Chequeo de Existencias ******/

select 	@wo_comp_tipo 	= ct_comp_tipo,
	@wo_empresa 	= ct_empresa,
	@wo_modificable = ct_modificable,
	@wo_concepto	= ct_concepto,
	@wo_oficina_orig = ct_oficina_orig,
	@wo_area_orig	= ct_area_orig,
	@wo_porcentual	= ct_porcentual,
        @wo_referencia  = ct_referencia,
	@wo_detalles 	= ct_detalles
from cob_conta..cb_comp_tipo
where 	ct_empresa = @i_empresa and
	ct_comp_tipo = @i_comp_tipo


if @@rowcount > 0 
	select @w_existe = 1
else
	select @w_existe = 0


--JCG10
if @i_area is null
begin
	select  @w_area1 = 0,
	       	@w_area2 = 9999
end
else 
begin
	select 	@w_area1 = @i_area,
	       	@w_area2 = @i_area
end

if @i_oficina is null
begin
	select 	@w_oficina1 = 0,
	      	@w_oficina2 = 9999
end
else 
begin
	select  @w_oficina1 = @i_oficina,
		@w_oficina2 = @i_oficina
end


/***************** Insert **********************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	begin tran
--PRINT '1'
	    select @w_comp_tipo	= tt_comp_tipo,
	 	   @w_empresa = tt_empresa,
		   @w_modificable = tt_modificable,
		   @w_concepto	= tt_concepto,
		   @w_oficina_orig = tt_oficina_orig,
		   @w_area_orig = tt_area_orig,
		   @w_porcentual = tt_porcentual,
                   @w_referencia = tt_referencia,
		   @w_detalles = tt_detalles
	    from cob_conta..cb_tcomp_tipo
	    where	tt_empresa = @i_empresa and 
			tt_comp_tipo = @i_comp_tipo

	    if @@rowcount = 0
	    begin
			print 'entro error'
			/* 'No existen Datos en las Tablas Temporales' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
	    end

	    select @w_tdet = count(*)
	    from cob_conta..cb_tdet_comptipo
	    where tct_comp_tipo = @i_comp_tipo 
            and   tct_empresa = @i_empresa


	    if @w_detalles <> @w_tdet
	    begin
		/* 'Numero de registros de detalle diferente al registrado' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
--PRINT '2'
		delete cob_conta..cb_tcomp_tipo
		where	tt_empresa = @i_empresa and 
			tt_comp_tipo = @i_comp_tipo

		delete cob_conta..cb_tdet_comptipo
		where	tct_empresa = @i_empresa and 
			tct_comp_tipo = @i_comp_tipo

		return 1
	    end

	/********************************************************/
	/* Se sacan los valores de la tabla temporal de terceros*/
	/* JCG20						*/
	/********************************************************/
	    select 	@w_tipo = tt_tipo,
			@w_identifica = tt_identifica,	
			@w_ente = tt_ente,
			@w_cuenta = tt_cuenta,
			@w_concepto2 = tt_concepto,
			@w_base = tt_base,			--OJE
			@w_valret = tt_valret,			--OJE
			@w_valor_asiento = tt_valor_asiento,	--OJE
			@w_valor_iva = tt_valor_iva,		--OJE
			@w_valor_ica = tt_valor_ica,		--OJE
			@w_iva_retenido	= tt_iva_retenido,	--OJE
			@w_con_iva = tt_con_iva,
			@w_con_iva_retenido = tt_con_iva_reten,
			@w_con_timbre = tt_con_timbre,
			@w_valor_timbre = tt_valor_timbre,	--OJE
			@w_codigo_regimen = tt_codigo_regimen,
			@w_con_ica = tt_con_ica,
			@w_con_ivapagado = tt_con_ivapagado,
			@w_valor_timbre = tt_valor_timbre	--OJE
	    from cob_conta..cb_tretencion_tipo
	    where	tt_empresa = @i_empresa and 
			tt_comprobante = @i_comp_tipo 

	    --JCG30	

	    /*if @@rowcount = 0
	    begin
			/* 'No existen Datos en las Tablas Temporales' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
	    end*/

-- Inicio - Nuevo
--PRINT '3'

	    delete cob_conta..cb_retencion_tipo
	     where rt_empresa = @i_empresa and 
		   rt_comprobante = @i_comp_tipo 

	    if @@rowcount <> 0
            begin
		insert into cb_retencion_tipo
		(
			rt_empresa,rt_comprobante, rt_asiento,rt_ente,rt_tipo, rt_identifica,
			rt_cuenta, rt_concepto, rt_con_iva, rt_con_iva_reten,rt_con_timbre, 
			rt_codigo_regimen, rt_con_ica,rt_con_ivapagado,
			rt_base,rt_valret,rt_valor_asiento,rt_valor_iva,rt_valor_ica,rt_iva_retenido,		
			rt_valor_timbre,rt_valor_ivapagado
		)
		select  tt_empresa, tt_comprobante,tt_asiento,tt_ente,tt_tipo, tt_identifica,
			tt_cuenta, tt_concepto, tt_con_iva, tt_con_iva_reten, tt_con_timbre,
			tt_codigo_regimen, tt_con_ica, tt_con_ivapagado,
			tt_base,tt_valret,tt_valor_asiento,tt_valor_iva,tt_valor_ica,tt_iva_retenido,
			tt_valor_timbre,tt_valor_ivapagado

		from 	cob_conta..cb_tretencion_tipo
	        where	tt_empresa = @i_empresa and 
			tt_comprobante = @i_comp_tipo 

		delete cob_conta..cb_tretencion_tipo
		where	tt_empresa = @i_empresa and 
			tt_comprobante = @i_comp_tipo 


            end
--PRINT '4'		
-- Fin - Nuevo

	    if @w_existe = 1
	    begin
		/*************** UPDATE CABECERA **************/
		--PRINT '5'
		update cob_conta..cb_comp_tipo
		set ct_modificable 	= @w_modificable,
		    ct_concepto 	= @w_concepto,
	 	    ct_oficina_orig 	= @w_oficina_orig,
		    ct_area_orig 	= @w_area_orig,
		    ct_porcentual 	= @w_porcentual,
                    ct_referencia       = @w_referencia,
		    ct_detalles 	= @w_detalles
		where ct_comp_tipo = @i_comp_tipo

		if @@error <> 0
		begin
			/* 'Error en actualizacion de comprobante tipo' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605016

			delete cob_conta..cb_tcomp_tipo
			where tt_comp_tipo = @i_comp_tipo

			delete cob_conta..cb_tdet_comptipo
			where tct_comp_tipo = @i_comp_tipo
			return 1
		end

		delete cob_conta..cb_det_comptipo
		where	dct_empresa = @i_empresa and 
			dct_comp_tipo = @i_comp_tipo


	/********************************************************/
	/* Se pasan los valores de la tabla temporal de terceros*/
	/* JCG20						*/
	/********************************************************/

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_comp_tipo
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@wo_comp_tipo,@wo_empresa,@wo_modificable,
			@wo_concepto,@wo_oficina_orig,@wo_area_orig,
			@wo_porcentual,@wo_detalles)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032

			delete cob_conta..cb_tcomp_tipo
			where tt_comp_tipo = @i_comp_tipo

			delete cob_conta..cb_tdet_comptipo
			where tct_comp_tipo = @i_comp_tipo
			return 1
		end
		insert into ts_comp_tipo
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@w_comp_tipo,@w_empresa,@w_modificable,
			@w_concepto,@w_oficina_orig,@w_area_orig,
			@w_porcentual,@w_detalles)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			delete cob_conta..cb_tcomp_tipo
			where tt_comp_tipo = @i_comp_tipo

			delete cob_conta..cb_tdet_comptipo
			where tct_comp_tipo = @i_comp_tipo
			return 1
		end
	    end
	    else
	    begin
	    	/****** copia cabecera a tabla definitiva ******/

	    --PRINT 'INSERTA RETENCION'
	   	 insert into cob_conta..cb_comp_tipo
	     	 (ct_comp_tipo,ct_empresa,ct_modificable,
		  ct_concepto,ct_oficina_orig,ct_area_orig,
		  ct_porcentual,ct_referencia,ct_detalles)
	     	 select tt_comp_tipo,tt_empresa,tt_modificable,
			tt_concepto,tt_oficina_orig,tt_area_orig,
			tt_porcentual,tt_referencia,tt_detalles 
	     	 from cob_conta..cb_tcomp_tipo
	     	 where	tt_empresa = @i_empresa and 
			tt_comp_tipo = @i_comp_tipo

	   	 if @@error <> 0
	   	 begin
			/*'error en insercion de cabecera de comprobante tipo'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603009
			delete cob_conta..cb_tcomp_tipo
			where tt_comp_tipo = @i_comp_tipo


			delete cob_conta..cb_tdet_comptipo
			where tct_comp_tipo = @i_comp_tipo
			return 1
		 end

	/********************************************************/
	/* Se pasan los valores de la tabla temporal de terceros*/
	/* JCG20						*/
	/********************************************************/


		insert into cb_retencion_tipo
		(
			rt_empresa,rt_comprobante, rt_asiento,rt_ente,rt_tipo, rt_identifica,
			rt_cuenta, rt_concepto, rt_con_iva, rt_con_iva_reten,rt_con_timbre, 
			rt_codigo_regimen, rt_con_ica,rt_con_ivapagado,
			rt_base,rt_valret,rt_valor_asiento,rt_valor_iva,rt_valor_ica,rt_iva_retenido,		
			rt_valor_timbre,rt_valor_ivapagado
		)
		select  tt_empresa, tt_comprobante,tt_asiento,tt_ente,tt_tipo, tt_identifica,
			tt_cuenta, tt_concepto, tt_con_iva, tt_con_iva_reten, tt_con_timbre,
			tt_codigo_regimen, tt_con_ica, tt_con_ivapagado,
			tt_base,tt_valret,tt_valor_asiento,tt_valor_iva,tt_valor_ica,tt_iva_retenido,
			tt_valor_timbre,tt_valor_ivapagado

		from 	cob_conta..cb_tretencion_tipo
	        where	tt_empresa = @i_empresa and 
			tt_comprobante = @i_comp_tipo 

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_comp_tipo
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@w_comp_tipo,@w_empresa,@w_modificable,
			@w_concepto,@w_oficina_orig,@w_area_orig,
			@w_porcentual,@w_detalles)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			delete cob_conta..cb_tcomp_tipo
			where tt_comp_tipo = @i_comp_tipo

			delete cob_conta..cb_tdet_comptipo
			where tct_comp_tipo = @i_comp_tipo
			return 1
		end
	    end

	    /******* copia detalles a tabla definitiva *****/
	    insert into cob_conta..cb_det_comptipo
	      (dct_comp_tipo,dct_asiento,dct_empresa,dct_cuenta,
	       dct_oficina_dest,dct_area_dest,dct_debe,dct_haber,
	       dct_debe_me,dct_haber_me,dct_cotizacion,dct_concepto,
	       dct_tipo_doc,dct_tipo_tran)
	      select tct_comp_tipo,tct_asiento,tct_empresa,tct_cuenta,
		     tct_oficina_dest,tct_area_dest,tct_debe,
		     tct_haber,tct_debe_me,tct_haber_me,tct_cotizacion,
	 	     tct_concepto,tct_tipo_doc,tct_tipo_tran
	      from cob_conta..cb_tdet_comptipo
	      where 	tct_empresa = @i_empresa and
			tct_comp_tipo = @i_comp_tipo

	    if @@error <> 0
	    begin
		/* 'Error en insercion de detalle de comprobante tipo'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603016

		delete cob_conta..cb_tdet_comptipo
		where tct_comp_tipo = @i_comp_tipo

		delete cob_conta..cb_tcomp_tipo
		where tt_comp_tipo = @i_comp_tipo
		return 1
	    end
	
	    delete cb_tcomp_tipo 
	    where tt_empresa = @i_empresa and
		  tt_comp_tipo = @i_comp_tipo
	    delete cb_tdet_comptipo 
	    where tct_empresa = @i_empresa and
		  tct_comp_tipo = @i_comp_tipo

	/********************************************************/
	/* Se borra la tabla temporal de terceros		*/
	/* JCG20						*/
	/********************************************************/

          delete cb_tretencion_tipo
	  from 	cob_conta..cb_tretencion_tipo
          where	tt_empresa = @i_empresa and 
		tt_comprobante = @i_comp_tipo

	commit tran
	return 0
end

/******Delete *******/

if @i_operacion = 'D'
begin
	if @w_existe = 1
	begin
             /* SYR 21/ENE/1998 se debe permitir eliminar el comprobante */
       /*		if exists (select co_comp_tipo from cob_conta..cb_comprobante
			   where co_comp_tipo = @i_comp_tipo)
		begin */			
			 /* 'Comprobante tipo relacionado con Comprobante'*/
		/*	exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607130
			return 1
		end */

	  begin tran
		delete cob_conta..cb_det_comptipo
		where 	dct_empresa = @i_empresa and	
			dct_comp_tipo = @i_comp_tipo

		if @@error <> 0
		begin
			/* 'Error en eliminacion de detalles de comp. tipo*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607039
			return 1
		end

		delete cob_conta..cb_comp_tipo
		where 	ct_empresa = @i_empresa and
			ct_comp_tipo = @i_comp_tipo

		if @@error <> 0
		begin
			/* 'Error en eliminacion de comprobante tipo' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607038
			return 1
		end

	/********************************************************/
	/* Se borra la tabla de terceros			*/
	/* JCG20						*/
	/********************************************************/

	        delete cb_retencion_tipo
		from 	cob_conta..cb_tretencion_tipo
          	where	rt_empresa = @i_empresa and 
			rt_comprobante = @i_comp_tipo and
			rt_asiento = @i_asiento 

		if @@error <> 0
		begin
			/* 'Error en eliminacion de comprobante tipo' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607038
			return 1
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_comp_tipo
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@wo_comp_tipo,@wo_empresa,@wo_modificable,
			@wo_concepto,@wo_oficina_orig,@wo_area_orig,
			@wo_porcentual,@wo_detalles)
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
	end
	else 
	begin
		/* 'Comprobante tipo no existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601045
		return 1
	end
	return 0
end

if @i_operacion = 'Q'
begin
    set rowcount 20
    if @i_modo = 0
    begin
	if @w_existe = 1
	begin
		select @w_noficina_orig = of_descripcion
		from cob_conta..cb_oficina
		where of_empresa = @i_empresa and
			of_oficina = @wo_oficina_orig

		select @w_narea  = ar_descripcion
		from cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
			ar_area = @wo_area_orig
		
		select @wo_comp_tipo,@wo_empresa,@wo_modificable,
		       @wo_concepto,@wo_oficina_orig,@wo_area_orig,
		       @wo_porcentual,@wo_referencia,@w_noficina_orig,@w_narea 

		select  dct_oficina_dest,dct_area_dest,dct_cuenta,dct_tipo_doc,	
			dct_debe,dct_haber,dct_debe_me,dct_haber_me,
			dct_cotizacion,dct_tipo_tran,
			substring(dct_concepto,1,60),cu_moneda
		from cob_conta..cb_det_comptipo,cob_conta..cb_cuenta
		where 	dct_empresa = @i_empresa and	
			dct_comp_tipo = @i_comp_tipo and
			dct_empresa = cu_empresa and
			cu_cuenta = dct_cuenta
		order by dct_asiento
	end	
	else
	begin
		/* 'Comprobante tipo consultado no existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601045
		return 1
	end
    end
    else
    begin
		select  dct_oficina_dest,dct_area_dest,dct_cuenta,dct_tipo_doc,	
			dct_debe,dct_haber,dct_debe_me,dct_haber_me,
		        dct_cotizacion,dct_tipo_tran,
			substring(dct_concepto,1,60) ,cu_moneda
		from cob_conta..cb_det_comptipo,cob_conta..cb_cuenta
		where 	dct_empresa = @i_empresa and	
			dct_comp_tipo = @i_comp_tipo and
			dct_asiento > @i_asiento and
			dct_empresa = cu_empresa and
			cu_cuenta = dct_cuenta
		order by dct_asiento
    end
        if @@rowcount = 0
	begin
		/* 'no exsten mas registros  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601150
		return 1
	end

    return 0
end

/******************     ALL     ********************/

if @i_operacion = 'A' 
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Comp. Tipo' = ct_comp_tipo,
                       'Concepto'   = substring(ct_concepto,1,50)
        	from cob_conta..cb_comp_tipo
		where ct_empresa = @i_empresa
		  and (ct_oficina_orig between @w_oficina1 and @w_oficina2)	--JCG10
		  and (ct_area_orig between @w_area1 and @w_area2)		--JCG10
		  and ct_concepto like @i_nombre				--JCG10
   		order by ct_comp_tipo

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
		select ct_comp_tipo, substring(ct_concepto,1,50)
		from cob_conta..cb_comp_tipo
		where 	ct_empresa = @i_empresa and
			ct_comp_tipo > @i_comp_tipo
		    and (ct_oficina_orig between @w_oficina1 and @w_oficina2)	--JCG10
		    and (ct_area_orig between @w_area1 and @w_area2) 		--JCG10
		    and ct_concepto like @i_nombre				--JCG10
		order by ct_comp_tipo

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'C' 
begin
                /* SYR 13/ENE/1998 para que tome las cuentas padre */
		/*select dct_cuenta
        	from cb_comp_tipo, cb_det_comptipo, cb_cuenta_proceso
		where cp_empresa = @i_empresa
                  and ct_comp_tipo = @i_comp_tipo
                  and dct_empresa = ct_empresa
                  and dct_comp_tipo = ct_comp_tipo 
                  and cp_empresa = ct_empresa
                  and cp_cuenta = dct_cuenta
                  and cp_proceso IN (6003,6095)
   		order by dct_asiento*/

		select dct_asiento,dct_cuenta,cp_condicion
        	from cb_comp_tipo, cb_det_comptipo, cb_cuenta_proceso
		where
                      ct_comp_tipo = @i_comp_tipo
                  and ct_empresa = @i_empresa 
                  and dct_empresa = @i_empresa
                  and dct_comp_tipo = ct_comp_tipo 
                  and cp_empresa = @i_empresa
                  and cp_proceso IN (6003,6095)
                  and (cp_oficina = dct_oficina_dest or cp_oficina = 0)
                  and (cp_area = dct_area_dest or cp_area = 0)
                  and (dct_cuenta like rtrim(ltrim(cp_cuenta))+'%' or
                       dct_cuenta = cp_cuenta)
   		order by dct_asiento

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
        	return 0
end

if @i_operacion = 'B' 
begin
                /* SYR 13/ENE/1998 para que tome las cuentas padre */
		/*select @w_count = count(*)
        	from cb_comp_tipo, cb_det_comptipo, cb_cuenta_proceso
		where cp_empresa = @i_empresa
                  and ct_comp_tipo = @i_comp_tipo
                  and dct_empresa = ct_empresa
                  and dct_comp_tipo = ct_comp_tipo 
                  and cp_empresa = ct_empresa
                  and cp_cuenta = dct_cuenta
                  and cp_proceso IN (6003,6095)
   		order by dct_asiento*/

		select @w_count = count(*)
        from cb_comp_tipo, cb_det_comptipo, cb_cuenta_proceso
		where
                      ct_comp_tipo = @i_comp_tipo
                  and ct_empresa = @i_empresa 
                  and dct_empresa = @i_empresa
                  and dct_comp_tipo = ct_comp_tipo 
                  and cp_empresa = @i_empresa
                  and cp_proceso IN (6003,6095)
                  and (cp_oficina = dct_oficina_dest or cp_oficina = 0)
                  and (cp_area = dct_area_dest or cp_area = 0)
                  and (dct_cuenta like rtrim(ltrim(cp_cuenta))+'%' or
                       dct_cuenta = cp_cuenta)
   	--	order by dct_asiento

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
                select @w_count
        	return 0
end

/* O. Escandon */
if @i_operacion = 'T' 
begin
--	set rowcount 20
	if @i_modo = 0
	begin
             select 'ASIENTO'		= rt_asiento,
		    'CUENTA' 		= rt_cuenta,
		    'IDENTIFICACION'	= rt_identifica,	
		    'TIPO ID'  		= rt_tipo,		
		    --'CONCEPTO'		= rt_concepto,	  JCG40
		    'CONCEPTO'		= rt_con_iva_reten,	--JCG40
                    'CONCEPTO IVA'      = rt_con_iva,
                    'CONCEPTO ICA'      = rt_con_ica,
                    'CONCEPTO TIMBRE'   = rt_con_timbre,
		    'BASE'		= rt_base,
                    'VALOR ASIENTO'     = rt_valor_asiento,
                    'RETENCION CALC.'   = '',
                    'IVA CALCULADO'     = '',
                    'ICA CALCULADO'     = '',
                    'TIMBRE CALCULADO'  = '',
		    'RETENCION'		= rt_valret,
                    'VALOR IVA'         = rt_valor_iva,
                    'VALOR ICA'         = rt_valor_ica,
                    'VALOR TIMBRE'      = rt_valor_timbre,
                    'CONCEPTO PAGADO'   = rt_con_ivapagado,
                    'CALCULADO PAGADO'  = '',
                    'VALOR PAGADO'      = rt_valor_ivapagado,
		    'ENTE'      	= rt_ente
			--'Empresa' = rt_empresa,
			--'Comprobante' = rt_comprobante,
			--'Asiento' = rt_asiento, 
			--'Tipo' = rt_tipo,
			--'Identifica' = rt_identifica,
			--'Cuenta' = rt_cuenta,
                        --'Concepto'   = rt_concepto,
			--'Base' = rt_base,
			--'Valret' = rt_valret,
			--'Valor Asiento' = rt_valor_asiento,
			--'Valor Iva' = rt_valor_iva,
			--'Valor Ica' = rt_valor_ica,
			--'Iva Retenido' = rt_iva_retenido,
			--'Con Iva' = rt_con_iva,
			--'Con Iva Reten' = rt_con_iva_reten,
			--'Con Timbre' = rt_con_timbre,
			--'Valor Timbre' = rt_valor_timbre,
			--'Codigo' = rt_codigo_regimen,
			--'Con Ica' = rt_con_ica,
			--'Con Ivapagado' = rt_con_ivapagado,
			--'Valor Pagado' = rt_valor_ivapagado,
                        --'ente' = rt_ente
        	 from 	cob_conta..cb_retencion_tipo
		where	rt_empresa = @i_empresa and 
			rt_comprobante = @i_comp_tipo 
   		order by rt_asiento

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
        
             select 'ASIENTO'		= rt_asiento,
		    'CUENTA' 		= rt_cuenta,
		    'IDENTIFICACION'	= rt_identifica,	
		    'TIPO ID'  		= rt_tipo,		
		    'CONCEPTO'		= rt_concepto,
                    'CONCEPTO IVA'      = rt_con_iva,
                    'CONCEPTO ICA'      = rt_con_ica,
                    'CONCEPTO TIMBRE'   = rt_con_timbre,
		    'BASE'		= rt_base,
                    'VALOR ASIENTO'     = rt_valor_asiento,
                    'RETENCION CALC.'   = '',
                    'IVA CALCULADO'     = '',
                    'ICA CALCULADO'     = '',
                    'TIMBRE CALCULADO'  = '',
		    'RETENCION'		= rt_valret,
                    'VALOR IVA'         = rt_valor_iva,
                    'VALOR ICA'         = rt_valor_ica,
                    'VALOR TIMBRE'      = rt_valor_timbre,
                    'CONCEPTO PAGADO'   = rt_con_ivapagado,
                    'CALCULADO PAGADO'  = '',
                    'VALOR PAGADO'      = rt_valor_ivapagado,
		    'ENTE'      	= rt_ente


--		select  'Empresa' = rt_empresa,
--			'Comprobante' = rt_comprobante,
--			'Asiento' = rt_asiento, 
--			'Tipo' = rt_tipo,
--			'Identifica' = rt_identifica,
--			'Cuenta' = rt_cuenta,
--                        'Concepto'   = rt_concepto,
--			'Base' = rt_base,
--			'Valret' = rt_valret,
--			'Valor Asiento' = rt_valor_asiento,
--			'Valor Iva' = rt_valor_iva,
--			'Valor Ica' = rt_valor_ica,
--			'Iva Retenido' = rt_iva_retenido,
--			'Con Iva' = rt_con_iva,
--			'Con Iva Reten' = rt_con_iva_reten,
--			'Con Timbre' = rt_con_timbre,
--			'Valor Timbre' = rt_valor_timbre,
--			'Codigo' = rt_codigo_regimen,
--			'Con Ica' = rt_con_ica,
--			'Con Ivapagado' = rt_con_ivapagado,
--			'Valor Pagado' = rt_valor_ivapagado,
--                      'ente'         = rt_ente 
        	 from 	cob_conta..cb_retencion_tipo
		where	rt_empresa = @i_empresa and 
			rt_comprobante = @i_comp_tipo and 
                        rt_asiento > @i_asiento
   		order by rt_asiento

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes Tipo' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601046
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end
/* O. Escandon */ 
go
