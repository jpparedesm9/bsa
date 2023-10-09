/************************************************************************/
/*                                  IMPORTANTE                          */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA                    AUTOR                       RAZON           */
/* 12/may/2016              KME                  Migracion CEN          */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_serbdom')
  drop proc sp_serbdom
go

CREATE proc sp_serbdom (

		@s_ssn		    int,
        @s_sesn         int            = null,
		@s_user		    login          = null,
		@s_term		    varchar(30)    = null,
		@s_date		    datetime,
		@s_srv		    varchar(30)    = null,
		@s_lsrv		    varchar(30)    = null,
        @s_ofi          smallint       = null,
		@s_rol		    smallint       = NULL,
		@s_org_err	    char(1)        = NULL,
		@s_error	    int            = NULL,
		@s_sev		    tinyint        = NULL,
		@s_msg		    descripcion    = NULL,
		@s_org		    char(1)        = NULL,
		@t_debug 	    char (1)       = 'N',
		@t_file		    varchar (14)   = null,
		@t_from		    varchar (30)   = null,
		@t_trn		    smallint       = null,
		@i_operacion	char (1),
		@i_modo		    tinyint        = null,
        @i_tipo         char (1)       = null,
		@i_codigo       catalogo       = null,
		@i_descripcion	descripcion    = null,
		@i_producto 	tinyint        = null,
		@i_valor	    money          = null,
		@i_causal_cte   catalogo       = null,
		@i_causal_aho	catalogo       = null,
        @i_estado       estado         = null,
		@t_show_version bit            = 0

)

as
declare		    @w_sp_name	      char (10),
		        @w_return	      int,
		        @w_siguiente	  int,
                @w_bandera        varchar(1), 
		        @w_codigo	      catalogo,
		        @w_descripcion	  descripcion,
		        @w_producto	      tinyint,
		        @w_valor	      money,
		        @w_causal_cte	  catalogo,
		        @w_causal_aho	  catalogo,
                @w_estado         estado,
		        @w_abr_producto   char(3),
		        @v_codigo	      catalogo,
		        @v_descripcion	  descripcion,
                @v_producto       tinyint,
                @v_valor          money,
                @v_causal_cte     catalogo,
                @v_causal_aho     catalogo,
                @v_estado         estado
				
/*  Inicializacion de Variables  */

select	@w_sp_name = 'sp_serbdom'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
/*  Insert  */

if @i_operacion = 'I'
begin
if @t_trn = 1415 
begin
    if exists ( select sb_codigo  from cl_servicio_bandom 
 		 where sb_codigo = @i_codigo )
    begin
	/*  Ya existe codigo  */

	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 101167

	return 1

    end

	begin tran

        /* insertar los datos de entrada */

	insert into cl_servicio_bandom 	(sb_codigo, sb_descripcion, sb_producto,  sb_valor, sb_causal_cte, sb_causal_aho,sb_estado)

	         values	                (@i_codigo, @i_descripcion, @i_producto, @i_valor, @i_causal_cte, @i_causal_aho,  'V')
	if @@error <> 0
	begin

		/*  Error en creacion de Servicio de Banca Domiciliaria  */

		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 105083 

		return 1

	end



	/*  Transaccion de Servicio  */

	insert into ts_servicio_bandom (secuencial, tipo_transaccion, clase,    fecha,    usuario,       terminal,      srv,  lsrv,

                                    codigo,      descripcion,    producto,  valor,    cau_cte,       cau_aho,      estado  )                           

	values	                      (@s_ssn,       @t_trn,        'N',        getdate(),@s_user,       @s_term,       @s_srv, @s_lsrv,
                                   @i_codigo,  @i_descripcion, @i_producto, @i_valor, @i_causal_cte, @i_causal_aho,  'V')

	if @@error <> 0
	begin
		/*  Error en creacion de transaccion de servicio  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 103005

		return 1

	end

        select @w_bandera = 'S' 

	commit tran



        if @w_bandera = 'S'

        begin

                /* Actualizacion de la los datos en el catalogo */

                exec @w_return = sp_catalogo

                        @s_ssn                     = @s_ssn,

                        @s_user                    = @s_user,

                        @s_sesn                    = @s_sesn,

                        @s_term                    = @s_term,

                        @s_date                    = @s_date,

                        @s_srv                     = @s_srv,

                        @s_lsrv                    = @s_lsrv,

                        @s_rol                     = @s_rol,

                        @s_ofi                     = @s_ofi,

                        @s_org_err                 = @s_org_err,

                        @s_error                   = @s_error,

                        @s_sev                     = @s_sev,

                        @s_msg                     = @s_msg,

                        @s_org                     = @s_org,

                        @t_debug                   = @t_debug,

                        @t_file                    = @t_file,

                        @t_from                    = @w_sp_name,

                        @t_trn                     = 584,

                        @i_operacion               = 'I',

                        @i_tabla                   = 'cl_servicio_bandom',

                        @i_codigo                  = @i_codigo,

                        @i_descripcion             = @i_descripcion,

                        @i_estado                  = 'V'

                if @w_return <> 0

                        return @w_return

        end

 

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

	return 1

end



end





/*  Update  */

if @i_operacion = 'U'

begin



if @t_trn = 1416

begin



	select	@w_descripcion	= sb_descripcion,

		@w_producto	= sb_producto,

                @w_valor        = sb_valor,

                @w_causal_cte	= sb_causal_cte,

		@w_causal_aho	= sb_causal_aho,

		@w_estado	= sb_estado

	  from	cl_servicio_bandom

	 where	sb_codigo = @i_codigo



	if @@rowcount <> 1

	begin

		/*  Codigo de Servicio de Banca Domiciliaria no existe  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 105086 

		return 1

	end

	select	@v_descripcion	= @w_descripcion,

		@v_producto	= @w_producto,

                @v_valor	= @w_valor,

		@v_causal_cte	= @w_causal_cte,

		@v_causal_aho	= @w_causal_aho,

                @v_estado       = @w_estado

	

	if @w_descripcion = @i_descripcion

		select	@w_descripcion = null,

			@v_descripcion = null

	else	 select	@w_descripcion = @i_descripcion



	if @w_producto = @i_producto

		select	@w_producto = null,

			@v_producto = null

	else	 select	@w_producto = @i_producto



        if @w_valor = @i_valor

                select  @w_valor = null,

                        @v_valor = null

        else     select @w_valor = @i_valor



        if @w_causal_cte = @i_causal_cte

                select  @w_causal_cte = null,

                        @v_causal_cte = null

        else     select @w_causal_cte = @i_causal_cte



        if @w_causal_aho = @i_causal_aho

                select  @w_causal_aho = null,

                        @v_causal_aho = null

        else     select @w_causal_aho = @i_causal_aho

        if @w_estado = @i_estado

           select @w_estado = null, @v_estado = null

        else

        begin

            if @i_estado = 'C'

            begin

                if exists (select *

    	        	     from cl_servicio_bandom

                            where sb_codigo = @i_codigo)

	        begin

	           exec sp_cerror

		   @t_debug	= @t_debug,

		   @t_file	= @t_file,

		   @t_from	= @w_sp_name,

		   @i_num	= 101114

		   /* Existe referencia en plan */

		   return 1

	        end 

            end

            select @w_estado = @i_estado

        end

	begin tran

	update	cl_servicio_bandom

	   set	sb_descripcion 	= @i_descripcion,

		sb_producto 	= @i_producto,

		sb_valor	= @i_valor,

		sb_causal_cte	= @i_causal_cte,

		sb_causal_aho	= @i_causal_aho,

                sb_estado       = @i_estado

	 where	sb_codigo	= @i_codigo



	if @@rowcount <> 1

	begin

		/*  Error en actualizacion de servicio banca domiciliaria  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 105084

		return 1

	end



	/*  Transaccion de Servicio - Previo */

	insert into ts_servicio_bandom	(secuencial, tipo_transaccion, clase, fecha, 

				usuario, terminal, srv, lsrv,

				codigo, descripcion, producto, 

                                valor, cau_cte, cau_aho,

                                estado)

			values	(@s_ssn, @t_trn, 'P', getdate(),

				@s_user, @s_term, @s_srv, @s_lsrv,

				@i_codigo, @v_descripcion, @v_producto,

                                @v_valor, @v_causal_cte, @v_causal_aho,

                                @v_estado)

	if @@error <> 0

	begin

		/*  Error en creacion de transaccion de servicio  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 103005

		return 1

	end



	/*  Transaccion de Servicio - Actual */

	insert into ts_servicio_bandom	(secuencial, tipo_transaccion, clase, fecha, 

				usuario, terminal, srv, lsrv,

                                codigo, descripcion, producto,

                                valor, cau_cte, cau_aho,

                                estado)      

			values	(@s_ssn, @t_trn, 'A', getdate(),

				@s_user, @s_term, @s_srv, @s_lsrv,

				@i_codigo, @w_descripcion, @w_producto,

				@w_valor, @w_causal_cte, @w_causal_aho,

                                @w_estado)

	if @@error <> 0

	begin

		/*  Error en creacion de transaccion de servicio  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 103005 

		return 1

	end

                select @w_bandera = 'S'   

	commit tran



        if @w_bandera = 'S'

        begin

                exec @w_return = sp_catalogo

                        @s_ssn                     = @s_ssn,

                        @s_user                    = @s_user,

                        @s_sesn                    = @s_sesn,

                        @s_term                    = @s_term,

                        @s_date                    = @s_date,

                        @s_srv                     = @s_srv,

                        @s_lsrv                    = @s_lsrv,

                        @s_rol                     = @s_rol,

                        @s_ofi                     = @s_ofi,

                        @s_org_err                 = @s_org_err,

                        @s_error                   = @s_error,

                        @s_sev                     = @s_sev,

                        @s_msg                     = @s_msg,

                        @s_org                     = @s_org,

                        @t_debug                   = @t_debug,

                        @t_file                    = @t_file,

                        @t_from                    = @w_sp_name,

                        @t_trn                     = 585,

                        @i_operacion               = 'U',     

                        @i_tabla                   = 'cl_servicio_bandom',

                        @i_codigo                  = @i_codigo,

                        @i_descripcion             = @i_descripcion,

                        @i_estado                  = @i_estado



                if @w_return <> 0

                        return @w_return



        end

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

	return 1

end



end





/*  Delete  */

if @i_operacion = 'D'

begin



if @t_trn = 1417 

begin

        select  @w_descripcion  = sb_descripcion,

                @w_producto     = sb_producto,

                @w_valor        = sb_valor,

                @w_causal_cte   = sb_causal_cte,

                @w_causal_aho   = sb_causal_aho,

                @w_estado       = sb_estado

          from  cl_servicio_bandom

         where  sb_codigo = @i_codigo

	

	if @@rowcount = 0

	begin

		/*  Cuenta de balance no existe  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 101162

		return 1

	end



        /* no se puede borrar si existe referencia en un plan */

        if exists (select *

           	     from cl_servicio_bandom

                            where sb_codigo = @i_codigo)

	begin

	     exec sp_cerror

	        @t_debug = @t_debug,

	        @t_file	 = @t_file,

		@t_from	 = @w_sp_name,

		@i_num	 = 101114

		/* Existe referencia en plan */

	     return 1

        end

    

	begin tran

	  delete cl_servicio_bandom

	   where sb_codigo = @i_codigo

	  if @@error <>0

	  begin

		/*  Error en eliminacion de Cuenta de Balance  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 105085 

		return 1

	   end



	  /*  Transaccion de Servicio  */

	  insert into ts_servicio_bandom (secuencial, tipo_transaccion, clase, fecha, 

				usuario, terminal, srv, lsrv,

                                codigo, descripcion, producto,

                                valor, cau_cte, cau_aho,

                                estado)           

			values	(@s_ssn, @t_trn, 'B', getdate(),

				@s_user, @s_term, @s_srv, @s_lsrv,

				@i_codigo, @w_descripcion, @w_producto, 

				@w_valor, @w_causal_cte,@w_causal_aho,

                                @w_estado)

	if @@error <> 0

	begin

		/*  Error en creacion de transaccion de servicio  */

		exec cobis..sp_cerror

			@t_debug= @t_debug,

			@t_file	= @t_file,

			@t_from	= @w_sp_name,

			@i_num	= 103005

		return 1

	end

	commit tran

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

	return 1

end



end



/*  Search  */

if @i_operacion = 'S' 

 begin



if @t_trn = 1419 

begin



     set rowcount 20

     if @i_modo = 0

	select 'Codigo' = sb_codigo,

	       'Descripcion' = convert(char(30),sb_descripcion),

	       'Producto'   = sb_producto,

	       'Valor '	= sb_valor,

               'Causal_Cte ' = sb_causal_cte,

	       'Causal_Aho ' = sb_causal_aho,

	       'Estado' = sb_estado

	from   cl_servicio_bandom

     else

	if @i_modo = 1

        select 'Codigo' = sb_codigo,

               'Descripcion' = convert(char(30),sb_descripcion),

               'Producto'   = sb_producto,

               'Valor ' = sb_valor,

               'Causal_Cte ' = sb_causal_cte,

               'Causal_Aho ' = sb_causal_aho,

               'Estado' = sb_estado

        from   cl_servicio_bandom

	where  sb_codigo > @i_codigo

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

	return 1

end

end



/* ** Help ** */

if @i_operacion = 'H'

begin



if @t_trn = 1418 

begin



	if @i_tipo = 'A'

	begin

	set rowcount 20

	if @i_modo = 0

		select	'Codigo ' = sb_codigo,

			'Descripcion ' = convert(char(30),sb_descripcion),

			'Producto ' = sb_producto,

			'Valor ' = sb_valor,

			'Causal_Cte ' = sb_causal_cte,

			'Causal_Aho ' = sb_causal_aho

		  from  cl_servicio_bandom

		 where  sb_estado = 'V'



	else

	if @i_modo = 1

               select  'Codigo ' = sb_codigo,

                        'Descripcion ' = convert(char(30),sb_descripcion),

                        'Producto ' = sb_producto,

                        'Valor ' = sb_valor,

                        'Causal_Cte ' = sb_causal_cte,

                        'Causal_Aho ' = sb_causal_aho

                  from  cl_servicio_bandom

                 where  sb_codigo > @i_codigo

		 and	sb_estado = 'V' 



	set rowcount 0

	return 0

        end

 

	if @i_tipo = 'V'

	begin

		select convert(char(30),sb_descripcion),

                       sb_producto,

		       sb_valor,

		       sb_causal_cte,

		       sb_causal_aho

		  from cl_servicio_bandom

		 where sb_codigo = @i_codigo

                   and sb_estado = 'V'

		if @@rowcount = 0

		begin

			exec sp_cerror

				@t_debug	= @t_debug,

				@t_file		= @t_file,

				@t_from		= @w_sp_name,

				@i_num		= 101001

			return 1 

		end

		return 0

	end



end

else

begin

	exec sp_cerror

	   @t_debug	 = @t_debug,

	   @t_file	 = @t_file,

	   @t_from	 = @w_sp_name,

	   @i_num	 = 151051

	   /*  'No corresponde codigo de transaccion' */

	return 1

end



end


