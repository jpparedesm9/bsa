/************************************************************************/
/*	Archivo:		distr.sp				*/
/*	Stored procedure:	sp_distributivo 			*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 07-Nov-1992					*/
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
/*	Insercion de distributivo					*/
/*	Query de distributivo						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	07/Nov/92	L. Carvajal 	Emision Inicial			*/
/*	13/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	05/May/95	S. Vinces       Admin Distribuido    		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_distributivo')
   drop proc sp_distributivo
go

create proc sp_distributivo (
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
	@i_operacion	     	varchar(1),
	@i_modo 	     	tinyint= null,
	@i_tipo 	     	char(1) = null,
	@i_oficina		smallint = null,
	@i_departamento      	smallint = null,
	@i_cargo	     	smallint = null,
	@i_secuencial	     	tinyint = null,
	@o_siguiente	     	int = null out,
        @i_central_transmit     varchar(1) = null
)
as
declare
       @w_filial      tinyint,
       @w_sp_name     varchar(32),
       @w_oficina     smallint,
       @w_var	      int,
       @w_today       datetime,
       @w_siguiente   int,
       @w_secuencial  int,
       @w_cmdtransrv       varchar(64),
       @w_nt_nombre        varchar(32),
       @w_num_nodos        smallint,    
       @w_contador          smallint,
       @w_clave		  int, 
       @w_return   int 

select @w_today = @s_date
select @w_sp_name = 'sp_distributivo'


/* ** Insert  ** */
if @i_operacion = 'I'
begin
if @t_trn = 593
begin
 select @w_today = getdate()
 
 /* chequeo de la clave foranea */
 select @w_filial = de_filial,
        @w_oficina = de_oficina
   from cl_departamento
  where de_departamento = @i_departamento
    and de_oficina = @i_oficina
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

 select @w_var = null
   from cl_catalogo
   where codigo = convert(char(10), @i_cargo)
     and tabla = (select codigo
		    from cl_tabla
	           where tabla = 'cl_cargo') 
 if @@rowcount = 0
 begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101012
	 /*	'Cargo no existe'*/
     return 1
 end

 select @w_var = null
   from  cl_dis_seqnos
  where dq_departamento = @i_departamento
    and dq_oficina = @i_oficina
    and dq_cargo = @i_cargo

 if @@rowcount = 0
 begin
   begin tran
     	insert into cl_dis_seqnos (dq_oficina, dq_departamento, dq_cargo, dq_siguiente)

            	values (@i_oficina, @i_departamento, @i_cargo, 1)
     	select @o_siguiente = 1
     	if @@error != 0
     	begin
       		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 103034
	    	/*	'Error en creacion de dir_seqnos'*/
       		return 1
     	end
   commit tran
 end
 else
    begin
   	begin tran
     	if @i_secuencial is null
       	begin
     		update cl_dis_seqnos
           	set dq_siguiente = dq_siguiente + 1
      	 	where dq_departamento = @i_departamento
	   	and dq_oficina = @i_oficina
           	and dq_cargo = @i_cargo
        end
     	else
        begin
        	update cl_dis_seqnos
           	set dq_siguiente = @i_secuencial
         	where dq_departamento = @i_departamento
      	   	and dq_oficina = @i_oficina
           	and dq_cargo = @i_cargo
        end
     	if @@error != 0
     	begin
       		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 103034
	   	/*	'Error en creacion de dir_seqnos'*/
       		return 1
     	end
     	if @i_secuencial is null
       	begin        
        	select  @o_siguiente = dq_siguiente
          	from  cl_dis_seqnos
         	where  dq_departamento = @i_departamento
   	   	and  dq_oficina = @i_oficina
           	and  dq_cargo = @i_cargo

         	select @i_secuencial = @o_siguiente
       	end
     	else
         	select @o_siguiente  = @i_secuencial
   commit tran
 end

 begin tran

  insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento,
                               ds_cargo, ds_secuencial, ds_fecha, ds_estado,
                               ds_vacante)
                       values (@w_filial, @w_oficina, @i_departamento,
			       @i_cargo, @o_siguiente, @w_today, 'V',
			       "S")
  if @@error != 0

  begin
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103035
	    /*'Error en creacion de distributivo'*/
       return 1
  end
  /* transaccion de servicio - distributivo */

   insert into ts_distributivo (secuencia, tipo_transaccion, clase, fecha,
		                oficina_s, usuario, terminal_s, srv, lsrv,
                                filial, oficina, departamento,
                                cargo, secuencia_d, fecha_reg, estado)
			values (@s_ssn, 593, 'N', @s_date,
		                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                                @w_filial, @w_oficina, @i_departamento,
				@i_cargo, @o_siguiente, @w_today, 'V')
 if @@error != 0
    begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 /*	"Error en creacion de transaccion de servicio"*/
      return 1

   end
 select @o_siguiente
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

/* Delete */

if @i_operacion = 'D'
begin
if @t_trn = 593
begin
 select @w_today = getdate()

 set rowcount 1
 select @w_secuencial = ds_secuencial,
	@w_filial = ds_filial
   from cl_distributivo
  where ds_oficina = @i_oficina
    and ds_departamento = @i_departamento
    and ds_cargo = @i_cargo
    and ds_vacante = 'S'
 if @@rowcount = 0
 begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151057
	/* No existe cargo vacante para eliminar */
       return 1
  end
 set rowcount 0

 begin tran
	delete cl_distributivo
	 where ds_oficina = @i_oficina
       	   and ds_departamento = @i_departamento
    	   and ds_cargo = @i_cargo
    	   and ds_vacante = 'S'
	   and ds_secuencial = @w_secuencial

  if @@error != 0
  begin
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 157050
	    /*'Error en eliminacion de distributivo'*/
       return 1
  end

  /* transaccion de servicio - distributivo */

   insert into ts_distributivo (secuencia, tipo_transaccion, clase, fecha,
		                oficina_s, usuario, terminal_s, srv, lsrv,
                                filial, oficina, departamento,
                                cargo, secuencia_d, fecha_reg, estado)
			values (@s_ssn, 593, 'B', @s_date,
		                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
                                @w_filial, @i_oficina, @i_departamento,
				@i_cargo, @w_secuencial, @w_today, 'V')
 if @@error != 0
    begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	 /*	"Error en creacion de transaccion de servicio"*/
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


/*  ** Help ** */
if @i_operacion = 'S'
 begin
If @t_trn = 1596
begin
  set rowcount 20
  if @i_modo = 0
  begin
  select   "Cargo" = ds_cargo,
	   "Secuencial" =  ds_secuencial,
	   "Descr.del Cargo" = valor ,
	   "Estado"= ds_estado,
	   "Vacante"= ds_vacante
    from   cl_distributivo, cl_catalogo x, cl_tabla y
    where  ds_departamento = @i_departamento 
      and  ds_oficina = @i_oficina
      and  x.codigo = convert(char(10), ds_cargo)
      and  x.tabla = y.codigo
      and  y.tabla = 'cl_cargo'
    order  by ds_cargo, ds_secuencial
  return 0
  end
  if @i_modo = 1
  begin
  	select 	"Cargo" = ds_cargo,
	       	"Secuencial" =  ds_secuencial, 
	   	"Descr.del Cargo" = valor ,
	   	"Estado"= ds_estado,
	   	"Vacante"= ds_vacante
         from   cl_distributivo, cl_catalogo x, cl_tabla y
         where 	ds_departamento = @i_departamento
	   and  ds_oficina = @i_oficina
           and  x.codigo = convert(char(10), ds_cargo)
           and  x.tabla = y.codigo
           and  y.tabla = 'cl_cargo'
           and ( (ds_cargo > @i_cargo) or
                 (ds_cargo = @i_cargo and ds_secuencial > @i_secuencial)
               ) 
         order by ds_cargo, ds_secuencial
      return 0
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

/*  ** Help ** */
if @i_operacion = 'H'
begin
If @t_trn = 1597
begin

 if @i_tipo = 'A'
 begin
  set rowcount 20
  if @i_modo = 0
  begin
  select   "Cargo" = ds_cargo,
	   "Secuencial" =  ds_secuencial,
	   "Descr.del Cargo" = valor ,
	   "Estado"= ds_estado,
	   "Vacante"= ds_vacante
    from   cl_distributivo, cl_catalogo x, cl_tabla y
    where  ds_departamento = @i_departamento 
      and  ds_oficina = @i_oficina
      and  x.codigo = convert(char(10), ds_cargo)
      and  x.tabla = y.codigo
      and  y.tabla = 'cl_cargo'
      and  ds_vacante = "S"
    order  by ds_cargo, ds_secuencial
/*  if @@rowcount = 0
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101049
	 /*	'No existe distributivo'*/
 */ 
  return 0
  end
  if @i_modo = 1
  begin
  	select 	"Cargo" = ds_cargo,
	       	"Secuencial" =  ds_secuencial, 
	   	"Descr.del Cargo" = valor ,
	   	"Estado"= ds_estado,
	   	"Vacante"= ds_vacante
         from   cl_distributivo, cl_catalogo x, cl_tabla y
         where  ds_departamento = @i_departamento
	   and  ds_oficina = @i_oficina
           and  x.codigo = convert(char(10), ds_cargo)
           and  x.tabla = y.codigo
           and  y.tabla = 'cl_cargo'
           and ds_vacante = "S"
           and ( (ds_cargo > @i_cargo) or
                 (ds_cargo = @i_cargo and ds_secuencial > @i_secuencial)
               ) 
         order by ds_cargo, ds_secuencial
     /*    if @@rowcount = 0
            exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101049
	 /*	'No existe distributivo'*/
     */ 
      return 0
  end
 end
 if @i_tipo = 'V'
 begin
  set rowcount 20
  if @i_modo = 0
  begin
         select   ds_secuencial, valor 
           from   cl_distributivo, cl_catalogo x, cl_tabla y
           where  ds_departamento = @i_departamento
	     and  ds_oficina = @i_oficina
             and  ds_cargo = @i_cargo
             and  x.codigo = convert(char(10),ds_cargo)
             and  x.tabla = y.codigo
             and  y.tabla = 'cl_cargo'
             and  ds_vacante = "S" 
          if @@rowcount = 0
          begin
            exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101049
             /* 'No existe  distributivo'*/
            return 1
          end
  end 
  if @i_modo = 1
  begin
  	select  ds_secuencial, valor
         from   cl_distributivo, cl_catalogo x, cl_tabla y
         where  ds_departamento = @i_departamento
	   and  ds_oficina = @i_oficina
           and  ds_cargo = @i_cargo
           and  x.codigo = convert(char(10), ds_cargo)
           and  x.tabla = y.codigo
           and  y.tabla = 'cl_cargo'
           and ds_vacante = "S"
           and ds_secuencial > @i_secuencial
        if @@rowcount = 0
            exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101049
             /* 'No existe  distributivo'*/
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
