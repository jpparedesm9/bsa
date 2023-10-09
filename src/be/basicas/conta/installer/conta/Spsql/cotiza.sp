/************************************************************************/
/*      Archivo:                cotiza.sp                               */
/*      Stored procedure:       sp_cotizacion                           */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     30-julio-1993                           */
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
/*         Mantenimiento al catalogo de Cotizaciones por moneda         */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      30/Jul/1993     G Jaramillo     Emision Inicial                 */
/*	07/May/1999	O. Escand¢n	Manejar los nuevos parametros	            */
/*					@i_factor1 y @i_factor2		                        */
/*      17/Nov/1999     Sandra Robayo   Envio a front end operacion 'S' */
/*                                      @w_Mon1, @w_mon2                */
/*      22/Nov/1999     Sandra Robayo   operacion 'B'.                  */
/*      12/Mar/2003     Abelardo Núñez  Esp. CD00073                    */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cotizacion')
	drop proc sp_cotizacion   

go 
create proc sp_cotizacion   ( 
	@s_ssn		      int = null,
	@s_date		      datetime = null,
	@s_user		      login = null,
	@s_term		      descripcion = null,
	@s_corr		      char(1) = null,
	@s_ssn_corr	      int = null,
    @s_ofi		      smallint = null,
	@t_rty		      char(1) = null,
    @t_trn		      smallint = null,
	@t_debug          char(1) = 'N',
	@t_file           varchar(14) = null,
	@t_from           varchar(30) = null,
	@i_operacion      char(1) = null,
	@i_modo           smallint = null,
	@i_fecha          datetime= null,
	@i_moneda         tinyint = null ,
	@i_valor	      float = 1.00,
    @i_empresa	      tinyint  = null,
	@i_fecha1	      datetime = null,
	@i_compra	      float = null,
	@i_venta	      float = null,
	@i_dpv_mn	      float = null,
	@i_dpv_me	      float = null,
	@i_tm_deb_mn	  float = null,
	@i_tm_deb_me	  float = null,
    @i_formato_fecha  tinyint = 1,
    @i_opcion         smallint = null,
	--@i_factor1	float = 0.00,	--OJE
    @i_factor1	      float = 1.00,	--JCRP
	@i_factor2	      float = 1.00	--OJE
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_siguiente    tinyint,
	@w_fecha	    datetime,
	@w_moneda	    tinyint ,
	@w_valor	    float,
	@w_compra	    float,
	@w_cotiza_com	float,
	@w_cotiza_ven	float,
	@w_venta	    float,
	@w_factor1	    float,	--OJE
	@w_factor2	    float, 	--OJE
	@w_mon1		    int,	--OJE
	@w_mon2		    int,	--OJE
	@w_mon_base	    int,
	@w_vmon1	    float,	--OJE
	@w_vmon2	    float, 	--OJE
    @w_mext         smallint, 
    @w_trm          money,
	@w_existe       int,             /* codigo existe = 1 no existe = 0 */
	@w_exito        int,  	--OJE    /* codigo exito = 1 no exito = 0 */
	@w_prec 	    tinyint,	/*A. Núñez Esp. CD00073 12/Mar/03*/
	@w_mgnrdec      char(1),		/*A. Núñez Esp. CD00073 12/Mar/03*/
	@w_diaant       datetime
	
select @w_today = getdate()
select @w_sp_name = 'sp_cotizacion'

/************************************************/
/*       A. Núñez Esp. CD00073 12/Mar/03        */
/************************************************/
select  @w_mon_base = isnull(em_moneda_base,0)
from cobis..cl_moneda, cob_conta..cb_empresa
where em_empresa = @i_empresa 
and mo_moneda = em_moneda_base
and mo_estado = 'V'

if @@rowcount = 0
begin  /* 'Codigo de moneda consultado no existe o no se encuentra vigente'*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601094
	return 1
end

/************************************************/
/*  Tipo de Transaccion = 614X 			*/

if (@t_trn <> 6141 and @i_operacion = 'I') or
   (@t_trn <> 6142 and @i_operacion = 'U') or
   (@t_trn <> 6143 and @i_operacion = 'D') or
   (@t_trn <> 6144 and @i_operacion = 'V') or
   (@t_trn <> 6144 and @i_operacion = 'E') or
   (@t_trn <> 6145 and @i_operacion = 'S') or
   (@t_trn <> 6145 and @i_operacion = 'R') or
   (@t_trn <> 6147 and @i_operacion = 'A') or
   (@t_trn <> 6148 and @i_operacion = 'Z') or
   (@t_trn <> 6149 and @i_operacion = 'C') or
   (@t_trn <> 6768 and @i_operacion = 'B')
begin
	/* Tipo de transaccion no corresponde */
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
		i_fecha         = @i_fecha,
		i_moneda        = @i_moneda,
		i_valor         = @i_valor,  
		i_formato_fecha = @i_formato_fecha   
end

/* Chequeo de Existencias */
/**************************/
/*if @i_operacion <> 'S' and @i_operacion <> 'A'*/
/*       A. Núñez Esp. CD00073 12/Mar/03        */
if @i_operacion <> 'R' and @i_operacion <> 'A'
begin

   select  @w_fecha = ct_fecha,
   	@w_moneda = ct_moneda,
   	@w_valor  = ct_valor ,
   	@w_compra = ct_compra,
	@w_venta = ct_venta
   from cob_conta..cb_cotizacion   
   where ct_fecha = @i_fecha   and
    	 ct_moneda = @i_moneda

   if @@rowcount <> 0
	select @w_existe = 1
   else
	select @w_existe = 0

   /*       A. Núñez Esp. CD00073 12/Mar/03        */

   select @w_mgnrdec = isnull(mo_decimales,'N')
   from cobis..cl_moneda
   where mo_moneda = @i_moneda
   and mo_estado = 'V'
   if @@rowcount = 0
   begin  /* 'Codigo de moneda consultado no existe o no se encuentra vigente'*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601094
	return 1
   end
/*       A. Núñez Esp. CD00073 12/Mar/03        */
if @i_moneda <> @w_mon_base
   select @w_prec =  isnull(pa_tinyint,0)
   from cobis..cl_parametro
   where pa_producto = 'ADM'
   and pa_nemonico = 'DECME'
else
   select @w_prec =  isnull(pa_tinyint,0)	-- A. Núñez Esp. CD00073 12/Mar/03
   from cobis..cl_parametro
   where pa_producto = 'ADM'
   and pa_nemonico = 'DECMN'

   if @w_mgnrdec = 'N'
      select @w_prec = 0

end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if      @i_fecha  = NULL or 
		@i_moneda = NULL 
	begin
		/* Campos NOT NULL con valores nulos */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end
end


if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D'
begin
	select @w_mon1 = pa_int 
	from  cobis..cl_parametro 
	where pa_producto = 'CON'
	and   pa_nemonico = 'MON1'		

	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601500
		return 1
	end

	select @w_mon2 = pa_int
	from  cobis..cl_parametro 
	where pa_producto = 'CON'
	and   pa_nemonico = 'MON2'		

	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601501
		return 1
	end
		
	/*select @w_mon_base = 0	A. Núñez Esp. CD00073 12/Mar/03*/
end


/* Insercion de cotizacion */
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1 
		begin
			/* Codigo de cotizacion ya existe */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601063
			return 1
		end
	
		/* Insercion del registro */
		/**************************/


		if exists (select top 1 * from cob_conta..cb_cotizacion
		           where ct_moneda = @i_moneda) begin
           select @w_existe = 0
           
           select @w_diaant = dateadd (dd,-1, @i_fecha)
           
		   select  @w_existe = 1
                   from cob_conta..cb_cotizacion   
                   where ct_fecha = @w_diaant
                   and   ct_moneda = @i_moneda
           
		   if @w_existe = 0
		   begin
		   	/* Codigo de cotizacion ya existe */
		   	exec cobis..sp_cerror
		   	@t_debug = @t_debug,
		   	@t_file  = @t_file,
		   	@t_from  = @w_sp_name,
		   	@i_num   = 601185
		   	return 1
		   end        
		end
		
		if @i_moneda not in (@w_mon1,@w_mon2,@w_mon_base)
		begin
			select @w_trm    = ct_valor
			from   cob_conta..cb_cotizacion
			where  ct_fecha  = @i_fecha  
			and    ct_moneda = @w_mon1

			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601502
				return 1
			end

			select @i_valor = @w_trm * round(@i_factor1,7)

		end

		insert into cob_conta..cb_cotizacion  (ct_fecha,ct_moneda,ct_valor,
					    ct_compra,ct_venta,ct_factor1,ct_factor2)	
				values     (@i_fecha,@i_moneda,@i_valor,
					    @i_compra,@i_venta,round(@i_factor1,7),round(@i_factor2,7))

		if @@error <> 0 
		begin
			/* Error en insercion de Cotizacion */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603026
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cotizacion
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_fecha,@i_moneda,@i_valor,@i_compra,@i_venta)

		if @@error <> 0
		begin
			/* Error en insercion de transaccion de servicio */
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

/* Actualizacion de cotizacion (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* Cotizacion a actualizar NO existe */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 605038
		return 1
	end
	
	/*  Actualizacion del registro  */
	/********************************/


	if @i_moneda not in (@w_mon1,@w_mon2,@w_mon_base)
	begin
		select @w_trm    = ct_valor
		from   cob_conta..cb_cotizacion
		where  ct_fecha  = @i_fecha  
		and    ct_moneda = @w_mon1

		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601502
			return 1
		end

		select @i_valor = @w_trm * round(@i_factor1,7)

	end

	begin tran
		update  cob_conta..cb_cotizacion  
		set     ct_valor = @i_valor,
			ct_compra = @i_compra,
			ct_venta = @i_venta,
			ct_factor1 = round(@i_factor1,7),	--OJE
			ct_factor2 = round(@i_factor2,7)	--OJE
		where   ct_fecha = @i_fecha  and
			ct_moneda = @i_moneda

		if @@error <> 0
		begin
			/* Error en Actualizacion de Cotizacion */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 605039
			return 1
		end

		if @i_moneda = @w_mon1
		begin
			update  cob_conta..cb_cotizacion  
			set     ct_valor = @i_valor * ct_factor1
			where   ct_fecha = @i_fecha  and
				ct_moneda not in (@w_mon1,@w_mon2,@w_mon_base)

			if @@error <> 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 605039
				return 1
			end
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cotizacion
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_fecha,@w_moneda,@w_valor,@w_compra,@w_venta)

		if @@error <> 0
		begin
			/* Error en insercion de transaccion de servicio */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

		insert into ts_cotizacion
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_fecha,@i_moneda,@i_valor,@i_compra,@i_venta)

		if @@error <> 0
		begin
			/* Error en insercion de transaccion de servicio */
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

/* Eliminacion de Cotizacion  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* Cotizacion a eliminar NO existe */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 607057
		return 1
	end

    select @w_diaant = dateadd (dd,-1, @i_fecha)

    select @w_existe = 0

	select  @w_existe = 1
    from cob_conta..cb_cotizacion   
    where ct_fecha = @w_diaant
    and   ct_moneda = @i_moneda

    select @w_diaant = dateadd (dd,1, @i_fecha)

	select  @w_existe = @w_existe + 1
    from cob_conta..cb_cotizacion   
    where ct_fecha = @w_diaant
    and   ct_moneda = @i_moneda

	if @i_moneda = @w_mon1
	begin
        if @w_existe = 2
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601503
			return 1
		end
                    
		if exists( 	select 1 from cob_conta..cb_cotizacion
				where ct_fecha   = @i_fecha 
				and   ct_moneda  not in (@w_mon1,@w_mon2,@w_mon_base)
			)
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601503
			return 1
		end
	end


	begin tran
		delete cob_conta..cb_cotizacion
		where   ct_fecha  = @i_fecha and
		ct_moneda = @i_moneda

		if @@error <> 0
		begin
			/* Error en la Eliminacion de Cotizacion*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607058
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cotizacion
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_fecha,@w_moneda,@w_valor,@w_compra,@w_venta)

		if @@error <> 0
		begin
			/* Error en insercion de transaccion de servicio */
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

/**** All   ****/

if @i_operacion = 'A'
begin
	select ct_moneda,ct_compra,ct_factor1,ct_factor2	--OJE
	from cob_conta..cb_cotizacion
	where ct_fecha = @i_fecha


	if @@rowcount = 0
	begin

		/* No existen Cotizaciones */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601064
		return 1
	end

	return 0
end


/**** Value ****/
/***************/

if @i_operacion = 'V'
begin
        if @w_existe = 0 and @i_opcion = 1
           begin

	/* OJE	*/
	select @w_mon1 = pa_int 
	from cobis..cl_parametro 
	where pa_nemonico = 'MON1'		
        and   pa_producto = 'CON'

	select @w_mon2 = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'MON2'		
        and   pa_producto = 'CON'

	if (@i_moneda <> @w_mon1) and (@i_moneda <> @w_mon2)
	begin
		
                
		select  @w_valor  = ct_valor ,
			@w_compra = round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			@w_venta = round(convert(float,ct_venta),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			@w_factor1 = ct_factor1,
			@w_factor2 = ct_factor2
	       	   from cob_conta..cb_cotizacion   
		   where   ct_fecha = @i_fecha   and
		           ct_moneda = @i_moneda

		   if @@rowcount <> 0
			select @w_existe = 1
		   else
			select @w_existe = 0
                
		if @w_existe = 1
		begin

			select  @w_valor  = ct_valor 
	       	   	  from  cob_conta..cb_cotizacion   
		   	 where  ct_fecha = @i_fecha   and
		           	ct_moneda = @w_mon1

			select @w_vmon1 = round((@w_factor1 * @w_valor),@w_prec)	-- A. Núñez Esp. CD00073 12/Mar/03

			select  @w_valor  = ct_valor 
	       	   	  from  cob_conta..cb_cotizacion   
		   	 where  ct_fecha = @i_fecha   and
		           	ct_moneda = @w_mon2

			select @w_vmon2 = round((@w_factor2 * @w_valor),@w_prec)	-- A. Núñez Esp. CD00073 12/Mar/03

			select @w_compra,@w_venta,@w_vmon1,@w_vmon2
		end
		else
		begin
			/* Cotizacion consultada no existe  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
	end
	else
	begin
                /*select @i_fecha = max(ct_fecha)
		from cob_conta..cb_cotizacion   
		where   ct_moneda = @i_moneda

		if @@rowcount <> 0
                begin */
		   select  @w_fecha = ct_fecha,
			@w_moneda = ct_moneda,
			@w_valor  = round(convert(float,ct_valor),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			@w_compra = round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			@w_venta = round(convert(float,ct_venta),@w_prec)	-- A. Núñez Esp. CD00073 12/Mar/03
	       	   from cob_conta..cb_cotizacion   
		   where   ct_fecha = @i_fecha   and
		           ct_moneda = @i_moneda
               
		   if @@rowcount <> 0
			select @w_existe = 1
		   else
			select @w_existe = 0
              /*  end**/
           end
		if @w_existe = 1
			select @w_compra,@w_venta,@w_valor
		else
		begin
			/* Cotizacion consultada no existe  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
	end
	else
			select @w_compra,@w_venta,@w_valor
	return 0
end

-- /**** Search ****/
-- /****************/

if @i_operacion = 'S'
begin

	select @w_mon1 = pa_int 
	from cobis..cl_parametro 
	where pa_nemonico = 'MON1'		
        and   pa_producto = 'CON'

	select @w_mon2 = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'MON2'		
        and   pa_producto = 'CON'

	/* OJE */
	if (@i_moneda <> @w_mon1) and (@i_moneda <> @w_mon2) and (@i_moneda <> @w_mon_base)	-- A. Núñez Esp. CD00073 12/Mar/03
	begin
		select @w_exito = 1
	end
	else
	begin
		select @w_exito = 0
	end
	
	select @w_exito
        select @w_mon1
        select @w_mon2

	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Fecha' = convert(char(12),ct_fecha,@i_formato_fecha),
			'Promedio Compra'= round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'Promedio Venta '= round(convert(float,ct_venta),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'T.R.M' = round(convert(float,ct_valor),@w_prec),		-- A. Núñez Esp. CD00073 12/Mar/03
			'Factor 1' = ct_factor1,
			'Factor 2' = ct_factor2
		from cob_conta..cb_cotizacion
		where ct_moneda = @i_moneda
		order by ct_fecha 

		if @@rowcount = 0
		begin
			/* No existen Cotizaciones */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
		set rowcount 0
	end
	if @i_modo = 1
	begin
		select 	'Fecha' = convert(char(12),ct_fecha,@i_formato_fecha),
			'Promedio Compra'= round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'Cotizacion Venta '= round(convert(float,ct_venta),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'T.R.M' = round(convert(float,ct_valor),@w_prec),		-- A. Núñez Esp. CD00073 12/Mar/03
			'Factor 1' = ct_factor1,
			'Factor 2' = ct_factor2
		from cob_conta..cb_cotizacion
		where 	ct_moneda = @i_moneda and
                        ct_fecha  > @i_fecha
		order by ct_fecha 

		if @@rowcount = 0
		begin
			/* 'No existen Cotizaciones '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
		set rowcount 0
	end

	return 0

end

if @i_operacion = 'Z'
begin
	/* consulta de cotizaciones diarias de un rango de fechas */
	set rowcount 20
	if @i_modo = 0
	begin
		select  'Fecha' = convert(char(12),ct_fecha,@i_formato_fecha),
			'Promedio Compra'= round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'Cotizacion Venta '= round(convert(float,ct_venta),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'T.R.M' = round(convert(float,ct_valor),@w_prec),		-- A. Núñez Esp. CD00073 12/Mar/03
			'Factor 1' = ct_factor1,
			'Factor 2' = ct_factor2
		from cob_conta..cb_cotizacion
		where 	ct_fecha between @i_fecha and @i_fecha1 and
			ct_moneda = @i_moneda
		order by ct_fecha

		if @@rowcount = 0
		begin
			/* No existen Cotizaciones */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select  'Fecha' = convert(char(12),ct_fecha,@i_formato_fecha),
			'Promedio Compra'= round(convert(float,ct_compra),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'Cotizacion Venta '= round(convert(float,ct_venta),@w_prec),	-- A. Núñez Esp. CD00073 12/Mar/03
			'T.R.M' = round(convert(float,ct_valor),@w_prec),		-- A. Núñez Esp. CD00073 12/Mar/03
			'Factor 1' = ct_factor1,
			'Factor 2' = ct_factor2
		from cob_conta..cb_cotizacion
		where 	ct_fecha between @i_fecha and @i_fecha1 and
			ct_fecha > @i_fecha and
			ct_moneda = @i_moneda
		order by ct_fecha

		if @@rowcount = 0
		begin
			/* No existen Cotizaciones */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601064
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'C'
begin
	if @i_dpv_me = 0
		select @w_cotiza_com = 0
    	else begin
		select @w_cotiza_com = @i_dpv_mn / @i_dpv_me
		select @w_cotiza_com = floor(@w_cotiza_com*10000000)/10000000
	end
	if @i_tm_deb_me = 0
		select @w_cotiza_ven = 0
	else begin
		select @w_cotiza_ven = @i_tm_deb_mn / @i_tm_deb_me
		select @w_cotiza_ven = floor(@w_cotiza_ven*10000000)/10000000
	end
	begin tran
		if @w_existe = 1 
		begin
			/* Codigo de cotizacion ya existe  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601063
			return 1
		end
	
		/* Insercion del registro */
		/**************************/

		insert into cob_conta..cb_cotizacion  (ct_fecha,ct_moneda,
					    ct_compra,ct_venta,ct_valor)
		values (@i_fecha,@i_moneda,@w_cotiza_com,
			@w_cotiza_ven,@i_valor)

		if @@error <> 0 
		begin
			/* Error en insercion de Cotizacion */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603026
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/
		insert into ts_cotizacion          
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,          
			@s_ofi,@i_fecha,@i_moneda,@i_valor,          
			@w_cotiza_com,@w_cotiza_ven)          

		if @@error <> 0          
		begin          
			-- /* Error en insercion de transaccion de servicio  */
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

if @i_operacion = 'B'
begin

    /* se retorna el valor TRM y el parametro MEXT  SYR */        

    select @w_mext = pa_smallint
    from cobis..cl_parametro
    where pa_nemonico = 'MEXT'
    and   pa_producto = 'CON'

    select @w_mon1 = pa_int 
    from cobis..cl_parametro 
    where pa_nemonico = 'MON1'		
    and   pa_producto = 'CON'

    if @i_moneda = @w_mon1
    begin
	select @w_trm = round(convert(float,ct_valor),@w_prec)	-- A. Núñez Esp. CD00073 12/Mar/03
	from cob_conta..cb_cotizacion
	where ct_fecha = @i_fecha
	  and ct_moneda = @i_moneda
    end
    else
    begin
	select @w_trm = ct_valor
	from cob_conta..cb_cotizacion
	where ct_fecha = @i_fecha
	  and ct_moneda = @w_mon1

	select @w_trm = round(convert(float,(ct_factor1 * @w_trm)),@w_prec)	-- A. Núñez Esp. CD00073 12/Mar/03
	from cob_conta..cb_cotizacion
	where ct_fecha = @i_fecha
	  and ct_moneda = @i_moneda
    end

    select @w_mext, @w_trm
    return 0

end

if @i_operacion = 'R'
begin

	select @w_mon1 = pa_int 
	from cobis..cl_parametro 
	where pa_nemonico = 'MON1'		
        and   pa_producto = 'CON'

	select @w_mon2 = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'MON2'		
        and   pa_producto = 'CON'

	select mo_descripcion
	from cobis..cl_moneda
	where mo_moneda = @w_mon1

	select mo_descripcion
	from cobis..cl_moneda
	where mo_moneda = @w_mon2
	return 0
end


if @i_operacion = 'E'
begin

	select round(convert(float,ct_valor),@w_prec)		-- A. Núñez Esp. CD00073 12/Mar/03
	from cob_conta..cb_cotizacion
        where ct_moneda  = @i_moneda
        and   ct_fecha   = @i_fecha


	return 0
end

go
