/************************************************************************/
/*	Archivo:		terminal.sp				*/
/*	Stored procedure:	sp_terminal				*/
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
/*	Insercion de terminal						*/
/*	Actualizacion del terminal					*/
/*	Borrado del terminal						*/
/*	Busqueda del terminal						*/
/*	Query del terminal						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Nov/1992	L. Carvajal	Emision inicial			*/
/*	07/Jun/1993	M. Davila	Search sin error		*/
/*	22/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_terminal')
   drop proc sp_terminal
go

create proc sp_terminal (
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
	@i_modo			smallint = null,
	@i_filial               tinyint = null,
	@i_oficina              smallint = null,
	@i_nodo 		tinyint = null,
	@i_terminal		tinyint = null,
	@i_nombre		varchar(10) = null,
	@i_marca                varchar(20) = NULL,
	@i_tipo                 varchar(10) = NULL,
	@i_modelo               varchar(10) = NULL,
	@i_registrador          smallint = NULL,
	@i_habilitante		smallint = NULL,
	@i_fecha_habil		datetime = NULL,
	@i_fecha_formato	int = NULL
)
as
declare
	@w_sp_name		varchar(32),
	@w_today                datetime,
	@w_fecha_habil          datetime,
	@w_terminal             smallint,
	@w_nombre		varchar(10),
	@w_term			int,
	@w_filial               tinyint,
	@w_oficina              smallint,
	@w_nodo                 tinyint,
	@w_marca                varchar(20),
	@w_tipo                 varchar(10),
	@w_modelo               varchar(10),
	@w_registrador          smallint,
	@w_habilitante          smallint,
	@v_fecha_habil          datetime,
	@v_terminal             int,
	@v_filial               tinyint,
	@v_oficina              smallint,
	@v_nodo                 tinyint,
	@v_marca                varchar(20),
	@v_tipo                 varchar(10),
	@v_modelo               varchar(10),
	@v_registrador          smallint,
	@v_habilitante		smallint,
	@o_fecha_habil		datetime,
	@o_fecha_reg		datetime,
	@o_terminal		int,
	@o_filial		tinyint,
	@o_oficina		smallint,
	@o_nodo			tinyint,
	@o_nombre_f		descripcion,
	@o_nombre_o		descripcion,
	@o_nombre_n		descripcion,
	@o_marca		varchar(20),
	@o_tipo			varchar(10),
	@o_modelo		varchar(10),
	@o_registrador		smallint,
	@o_habilitante		smallint,
	@w_siguiente		int,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime,
	@w_fecha_reg		datetime,
	@w_return		int,
	@o_nombre_reg		descripcion,
	@o_nombre_hab		descripcion,
	@o_nombre		varchar(10)

select @w_today = @s_date
select @w_sp_name = 'sp_terminal'



/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 555
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL   OR @i_oficina is NULL OR @i_nombre is NULL
      OR @i_nodo is NULL  OR @i_marca is NULL
      OR @i_registrador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
   end

  select @w_term = nl_terminal
   from ad_nodo_oficina
   where nl_nodo = @i_nodo
     and nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_fecha_habil is not NULL
     and nl_estado = 'V'
  if @@rowcount = 0
  begin
/*  'No existe nodo_oficina habilitado' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151002
	return 1
  end

  if @i_habilitante is not NULL
  begin
    if not exists (
	select fu_funcionario
	  from cl_funcionario
	  where fu_funcionario = @i_habilitante)
    begin
/*  'No existe funcionario ' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
	return 1
    end
 end
/* else
 **  select @i_habilitante = 0*/

  begin tran
   exec @w_return = sp_cseqnos	@i_tabla = 'ad_terminal',
				@o_siguiente = @w_siguiente out
     if @w_return != 0
	return @w_return
   insert into ad_terminal (te_filial, te_oficina, te_nodo, te_terminal,
			   te_nombre, te_marca, te_tipo, te_modelo,
			   te_fecha_reg, te_registrador, te_fecha_habil,
			   te_habilitante, te_estado, te_fecha_ult_mod)
		   values (@i_filial, @i_oficina, @i_nodo, @w_siguiente,
			   @i_nombre, @i_marca, @i_tipo, @i_modelo,
			   @w_today,@i_registrador, @i_fecha_habil,
			   @i_habilitante, 'V', @w_today)
   if @@error != 0
   begin
/*  'Error en insercion de terminal' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153003
	return 1
   end

   update ad_nodo_oficina
     set nl_terminal = @w_term + 1
   where nl_nodo = @i_nodo
     and nl_filial = @i_filial
     and nl_oficina = @i_oficina
   if @@error != 0
   begin
/*  'Error en insercion de terminal' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153003
	return 1
   end

  /* transaccion de servicio - terminal */
     insert into ts_terminal (secuencia, tipo_transaccion, clase, fecha,
		              oficina_s, usuario, terminal_s, srv, lsrv,
			      filial, oficina, nodo, terminal, nombre,
			      marca, tipo, modelo, fecha_reg,
			      registrador, fecha_habil,
			      habilitante, estado, fecha_ult_mod)
		   values    (@s_ssn, 555, 'N', @s_date,
		              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			      @i_filial, @i_oficina, @i_nodo, @w_siguiente,
			      @i_nombre, @i_marca, @i_tipo, @i_modelo,
			      @w_today, @i_registrador, @i_fecha_habil,
			      @i_habilitante, 'V', @w_today)
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
if @t_trn = 556
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL   OR @i_oficina is NULL
      OR @i_nodo is NULL  OR @i_terminal is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
  end

  select  @w_registrador = te_registrador,
	  @w_nombre = te_nombre,
	  @w_marca = te_marca,
	  @w_tipo = te_tipo,
	  @w_modelo = te_modelo,
	  @w_fecha_habil = te_fecha_habil,
	  @w_habilitante = te_habilitante,
	  @w_fecha_ult_mod = te_fecha_ult_mod
  from ad_terminal
  where te_filial = @i_filial
    and te_oficina = @i_oficina
    and te_nodo = @i_nodo
    and te_terminal = @i_terminal
    and te_estado = 'V'
  if @@rowcount = 0
  begin
/*  'No existe terminal' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151015
	return 1
  end

 
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
 /* else
 **    select @i_habilitante = 0, @w_habilitante = 0*/

  /* verificacion de campos a actualizar */
  select @v_marca = @w_marca,
	 @v_tipo = @w_tipo,
	 @v_modelo = @w_modelo,
	 @v_fecha_habil = @w_fecha_habil,
	 @v_habilitante = @w_habilitante,
	 @v_fecha_ult_mod = @w_fecha_ult_mod

  if @w_marca = @i_marca
   select @w_marca = null, @v_marca = null
  else
   select @w_marca = @i_marca

  if @w_tipo = @i_tipo
   select @w_tipo = null, @v_tipo = null
  else
   select @w_tipo = @i_tipo

  if @w_modelo = @i_modelo
   select @w_modelo = null, @v_modelo = null
  else
   select @w_modelo = @i_modelo

  if @w_habilitante = @i_habilitante
     select @w_habilitante = null, @v_habilitante = null
  else
     select @w_habilitante = @i_habilitante

  if @w_fecha_habil = @i_fecha_habil
     select @w_fecha_habil = null, @v_fecha_habil = null
  else
   select @w_fecha_habil = @i_fecha_habil

  begin tran
   Update ad_terminal
      set te_marca = @i_marca,
	  te_tipo = @i_tipo,
	  te_modelo = @i_modelo,
	  te_fecha_habil = @i_fecha_habil,
	  te_habilitante = @i_habilitante,
	  te_fecha_ult_mod = @w_today
    where te_filial = @i_filial
      and te_oficina = @i_oficina
      and te_nodo = @i_nodo
      and te_terminal = @i_terminal
  if @@error != 0
  begin
/*  'Error en actualizacion de terminal' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155004
	return 1
  end

/* transaccion de servicio - terminal */
     insert into ts_terminal (secuencia, tipo_transaccion, clase, fecha,
		              oficina_s, usuario, terminal_s, srv, lsrv,
			      filial, oficina, nodo, terminal, nombre,
			      marca, tipo, modelo, fecha_reg,
			      registrador, fecha_habil,
			      habilitante, estado, fecha_ult_mod)
		   values    (@s_ssn, 556, 'P', @s_date,
		              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			      @i_filial, @i_oficina, @i_nodo, @i_terminal, null,
			      @v_marca, @v_tipo, @v_modelo, null,
			      null, @v_fecha_habil,
			      @v_habilitante, null, @v_fecha_ult_mod)
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

     insert into ts_terminal (secuencia, tipo_transaccion, clase, fecha,
		              oficina_s, usuario, terminal_s, srv, lsrv,
			      filial, oficina, nodo, terminal, nombre,
			      marca, tipo, modelo, fecha_reg,
			      registrador, fecha_habil,
			      habilitante, estado, fecha_ult_mod)
		   values    (@s_ssn, 556, 'A', @s_date,
		              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			      @i_filial, @i_oficina, @i_nodo, @i_terminal, null,
			      @w_marca, @w_tipo, @w_modelo, null,
			      null, @w_fecha_habil,
			      @w_habilitante, null, @w_fecha_ult_mod)
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
if @t_trn = 557
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL   OR @i_oficina is NULL
      OR @i_nodo is NULL  OR @i_terminal is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
  end

  select  @w_registrador = te_registrador,
	  @w_nombre = te_nombre,
	  @w_marca = te_marca,
	  @w_tipo= te_tipo,
	  @w_modelo = te_modelo,
	  @w_fecha_habil = te_fecha_habil,
	  @w_habilitante = te_habilitante,
	  @w_fecha_reg = te_fecha_reg,
	  @w_fecha_ult_mod = te_fecha_ult_mod
  from ad_terminal
  where te_filial = @i_filial
    and te_oficina = @i_oficina
    and te_nodo = @i_nodo
    and te_terminal = @i_terminal
    and te_estado = 'V'
  if @@rowcount = 0
  begin
/*  'No existe terminal' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151015
	return 1
  end


/* borrado de terminal */
 begin tran
  Delete ad_terminal
   where te_filial = @i_filial
     and te_oficina = @i_oficina
     and te_nodo = @i_nodo
     and te_terminal = @i_terminal
   if @@error != 0
   begin
/*  'Error en eliminacion de terminal' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157011
	return 1
   end

  Update ad_nodo_oficina
     set nl_terminal = nl_terminal - 1
   where nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_nodo = @i_nodo
  if @@error != 0
  begin
/*  'Error en eliminacion de terminal' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157011
	return 1
  end

  /* transaccion de servicio */
     insert into ts_terminal (secuencia, tipo_transaccion, clase, fecha,
		              oficina_s, usuario, terminal_s, srv, lsrv,
			      filial, oficina, nodo, terminal, nombre,
			      marca, tipo, modelo, fecha_reg,
			      registrador, fecha_habil,
			      habilitante, estado, fecha_ult_mod)
		   values    (@s_ssn, 557, 'B', @s_date,
		              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			      @i_filial, @i_oficina, @i_nodo, @i_terminal,
			      @w_nombre, @w_marca, @w_tipo, @w_modelo,
			      @w_fecha_reg,@w_registrador, @w_fecha_habil,
			      @w_habilitante, 'V', @w_fecha_ult_mod)
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
If @t_trn = 15062
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'No. Terminal' = te_terminal,
		'Nombre' = te_nombre,
		'Marca' = te_marca,
		'Tipo' = te_tipo,
		'Modelo' = te_modelo,
		'Registrador' = te_registrador,
		'Nombre Reg.' = X.fu_nombre,
		'Habilitante' = te_habilitante,
		'Nombre Hab.' = Y.fu_nombre
	 from	ad_terminal, cl_funcionario X, cl_funcionario Y
	where	te_registrador = X.fu_funcionario
	  /*and	isnull(te_habilitante, 0) = Y.fu_funcionario*/
	  and	te_habilitante = Y.fu_funcionario
	  and	te_filial = @i_filial
	  and	te_oficina = @i_oficina
	  and	te_nodo = @i_nodo
	  and   te_estado = 'V'
        order   by te_filial, te_oficina, te_nodo, te_terminal
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
	select	'No. Terminal' = te_terminal,
		'Nombre' = te_nombre,
		'Marca' = te_marca,
                'Tipo' = te_tipo,
                'Modelo' = te_modelo,
		'Registrador' = te_registrador,
		'Nombre Reg.' = X.fu_nombre,
		'Habilitante' = te_habilitante,
		'Nombre Hab.' = Y.fu_nombre
	 from	ad_terminal, cl_funcionario X, cl_funcionario Y
	where	te_registrador = X.fu_funcionario
	  /*and	isnull(te_habilitante, 0) = Y.fu_funcionario*/
	  and	te_habilitante = Y.fu_funcionario
	  and	te_filial = @i_filial
	  and	te_oficina = @i_oficina
	  and	te_nodo = @i_nodo
	  and	te_terminal > @i_terminal
          and   te_estado = 'V'
        order   by te_filial, te_oficina, te_nodo, te_terminal
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


/* ** Query ** */
if @i_operacion ='Q'
begin
If @t_trn = 15063
begin
	select	@o_nombre_f = fi_nombre,
		@o_nombre_o = of_nombre,
		@o_nombre_n = nl_nombre,
		@o_terminal = te_terminal,
		@o_nombre = te_nombre,
		@o_marca = te_marca,
		@o_tipo = te_tipo,
		@o_modelo = te_modelo,
		@o_registrador = te_registrador,
		@o_fecha_reg = te_fecha_reg,
		@o_habilitante = te_habilitante,
		@o_fecha_habil = te_fecha_habil
	 from	ad_terminal, cl_filial, cl_oficina, ad_nodo_oficina
	where	te_filial  = fi_filial
	  and	te_oficina = of_oficina
	  and	te_nodo    = nl_nodo
	  and	te_filial  = nl_filial
	  and	te_oficina = nl_oficina
	  and	te_filial = @i_filial
	  and	te_oficina = @i_oficina
	  and	te_nodo = @i_nodo
	  and	te_terminal = @i_terminal
	  and	te_estado = 'V'
       if @@rowcount = 0
       begin
/*  'No existe terminal' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151015
	 return 1
       end

	select @o_nombre_hab= ''
	if @o_habilitante is not NULL
	begin
	select @o_nombre_hab = fu_nombre
	  from cl_funcionario
	 where fu_funcionario = @o_habilitante
	 if @@rowcount = 0
	 begin
/* 'No existe funcionario' */
	   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 101036
	 end
	end
	else
	  select @o_habilitante = 0

	select @o_nombre_reg = fu_nombre
	  from cl_funcionario
	 where fu_funcionario = @o_registrador
	if @@rowcount = 0
	begin
/* 'No existe funcionario' */
	   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 101036
	end

       select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o,
	      @i_nodo, @o_nombre_n, @o_terminal, @o_nombre, @o_marca,
	      @o_tipo, @o_modelo,
	      @o_registrador, @o_nombre_reg, convert(char(10), @o_fecha_reg, @i_fecha_formato),
	      @o_habilitante, @o_nombre_hab, convert(char(10), @o_fecha_habil, @i_fecha_formato)
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
