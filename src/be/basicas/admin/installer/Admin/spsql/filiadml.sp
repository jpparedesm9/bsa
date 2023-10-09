/************************************************************************/
/*	Archivo:		filiadml.sp				*/
/*	Stored procedure:	sp_filial_dml				*/
/*	Base de datos:		cobis					*/
/*	Producto:               Clientes				*/
/*	Disenado por:           Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura:     15-Nov-1992				*/
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
/*	Este programa procesa las transacciones del stored procedure	*/
/*	Insercion de filial						*/
/*	Actualizacion de filial						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	11/Jun/93	S. Ortiz	Actualizacion de datos redun-	*/
/*					dantes de ad_ruta.		*/
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	02/May/95	S. Vinces  	Cambios de Admin Distribuido    */
/************************************************************************/
use cobis
go




if exists (select * from sysobjects where name = 'sp_filial_dml')
   drop proc sp_filial_dml
go

create proc sp_filial_dml (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		varchar(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			varchar(1) = NULL,
	@t_debug		varchar(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
	@i_operacion        	varchar(1),
	@i_modo			tinyint = null,
	@i_tipo			varchar(1) = null,
	@i_filial		tinyint = null,
	@i_nombre		descripcion = null,
	@i_direccion		direccion = null,
        @i_actividad		catalogo = null,
        @i_estado           	estado = null,
	@i_abreviatura		varchar(4) = null,
	@i_rep_legal		descripcion = null,
        @i_ruc              	numero = null,
        @i_central_transmit     varchar(1) = null
)
as
declare     @w_var	   int,
	    @w_sp_name	   varchar(32),
	    @w_today	   datetime,
	    @w_filial      tinyint,
	    @w_nombre      descripcion,
	    @w_rep_legal   descripcion,
	    @w_direccion   direccion,
	    @w_actividad   catalogo,
	    @w_abreviatura varchar(4),
            @w_estado      estado,
            @w_ruc         numero,
	    @v_filial      tinyint,
	    @v_nombre      descripcion,
	    @v_rep_legal   descripcion,
	    @v_direccion   direccion,
	    @v_actividad   catalogo,
	    @v_abreviatura char(4),
            @v_estado      estado,
            @v_ruc         numero,
            @o_siguiente   int,
            @w_contador    tinyint,
	    @w_return	   smallint,
	    @w_clave 	   int,      
	    @w_num_nodos   smallint,      
	    @w_codigo	   catalogo, 
	    @w_bandera	   char(1) ,
	    @w_nt_nombre   varchar(30),
	    @w_cmdtransrv    varchar(64)


select @w_today = @s_date
select @w_sp_name = 'sp_filial_dml'
select @w_bandera = 'N'

/* ** insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 596
begin

  /* verificacion de claves foraneas */
  select @w_var = null
   from cl_catalogo
   where codigo = @i_actividad
     and tabla = (select codigo
		    from cl_tabla
		   where tabla = 'cl_actividad')

  if @@rowcount = 0
  begin
       /* 'No existe actividad economica' */
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101027
       return 1
  end

  /* no permitir filiales duplicadas */
  if exists ( select *
                from cl_filial
               where fi_ruc = @i_ruc 
		  or fi_filial = @i_filial )
  begin
       /* 'filial duplicada' */
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151052
       return 1
  end
   
  begin tran

     /* insertar los datos */
     insert into cl_filial (fi_filial, fi_nombre, fi_rep_nombre,
			     fi_direccion, fi_actividad, fi_estado,
			     fi_abreviatura, fi_ruc)
		     values (@i_filial, @i_nombre, @i_rep_legal,
			     @i_direccion, @i_actividad, 'V',
			     @i_abreviatura, @i_ruc)
      if @@error != 0
      begin
	 /* 'Error en creacion de filial'*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103036
	 return 1
      end

      insert into ts_filial (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     filial, nombre, rep_legal, direccion,
			     actividad, estado, ruc)
      values (@s_ssn, 596, 'N', @s_date,
	      @s_ofi,@s_user, @s_term, @s_srv, @s_lsrv,
	      @i_filial, @i_nombre, @i_rep_legal,
	      @i_direccion, @i_actividad, 'V', @i_ruc)

      if @@error != 0
      begin
	 /* 'Error en creacion de transaccion de servicio'*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 return 1
      end
  select @w_bandera = 'S'
  commit tran
  if @w_bandera = 'S'
    begin
	/* Actualizacion de la los datos en el catalogo */

       	select @w_codigo = convert(varchar(10),@i_filial)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 584,
       		@i_operacion		   = 'I',
       		@i_tabla		   = 'cl_filial',
       		@i_codigo		   = @w_codigo,
       		@i_descripcion 		   = @i_nombre,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
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

/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 597
begin

  /* verificacion de claves foraneas */
  select @w_var = null
   from cl_catalogo
   where codigo = @i_actividad
     and tabla = (select codigo
		    from cl_tabla
		   where tabla = 'cl_actividad')

  if @@rowcount = 0
  begin
       /* 'No existe actividad economica'*/
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101027
       return 1
  end

  /* no permitir filiales duplicadas (mismo RUC) */
  if exists ( select *
                from cl_filial
               where fi_ruc = @i_ruc 
                 and fi_filial != @i_filial )
  begin
       /* 'filial duplicada' */
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101105
       return 1
  end
   
  /* chequeo de campos actualizados */
  select @w_nombre = fi_nombre,
	 @w_rep_legal = fi_rep_nombre,
	 @w_direccion = fi_direccion,
	 @w_actividad = fi_actividad, 
	 @w_abreviatura = fi_abreviatura,
         @w_estado = fi_estado,
         @w_ruc = fi_ruc
    from cl_filial
    where fi_filial = @i_filial

  select @v_nombre = @w_nombre,
	 @v_rep_legal = @w_rep_legal,
	 @v_direccion = @w_direccion,
	 @v_actividad = @w_actividad,
	 @v_abreviatura = @w_abreviatura,
         @v_estado = @w_estado,
         @v_ruc = @w_ruc

  if @w_nombre = @i_nombre
    select @w_nombre = null, @v_nombre = null
  else
    select @w_nombre = @i_nombre

  if @w_rep_legal = @i_rep_legal
    select @w_rep_legal = null, @v_rep_legal = null
  else
    select @w_rep_legal = @i_rep_legal

  if @w_direccion = @i_direccion
    select @w_direccion = null, @v_direccion = null
  else
    select @w_direccion= @i_direccion

  if @w_actividad = @i_actividad
    select @w_actividad = null, @v_actividad = null
  else
    select @w_actividad = @i_actividad

  if @w_abreviatura = @i_abreviatura
    select @w_abreviatura = null, @v_abreviatura = null
  else
    select @w_abreviatura = @i_abreviatura

  if @w_estado = @i_estado
    select @w_estado = null, @v_estado = null
  else
    select @w_estado = @i_estado

  if @w_ruc = @i_ruc
    select @w_ruc = null, @v_ruc = null
  else
    select @w_ruc = @i_ruc

  begin tran
      update cl_filial
      set    fi_nombre = @i_nombre,
	     fi_rep_nombre = @i_rep_legal,
	     fi_direccion = @i_direccion,
	     fi_actividad = @i_actividad,
	     fi_abreviatura = @i_abreviatura,
             fi_ruc         = @i_ruc,
             fi_estado      = @i_estado
      where  fi_filial = @i_filial

      if @@error != 0
      begin
	 /* 'Error en actualizacion de filial'*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105043
	 return 1
      end

      /*  Mantiente actualizados los datos redundates de ad_ruta  */
      if @w_nombre is not null
      begin
	      update	ad_ruta
	      set	ru_nombre_f_d = @i_nombre
	      where	ru_filial_d = @i_filial

	      if @@error != 0
	      begin
		 /* 'Error en actualizacion de ruta'*/
		 exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 155018
		 return 1
	      end

	      update	ad_ruta
	      set	ru_nombre_f_h = @i_nombre
	      where	ru_filial_h = @i_filial

	      if @@error != 0
	      begin
		 /* 'Error en actualizacion de ruta'*/
		 exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 155018
		 return 1
	       end
      end

      /* transaccion de servicio - filial */
      insert into ts_filial (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     filial, nombre, rep_legal, direccion,
			     actividad, ruc)
      values (@s_ssn, 597, 'P', @s_date,
	      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	      @i_filial, @v_nombre, @v_rep_legal,
	      @v_direccion, @v_actividad, @v_ruc)

      if @@error != 0
      begin
	 /* 'Error en creacion de transaccion de servicio'*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 return 1
      end
      
      insert into ts_filial (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     filial, nombre, rep_legal, direccion,
			     actividad, ruc)
      values (@s_ssn, 597, 'A', @s_date,
	      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	      @i_filial, @w_nombre, @w_rep_legal,
	      @w_direccion, @w_actividad, @w_ruc)
      if @@error != 0
      begin
	 /* 'Error en creacion de transaccion de servicio'*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 return 1
      end

  select @w_bandera = 'S'
  commit tran
  if @w_bandera = 'S'
    begin
	/* Actualizacion de la los datos en el catalogo */

       	select @w_codigo = convert(varchar(10), @i_filial)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 585,
       		@i_operacion		   = 'U',
       		@i_tabla		   = 'cl_filial',
       		@i_codigo		   = @w_codigo,
       		@i_descripcion 		   = @i_nombre,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
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
go
