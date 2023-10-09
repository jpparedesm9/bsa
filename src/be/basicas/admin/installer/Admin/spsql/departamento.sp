/************************************************************************/
/*	Archivo:		depar.sp				*/
/*	Stored procedure:	sp_departamento				*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 12-Nov-1992					*/
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
/*	Busqueda de telefono						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12/Nov/92	L. Carvajal	Emision Inicial			*/
/*	13/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*      11/Ene/94       F.Espinosa      Retorno del codigo de Depart.   */
/*      17/Ene/94       F.Espinosa      Operacion "H", Tipo "E" : Retor_*/
/*                                      na la descripcion del depart.   */
/*                                      tomando como parametro adicional*/
/*					la filial                       */
/*	19/Ene/94	F.Espinosa	Operacion "S" con modos (2,3)   */
/*					para retornar los departamentos */
/*					de una oficina.			*/
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	07/Sep/94	C.Rodriguez 	Considerar la oficina en toda   */
/*					Operaciones sobre departamentos	*/
/*	02/May/95	S. Vinces   	Admin Distribuido               */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_departamento')
   drop proc sp_departamento
go

create proc sp_departamento (
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
        @i_operacion            varchar(1),
	@i_modo		   	tinyint = null,
	@i_tipo		    	varchar(1) = null,
	@i_departamento	    	smallint = null,
	@i_filial	    	tinyint = null,
	@i_oficina	    	smallint = null,
	@i_descripcion	    	descripcion = null,
	@i_o_departamento    	smallint = null,
	@i_o_oficina		smallint = null,
	@o_siguiente	    	int = null out,
	@i_central_transmit     varchar(1) = null
)
as
declare
       @w_sp_name	       varchar(32),
       @w_today                datetime,
       @w_var                  int,
       @w_aux		       tinyint,	
       @w_codigo               int,
       @w_departamento         smallint,
       @w_filial               tinyint,
       @w_oficina	       smallint,
       @w_descripcion          descripcion,
       @w_o_departamento       smallint,
       @w_o_oficina            smallint,
       @w_nivel                tinyint,
       @v_departamento         smallint,
       @v_filial               tinyint,
       @v_oficina	       smallint,
       @v_descripcion          descripcion,
       @v_o_departamento       smallint,
       @v_o_oficina            smallint,
       @v_nivel                tinyint,
       @o_departamento         tinyint,
       @o_filial               tinyint,
       @o_finombre             descripcion,
       @o_oficina	       smallint,
       @o_lonombre             descripcion,
       @o_descripcion          descripcion,
       @o_o_departamento       smallint,
       @o_o_oficina            smallint,
       @o_denombre             descripcion,
       @o_nivel                tinyint,
       @w_return	       int,
       @w_cmdtransrv           varchar(64),
       @w_nt_nombre            varchar(32),
       @w_num_nodos            smallint,    
       @w_contador             smallint,
	@w_clave		int

select @w_today = @s_date
select @w_sp_name = 'sp_departamento'

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 590
begin
  select  @w_aux = de_nivel
   from  cl_departamento
   where de_departamento = @i_departamento
     and de_oficina = @i_oficina
  if @@rowcount <> 0
  begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151054
	  /*	'Departamento fue creado anteriormente'*/
      return 1
  end


 /* chequeo de claves fornaneas */
  if not exists (
   select of_filial
   from  cl_oficina
   where of_filial = @i_filial
     and of_oficina = @i_oficina)
  begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101016
	   /*	'No existe oficina'*/
      return 1
  end

 if (@i_o_departamento = 0) or (@i_o_departamento is null)
  select @w_nivel = 0
 else
 begin
  select  @w_nivel = de_nivel
   from  cl_departamento
   where de_departamento = @i_o_departamento
     and de_oficina = @i_o_oficina
  if @@rowcount = 0
  begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101010
      /* 'Departamento no existe'*/
    return 1
  end
  select @w_nivel = @w_nivel + 1
 end

 begin tran
  insert into cl_departamento (de_departamento, de_filial, de_oficina,
                               de_descripcion, de_o_departamento, 
			       de_o_oficina, de_nivel)
                       values (@i_departamento, @i_filial, @i_oficina,
                               @i_descripcion, @i_o_departamento,
			       @i_o_oficina, @w_nivel)
  if @@error != 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103004
	/*	'Error en creacion de departamento'*/
     return 1
  end


  /* transaccion de servicio - departamento */

  insert into ts_departamento (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
                               departamento, filial, oficina,
                               descripcion, o_departamento, 
			       o_oficina, nivel)
		       values (@s_ssn, 590 , 'N', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                               @i_departamento, @i_filial, @i_oficina,
                               @i_descripcion, @i_o_departamento, 
			       @i_o_oficina, @w_nivel)
  if @@error != 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 /*	'Error en creacion de transaccion de servicio'*/
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
if @t_trn = 591
begin
 /* verificacion de claves foraneas */
 if (@i_departamento = @i_o_departamento and @i_oficina = @i_o_oficina)
 begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101057
	 /*'Departamentos no deben ser iguales'*/
    return 1
 end

 if not exists (
   select de_departamento
     from cl_departamento
     where de_departamento = @i_departamento
       and de_oficina = @i_oficina)
 begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101010
	  /*'Departamento no existe'*/
    return 1
 end

 
 if (@i_o_departamento = 0)  or (@i_o_departamento is null)
  select @w_aux = 0 
 else
 begin
  select  @w_aux = de_nivel
   from  cl_departamento
   where de_departamento = @i_o_departamento
     and de_oficina = @i_o_oficina
  if @@rowcount = 0
  begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101010
	  /*	'Departamento no existe'*/
      return 1
  end
  select @w_aux = @w_aux + 1
 end

 /* chequeo de campos a actualizar */
   select @w_descripcion = de_descripcion,
          @w_o_departamento = de_o_departamento,
	  @w_o_oficina = de_o_oficina,
          @w_nivel = de_nivel
     from cl_departamento
     where  de_departamento = @i_departamento
       and  de_oficina = @i_oficina

   select @v_descripcion = @w_descripcion,
          @v_o_departamento = @w_o_departamento,
          @v_o_oficina = @w_o_oficina,
          @v_nivel = @w_nivel

   if @w_descripcion = @i_descripcion
     select @w_descripcion = null, @v_descripcion = null
   else
     select @w_descripcion = @i_descripcion
   if @w_o_departamento = @i_o_departamento and @w_o_oficina = @i_o_oficina
    begin
     select @w_o_departamento = null, @v_o_departamento = null
     select @w_o_oficina = null, @v_o_oficina = null
     select @w_nivel = null, @v_nivel = null
    end
   else
    begin
     select @w_o_departamento = @i_o_departamento
     select @w_o_oficina = @i_o_oficina
     select @w_nivel= @w_aux
    end

  begin tran
   update cl_departamento
     set  de_descripcion = @i_descripcion,
          de_o_departamento = @i_o_departamento,
	  de_o_oficina = @i_o_oficina,
	  de_nivel = @w_aux

    where de_departamento = @i_departamento
      and de_oficina = @i_oficina

  if @@error != 0
  begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105004
	 /*'Error en actualizacion de departamento'*/
    return 1
  end

  /* transaccion de servicio - departamento */

  insert into ts_departamento (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
                               departamento, filial, oficina,
                               descripcion, o_departamento, 
			       o_oficina, nivel)
		       values (@s_ssn, 591, 'A', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                               @i_departamento, @v_filial, @v_oficina,
                               @v_descripcion, @v_o_departamento, 
			       @v_o_oficina, @v_nivel)
  if @@error != 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	  /*	'Error en creacion de transaccion de servicio'*/
     return 1
  end

  insert into ts_departamento (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
                               departamento, filial, oficina,
                               descripcion, o_departamento, 
			       o_oficina, nivel)
		       values (@s_ssn, 591, 'P', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                               @i_departamento, @w_filial,  @w_oficina,
                               @w_descripcion, @w_o_departamento, 
			       @w_o_oficina, @w_nivel)
  if @@error != 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	    /*	'Error en creacion de transaccion de servicio'*/
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
if @t_trn = 592
begin
 if not exists (
   select de_departamento
     from cl_departamento
     where de_departamento = @i_departamento
       and de_oficina = @i_oficina)
 begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101010
	  /*'Departamento no existe'*/
    return 1
 end
 
 /* chequeo de referencias */
 if exists( select  de_departamento
      from  cl_departamento
     where  de_o_departamento = @i_departamento
       and  de_o_oficina = @i_oficina
	  )
 begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151048
	/* Existen Departamentos bajo este */
	return 1
 end


 if exists (
	select fu_departamento  
	  from cl_funcionario
	 where fu_departamento = @i_departamento
	   and fu_oficina = @i_oficina
	 )
 begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101065
	/* Existe referencia en funcionario */
	return 1
 end

 /* campos para transaccion de servicios */
   select @w_filial = de_filial,
          @w_oficina = de_oficina,
          @w_descripcion = de_descripcion,
          @w_o_departamento = de_o_departamento,
	  @w_o_oficina = de_o_oficina,
          @w_nivel = de_nivel
     from cl_departamento
     where  de_departamento = @i_departamento
       and  de_oficina = @i_oficina
 begin tran
	/* Borrado de la tabla cl_dis_seqnos */
	if exists (
 		select dq_departamento
		 from  cl_dis_seqnos
                 where dq_departamento = @i_departamento
		   and dq_oficina = @i_oficina
		 )
	begin
 	delete from cl_dis_seqnos
         where dq_departamento = @i_departamento
	   and dq_oficina = @i_oficina
        if @@error != 0 
        begin
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 107004
		/* Error al eliminar departamento */
		return 1
	end
	end
  	/* Borrado de la tabla cl_distributivo */
	if exists (
		select ds_departamento
		  from cl_distributivo
		 where ds_departamento = @i_departamento
		   and ds_oficina = @i_oficina 
		 )
	begin
	delete from cl_distributivo
	 where ds_departamento = @i_departamento
	   and ds_oficina = @i_oficina 
  	if @@error != 0 
        begin
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 107004
		/* Error al eliminar departamento */
		return 1
	end
	end
	/* Borrado de la tabla cl_departamento */
	delete from cl_departamento
	 where de_departamento = @i_departamento
	   and de_oficina = @i_oficina 
  	if @@error != 0
        begin
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 107004
		/* Error al eliminar departamento */
		return 1
	end
	/* transaccion de servicios cl_departamento */

  	insert into ts_departamento (secuencia, tipo_transaccion, clase, fecha,
		                oficina_s, usuario, terminal_s, srv, lsrv,
       	                        departamento, filial, oficina,
       	                        descripcion, o_departamento, 
				o_oficina, nivel)
		       values (@s_ssn, 592, 'D', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                               @i_departamento, @w_filial,  @w_oficina,
                               @w_descripcion, @w_o_departamento, 
			       @w_o_oficina, @w_nivel)
  	if @@error != 0
  	begin
     	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	    /*	'Error en creacion de transaccion de servicio'*/
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

if @i_operacion = 'S' OR @i_operacion = 'Q' OR @i_operacion = "H"
begin
	exec @w_return = sp_cons_departamento 
		@s_ssn		= @s_ssn,		
		@s_user		= @s_user,	
		@s_sesn		= @s_sesn,
		@s_term		= @s_term,	
		@s_date	 	= @s_date,
		@s_srv		= @s_srv,
		@s_lsrv		= @s_lsrv,	
		@s_rol		= @s_rol,
		@s_ofi		= @s_ofi,	
		@s_org_err	= @s_org_err,
		@s_error	= @s_error,
		@s_sev		= @s_sev,
		@s_msg		= @s_msg,
		@s_org		= @s_org,
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@t_trn		= @t_trn, 	
        	@i_operacion    = @i_operacion,
		@i_modo		= @i_modo,	
		@i_tipo		= @i_tipo,
		@i_departamento	= @i_departamento,
		@i_filial	= @i_filial,	
		@i_oficina	= @i_oficina,
		@i_descripcion	= @i_descripcion,
		@i_o_departamento = @i_o_departamento,
		@o_siguiente	= @o_siguiente	

	if @w_return != 0
		return @w_return
end
go

