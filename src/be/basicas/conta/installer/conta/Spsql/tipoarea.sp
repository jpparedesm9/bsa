/************************************************************************/
/*      Archivo:                tipoarea.sp                             */
/*      Stored procedure:       sp_tipoarea                             */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:                                        		*/
/*      Fecha de escritura:     					*/
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
/*      Este programa procesa las transacciones de:                     */
/*        Mantenimiento al catalogo de Tipos de Area			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tipoarea')
	drop proc sp_tipoarea
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tipoarea   (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = 602,
	@t_debug        	char(1) = 'N',
	@t_file         	varchar(14) = null,
	@t_from         	varchar(30) = null,
	@i_operacion    	char(1) = null,
	@i_modo         	smallint = null,
	@i_empresa     		tinyint = null,
	@i_producto     	tinyint = null,
	@i_tipo_area    	varchar(10) = null,
	@i_descripcion  	descripcion = null,
	@i_error        	smallint = null,
        @i_utiliza_valor 	char(1) = null,
        @i_area          	smallint = null,
        @i_oficentral          	smallint = null
)
as
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_siguiente    tinyint,
	@w_empresa    	tinyint,
	@w_producto     tinyint,
       	@w_tipo_area    varchar(10),
	@w_descripcion  descripcion,
	@w_flag1        tinyint,
	@w_cuenta       char(16),
	@w_existe       int             /* codigo existe = 1
					       no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_tipoarea'


/************************************************/
/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6891 and @i_operacion = 'I') or
   (@t_trn <> 6892 and @i_operacion = 'U') or
   (@t_trn <> 6893 and @i_operacion = 'D') or
   (@t_trn <> 6894 and @i_operacion = 'V') or
   (@t_trn <> 6895 and @i_operacion = 'S') or
   (@t_trn <> 6896 and @i_operacion = 'A') or
   (@t_trn <> 6897 and @i_operacion = 'B')
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
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_producto      = @i_producto,
		i_tipo_area     = @i_tipo_area,
		i_descripcion   = @i_descripcion
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select  @w_empresa      = ta_empresa,
		@w_producto     = ta_producto,
		@w_tipo_area    = ta_tiparea,
                @w_descripcion  = ta_descripcion
	from cb_tipo_area
	where   ta_empresa   = @i_empresa  and
		ta_producto  = @i_producto and
		ta_tiparea   = @i_tipo_area

	if @@rowcount <> 0
		select @w_existe = 1
	else
		select @w_existe = 0
end


/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if      @i_empresa is NULL or
		@i_descripcion is NULL or
		@i_producto is NULL or
		@i_tipo_area is NULL or
                @i_utiliza_valor is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end

	if NOT EXISTS (select * from cob_conta..cb_empresa
		where em_empresa = @i_empresa)
	begin
		/* 'No existe empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601018
		return 1
	end
end


/* Insercion de tipo de area */
/*************************/

if @i_operacion = 'I'
begin
		if @w_existe = 1
		begin
		/* Tipo de Area ya existe */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601179
			return 1
		end

	begin tran
	/* Insercion del registro */
	/**************************/
		insert into cb_tipo_area
			(ta_empresa,ta_producto,ta_tiparea,ta_descripcion,
			ta_utiliza_valor,ta_area,ta_ofi_central)
		values (@i_empresa,@i_producto,@i_tipo_area,@i_descripcion,
			@i_utiliza_valor,@i_area,@i_oficentral)
		if @@error <> 0
		begin
			/* 'Error en insercion de tipo de area' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603080
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_area
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_producto,@i_tipo_area,@i_descripcion)

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


/* Actualizacion de tipo de area  (Update) */
/***************************************/
if @i_operacion = 'U'
begin
	if @w_existe = 0
	begin
		/* 'codigo a actualizar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/
	begin tran
		update cob_conta..cb_tipo_area
		set     ta_descripcion = @i_descripcion,
                        ta_utiliza_valor = @i_utiliza_valor,
                        ta_area = @i_area,
                        ta_ofi_central = @i_oficentral
		where   ta_empresa  = @i_empresa  and
			ta_producto = @i_producto and
			ta_tiparea   = @i_tipo_area
		if @@error <> 0
		begin
			/* 'Error en Actualizacion de tipo de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 605081
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_area
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_producto,@w_tipo_area,@w_descripcion)

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
		insert into ts_tipo_area
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_producto,@i_tipo_area,@i_descripcion)

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



/* Eliminacion de tipo de area  (Delete) */
/***************************************/
if @i_operacion = 'D'
begin
	if @w_existe = 0
	begin
		/* 'tipo de area a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
        end

	if EXISTS (select * from cob_conta..cb_relparam
		where re_empresa   = @i_empresa
                and   re_producto  = @i_producto
                and   re_tipo_area = @i_tipo_area)
	begin
		/* 'No existe empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 607133
		return 1
	end

	if EXISTS (select * from cob_conta..cb_det_perfil
		where dp_empresa  = @i_empresa
                and   dp_producto = @i_producto
                and   dp_area     = @i_tipo_area)
	begin
		/* 'No existe empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 607133
		return 1
	end


begin tran

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_area
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_producto,@w_tipo_area,@w_descripcion)

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

	delete cob_conta..cb_tipo_area
	where  ta_empresa  = @i_empresa and
	       ta_producto = @i_producto and
	       ta_tiparea  = @i_tipo_area
	if @@error <> 0
	begin

	/* 'Error en Eliminacion de tipo de area' */
       	   exec cobis..sp_cerror
	   @t_debug = @t_debug,
           @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 607133
           return 1
	end
   commit tran
   return 0
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'COD.PROD' = ta_producto,
			'PRODUCTO'     = pd_descripcion,
			'TIP.AREA'     = ta_tiparea,
			'DESCRIPCION'  = substring(ta_descripcion,1,70),
            'VALOR'        = ta_utiliza_valor,
            'AREA'         = ta_area,
            'DESC.AREA'    = ar_descripcion,
            'OF. CENTRALIZA' = ta_ofi_central
		from cob_conta..cb_tipo_area
                left outer join cob_conta..cb_area on
                      ta_area = ar_area
                inner join cobis..cl_producto on
                      ta_empresa = @i_empresa
		  and ta_producto = @i_producto
		  and pd_producto = ta_producto
                  and ar_empresa = @i_empresa
		order by ta_producto, ta_tiparea

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existe tipo de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 =601153
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'COD.PROD'   = ta_producto,
			'PRODUCTO'   = pd_descripcion,
			'TIP.AREA'   = ta_tiparea,
			'DESCRIPCION' = substring(ta_descripcion,1,70),
                        'VALOR'       = ta_utiliza_valor,
                        'AREA'        = ta_area,
                        'DESC.AREA' = ar_descripcion,
                        'OF. CENTRALIZA' = ta_ofi_central
		from cob_conta..cb_tipo_area
                left outer join cob_conta..cb_area on
                      ta_area = ar_area
                inner join cobis..cl_producto on
                      ta_empresa = @i_empresa
		  and ta_producto = @i_producto
		  and ta_tiparea > @i_tipo_area
		  and pd_producto = ta_producto
                  and ar_empresa = @i_empresa
		order by ta_producto, ta_tiparea                  

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen mas tipos de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
                   end
		   set rowcount 0
	           return 1
		end
		set rowcount 0
		return 0
	end
end

/******** ALL *********/
if @i_operacion = 'A'
begin
     set rowcount 20
     if @i_modo = 0
     begin
          select 'COD.PROD' = ta_producto,
                 'PRODUCTO' = pd_descripcion,
                 'TIP.AREA'   = ta_tiparea,
                 'DESCRIPCION' = substring(ta_descripcion,1,70),
                 'VALOR'       = ta_utiliza_valor,
                 'AREA'        = ta_area,
                 'DESC.AREA'   = ar_descripcion
          from cob_conta..cb_tipo_area
          inner join cobis..cl_producto on
          pd_producto = ta_producto and
          ta_empresa = @i_empresa
          left outer join cob_conta..cb_area on
          ta_area = ar_area
          where ar_empresa = @i_empresa
          order by ta_producto, ta_tiparea
	

        if @@rowcount = 0
	begin
            if @i_error <> 1
            begin
			/* 'No existen tipos de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
            end
	    set rowcount 0
	    return 1
	end
        set rowcount 0
        return 0
   end
     if @i_modo = 1
	begin
          select 'COD.PROD' = ta_producto,
                 'PRODUCTO' = pd_descripcion,
                 'TIP.AREA'   = ta_tiparea,
                 'DESCRIPCION' = substring(ta_descripcion,1,70),
                 'VALOR'       = ta_utiliza_valor,
                 'AREA'        = ta_area,
                 'DESC.AREA'   = ar_descripcion
          from cob_conta..cb_tipo_area
          inner join cobis..cl_producto on
                pd_producto = ta_producto and
                ta_empresa = @i_empresa and
		        ((ta_producto = @i_producto and
   			    ta_tiparea > @i_tipo_area) or
                ta_producto > @i_producto)                
                left outer join cob_conta..cb_area on
                     ta_area = ar_area
          where ar_empresa = @i_empresa
          order by ta_producto, ta_tiparea		

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen mas tipos de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
                   end
		   set rowcount 0
	           return 1
		end
		set rowcount 0
		return 0
	end
end


/******** VALUE *********/
if @i_operacion = 'V'
begin
        if @w_existe = 0
        begin
			/* 'No existe tipo de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
	    return 1
	end
        select @w_descripcion
        return 0
end
go
