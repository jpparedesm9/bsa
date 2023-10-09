/************************************************************************/
/*	Archivo:		nodo_loc.sp				*/
/*	Stored procedure:	sp_nodo_oficina 			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 24-Nov-1992					*/
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
/*	Insercion de nodo - oficina					*/
/*	Actualizacion del nodo - oficina				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Nov/1992	L. Carvajal	Emision inicial			*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nodo_oficina')
   drop proc sp_nodo_oficina
go

create proc sp_nodo_oficina (
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
        @i_operacion            char(1),
	@i_tipo			char(1) = null,
	@i_modo			smallint = null,
        @i_filial               tinyint = null,
	@i_oficina		smallint = null,
        @i_nodo                 tinyint = null,
        @i_sis_operativo        tinyint = NULL,
        @i_nombre               descripcion = NULL,
        @i_registrador          smallint = NULL,
	@i_habilitante		smallint = NULL,
	@i_fecha_habil		datetime = null,
	@i_x			smallint = null,
	@i_y			smallint = null,
	@i_formato_fecha	int = null
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
        @w_fecha_habil          datetime,
        @w_filial               tinyint,
	@w_oficina		smallint,
        @w_nodo                 tinyint,
        @w_sis_operativo        tinyint,
        @w_nombre               descripcion,
        @w_registrador          smallint,
        @w_habilitante          smallint,
        @v_filial               tinyint,
	@v_oficina		smallint,
        @v_nodo                 tinyint,
        @v_sis_operativo        tinyint,
	@v_nombre		descripcion,
        @v_registrador          smallint,
        @v_fecha_habil          datetime,
        @v_habilitante          smallint,
	@w_siguiente		int,
	@o_sis_operativo	tinyint,
	@o_nombre		descripcion,
	@o_nombre_n		descripcion,
	@o_nombre_o		descripcion,
	@o_nombre_f		descripcion,
	@o_nombre_so		descripcion,
	@o_registrador		smallint,
	@o_habilitante		smallint,
	@o_fecha_reg		datetime,
	@o_fecha_habil		datetime,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime,
	@w_fecha_reg		datetime,
	@w_secuencial		int,
	@w_terminal		int,
	@w_detecta_cambio	char(1),
	@o_nombre_reg		descripcion,
	@o_nombre_hab		descripcion

select @w_today = @s_date
select @w_sp_name = 'sp_nodo_oficina'



/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 522
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_sis_operativo is NULL OR @i_registrador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
   end

  if not exists (
	select of_oficina
	  from cl_oficina
	 where of_oficina = @i_oficina
	   and of_filial = @i_filial)
  begin
/*  'No existe oficina' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101016
	return 1
  end

  if not exists (
        select no_nodo
          from ad_nodo
          where no_nodo = @i_nodo
            and no_fecha_habil is not NULL
            and no_estado = 'V')
  begin
/*  'No existe nodo habilitado' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
        return 1
  end

  if not exists (
        select fu_funcionario
          from cl_funcionario
          where fu_funcionario = @i_registrador)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
/*  'No existe funcionario' */
	return 1
  end

  if @i_habilitante is not NULL
  begin
   if not exists (
        select fu_funcionario
          from cl_funcionario
          where fu_funcionario = @i_habilitante)
   begin
/*  'No existe funcionario'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
	return 1
   end
  end
/*  else
**   select @i_habilitante = 0*/

  if not exists (
        select so_sis_operativo
          from ad_sis_operativo
		 where so_sis_operativo = @i_sis_operativo
		   and so_estado = 'V')
	  begin
	/*  'No existe sistema operativo'*/
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 151003
		return 1
	  end

	if exists ( select * 
		    from ad_nodo_oficina 
		    where nl_filial=@i_filial and nl_oficina =@i_oficina and nl_nombre=@i_nombre )
	begin
	/*  'Error en insercion de nodo_oficina'*/
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 153002,
		   @i_msg	 = 'Ya se encuentra el nodo registrado en la oficina.'
		return 1
	end
	
	 
	  begin tran
	   exec @w_return = sp_cseqnos @i_tabla = 'ad_nodo_oficina',
				       @o_siguiente = @w_siguiente out
	   if @w_return != 0
	      return @w_return
	   insert into ad_nodo_oficina (nl_filial, nl_oficina, nl_nodo, 
					nl_sis_operativo, nl_nombre, nl_fecha_reg, 
					nl_registrador, nl_fecha_habil, nl_habilitante,
					nl_terminal, nl_estado, nl_secuencial,
				nl_fecha_ult_mod, nl_x, nl_y)
		     values    (@i_filial, @i_oficina, @i_nodo,
                                @i_sis_operativo, @i_nombre, @w_today, 
				@i_registrador, @i_fecha_habil, @i_habilitante,
				0, 'V', @w_siguiente, @w_today, 0, 0)
   if @@error != 0
   begin
/*  'Error en insercion de nodo_oficina'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153002
	return 1
   end
/* transaccion de servicio */
   insert into ts_nodo_oficina (secuencia, tipo_transaccion, clase, fecha,
				oficina_s, usuario, terminal_s, srv, lsrv,
				filial, oficina, nodo,
				sis_operativo, nombre, fecha_reg,
				registrador, fecha_habil, habilitante,
				terminal, estado, secuencial,
				fecha_ult_mod)
		     values    (@s_ssn, 522, 'N', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
				@i_filial, @i_oficina, @i_nodo,
                                @i_sis_operativo, @i_nombre, @w_today, 
				@i_registrador, @i_fecha_habil, @i_habilitante,
				0, 'V', @w_siguiente, @w_today)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
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
if @t_trn = 523
begin
/* chequeo de claves foraneas */
  if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_sis_operativo is NULL OR @i_registrador is NULL)
  begin
/*  'No se llenaron todos los campos'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
      return 1
  end

  select  @w_registrador = nl_registrador,
	  @w_nombre = nl_nombre,
          @w_fecha_habil = nl_fecha_habil,
          @w_habilitante = nl_habilitante,
	  @w_sis_operativo = nl_sis_operativo,
	  @w_fecha_reg = nl_fecha_reg,
	  @w_fecha_ult_mod = nl_fecha_ult_mod
  from ad_nodo_oficina
  where nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_nodo = @i_nodo
     and nl_estado = 'V'        
  if @@rowcount = 0
  begin
/*  'No existe nodo oficina'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	return 1
  end

  if not exists (
        select so_sis_operativo
          from ad_sis_operativo
          where so_sis_operativo = @i_sis_operativo
            and so_estado = 'V')
  begin
/*  'No existe sistema operativo'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151003
	return 1
  end

/*  if @i_registrador != @w_registrador
  begin
/*  'Campo no puede ser actualizado' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155000
	return 1
  end
*/
  if @i_habilitante is not NULL
  begin
   if not exists (
        select fu_funcionario
          from cl_funcionario
          where fu_funcionario = @i_habilitante)
   begin
/*  'No existe funcionario' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
	return 1
   end
  end
/*  else
**    select @i_habilitante = 0, @w_habilitante = 0*/

/**** verificacion de campos a actualizar ****/
  select @v_nombre = @w_nombre,
         @v_fecha_habil = @w_fecha_habil,
         @v_habilitante = @w_habilitante,
	 @v_sis_operativo = @w_sis_operativo,
	 @v_fecha_ult_mod = @w_fecha_ult_mod,
	 @v_registrador = @w_registrador

  select @w_detecta_cambio = 'N'
  if @w_nombre = @i_nombre
   select @w_nombre = null, @v_nombre = null
  else
   begin
     select @w_detecta_cambio = 'S'
     select @w_nombre = @i_nombre
   end

  if @w_habilitante = @i_habilitante
   select @w_habilitante = null, @v_habilitante = null
  else
   select @w_habilitante = @i_habilitante

  if @w_fecha_habil = @i_fecha_habil
     select @w_fecha_habil = null, @v_fecha_habil = null
  else
      select @w_fecha_habil = @i_fecha_habil

  if @w_sis_operativo = @i_sis_operativo
   select @w_sis_operativo = null, @v_sis_operativo = null
  else
   select @w_sis_operativo = @i_sis_operativo 

  if @w_registrador = @i_registrador
   select @w_registrador = null, @v_registrador= null
  else
   select @w_registrador= @i_registrador 
  
 begin tran
   Update ad_nodo_oficina
      set nl_nombre = @i_nombre,
          nl_sis_operativo = @i_sis_operativo,
	  nl_fecha_habil = @i_fecha_habil,
	  nl_habilitante = @i_habilitante,
	  nl_fecha_ult_mod = @w_today,
	  nl_registrador = @i_registrador
    where nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_nodo = @i_nodo
  if @@error != 0
  begin
/*  'Error en actualizacion de nodo oficina' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155003
	return 1
  end
/* transaccion de servicio */
   insert into ts_nodo_oficina (secuencia, tipo_transaccion, clase, fecha,
				oficina_s, usuario, terminal_s, srv, lsrv,
				filial, oficina, nodo,sis_operativo, nombre,
				fecha_habil, habilitante, fecha_ult_mod)
		     values    (@s_ssn, 523, 'P', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
				@i_filial, @i_oficina, @i_nodo,
				@v_sis_operativo, @v_nombre, @v_fecha_habil,
				@v_habilitante, @v_fecha_ult_mod)
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

   insert into ts_nodo_oficina (secuencia, tipo_transaccion, clase, fecha,
				oficina_s, usuario, terminal_s, srv, lsrv,
				filial, oficina, nodo,sis_operativo, nombre,
				fecha_habil, habilitante,fecha_ult_mod)
		     values    (@s_ssn, 523, 'A', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
				@i_filial, @i_oficina, @i_nodo,
				@w_sis_operativo, @w_nombre, @w_fecha_habil,
				@w_habilitante, @w_today)
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

/* verificacion de campos redundantes por de-normalizacion */
   if @w_detecta_cambio = 'S'
   begin
      if exists (
	 select ru_nodo_d
	   from ad_ruta
	  where ru_nodo_d = @i_nodo
	    and ru_oficina_d = @i_oficina
	    and ru_filial_d = @i_filial)
      begin
	 Update ad_ruta
	    set ru_nombre_n_d = @i_nombre
	  where ru_nodo_d = @i_nodo
	    and ru_oficina_d = @i_oficina
	    and ru_filial_d = @i_filial
	 if @@error != 0
	 begin
/*	'Error en actualizacion de nodo oficina' */
	  exec sp_cerror
	    @t_debug	 = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	  = @w_sp_name,
	    @i_num	 = 155003
	  return 1
	 end
      end

      if exists (
	 select ru_nodo_h
	   from ad_ruta
	  where ru_nodo_h = @i_nodo
	    and ru_oficina_h = @i_oficina
	    and ru_filial_h = @i_filial)
      begin
	  Update ad_ruta
	     set ru_nombre_n_h = @i_nombre
	   where ru_nodo_h = @i_nodo
	     and ru_oficina_h = @i_oficina
	     and ru_filial_h = @i_filial
	if @@error != 0
	 begin
	  exec sp_cerror
	    @t_debug	 = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	  = @w_sp_name,
	    @i_num	 = 155003
	  return 1
	 end
      end

      if exists (
	 select in_nodo_p
	   from ad_ruta
	  where in_nodo_p = @i_nodo
	    and in_oficina_p = @i_oficina
	    and in_filial_p = @i_filial)
      begin
	 Update ad_ruta
	    set in_nombre_n_p = @i_nombre
	  where in_nodo_p = @i_nodo
	    and in_oficina_p = @i_oficina
	    and in_filial_p = @i_filial
	 if @@error != 0
	 begin
	  exec sp_cerror
	    @t_debug	 = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	  = @w_sp_name,
	    @i_num	 = 155003
	  return 1
	 end
      end

      if exists (
	 select in_nodo_a
	   from ad_ruta
	  where in_nodo_a = @i_nodo
	    and in_oficina_a = @i_oficina
	    and in_filial_a = @i_filial)
      begin
	 Update ad_ruta
	    set in_nombre_n_a = @i_nombre
	  where in_nodo_a = @i_nodo
	    and in_oficina_a = @i_oficina
	    and in_filial_a = @i_filial
	 if @@error != 0
	 begin
	  exec sp_cerror
	    @t_debug	 = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	 = @w_sp_name,
	    @i_num	 = 155003
	  return 1
	 end
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

if @i_operacion = 'D' or @i_operacion ='Q' or @i_operacion = 'S'
or @i_operacion = 'H' or @i_operacion = 'G' or @i_operacion = 'N'
or @i_operacion = 'C'
begin
    exec @w_return = sp_nodo_oficina_2
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user, 
		@s_sesn			   = @s_sesn,  
		@s_term		           = @s_term,    
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
		@t_file	                   = @t_file,
		@t_from		       	   = @t_from,
		@t_trn			   = @t_trn,
		@i_operacion		   = @i_operacion,
		@i_tipo			   = @i_tipo,
		@i_modo			   = @i_modo,
		@i_filial		   = @i_filial,
		@i_oficina		   = @i_oficina,
		@i_nodo			   = @i_nodo,
		@i_sis_operativo	   = @i_sis_operativo,
		@i_nombre		   = @i_nombre,
		@i_registrador		   = @i_registrador,
		@i_habilitante		   = @i_habilitante,
		@i_x			   = @i_x,
		@i_y			   = @i_y,
		@i_formato_fecha	   = @i_formato_fecha

    if @w_return != 0
       return @w_return
end
go
