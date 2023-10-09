/************************************************************************/
/*	Archivo:		vigencia.sp				*/
/*	Stored procedure:	sp_vigencia     			*/
/*	Base de datos:		cobis					*/
/*	Producto:       	Admin					*/
/*	Disenado por:           Mauricio Bayas/Sandra Ortiz 		*/
/*	Fecha de escritura:     11/Abr/1994    				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes  exclusivos  para el  Ecuador  de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones del stored procedure	*/
/*      Insercion de vigencia de tablas                                 */
/*      Modificacion de vigencia de tablas                              */
/*      Borrado de vigencia de tablas                                   */
/*	Busqueda de vigencia de tablas     				*/
/*      Query de vigencia de tablas					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	11/Abr/94	F.Espinosa     	Emision Inicial			*/
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis 
go

if exists (select * from sysobjects where name = 'sp_vigencia')
   drop proc sp_vigencia







go
create proc sp_vigencia (
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
       @i_operacion	char(1),
       @i_modo		tinyint = null,
       @i_tipo		char(1) = null,
       @i_tabla		descripcion =null,
       @i_plazo		smallint = null 
)
as

declare @w_return       int,
        @w_sp_name	varchar(32),
	@w_tabla	descripcion,
	@w_plazo	smallint ,
	@v_tabla	descripcion,
	@v_plazo	smallint ,
	@o_tabla	descripcion,
	@o_plazo	smallint

select @w_sp_name = 'sp_vigencia'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 581
begin
  /* comprobar que no existan datos duplicados */
     if exists ( select vi_tabla	
	           from	ad_vigencia
	          where	vi_tabla = @i_tabla)
     begin
	/* 'La vigencia de esta tabla ha sido registrada anteriormente'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151049
	return 1
     end


  begin tran

     /* Insertar los datos */
     insert into  ad_vigencia(vi_tabla, vi_plazo)
	  values (@i_tabla, @i_plazo)

     /* Si no se puede insertar error */
     if @@error != 0
     begin
	/* 'No se pudo crear la vigencia '*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 153031
	return 1
     end

     /* transaccion servicio - nuevo */
     insert into ts_vigencia (secuencia, tipo_transaccion, clase, fecha,
		 oficina_s, usuario, terminal_s, srv, lsrv,
		 tabla, plazo)
        values (@s_ssn, 581 , 'N', @s_date,
	        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_tabla, @i_plazo)

     /* Si no se puede insertar , error */
     if @@error != 0
     begin
	  /* 'Error en creacion de transaccion de servicios'*/
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
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



/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 582
begin

  /* Guardar los datos anteriores */
  select @w_tabla = vi_tabla,
         @w_plazo = vi_plazo
    from ad_vigencia
   where vi_tabla = @i_tabla

  if @@rowcount != 1 
  begin
        /* No existe tabla para actualizacion */
	exec sp_cerror 
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151050
	return 1
  end

  /* Guardar en transacciones de servicio solo los datos que han
     cambiado */
  select @v_tabla = @w_tabla,
         @v_plazo = @w_plazo 

  If @w_tabla = @i_tabla
     select @w_tabla = null, @v_tabla = null
  else
     select @w_tabla = @i_tabla

  If @w_plazo = @i_plazo
     select @w_plazo = null, @v_plazo = null
  else
     select @w_plazo = @i_plazo


  begin tran

     update ad_vigencia
     set vi_tabla = @i_tabla,
	 vi_plazo = @i_plazo
     where vi_tabla  = @i_tabla

     if @@error != 0
     begin
	/* 'Error en actualizacion '*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 155027
	return 1
     end

     /* transaccion servicios - previo */
     insert into ts_vigencia  (secuencia, tipo_transaccion, clase, fecha,
		   oficina_s, usuario, terminal_s, srv, lsrv,
		   tabla, plazo )
        values (@s_ssn, 582 , 'P', @s_date,
	        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	        @v_tabla, @v_plazo)

     if @@error != 0
     begin
	/* 'Error en creacion de transaccion de servicios'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	return 1
     end

     /* transaccion servicios - actual */
     insert into ts_vigencia (secuencia, tipo_transaccion, clase, fecha,
		   oficina_s, usuario, terminal_s, srv, lsrv,
		   tabla, plazo)
        values (@s_ssn, 582 , 'A', @s_date,
	        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	        @w_tabla, @w_plazo)

     if @@error != 0
     begin
	/* 'Error en creacion de transaccion de servicios'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
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



/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 583
begin

    /* Conservar valores para transaccion de servicios */
    select @w_tabla = vi_tabla,
	   @w_plazo = vi_plazo
      from ad_vigencia
     where vi_tabla = @i_tabla

    /* si no existe registro a borrar, error */
    if @@rowcount = 0
    begin
      /* No existe la tabla*/
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		=151050 
      return 1
    end

     begin tran

      /* borrar ... */
      delete ad_vigencia 
       where vi_tabla = @i_tabla

     /* si no se puede borrar, error */
     if @@error != 0
     begin
	/* Error en eliminacion de tabla*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 157049
	return 1
     end

    /* Transaccion servicios - borrado */
      insert into ts_vigencia (secuencia, tipo_transaccion, clase, fecha,
		oficina_s, usuario, terminal_s, srv, lsrv,
	        tabla, plazo)
      values (@s_ssn, 583 , 'B', @s_date,
	      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	      @w_tabla, @w_plazo)

      /* error si no se puede insertar transaccion de servicio */
      if @@error != 0
      begin
	  /* Error en creacion de transaccion de servicio */
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
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


/* ** Search** */
 if @i_operacion = 'S' 
 begin
If @t_trn = 15081
begin
     set rowcount 20
     if @i_modo = 0
	select 'Tabla' = substring(vi_tabla, 1,20),
	       'Plazo' = vi_plazo
	from  ad_vigencia 
	order by vi_tabla

     if @i_modo = 1
	select 'Tabla' = substring(vi_tabla, 1,20),
	       'Plazo' = vi_plazo
	from  ad_vigencia 
	where vi_tabla >  @i_tabla
	order by vi_tabla

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

/* ** Query especifico para cada sp ** */
if @i_operacion = "Q"
begin
If @t_trn = 15082
begin
	select @o_tabla = vi_tabla ,
	       @o_plazo = vi_plazo
	from  ad_vigencia 
	where substring(vi_tabla,1,20) = @i_tabla
	
	select @o_tabla, @o_plazo
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
