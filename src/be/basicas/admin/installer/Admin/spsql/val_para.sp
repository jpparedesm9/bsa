/************************************************************************/
/*	Archivo: 		val_para.sp				*/
/*	Stored procedure: 	sp_valor_parametros       		*/
/*	Base de datos:  	cobis		         		*/
/*	Producto:               Administrador		       		*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura:	15/Abr/94				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa realiza la insercion de los valores de los parame_*/
/*	tros de las transacciones					*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Abr/94	F.Espinosa	Emision inicial			*/
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_valor_parametros')
   drop proc sp_valor_parametros







go
create proc sp_valor_parametros (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
	@i_pro		      	tinyint,
	@i_mon		      	tinyint,
	@i_tipo		      	char(1),
	@i_tdef		      	char(1) = null,
        @i_cod                	cuenta = null,
	@i_trn		      	smallint,
	@i_nem		      	descripcion,
	@i_integer	      	int = null,
	@i_smallint	      	smallint = null,
	@i_float	      	float = null,
	@i_money              	money = null,
	@i_cat		      	char (1) = null
)
as
declare @w_return		int,
	@w_sp_name		varchar(30),
	@w_null			int,
	@w_cliente		int,
	@w_tdato		descripcion,
        @w_codigo               int,
	@w_pro		      	tinyint,
	@w_mon		      	tinyint,
	@w_tipo		      	char(1),
	@w_tdef		      	char(1),
        @w_cod                	cuenta ,
	@w_trn		      	smallint,
	@w_nem		      	descripcion,
	@w_integer	      	int,
	@w_smallint	      	smallint,
	@w_float	      	float,
	@w_money              	money,
	@w_cat		      	char (1),
	@v_pro		      	tinyint,
	@v_mon		      	tinyint,
	@v_tipo		      	char(1),
	@v_tdef		      	char(1) ,
        @v_cod                	cuenta,
	@v_trn		      	smallint,
	@v_nem		      	descripcion,
	@v_integer	      	int ,
	@v_smallint	      	smallint,
	@v_float	      	float,
	@v_money              	money,
	@v_cat		      	char (1)

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_valor_parametros'

/* Modo de debug */

if @t_trn = 1530
begin

/* Chequear que exista el tipo de default */
exec @w_return = cobis..sp_catalogo
	     @t_debug	   = @t_debug,
	     @t_file	   = @t_file,
	     @t_from	   = @w_sp_name,
	     @i_tabla	   = 'cl_tdefault',
	     @i_operacion  = 'E',
	     @i_codigo	   = @i_tdef

if @w_return != 0
begin
         /* No existe tipo de default */
	 exec cobis..sp_cerror
	      @t_debug	 = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 201059
	 return 1
end


/* Chequear que exista la categoria */
if @i_cat is not null
begin
	exec @w_return = cobis..sp_catalogo
		     @t_debug	   = @t_debug,
		     @t_file	   = @t_file,
		     @t_from	   = @w_sp_name,
		     @i_tabla	   = 'cc_categoria',
		     @i_operacion  = 'E',
		     @i_codigo	   = @i_cat
	if @w_return != 0
	begin
	         /* No existe categoria de cuenta corriente */
		 exec cobis..sp_cerror
		      @t_debug	 = @t_debug,
		      @t_file	 = @t_file,
		      @t_from	 = @w_sp_name,
		      @i_num	 = 201018
		 return 1
	end
end


/*  Verificar el tipo de dato  */
select @w_tdato = df_tdato
  from cobis..cl_default_tr
 where df_nemonico = @i_nem

if @@rowcount != 1
begin
	/*  No existe parametro de default  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @t_from,
		@i_num	= 151035
	return 1
end

/* Verificar que se pase un valor para el parametro indicado */
if (@w_tdato = 'INTEGER' and @i_integer is null) or
   (@w_tdato = 'SMALLINT' and @i_smallint is null) or
   (@w_tdato = 'FLOAT' and @i_float is null) or
   (@w_tdato = 'MONEY' and @i_money is null)
begin 
	/*  Tipo de dato no corresponde a parametro escogido  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @t_from,
		@i_num	= 101095
	return 1
end
		

begin tran
 /* si se desea ingresar un default */
 if @i_tdef = 'D'
 begin
   /* Verifica si no existe previamente el registro */
   if exists	(select	*
		   from	cobis..cl_def_tran
		  where	dt_producto = @i_pro
		    and	dt_tipo	= @i_tipo
		    and	dt_moneda = @i_mon
		    and	dt_transaccion = @i_trn
		    and	dt_default = @i_nem
                    and dt_categoria = @i_cat)
   begin

  		select  @w_pro	      	= dt_producto,
			@w_mon	     	= dt_moneda, 
			@w_tipo	      	= dt_tipo,
			@w_trn	      	= dt_transaccion,
			@w_nem	      	= dt_default,
			@w_integer	= dt_int,
			@w_smallint	= dt_smallint,
			@w_float	= dt_float,
			@w_money        = dt_money,
			@w_cat		= dt_categoria
			from cl_def_tran
	    	where	dt_producto = @i_pro
	           and	dt_tipo	= @i_tipo
	      	   and	dt_moneda = @i_mon
	           and	dt_transaccion = @i_trn
	           and 	dt_default = @i_nem
                   and  dt_categoria = @i_cat

  		select  @v_pro	      	= @w_pro 
		select	@v_mon	     	= @w_mon 
		select	@v_tipo	      	= @w_tipo
		select	@v_trn	      	= @w_trn
		select	@v_nem	      	= @w_nem
		select	@v_integer	= @w_integer
		select	@v_smallint	= @w_smallint
		select	@v_float	= @w_float
		select	@v_money        = @w_money
		select	@v_cat		= @w_cat

	        if @w_pro = @i_pro
		   select @w_pro = null, @v_pro = null
                else
	           select @w_pro = @i_pro

                if @w_mon = @i_mon
		   select @w_mon = null, @v_mon = null
  		else
	 	   select @w_mon = @i_mon

  		if @w_tipo = @i_tipo
		   select @w_tipo = null, @v_tipo = null
 		else
	 	   select @w_tipo = @i_tipo
  
  		if @w_trn = @i_trn
		   select @w_trn = null, @v_trn = null
  		else
		   select @w_trn = @i_trn

  		if @w_nem = @i_nem
		   select @w_nem = null, @v_nem = null
  		else
		   select @w_nem = @i_nem

  		if @w_integer = @i_integer
	           select @w_integer = null, @v_integer = null
  		else
		   select @w_integer = @i_integer

  		if @w_float = @i_float
	 	   select @w_float = null, @v_float = null
  		else
		   select @w_float = @i_float

  		if @w_money = @i_money
		   select @w_money = null, @v_money = null
  		else
		   select @w_money = @i_money

  		if @w_smallint = @i_smallint
		   select @w_smallint = null, @v_smallint = null
  		else
		   select @w_smallint = @i_smallint

  		if @w_cat = @i_cat
		   select @w_cat = null, @v_cat = null
  		else
		   select @w_cat = @i_cat

	   /* Actualiza el registro existente en cl_def_tran  */
	   update	cobis..cl_def_tran
	      set	dt_int = @i_integer,
			dt_smallint = @i_smallint,
			dt_float = @i_float,
			dt_money = @i_money
	    where	dt_producto = @i_pro
	      and	dt_tipo	= @i_tipo
	      and	dt_moneda = @i_mon
	      and	dt_transaccion = @i_trn
	      and 	dt_default = @i_nem
              and       dt_categoria = @i_cat
	    if @@error != 0
		/*  Error en actualizacion de default de transaccion  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 155019

	 /* transaccion servicios  */

	 insert into ts_val_tran (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       producto, tipo, moneda, transaccion,
			       defa, va_int, va_smallint, va_float, va_money,
			       categoria)
	 values (@s_ssn, 1530, 'P', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
   		 @v_pro, @v_tipo, @v_mon, @v_trn,
		 @v_nem, @v_integer, @v_smallint, @v_float, @v_money,
		 @v_cat)
	 if @@error != 0
	 begin
		exec sp_cerror
			@t_debug    = @t_debug,
			@t_file     = @t_file,
			@t_from     = @w_sp_name,
			@i_num      = 103005
		  	/* 'Error en creacion de transaccion de servicios'*/
		return 1
	 end

	 insert into ts_val_tran (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       producto, tipo, moneda, transaccion,
			       defa, va_int, va_smallint, va_float, va_money,
			       categoria)
	 values (@s_ssn, 1530, 'A', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
   		 @w_pro, @w_tipo, @w_mon, @w_trn,
		 @w_nem, @w_integer, @w_smallint, @w_float, @w_money,
		 @w_cat)
	 if @@error != 0
	 begin
	 	exec sp_cerror
			@t_debug    = @t_debug,
			@t_file     = @t_file,
			@t_from     = @w_sp_name,
			@i_num      = 103005
			/* 'Error en creacion de transaccion de servicios'*/
		return 1
	 end
  end 

   /*  si no existe el dato Insercion en la tabla cl_def_tran */
   else
   begin
	   insert into cobis..cl_def_tran 
			(dt_producto, dt_tipo, dt_moneda, dt_transaccion, 
			 dt_default, dt_int, dt_smallint, dt_float, dt_money,
			 dt_categoria)
   		 values (@i_pro, @i_tipo, @i_mon, @i_trn,
			 @i_nem, @i_integer, @i_smallint, @i_float, @i_money,
			 @i_cat)
	   if @@error != 0
	   begin 
	      /* Error en creacion de registro en cl_def_tran */
	      exec cobis..sp_cerror
	          @t_debug	= @t_debug,
	          @t_file	= @t_file,
	          @t_from	= @w_sp_name,
	          @i_num	= 103058 
	      return 1
	   end

	/* transaccion de servicio */
   	insert into ts_val_tran (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       producto, tipo, moneda, transaccion,
			       defa, va_int, va_smallint, va_float, va_money,
			 	categoria)
	       values (@s_ssn, 1530, 'N', @s_date,
		         @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
   		         @i_pro, @i_tipo, @i_mon, @i_trn,
			 @i_nem, @i_integer, @i_smallint, @i_float, @i_money,
			 @i_cat)
   		if @@error != 0
   		begin
			/*  'Error en creacion de transaccion de servicio' */
			exec sp_cerror
	  		 	@t_debug	 = @t_debug,
	  		 	@t_file	 = @t_file,
	  		 	@t_from	 = @w_sp_name,
	  		 	@i_num	 = 153023
			return 1
   		end
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
go
