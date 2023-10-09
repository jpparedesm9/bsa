/************************************************************************/
/*      Archivo:                sis_ope.sp                              */
/*      Stored procedure:       sp_sis_operativo                        */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 23-Nov-1992                                 */
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
/*      Insercion de nodos                                              */
/*      Actualizacion del nodo                                          */
/*      Borrado del nodo                                                */
/*      Busqueda del nodo                                               */
/*      Query del nodo                                                  */
/*      Ayuda del nodo                                                  */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      23/Nov/1992     L. Carvajal     Emision inicial                 */
/*	07/Jun/1993	M. Davila	Search sin error		*/
/*	22/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_sis_operativo')
   drop proc sp_sis_operativo
go

create proc sp_sis_operativo (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
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
        @i_operacion            char(1),
        @i_tipo                 char(1) = null,
        @i_modo                 smallint = null,
        @i_sis_operativo        tinyint = null,
        @i_descripcion          descripcion = NULL,
        @i_version              varchar(12) = NULL,
        @i_release              varchar(12) = NULL,
        @i_propietario          descripcion = NULL
)
as
declare
        @w_today                datetime,
        @w_return               int,
        @w_sp_name              varchar(32),
        @w_sis_operativo        tinyint,
        @w_descripcion          descripcion,
        @w_version              varchar(12),
        @w_release              varchar(12),
        @w_propietario          descripcion,
        @v_sis_operativo        tinyint,
        @v_descripcion          descripcion,
        @v_version              varchar(12),
        @v_release              varchar(12),
        @v_propietario          descripcion,
	@w_siguiente		 int,
        @o_sis_operativo        tinyint,
        @o_descripcion          descripcion,
        @o_version              varchar(12),
        @o_release              varchar(12),
        @o_propietario          descripcion,
        @w_fecha_ult_mod        datetime,
        @v_fecha_ult_mod        datetime


select @w_today = @s_date
select @w_sp_name = 'sp_sis_operativo'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn  = 552
begin
  if (@i_descripcion is NULL OR @i_version is NULL)
  begin
        exec sp_cerror
	     @t_debug  = @t_debug,
	     @t_file   = @t_file,
	     @t_from   = @w_sp_name,
	     @i_num    = 151001
	     /*'No se llenaron todos los campos' */
        return 1
  end

  begin tran
   exec @w_return = sp_cseqnos @i_tabla = 'ad_sis_operativo',
			      @o_siguiente = @w_siguiente out
   if @w_return != 0
    return @w_return
   insert into ad_sis_operativo (so_sis_operativo, so_descripcion, so_version,
                                 so_release, so_propietario, so_estado,
                                 so_fecha_ult_mod)
			values	(@w_siguiente, @i_descripcion, @i_version,
                                 @i_release, @i_propietario, 'V', @w_today)
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug  = @t_debug,
	     @t_file   = @t_file,
	     @t_from   = @w_sp_name,
	     @i_num    = 153000
	     /*  'Error en insercion de sistema operativo' */
        return 1
   end

   /* transaccion de servicio - sistema operativo */
   insert into  ts_sis_operativo (secuencia, tipo_transaccion, clase, fecha,
		                 oficina_s, usuario, terminal_s, srv, lsrv,
                                 sis_operativo, descripcion, version,
                                 release, propietario, estado, fecha_ult_mod)
			values	(@s_ssn, 552, 'N', @s_date,
		                 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
				 @w_siguiente, @i_descripcion, @i_version,
                                 @i_release, @i_propietario, 'V', @w_today)
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug	= @t_debug,
	     @t_file	= @t_file,
	     @t_from	= @w_sp_name,
	     @i_num	= 153023
	     /*   = 'Error en creacion de transaccion de servicio' */
        return 1
   end
  commit tran
  select @w_siguiente
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
if @t_trn = 553
begin
  if (@i_sis_operativo is NULL)
  begin
        exec sp_cerror
	     @t_debug	= @t_debug,
	     @t_file	= @t_file,
	     @t_from	= @w_sp_name,
	     @i_num	= 151001
	     /*   = 'No se llenaron todos los campos' */
        return 1
  end

  select @w_descripcion = so_descripcion,
         @w_version = so_version,
         @w_release = so_release,
         @w_propietario = so_propietario,
         @w_fecha_ult_mod = so_fecha_ult_mod
    from ad_sis_operativo
   where so_sis_operativo = @i_sis_operativo
     and so_estado = 'V'
  if @@rowcount = 0
  begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151003
	     /*   = 'No existe sistema operativo' */
        return 1
  end

  /* chequeo de claves a actualizar */
  select @v_descripcion = @w_descripcion,
         @v_version = @w_version,
         @v_release = @w_release,
         @v_propietario = @w_propietario,
         @v_fecha_ult_mod = @w_fecha_ult_mod

  if @w_descripcion = @i_descripcion
   select @w_descripcion = NULL, @v_descripcion = NULL
  else
   select @w_descripcion = @i_descripcion

  if @w_version = @i_version
   select @w_version = NULL, @v_version = NULL
  else
   select @w_version = @i_version

  if @w_release = @i_release
   select @w_release = NULL, @v_release = NULL
  else
   select @w_release = @i_release

  if @w_propietario = @i_propietario
   select @w_propietario = NULL, @v_propietario = NULL
  else
   select @w_propietario = @i_propietario
  
  begin tran
    Update ad_sis_operativo
       set so_descripcion = @i_descripcion,
           so_version = @i_version,
           so_release = @i_release,
           so_propietario = @i_propietario,
           so_fecha_ult_mod = @w_today
     where so_sis_operativo = @i_sis_operativo
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 155002
	     /*   = 'Error en actualizacion de sistema operativo'*/
        return 1
   end

   /* transaccion de servicio - sistema operativo */
   insert into ts_sis_operativo (secuencia, tipo_transaccion, clase, fecha,
		                 oficina_s, usuario, terminal_s, srv, lsrv,
                                 sis_operativo, descripcion, version,
                                 release, propietario, estado, fecha_ult_mod)
			values	(@s_ssn, 553, 'P', @s_date,
		                 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                                 @i_sis_operativo, @v_descripcion, @v_version,
                                 @v_release, @v_propietario, null, @v_fecha_ult_mod)
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 153023
	     /*   = 'Error en creacion de transaccion de servicio' */
        return 1
   end
   insert into ts_sis_operativo (secuencia, tipo_transaccion, clase, fecha,
		                 oficina_s, usuario, terminal_s, srv, lsrv,
                                 sis_operativo, descripcion, version,
                                 release, propietario, estado, fecha_ult_mod)
			values	(@s_ssn, 553, 'A', @s_date,
		                 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                                 @i_sis_operativo, @w_descripcion, @w_version,
                                 @w_release, @w_propietario, null, @w_today)
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 153023
	     /*   = 'Error en creacion de transaccion de servicio'*/
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
if @t_trn = 554
begin
  if (@i_sis_operativo is NULL)
  begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
	     /*   = 'No se llenaron todos los campos' */
        return 1
  end

  select @w_descripcion = so_descripcion,
         @w_version = so_version,
         @w_release = so_release,
         @w_propietario = so_propietario,
         @w_fecha_ult_mod = so_fecha_ult_mod
    from ad_sis_operativo
   where so_sis_operativo = @i_sis_operativo
     and so_estado = 'V'
  if @@rowcount = 0 
  begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151003
	     /*   = 'No existe sistema operativo' */
        return 1
  end

 if exists (
    select nl_sis_operativo
     from  ad_nodo_oficina
     where nl_sis_operativo = @i_sis_operativo
       and nl_estado = 'V')
  begin
   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 157000
	     /*   = 'Existe referencia en nodo oficina' */
   return 1
  end

 /* borrado de sistema operativo */
  begin tran
   update ad_sis_operativo
     set  so_estado = 'C'
    where so_sis_operativo = @i_sis_operativo
   if @@error != 0
   begin
     exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 157002
	     /*   = 'Error en eliminacion de sistema operativo' */
     return 1
   end
   /* transaccion de servicio */
   insert into ts_sis_operativo (secuencia, tipo_transaccion, clase, fecha,
		                 oficina_s, usuario, terminal_s, srv, lsrv,
                                 sis_operativo, descripcion, version,
                                 release, propietario, estado, fecha_ult_mod)
			values	(@s_ssn, 554, 'B', @s_date,
		                 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                                 @i_sis_operativo, @w_descripcion, @w_version,
                                 @w_release, @w_propietario, 'V', @w_fecha_ult_mod)
   if @@error != 0
   begin
        exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 153023
	     /*   = 'Error en creacion de transaccion de servicio' */
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

/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15052
begin
     set rowcount 20
     if @i_modo = 0
     begin
        select  'Codigo' = so_sis_operativo,
                'Sistema Operativo' = substring(so_descripcion,1,20),
                'Version' = so_version,
                'Release' = so_release,
                'Propietario' = substring(so_propietario,1,20)
         from   ad_sis_operativo
        where   so_estado = 'V'
        order   by so_sis_operativo
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
        select  'Codigo' = so_sis_operativo,
                'Sistema Operativo' = substring(so_descripcion,1,20),
                'Version' = so_version,
                'Release' = so_release,
                'Propietario' = substring(so_propietario, 1, 20)
         from   ad_sis_operativo
        where   so_sis_operativo > @i_sis_operativo
          and   so_estado = 'V'
        order   by so_sis_operativo
       set rowcount 0
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

/* ** query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15053
begin
         select @o_descripcion = so_descripcion,
                @o_version = so_version,
                @o_release = so_release,
                @o_propietario = so_propietario
         from   ad_sis_operativo
        where   so_sis_operativo = @i_sis_operativo
          and   so_estado = 'V'
       if @@rowcount = 0
       begin
         exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151003
	     /*   = 'No existe sistema operativo' */
         return 1
       end
       select @i_sis_operativo, @o_descripcion, @o_version, @o_release,
              @o_propietario
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

/* ** help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15054
begin
 if @i_tipo = 'A'
 begin
         select   'Codigo' = so_sis_operativo,
	          'Descripcion' = so_descripcion
           from   ad_sis_operativo
          where   so_estado = 'V'
           order  by so_sis_operativo
         if @@rowcount = 0
         begin
           exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151003
	     /*   = 'No existe sistema operativo' */
           return 1
        end
 end
 if @i_tipo = 'V'
 begin
	 select so_descripcion
           from ad_sis_operativo
          where so_sis_operativo = @i_sis_operativo
            and so_estado = 'V'
         if @@rowcount = 0
         begin
           exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151003
	     /*   = 'No existe sistema operativo' */
           return 1
        end
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

