use cobis
go
if exists (select * from sysobjects where name = 'sp_control_version')
		drop proc sp_control_version
go

create proc sp_control_version(
	@s_ssn		int = NULL,
	@s_user		login = NULL,
	@s_sesn		int = NULL,
	@s_term		varchar(32) = NULL,
	@s_date		datetime = NULL,
	@s_srv		varchar(30) = NULL,
	@s_lsrv		varchar(30) = NULL,
	@s_rol		smallint = NULL,
	@s_ofi		smallint = NULL,
	@s_org_err	char(1) = NULL,
	@s_error	int = NULL,
	@s_sev		tinyint = NULL,
	@s_msg		descripcion = NULL,
	@s_org		char(1) = NULL,
	@t_trn        	int = NULL,
	@t_debug       	char(1) = 'N',
	@t_file        	varchar(14) = NULL,
	@t_from        	varchar (32) = NULL,
	@i_operacion	char(1) = NULL,
	@i_modulo	tinyint = NULL,
	@i_modo		smallint = NULL,
	@i_archivo	descripcion = NULL,
	@i_numero1	tinyint = NULL,
	@i_numero2	tinyint = NULL,	
	@i_numero3	tinyint = NULL,	
	@i_fecha	datetime = NULL,
	@i_proposito	catalogo = NULL,
	@i_opcion	char(1) = NULL,
	@i_oficina	smallint = null
)
as

declare  @w_sp_name	varchar(32),
	@w_mayor	tinyint,
	@w_menor	tinyint,	
	@w_revision	tinyint,
	@w_oficina	smallint
,	@w_msg		varchar(255) 	-- ODI20051228

select  @w_sp_name = 'sp_control_version'
select  @i_fecha = getdate()

if (@t_trn <> 28741 and @i_operacion = 'I')  or
   (@t_trn <> 28743 and @i_operacion = 'S')  or
   (@t_trn <> 28744 and @i_operacion = 'V')
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file = @t_file,
   @t_from = @w_sp_name,
   @i_num = 2874900
   return 1
end

select @i_archivo = lower(@i_archivo)
if ( @i_operacion='I' )  /*Ingresar la catalogacion del archivo*/
begin
if @i_opcion = 'E'
begin 
	if exists(select * from ve_version where 
		ve_producto = @i_modulo and
		ve_archivo = @i_archivo and
		ve_oficina = @i_oficina)
	begin
		/* envia al historico el registro */
		
--Adaptive Server has expanded all '*' elements in the following statement
insert into ve_version_his
		     select ve_version.ve_producto, ve_version.ve_archivo, ve_version.ve_oficina, ve_version.ve_numero1, ve_version.ve_numero2, ve_version.ve_numero3, ve_version.ve_fecha_mod, ve_version.ve_usuario, ve_version.ve_proposito from ve_version where 
			ve_producto = @i_modulo and
			ve_archivo = @i_archivo and
			ve_oficina = @i_oficina

		delete from ve_version where 
			ve_producto = @i_modulo and
			ve_archivo = @i_archivo and
			ve_oficina = @i_oficina
	end
	insert into ve_version values 
		(@i_modulo,@i_archivo,@i_oficina,@i_numero1,@i_numero2,@i_numero3,@i_fecha,@s_user,@i_proposito)
end
else
begin
	declare oficinas cursor for
	   select of_oficina
	   from cl_oficina
	open oficinas
	fetch oficinas into @w_oficina
    
	if (@@fetch_status = -1)  --sqlstatus: mig syb-sqls 11032016
    begin
	      close oficinas
	      return 710124
	end

	while (@@fetch_status = 0 )  --sqlstatus: mig syb-sqls 11032016
	begin 
		if exists(select * from ve_version where 
			ve_producto = @i_modulo and
			ve_archivo = @i_archivo and
			ve_oficina = @w_oficina)
		begin
			/* envia al historico el registro */
			
--Adaptive Server has expanded all '*' elements in the following statement
insert into ve_version_his
			     select ve_version.ve_producto, ve_version.ve_archivo, ve_version.ve_oficina, ve_version.ve_numero1, ve_version.ve_numero2, ve_version.ve_numero3, ve_version.ve_fecha_mod, ve_version.ve_usuario, ve_version.ve_proposito from ve_version where 
				ve_producto = @i_modulo and
				ve_archivo = @i_archivo and
				ve_oficina = @w_oficina

			delete from ve_version where 
				ve_producto = @i_modulo and
				ve_archivo = @i_archivo and
				ve_oficina = @w_oficina
		end
		insert into ve_version values 
			(@i_modulo,@i_archivo,@w_oficina,@i_numero1,@i_numero2,@i_numero3,@i_fecha,@s_user,@i_proposito)
		
		fetch oficinas into @w_oficina	
	end
end
end

if ( @i_operacion='S' )  /*Ingresar la catalogacion del archivo*/
begin
   set rowcount 20
	if @i_modo = 0
	begin
		select 'PRODUCTO ' = convert(char(3),ve_producto) +' - ' + pd_descripcion,
			'ARCHIVO ' = ve_archivo,
			'OFICINA ' = convert(char(3),ve_oficina ) + ' - ' + of_nombre,
			'VERSION ' = CONVERT(CHAR(2),ve_numero1) + '.' + convert(char(2),ve_numero2) + '.' + convert(char(2),ve_numero3),
			'FECHA CATALOGACION ' = ve_fecha_mod,
			'USUARIO' = ve_usuario,
			'PROPOSITO ' = ve_proposito 
		from ve_version, cl_producto, cl_oficina
		where ve_producto = pd_producto and
		      ve_oficina  = of_oficina
		order by ve_producto, ve_archivo, ve_oficina
	end
	else
	begin
		select 'PRODUCTO ' = convert(char(3),ve_producto) +' - ' + pd_descripcion,
			'ARCHIVO ' = ve_archivo,
			'OFICINA ' = convert(char(3),ve_oficina ) + ' - ' + of_nombre,
			'VERSION ' = CONVERT(CHAR(2),ve_numero1) + '.' + convert(char(2),ve_numero2) + '.' + convert(char(2),ve_numero3),
			'FECHA CATALOGACION ' = ve_fecha_mod,
			'USUARIO' = ve_usuario,
			'PROPOSITO ' = ve_proposito 
		from ve_version, cl_producto, cl_oficina
		where ve_producto = pd_producto
		  and ve_oficina  = of_oficina
		  and ((ve_producto = @i_modulo 
                  and 	ve_archivo = @i_archivo
		  and   ve_oficina > @i_oficina)
		  or   (ve_producto = @i_modulo 
                  and 	ve_archivo > @i_archivo)
    		   or  (ve_producto > @i_modulo))
		order by ve_producto, ve_archivo, ve_oficina
	end
end

if ( @i_operacion='V' )  /*Verificar la catalogacion del archivo*/
begin
	if exists(select * from ve_producto where pr_producto = @i_modulo and pr_version = 'V')
	begin
		if exists(select * from ve_version where 
			ve_producto = @i_modulo and
			ve_archivo = @i_archivo and
			ve_oficina = @s_ofi)
		begin
			select @w_mayor = ve_numero1,
			       @w_menor =ve_numero2,
			       @w_revision = ve_numero3
			from ve_version where 
			ve_producto = @i_modulo and
			ve_archivo = @i_archivo and
			ve_oficina = @s_ofi
		
			if @w_mayor <> @i_numero1 or @w_menor <> @i_numero2 or @w_revision <> @i_numero3
			begin
			select @w_msg = mensaje
			from cobis..cl_errores
			where numero =  2874902

			select @w_msg = isnull(@w_msg, "SIN TEXTO")
				+ char(10)
				+ char(10)
				+ "SERVIDOR : "	+ @s_srv
				+ char(10)
				+ "Archivo : "	+ @i_archivo
				+ char(10)
				+ "Modulo  : "	+ convert(varchar, @i_modulo) 
				+ char(10)
				+ "V. en la PC: "	+ convert(varchar, @i_numero1)
				+ "."			+ convert(varchar, @i_numero2)
				+ "."			+ convert(varchar, @i_numero3)
				+ char(10)
				+ "V. ACTUAL: "	+ convert(varchar, @w_mayor)
				+ "."			+ convert(varchar, @w_menor)
				+ "."			+ convert(varchar, @w_revision)
				+ char(10)
				+ "Oficina : "	+ convert(varchar, @s_ofi)
				+ char(10)

			exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file = @t_file,
			   @t_from = @w_sp_name,
				@i_msg	=	@w_msg,
			   @i_num = 2874902

				return 1
			end
		end
		else
		begin
			select @w_msg = mensaje
			from cobis..cl_errores
			where numero =  2874901

			select @w_msg = isnull(@w_msg, "SIN TEXTO")
				+ char(10)
				+ char(10)
				+ "SERVIDOR : "	+ @s_srv
				+ char(10)
				+ "Archivo : "	+ @i_archivo
				+ char(10)
				+ "Modulo  : "	+ convert(varchar, @i_modulo) 
				+ char(10)
				+ "Version : "	+ convert(varchar, @i_numero1)
				+ "."			+ convert(varchar, @i_numero2)
				+ "."			+ convert(varchar, @i_numero3)
				+ char(10)
				+ "Oficina : "	+ convert(varchar, @s_ofi)
				+ char(10)

			exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file = @t_file,
			   @t_from = @w_sp_name,
				@i_msg	=	@w_msg,
			   @i_num = 2874901
			return 1
		end
	end
end

return 0
go
