/************************************************************************/
/*	Archivo: 		cuenta.sp			        */
/*	Stored procedure: 	sp_cuenta				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan Uria/Gonzalo Jaramillo            	*/
/*	Fecha de escritura:     3-Agosto-1993 				*/
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
/*	   Mantenimiento al Catalogo de Cuentas                         */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	3/Ago/1993	G. Jaramillo    Emision Inicial			*/
/*	25/Jul/96	S. de la Cruz	Utilizacion tabla cb_hist_saldo */
/*	22/Ene/1997	F. Salgado	Personalizacion CajaCoop	*/
/*					FS001: Adicion variable @i_pre- */
/*					supuesto y @w_presupuesto	*/
/*	FS002: Insercion del campo ts_presupuesto en la tabla de tran-  */
/*	sacciones de servicio						*/
/*	13/Feb/1997	R. Villota	RV001: @i_acceso puede ser nulo */
/*      14/11/1997      Martha Gil V.   cu_descripcion varchar(255)     */
/*      29/Dic/1997     M.Claudia Morales MCM001: Cambio codigo mensaje */
/*	18/May/1999	O. Escandon	Crearcion y Modificacion sobre	*/
/*					las tablas de presupuesto OJE01	*/
/*	27/May/1999	O.Escandon	Cambiar el uso de cb_asiento por*/
/*					cob_conta_tercero..ct_asiento	*/
/*	01/Jun/1999	O. Escandon	Modificar el insertar presuouesto*/
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_cuenta')
	drop proc sp_cuenta
go

create proc sp_cuenta   (
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
	@i_empresa      tinyint = null,
	@i_cuenta   	cuenta= null,
        @i_cuenta2      cuenta=null,
	@i_cuenta_padre	cuenta= null,
	@i_nombre	descripcion = null,
	@i_descripcion 	varchar(255)=null,
	@i_estado      	char(1) = null ,
	@i_movimiento	char(1) = null,
	@i_nivel_cuenta	tinyint = null,
	@i_categoria	varchar(10) = null,
	@i_fecha_estado	datetime = null ,
	@i_moneda	tinyint  = null ,
	@i_sinonimo	char(20) = null ,
        @i_acceso       char(1) = null,  /*RV001*/
	@i_presupuesto	char(1) = null  /* FS001 */
)
as
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_cuenta   		cuenta,
	@w_cuenta_padre   	cuenta,
	@w_nombre		descripcion ,
	@w_descripcion  	descripcion ,
	@w_estado       	char(1)  ,
	@w_saldo       		money  ,
	@w_estado_padre       	char(1)  ,
	@w_movimiento		char(1) ,
	@w_acceso       	char(1),
	@w_nivel_cuenta		tinyint ,
	@w_categoria		char(10) ,
	@w_fecha_estado		datetime ,
	@w_moneda		tinyint ,
        @w_categoria_padre      char(1),
	@w_moneda1		tinyint ,
	@w_moneda_base		tinyint ,
	@w_movimiento2		char(1),
	@w_estado_ant		char(1),
	@w_flag1		int,
	@w_flag			char(1),
	@w_flag2		char(1),	/*OJE01*/
	@w_flag3		char(1),	/*OJE01*/
	@w_menor		tinyint,
	@w_empresa		tinyint,
	@w_max_periodo		tinyint,
	@w_nomemp		descripcion,
	@w_sinonimo		char(20),
	@w_corte		int,
	@w_fecha_act		datetime,
	@w_hijas		int,  		/*contador de hijas vigentes */
	@w_periodo		int,
	@w_existe		int,		/* codigo existe = 1
						no existe = 0 */
	@w_presupuesto		char(1),		/* FS001 */
	@w_cuenta_aux  		cuenta,
	@w_cuenta_presupuesto  	cuenta,
	@w_cuenta_padre_pre  	cuenta,
	@w_sa_saldo		money,
	@w_hi_saldo		money,
	@w_cup_cuenta  		cuenta

select @w_today = getdate()
select @w_sp_name = 'sp_cuenta'


/************************************************/
/*  Tipo de Transaccion = 601 			*/

if (@t_trn <> 6011 and @i_operacion = 'I') or
   (@t_trn <> 6012 and @i_operacion = 'U') or
   (@t_trn <> 6013 and @i_operacion = 'D') or
   (@t_trn <> 6840 and @i_operacion = 'A') or
   (@t_trn <> 6009 and @i_operacion = 'C')
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
		i_empresa 	= @i_empresa,
		i_cuenta   	= @i_cuenta ,
		i_cuenta_padre  = @i_cuenta_padre ,
		i_nombre	= @i_nombre ,
		i_descripcion  	= @i_descripcion,
		i_estado       	= @i_estado,
		i_movimiento	= @i_movimiento,
		i_nivel_cuenta	= @i_nivel_cuenta,
		i_categoria	= @i_categoria,
		i_fecha_estado	= @i_fecha_estado,
		i_moneda	= @i_moneda ,
		i_sinonimo	= @i_sinonimo,
		i_presupuesto	= @i_presupuesto /* FS001 */
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

/* Trae naturaleza de la cuenta padre */ /* MCM001 */
if @i_operacion = 'U'
   select @w_categoria_padre = cu_categoria
   from cob_conta..cb_cuenta
   where cu_empresa = @i_empresa
     and cu_cuenta  = substring(@i_cuenta,1,1)


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select  @w_empresa = cu_empresa,
		@w_cuenta = cu_cuenta,
		@w_cuenta_padre = cu_cuenta_padre,
		@w_nombre = cu_nombre,
		@w_descripcion = cu_descripcion,
		@w_estado = cu_estado,
		@w_movimiento = cu_movimiento,
		@w_nivel_cuenta = cu_nivel_cuenta,
		@w_categoria = cu_categoria,
		@w_fecha_estado = cu_fecha_estado,
		@w_moneda = cu_moneda,
 		@w_acceso = cu_acceso,
		@w_presupuesto = cu_presupuesto /* FS001 */
	from cob_conta..cb_cuenta
	where 	cu_empresa = @i_empresa and
		cu_cuenta = @i_cuenta

	if @@rowcount > 0
	begin
		select  @w_existe = 1,
			@w_estado_ant = @w_estado
	end
	else
		select @w_existe = 0

end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	select @w_flag = @i_presupuesto

	select @w_corte = co_corte,
		@w_fecha_act = co_fecha_ini,
		@w_periodo = co_periodo
	from cb_corte
	where co_empresa = @i_empresa and
	      co_estado  = 'A'

	select @w_moneda_base = em_moneda_base
	from cob_conta..cb_empresa
	where em_empresa = @i_empresa

	if @i_moneda is null
		select @w_moneda = @w_moneda_base
	else
		select @w_moneda = @i_moneda

	/* Validacion de datos */
	/***********************/

	if 	@i_empresa is null or @i_cuenta is null or
		@i_nombre  is null or
		@i_estado  is null  or
		@i_nivel_cuenta is null or @i_categoria is null
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

/**** Integridad Referencial *****/
/*********************************/
	if @i_nivel_cuenta > 1
	begin
		select @w_movimiento2 = cu_movimiento,
			@w_estado_padre = cu_estado
		from cb_cuenta
		where cu_empresa  = @i_empresa and
			cu_cuenta = @i_cuenta_padre

		if @@rowcount = 0
		begin
			/* 'No existe Nivel Superior de cuenta especificado' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601023
			return 1
		end
	end
	else
		select @w_estado_padre = @i_estado

        if NOT EXISTS (select 1 from cob_conta..cb_empresa
			where  em_empresa = @i_empresa)
	begin
		/* 'No existe empresa' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

        if NOT EXISTS (select 1 from cb_nivel_cuenta
			where  nc_empresa   = @i_empresa and
				nc_nivel_cuenta = @i_nivel_cuenta
			)
	begin
		/* 'No existe Nivel de Cuenta  especificado' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601034
		return 1
	end

end


/* Insercion de cuenta */
/*************************/

if @i_operacion = 'I'
begin


	if exists(select 1 from cob_conta..cb_asiento
		  where as_empresa = @i_empresa and
			as_cuenta = @i_cuenta_padre)
	begin
		/* 'Nivel superior de cuenta tiene movimientos ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603061
		return 1
	end

	if exists (select 1 from cb_cuenta
			where cu_empresa = @i_empresa
	   		and cu_cuenta = @i_cuenta_padre
			and cu_movimiento = 'S')
	begin
		/* 'Nivel superior de cuenta tiene movimientos ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605078
		return 1
	end

	if @w_existe = 1
	begin
		/* 'Codigo de cuenta ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601027
		return 1
	end

	/* Insercion del registro */
	/**************************/

	begin tran
		/* FS001 */
		insert into cob_conta..cb_cuenta
		(cu_empresa,cu_cuenta,cu_cuenta_padre,cu_nombre,
		cu_descripcion, cu_estado,cu_movimiento,cu_nivel_cuenta,
		cu_categoria, cu_fecha_estado,cu_moneda,cu_sinonimo,cu_acceso,
		cu_presupuesto)
		values (@i_empresa,@i_cuenta,@i_cuenta_padre,
			@i_nombre, @i_descripcion, @w_estado_padre,
			@i_movimiento, @i_nivel_cuenta,
			@i_categoria,@i_fecha_estado,@w_moneda,@i_sinonimo,
                        @i_acceso,@i_presupuesto)

		if @@error <> 0
		begin

			/* 'Error en insercion de Cuenta          ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603007
			rollback
			return 1
		end

		/* Si la cuenta es de presupuesto OJE01 */

		if @w_flag = 'P'
		begin
			select @w_cuenta_presupuesto = @i_cuenta

			select @w_cuenta_aux = cup_cuenta
			  from cb_cuenta_presupuesto
			 where cup_cuenta = @i_cuenta
			   and cup_empresa = @i_empresa

			if @@rowcount > 0
			begin
				/* 'Error en insercion de Cuenta Presupuesto      ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601141
			end
			else
			begin

				select @w_flag1 = 1
				while @w_flag1 > 0
				begin

					if @w_cuenta_presupuesto is not null
					begin

						if exists (select 1 from cb_cuenta_presupuesto
						where cup_empresa = @i_empresa
				   		  and cup_cuenta = @w_cuenta_presupuesto)

						begin
							select @w_flag1 = 0
							continue
						end

						insert into cob_conta..cb_cuenta_presupuesto
						(cup_empresa,cup_cuenta,cup_cuenta_padre,cup_nombre,
						cup_descripcion,cup_nivel_cuenta,cup_categoria,
						cup_movimiento,cup_estado)
						select 	cu_empresa,cu_cuenta,cu_cuenta_padre,cu_nombre,
							cu_descripcion,cu_nivel_cuenta,cu_categoria,
							cu_movimiento,cu_estado
						  from  cb_cuenta
						 where  cu_empresa = @i_empresa
				   		   and  cu_cuenta = @w_cuenta_presupuesto

						if @@error <> 0
						begin

							/* 'Error en insercion de Cuenta  ' */
							exec cobis..sp_cerror
							@t_debug = @t_debug,
							@t_file	 = @t_file,
							@t_from	 = @w_sp_name,
							@i_num	 = 603053
							rollback
							return 1
						end

						select @w_cuenta_padre_pre = cup_cuenta_padre
						from cb_cuenta_presupuesto
						where cup_cuenta = @w_cuenta_presupuesto
				   		  and cup_empresa = @i_empresa

						select @w_cuenta_presupuesto = @w_cuenta_padre_pre
						continue
					end
					else
					begin
						select @w_flag1 = 0
						continue
					end
				end

			end
		end

		/* End OJE01 */

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/
	/* FS002 */
	insert into cb_tran_servicio (
           ts_secuencial, ts_tipo_transaccion, ts_clase,
           ts_fecha,ts_usuario,ts_terminal,ts_oficina,
           ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
           ts_movimiento,ts_categoria,ts_presupuesto, ts_causa)
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa,@i_cuenta,@i_descripcion,@i_estado,
		@i_movimiento,@i_categoria,@i_presupuesto, @i_acceso)

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
	/****************************************/


	update cob_conta..cb_cuenta
	set cu_movimiento = 'N'
	where cu_empresa = @i_empresa and
		cu_cuenta = @i_cuenta_padre

	if @@error <> 0
	begin
		/* 'Error en actualizacion de movimiento en cuenta superior' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603042
		return 1
	end

	commit tran
	return 0
end

/* Actualizacion de cuenta  (Update) */
/***************************************/

if @i_operacion = 'U'
begin

	if @w_existe = 0
	begin
		/* 'Codigo de Cuenta a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605013
		return 1
	end

	/* Verificar si la modificacion es de P a null, o de null a P */

	select @w_flag2 = cu_presupuesto
	  from cb_cuenta
	 where cu_cuenta = @i_cuenta
	   and cu_empresa = @i_empresa


	/*No se puede modificar la moneda porque la cuenta tiene saldo */
	/*o movimiento */

	select @w_moneda1=cu_moneda from cb_cuenta
	where cu_empresa = @i_empresa and
	      cu_cuenta  = @i_cuenta

   if (@i_movimiento='S') and (@w_moneda1 <> @i_moneda)
   begin
        /* select * from cob_conta_his..cb_hist_saldo */
      select 1 from cob_conta..cb_saldo
      where (sa_empresa = @i_empresa and
      sa_periodo = @w_periodo and
      sa_corte   = @w_corte   and
      sa_cuenta  = @i_cuenta) and
            (abs(sa_debito) > 0 or
      abs(sa_credito) > 0 or
      abs(sa_debito_me) > 0 or
      abs(sa_credito_me) > 0)

      if @@rowcount > 0 begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 609128 /* MCM001 */
         return 1
      end

/*    select * from cob_conta..cob_conta..cb_asiento
      where 	(as_empresa = @i_empresa and
      as_fecha_tran = @w_fecha_act and
      as_cuenta  = @i_cuenta) and
      (abs(as_debito) > 0 or
      abs(as_credito) > 0 or
      abs(as_debito_me) > 0 or
      abs(as_credito_me) > 0) */

      /* SYR  21/ENE/1997  no se valida en comprobante tipo */
      /* or
      exists(select 1 from cob_conta..cb_det_comptipo
      where 	(dct_empresa = @i_empresa and
      dct_cuenta  = @i_cuenta) and
      (abs(dct_debe) > 0 or
      abs(dct_haber) > 0 or
      abs(dct_debe_me) > 0 or
      abs(dct_haber_me) > 0))*/

      if @@rowcount > 0
      begin
         /* 'Cuenta tiene saldo o movimiento'*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 609128 /* MCM001 */
         return 1
      end
   end

   /* Chequea que para cambiar una cuenta de movimiento a grupo, o
   el estado de vigente a cancelada, la cuenta tenga saldo 0 */

   --print 'movimiento i %1! movimiento w %2!',@i_movimiento,@w_movimiento
   if @i_movimiento='N' and @w_movimiento<>@i_movimiento
   begin
   /* select @w_saldo=hi_saldo from cob_conta_his..cb_hist_saldo */
      select @w_saldo=sa_saldo from cob_conta..cb_saldo
      where sa_empresa= @i_empresa and
      sa_periodo = @w_periodo      and
      sa_corte  = @w_corte         and
      sa_cuenta = @i_cuenta

      if abs(@w_saldo)>0
	  begin
         /* 'Cuenta tiene saldo'*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601042
         return 1
      end
   end

   if @i_estado='C' and @w_estado<>@i_estado
   begin
      --select @w_saldo=hi_saldo from cob_conta_his..cb_hist_saldo
      select @w_saldo= count(1)
      from cob_conta..cb_saldo
      where sa_empresa = @i_empresa and
            sa_periodo = @w_periodo and
            sa_corte   = @w_corte   and
            sa_cuenta  = @i_cuenta  and
            sa_saldo  <> 0
      
      if abs(@w_saldo)>0
      begin
      	/* 'Cuenta tiene saldo'*/
      	exec cobis..sp_cerror
      	@t_debug = @t_debug,
      	@t_file	 = @t_file,
      	@t_from	 = @w_sp_name,
      	@i_num	 = 609126
      	return 1
      end
      
      select @w_hijas = count(*) from cb_cuenta
      where cu_cuenta_padre = @i_cuenta and
            cu_estado ='V' and
      	      cu_empresa = @i_empresa
      
      if @w_hijas > 0
      begin
      	/* 'Cuenta con hijas vigentes'*/
      	exec cobis..sp_cerror
      	@t_debug = @t_debug,
      	@t_file	 = @t_file,
      	@t_from	 = @w_sp_name,
      	@i_num	 = 605087
      	return 1
      end
   end

   /*  Actualizacion del registro  */
   /********************************/
   if @i_movimiento = 'S'
   begin
   	if exists(select 1 from cb_cuenta
   		 where 	cu_empresa = @i_empresa and
   			cu_cuenta_padre = @i_cuenta)
   	begin
   	/* 'Cuenta No puede ser de movimiento'*/
   		exec cobis..sp_cerror
   		@t_debug = @t_debug,
   		@t_file	 = @t_file,
   		@t_from	 = @w_sp_name,
   		@i_num	 = 605078
   		return 1
   	end
   end
   
   begin tran
   	/* FS001 */
   update cob_conta..cb_cuenta
   set cu_cuenta_padre = @i_cuenta_padre,
   cu_nombre = @i_nombre,
   cu_descripcion = @i_descripcion,
   cu_estado = @i_estado,
   cu_nivel_cuenta = @i_nivel_cuenta,
   cu_categoria = @i_categoria,
   cu_fecha_estado = @i_fecha_estado,
   cu_moneda = @w_moneda ,
   cu_sinonimo = @i_sinonimo,
   cu_movimiento = @i_movimiento,
   cu_acceso     = @i_acceso,
   cu_presupuesto = @i_presupuesto
   where  	cu_empresa = @i_empresa and
   cu_cuenta = @i_cuenta
   
   if @@error <> 0
   begin
      /* 'Error en Actualizacion de Cuenta       '*/
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 605014
      return 1
   end
   
   	/* manejo de cuentas de prewsupuesto OJE01 */
   
   if @w_flag2 = 'P' and  @i_presupuesto is null
   begin
   
   	   select @w_sa_saldo = sa_saldo
   	     from cb_saldo
   	    where sa_cuenta = @i_cuenta
   	      and sa_empresa = @i_empresa
       
   	   select @w_hi_saldo = hi_saldo
   	     from cob_conta_his..cb_hist_saldo
   	    where hi_cuenta = @i_cuenta
   	      and hi_empresa = @i_empresa
   
   
      if (@w_sa_saldo is not null) or (@w_hi_saldo is not null)
      begin
      		/* 'Error en eliminacion de Cuenta Presupuesto      ' */
      		exec cobis..sp_cerror
      		@t_debug = @t_debug,
      		@t_file	 = @t_file,
      		@t_from	 = @w_sp_name,
      		@i_num	 = 607113
      		return 1
      end
      else
      begin
      
         delete
         from cb_saldo_presupuesto
         where sap_cuenta = @i_cuenta
         and sap_empresa = @i_empresa
      
      	  if @@error <> 0
      	  begin
      	     /* 'Error en la Eliminacion de Cuenta Presupuesto'*/
      	     exec cobis..sp_cerror
      	     @t_debug = @t_debug,
      	     @t_file	 = @t_file,
      	     @t_from	 = @w_sp_name,
      	     @i_num	 = 607113
      	     return 1
      	  end
      
         delete
         from cb_plan_general_presupuesto
         where pgp_cuenta = @i_cuenta
         and pgp_empresa = @i_empresa
      
         if @@error <> 0
         begin
            /* 'Error en la Eliminacion de Cuenta Presupuesto'*/
            exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file	= @t_file,
            @t_from	= @w_sp_name,
            @i_num	    = 607113
            return 1
         end
      
         delete
           from cb_general_presupuesto
          where gp_cuenta = @i_cuenta
            and gp_empresa = @i_empresa
         
         if @@error <> 0
         begin
         	/* 'Error en la Eliminacion de Cuenta Presupuesto'*/
         	exec cobis..sp_cerror
         	@t_debug = @t_debug,
         	@t_file	 = @t_file,
         	@t_from	 = @w_sp_name,
         	@i_num	 = 607113
         	return 1
         end
      
         delete
         from cb_cuenta_presupuesto
         where cup_cuenta = @i_cuenta
         and cup_empresa = @i_empresa
         
         if @@error <> 0
         begin
            /* 'Error en la Eliminacion de Cuenta Presupuesto'*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num	  = 607113
            return 1
         end
      end
   end
   
   if (@w_flag2 is null)  and @i_presupuesto = 'P'
   begin
   
      select @w_cup_cuenta = cup_cuenta
      from cb_cuenta_presupuesto
      where cup_cuenta = @i_cuenta
      and cup_empresa = @i_empresa
   
      if @@rowcount > 0
      begin
         /* 'Error en insercion de Cuenta Presupuesto      ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601141
      end
      else
      begin
   			select @w_cuenta_presupuesto = @i_cuenta
   
   			select @w_flag1 = 1
   			while @w_flag1 > 0
   			begin
   				if @w_cuenta_presupuesto is not null
   				begin
   
   					if exists (select 1 from cb_cuenta_presupuesto
   					where cup_empresa = @i_empresa
   			   		  and cup_cuenta = @w_cuenta_presupuesto)
   
   					begin
   						select @w_flag1 = 0
   						continue
   					end
   
   
   					insert into cob_conta..cb_cuenta_presupuesto
   					(cup_empresa,cup_cuenta,cup_cuenta_padre,cup_nombre,
   					cup_descripcion,cup_nivel_cuenta,cup_categoria,
   					cup_movimiento,cup_estado)
   					select 	cu_empresa,cu_cuenta,cu_cuenta_padre,cu_nombre,
   						cu_descripcion,cu_nivel_cuenta,cu_categoria,
   						cu_movimiento,cu_estado
   					  from  cb_cuenta
   					 where  cu_empresa = @i_empresa
   			   		   and  cu_cuenta = @w_cuenta_presupuesto
   
   					if @@error <> 0
   					begin
   
   						/* 'Error en insercion de Cuenta  ' */
   						exec cobis..sp_cerror
   						@t_debug = @t_debug,
   						@t_file	 = @t_file,
   						@t_from	 = @w_sp_name,
   						@i_num	 = 603053
   						rollback
   						return 1
   					end
   
   					insert into cb_plan_general_presupuesto
   					select pg_empresa,pg_cuenta,pg_oficina,pg_area
   					from cb_plan_general
   					where pg_cuenta = @w_cuenta_presupuesto
   					and pg_empresa = @i_empresa
   					if @@error <> 0
   					begin
   						/* 'Error en insercion de Cuenta  ' */
   						exec cobis..sp_cerror
   						@t_debug = @t_debug,
   						@t_file	 = @t_file,
   						@t_from	 = @w_sp_name,
   						@i_num	 = 603053
   					end
   
   					insert into cb_general_presupuesto (gp_empresa,
   									gp_cuenta,
   									gp_oficina,
   									gp_area,
   									gp_cuenta_presupuesto,
   									gp_oficina_presupuesto,
   									gp_area_presupuesto)
   							select pg_empresa,
   								pg_cuenta,
   								pg_oficina,
   								pg_area,
   								pg_cuenta,
   								pg_oficina,
   								pg_area
   							 from cb_plan_general
   							 where pg_cuenta = @w_cuenta_presupuesto
   							   and pg_empresa = @i_empresa
   
   					if @@error <> 0
   					begin
             						/* 'Error en insercion de Cuenta  ' */
   						exec cobis..sp_cerror
   						@t_debug = @t_debug,
   						@t_file	 = @t_file,
   						@t_from	 = @w_sp_name,
   						@i_num	 = 603053
   					end
   
   					select @w_cuenta_padre_pre = cup_cuenta_padre
   					from cb_cuenta_presupuesto
   					where cup_cuenta = @w_cuenta_presupuesto
   			   		  and cup_empresa = @i_empresa
   
   
   
   					select @w_cuenta_presupuesto = @w_cuenta_padre_pre
   					continue
   				end
   				else
   				begin
   					select @w_flag1 = 0
   					continue
   				end
   
   			end
   		end
   	end
   
   	/* End OJE01 */
   
   	if @w_estado_ant <> @i_estado
   	begin
   		if @w_estado_padre = 'C' and @i_estado <> 'C'
   		begin
   			/* 'Nivel Superior de Cuenta esta Cancelado '*/
   			exec cobis..sp_cerror
   			@t_debug = @t_debug,
   			@t_file	 = @t_file,
   			@t_from	 = @w_sp_name,
   			@i_num	 = 605033
   			return 1
   		end
   		update cob_conta..cb_cuenta
   		set cu_estado = @i_estado
   		where 	cu_empresa = @i_empresa and
   			cu_cuenta like @i_cuenta + '%'
   
   		if @@error <> 0
   		begin
   		/* 'Error en la actualizacion de estado en niveles inferiores de la cueta'*/
   			exec cobis..sp_cerror
   			@t_debug = @t_debug,
   			@t_file	 = @t_file,
   			@t_from	 = @w_sp_name,
   			@i_num	 = 605034
   			return 1
   		end
   
   	end
   
   	if @@error <> 0
   	begin
   		/* 'Error en Actualizacion de Cuenta       '*/
   		exec cobis..sp_cerror
   		@t_debug = @t_debug,
   		@t_file	 = @t_file,
   		@t_from	 = @w_sp_name,
   		@i_num	 = 605014
   		return 1
   	end
   
   
   	/****************************************/
   	/* TRANSACCION DE SERVICIO		*/
   	/* FS002 */
   insert into cb_tran_servicio (
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_fecha,ts_usuario,ts_terminal,ts_oficina,
   
             ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
             ts_movimiento,ts_categoria,ts_presupuesto, ts_causa)
   	values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
   		@w_empresa,@w_cuenta,@w_descripcion,@w_estado,
   		@w_movimiento,@w_categoria,@w_presupuesto, @w_acceso)
   
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
   /* FS002 */
   insert into cb_tran_servicio (
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_fecha,ts_usuario,ts_terminal,ts_oficina,
             ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
             ts_movimiento,ts_categoria,ts_presupuesto, ts_causa)
   	values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
   		@i_empresa,@i_cuenta,@i_descripcion,@i_estado,
   		@i_movimiento,@i_categoria,@i_presupuesto, @i_acceso)
   
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

/* Eliminacion de cuenta  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0
	begin
		/* 'Codigo de Cuenta a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607021
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

       	/* Si codigo de cuenta existe en catalogo Plan General
	   No se puede eliminar la cuenta */

     	if EXISTS (select pg_cuenta
		from cob_conta..cb_plan_general
		where   pg_empresa = @i_empresa and
			pg_cuenta = @i_cuenta
		)
	begin
		/* 'Codigo de Cuenta relacionada con Plan General '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607022
		return 1
	end


	/* Si codigo de cuenta a eliminar es padre de una cuenta
	   existente, No se la puede eliminar */

	select @w_cuenta = cu_cuenta
	from cob_conta..cb_cuenta
	where   cu_empresa = @i_empresa and
		cu_cuenta_padre = @i_cuenta

	if @@rowcount > 0
	begin
	/* 'Cuenta a eliminar es Nivel Superior de Cuentas existentes'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607045
		return 1
	end

         /* debe buscar la cuenta en cuenta_proceso  */

	select @w_cuenta = cp_cuenta
	from cob_conta..cb_cuenta_proceso
	where   cp_cuenta = @i_cuenta
		and cp_empresa = @i_empresa  /* Validaci¢n por la empresa para las cuentas */

	if @@rowcount > 0
	begin
	/* 'Cuenta a eliminar esta asociada a proceso'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609137
		return 1
	end

	/*Validacion de la existencia en cuenta asociada */
	select @w_cuenta = ca_cta_asoc
	from cob_conta..cb_cuenta_asociada
	where   ca_cta_asoc = @i_cuenta
		and ca_empresa = @i_empresa  /* Validaci¢n por la empresa para las cuentas */

	if @@rowcount > 0
	begin
	/* 'Cuenta a eliminar esta asociada a proceso'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609137
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_cuenta
		where 	cu_empresa = @i_empresa and
			cu_cuenta = @i_cuenta

		if @@error <> 0
		begin
		/*	'Error en Eliminacion de Cuenta          ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607023
			return 1
		end

/*BEGIN OJE01 */
			select @w_sa_saldo = sa_saldo
			  from cb_saldo
			 where sa_cuenta = @i_cuenta
			   and sa_empresa = @i_empresa

			select @w_hi_saldo = hi_saldo
			  from cob_conta_his..cb_hist_saldo
			 where hi_cuenta = @i_cuenta
			   and hi_empresa = @i_empresa



			if (@w_sa_saldo is not null)  or (@w_hi_saldo is not null)
			begin
				/* 'Error en eliminacion de Cuenta Presupuesto      ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 607113
				return 1
			end
			else
			begin

				delete
				  from cb_saldo_presupuesto
				 where sap_cuenta = @i_cuenta
				   and sap_empresa = @i_empresa

				if @@error <> 0
				begin
					/* 'Error en la Eliminacion de Cuenta Presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607113
					return 1
				end

				delete
				  from cb_plan_general_presupuesto
				 where pgp_cuenta = @i_cuenta
				   and pgp_empresa = @i_empresa

				if @@error <> 0
				begin
					/* 'Error en la Eliminacion de Cuenta Presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607113
					return 1
				end

				delete
				  from cb_general_presupuesto
				 where gp_cuenta = @i_cuenta
				   and gp_empresa = @i_empresa

				if @@error <> 0
				begin
					/* 'Error en la Eliminacion de Cuenta Presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607113
					return 1
				end

				delete
				  from cb_cuenta_presupuesto
				 where cup_cuenta = @i_cuenta
				   and cup_empresa = @i_empresa

				if @@error <> 0
				begin
					/* 'Error en la Eliminacion de Cuenta Presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607113
					return 1
				end
			end

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/
	/* FS002 */
	insert into cb_tran_servicio (
           ts_secuencial, ts_tipo_transaccion, ts_clase,
           ts_fecha,ts_usuario,ts_terminal,ts_oficina,
           ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
           ts_movimiento,ts_categoria,ts_presupuesto, ts_causa)
	values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		@w_empresa,@w_cuenta,@w_descripcion,@w_estado,
		@w_movimiento,@w_categoria,@w_presupuesto, @w_acceso)

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
	/****************************************/

         commit tran
	 return 0
end
if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo=0
	   begin
		select  cu_cuenta,cu_nombre
		from    cob_conta..cb_cuenta
		where   cu_empresa = @i_empresa and
                        cu_cuenta like @i_cuenta and
	      		cu_movimiento = 'S'
                order by cu_cuenta

	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe o no es de movimiento '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601109
		return 1
	end
 	end
	if @i_modo=1
	   begin
		 select cu_cuenta,cu_nombre
                 from   cob_conta..cb_cuenta
		 where  cu_empresa = @i_empresa and
	      		cu_movimiento = 'S' and
                        cu_cuenta like @i_cuenta and
			cu_cuenta > @i_cuenta2
                order by cu_cuenta
	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe o no es de movimiento '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601109
		return 1
	end
	end
	set rowcount 0
end

/* leer nombre cuenta */
/*************************/

if @i_operacion = 'C'
begin
	select cu_nombre
	from cob_conta..cb_cuenta
	where   cu_empresa = @i_empresa and
		cu_cuenta = @i_cuenta

end
go
