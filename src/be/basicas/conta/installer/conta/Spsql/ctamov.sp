/************************************************************************/
/*	Archivo: 		ctamov.sp  				*/
/*	Stored procedure: 	sp_cuenta_movimiento			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           G. Jaramillo                        	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
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
/*	   consulta de cuentas de movimiento para ingreso en 		*/
/*         comprobantes.                         			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de Secciones	*/
/*	17/Mrz/1995	N Maldonado     Busqueda de Cuentas PG. 	*/
/*                                      opcion S, opcion2 1             */
/*	23/Abr/1999	Juan C. G¢mez	Se agrega concici¢n al query	*/
/*					JCG10				*/
/*      17/Nov/1999     Sandra Robayo   Se agregaron validaciones de    */
/*                                      cuenta                          */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_cuenta_movimiento')
	drop proc sp_cuenta_movimiento   

go
create proc sp_cuenta_movimiento    (
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
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta  = null,
	@i_cuenta_i 	cuenta = null,
	@i_cuenta_f 	cuenta = null,
	@i_cuenta1	cuenta = null,
	@i_oficina 	smallint = null ,
	@i_sinonimo	char(20) = null,
	@i_area 	smallint = null,
	@i_subopcion    tinyint = null,
        @i_fecha        datetime = null,
        @i_formato_fecha tinyint = 1,
        @i_estado       char(1)  = '%',
        @i_acceso       char(1)  = '%',
        @i_tabla        varchar(30) = null,
        @i_codigo       char(2) = null ,
	@o_cotiza       float    = null,
        @o_descripcion  varchar(30) = null
      

)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */

	@w_empresa 	tinyint ,
	@w_cuenta 	cuenta,
	@w_nombre	descripcion,
	@w_moneda	tinyint,
	@w_moneda_base	tinyint,
	@w_cotiza       float,
	@w_extranjera	char(1),
	@w_conteo       tinyint

select @w_today = getdate()
select @w_sp_name = 'sp_cuenta_movimiento'

/************************************************/
/*  Tipo de Transaccion = 607X                  */

if (@t_trn <> 6074 and @i_operacion = 'V') or
   (@t_trn <> 6074 and @i_operacion = 'W') or
   (@t_trn <> 6077 and @i_operacion = 'A') or
   (@t_trn <> 6499 and @i_operacion = 'L') or
   (@t_trn <> 6072 and @i_operacion = 'S') or
   (@t_trn <> 6074 and @i_operacion = 'H')
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
		s_ssn		= @s_ssn,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,   
		i_cuenta 	= @i_cuenta,
		i_oficina 	= @i_oficina,
		i_area		= @i_area
	exec cobis..sp_end_debug
end

/**** Value  ****/
/****************/

if @i_operacion = 'V'
begin
	if @i_cuenta is null
	begin
		if @i_sinonimo is null
		begin
			/* 'Campos NOT NULL con valores nulos' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
		end
		else 
		begin
                    /* Validaciones de cuenta SYR01 */

                    if NOT EXISTS (select 1 from cob_conta..cb_cuenta 
                       where cu_estado = 'V' and
			     cu_sinonimo = @i_sinonimo )
	            begin
                       /* cuenta no existe o no se encuentra vigente  */
			 exec cobis..sp_cerror
			 @t_debug = @t_debug,
			 @t_file	 = @t_file,
			 @t_from	 = @w_sp_name,
			 @i_num	 = 601028
			 return 1
	            end

                    if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
			            where cu_sinonimo = @i_sinonimo and
                                          cu_acceso = 'N' ) 
                    begin
                       /* cuenta no tiene acceso Normal  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601066
			return 1
                    end

                    if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
			            where cu_sinonimo = @i_sinonimo and
                                          cu_movimiento = 'S' ) 
                    begin
                       /* cuenta no es de movimiento  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601067
			return 1
                    end


	            if NOT EXISTS (select 1 from cob_conta..cb_plan_general
		      	           where pg_empresa = @i_empresa and
				         pg_cuenta = @i_sinonimo and
				         pg_oficina = @i_oficina and
				         pg_area = @i_area)
	            begin
                         /* cuenta no se encuentra asociada a oficina y area de destino */
			 exec cobis..sp_cerror
			 @t_debug = @t_debug,
			 @t_file	 = @t_file,
			 @t_from	 = @w_sp_name,
			 @i_num	 = 601068
			return 1
	            end



	        select pg_cuenta,cu_nombre,cu_moneda
		    from cob_conta..cb_plan_general,
			 cob_conta..cb_cuenta
		    where	pg_empresa = @i_empresa and
				pg_oficina = @i_oficina and
				pg_area    = @i_area and
				cu_empresa = pg_empresa and
				cu_cuenta = pg_cuenta and
				cu_sinonimo = @i_sinonimo and
				cu_movimiento = 'S'
				
            select @w_conteo = count(1)
            from cob_conta..cb_cuenta_proceso
            where cp_proceso = 6980
            and   cp_cuenta = @i_cuenta
            and   cp_empresa = @i_empresa
            
            if @w_conteo > 0
            begin
                 select @w_conteo = 1
            end
            else
            begin
                 select @w_conteo = 0
            end
            
            select @w_conteo

		end
	end
	else
	begin

             /* validaciones  de cuenta  SYR01*/
             if NOT EXISTS (select 1 from cob_conta..cb_cuenta 
                            where cu_estado = 'V' and
                              cu_cuenta = @i_cuenta)
      	     begin
                   /* cuenta no existe o no se encuentra vigente  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601028
			return 1
	     end


             if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                             where cu_cuenta = @i_cuenta and
                                   cu_acceso = 'N' ) 
             begin
                /* cuenta no tiene acceso Normal  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601066
			return 1
             end

             if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                             where cu_cuenta = @i_cuenta and
                              cu_movimiento = 'S' ) 
             begin
                 /* cuenta no es de movimiento  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601067
			return 1
             end


	     if NOT EXISTS (select 1 from cob_conta..cb_plan_general
		      	    where 	pg_empresa = @i_empresa and
				pg_cuenta = @i_cuenta and
				pg_oficina = @i_oficina and
				pg_area = @i_area)
	     begin
                  /* cuenta no se encuentra asociada a oficina y area de destino */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601068
			return 1
	     end

	     select pg_cuenta,cu_nombre,cu_moneda
	     from cob_conta..cb_plan_general,
		  cob_conta..cb_cuenta 
	     where	pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			pg_area	   = @i_area and
			pg_cuenta  = @i_cuenta  and
			cu_empresa = pg_empresa and
			cu_cuenta  = pg_cuenta and
			cu_movimiento = 'S'       and
                        cu_estado like @i_estado and
                        cu_acceso  like @i_acceso
                        
            select @w_conteo = count(1)
            from cob_conta..cb_cuenta_proceso
            where cp_proceso = 6980
            and   cp_cuenta = @i_cuenta
            and   cp_empresa = @i_empresa
            
            if @w_conteo > 0
            begin
                 select @w_conteo = 1
            end
            else
            begin
                 select @w_conteo = 0
            end                        
            
            select @w_conteo
	end

	/*if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601109
		return 1
	end */

        if @i_subopcion = 1
           begin
           select @w_moneda = cu_moneda
           from cb_cuenta
           where cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta

           select @w_moneda_base = em_moneda_base
           from cb_empresa
           where em_empresa = @i_empresa
         
        /* se elimina consulta de cotizacion MGV 31/10/1997 */    
        /*    if @w_moneda <> @w_moneda_base
   	      begin    
	      	exec @w_return = sp_cotizacion
                            @t_trn   	= 6144,
                            @i_operacion= 'V',
                            @i_opcion 	= @i_subopcion,
                            @i_moneda 	= @w_moneda,
                            @i_fecha  	= @i_fecha,
                            @i_formato_fecha = @i_formato_fecha,
			    @o_cotiza 	= @w_cotiza out   
		if @w_return <> 0
		   return @w_return
	        else
		   select @w_cotiza
 	      end
          */
           end
	return 0
end

/**** Value  ****/
/****************/

if @i_operacion = 'W'
begin
	if @i_cuenta is null
	begin
		if @i_sinonimo is null
		begin
			/* 'Campos NOT NULL con valores nulos' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
		end
		else 
		begin
		        select cu_cuenta,cu_nombre,cu_moneda
			from cob_conta..cb_cuenta
			where	cu_empresa = @i_empresa and
				cu_sinonimo = @i_sinonimo and
				cu_movimiento = 'S'

   	                if @@rowcount = 0
	                begin

                           /* cuenta no es de movimiento  */
			   exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 601067
			   return 1
                       end
		end
	end
	else
	begin

             if NOT EXISTS (select 1 from cob_conta..cb_cuenta 
                            where cu_estado = 'V' and
                              cu_cuenta = @i_cuenta)
      	     begin
                   /* cuenta no existe o no se encuentra vigente  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601028
			return 1
	     end


             if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                             where cu_cuenta = @i_cuenta and
                              cu_movimiento = 'S' ) 
             begin
                 /* cuenta no es de movimiento  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601067
			return 1
             end

             if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                             where cu_cuenta = @i_cuenta and
                                   cu_acceso = 'N' ) 
             begin
                /* cuenta no tiene acceso Normal  */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601066
			return 1
             end


	     select cu_cuenta,cu_nombre,cu_moneda
	     from cob_conta..cb_cuenta 
	     where	cu_empresa = @i_empresa and
			cu_cuenta  = @i_cuenta  and
			cu_movimiento = 'S'       and
                        cu_estado like @i_estado and
                        cu_acceso  like @i_acceso
	end

	/*if @@rowcount = 0
	begin
		
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601109
		return 1
	end*/

        if @i_subopcion = 1
           begin
           select @w_moneda = cu_moneda
           from cb_cuenta
           where cu_empresa = @i_empresa
             and cu_cuenta  = @i_cuenta

           select @w_moneda_base = em_moneda_base
           from cb_empresa
           where em_empresa = @i_empresa
         
        /* se elimina consulta de cotizacion MGV 31/10/1997 */    
        /*    if @w_moneda <> @w_moneda_base
   	      begin    
	      	exec @w_return = sp_cotizacion
                            @t_trn   	= 6144,
                            @i_operacion= 'V',
                            @i_opcion 	= @i_subopcion,
                            @i_moneda 	= @w_moneda,
                            @i_fecha  	= @i_fecha,
                            @i_formato_fecha = @i_formato_fecha,
			    @o_cotiza 	= @w_cotiza out   
		if @w_return <> 0
		   return @w_return
	        else
		   select @w_cotiza
 	      end
          */
           end
	return 0
end

/******** Busqueda de cuentas dadas una oficina y area *********/
if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Cuenta' = pg_cuenta,
			'Nombre' = cu_nombre
		--from cb_plan_general(1),cb_cuenta
		from cb_plan_general --(index i_pg_cuenta)
		,cb_cuenta
		where 	cu_empresa = @i_empresa and
			cu_cuenta like @i_cuenta1 and
			cu_movimiento = 'S'   and
                        cu_estado like @i_estado and
                        cu_acceso like @i_acceso and
                        pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			pg_area	   = @i_area and
			pg_cuenta = cu_cuenta
		order by pg_cuenta
	end
	else
	begin
		select 'Cuenta' = pg_cuenta,
		       'Nombre' = cu_nombre
		--from cob_conta..cb_plan_general,cob_conta..cb_cuenta
		from cb_plan_general--(index i_pg_cuenta)
		,cb_cuenta
		where 	pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			pg_area    = @i_area and
			pg_cuenta > @i_cuenta and
			pg_cuenta like @i_cuenta1 and
			cu_empresa = pg_empresa and
			cu_cuenta = pg_cuenta and
			cu_movimiento = 'S' 
		order by pg_cuenta
	end	

	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
		return 1
	end
	return 0
end

/*  busqueda de cuentas de movimiento relacionadas a una
    area de movimiento dada una oficina */
/*  con i_subopcion = 1 retorna las cuentas de movimientos de la empresa */

if @i_operacion = 'S'
begin
    set rowcount 20
    if @i_subopcion = 1
      begin
	if @i_modo = 0
	begin
		select 	cu_cuenta, cu_nombre
		from cb_cuenta 
		where 	cu_empresa = @i_empresa
                  and   cu_cuenta like rtrim(@i_cuenta) + '%'
                  and   cu_movimiento = 'S'
	end
	else
	begin
		select 	cu_cuenta, cu_nombre
		from cb_cuenta 
		where 	cu_empresa = @i_empresa
                  and   cu_cuenta > @i_cuenta
                  and   cu_movimiento = 'S'
        end
        set rowcount 0
        return 0
      end
    else
      begin
	if @i_modo = 0
	begin
		select 	pg_cuenta, pg_area
		from cob_conta..cb_plan_general,cob_conta..cb_cuenta,
		     cob_conta..cb_area
		where 	pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			cu_empresa = pg_empresa and
			cu_cuenta = pg_cuenta and
			cu_cuenta >= @i_cuenta_i and
			cu_cuenta <= @i_cuenta_f and
			cu_movimiento = 'S' and
			ar_empresa = @i_empresa and
			ar_area = pg_area and
			ar_movimiento = 'S'
		order by pg_cuenta, pg_area
	end
	else
	begin
		select  pg_cuenta, pg_area
		from cob_conta..cb_plan_general,cob_conta..cb_cuenta,
		     cob_conta..cb_area
		where 	pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
                      ((pg_cuenta = @i_cuenta and
                        pg_area > @i_area) or
		       (pg_cuenta > @i_cuenta)) and
			cu_cuenta >  @i_cuenta and
			cu_cuenta <= @i_cuenta_i and
			cu_empresa = pg_empresa and
			cu_cuenta = pg_cuenta and
			cu_movimiento = 'S' and
			ar_empresa = @i_empresa and
			ar_area = pg_area  and
			ar_movimiento = 'S'
		order by pg_cuenta, pg_area
	end	

	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
		return 1
	end
	return 0
      end
end

if @i_operacion = 'L'
begin

   select cu_cuenta, cu_nombre 
   from cb_cuenta
   where cu_empresa = @i_empresa and	--JCG10
	 cu_cuenta = @i_cuenta and
         cu_movimiento = 'S'

   if @@rowcount = 0
   begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609140
		return 1
   end
   return 0

end


if @i_operacion = 'H'
begin
	     select 
            @o_descripcion = b.valor
		    from  cobis..cl_tabla a, cobis..cl_catalogo b
		    where a.tabla = @i_tabla
		      and a.codigo = b.tabla
              and b.codigo = @i_codigo
		
			if @@rowcount = 0
			begin
	 	    	exec cobis..sp_cerror
 	  	    	@t_debug = @t_debug,
	   	    	@t_file  = @t_file, 
	    	    @t_from  = @w_sp_name,
	     		@i_num   = 601159
	      		return 1 
		    end
      select @o_descripcion
end

go
