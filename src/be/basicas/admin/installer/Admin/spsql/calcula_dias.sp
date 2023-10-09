use cobis
go

if exists(select * from sysobjects where name = 'sp_calcula_dias') 
		drop proc sp_calcula_dias











go
create proc sp_calcula_dias (
		@t_debug	char(1) = 'N',
		@t_file		varchar(14) = null,
		@t_from		varchar(32) = null,
		@i_fecha	datetime
) as
declare	@w_max_dias	tinyint,
	@w_cont_dias	tinyint,
	@w_fecha	datetime,
	@w_secuencial	smallint,
	@w_sp_name	varchar(30)

/*  Captura nombre de stored procedure  */
select	@w_sp_name = 'sp_calcula_dias'

/*  Inicializa variables  */
select	@w_max_dias  = 100,
	@w_cont_dias = 0,
	@w_fecha     = @i_fecha


/*  Inserta el registro correspondiente a la fecha de input */
insert into cl_dias_laborables (dl_fecha, dl_num_dias) 
	values	(@w_fecha, 0) 
if @@error != 0
begin
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 103051
	return  1
end

/*  Calcula numero de dias transcurridos  */
while	@w_max_dias != 0
begin
	/*  Resta dias  */
	select	@w_fecha = dateadd(dd, -1, @w_fecha)
	/*  Determina si @w_fecha es feriado  */
	if not exists (select	df_fecha
			 from	cobis..cl_dias_feriados
			where	df_fecha = @w_fecha)
	      select @w_cont_dias = @w_cont_dias + 1

	/*  Inserta el registro correspondiente  */
	insert into cl_dias_laborables (dl_fecha, dl_num_dias) 
	  values (@w_fecha, @w_cont_dias * -1) 
	if @@error != 0
	begin
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103051
		return  1
	end
        select @w_max_dias = @w_max_dias - 1
end


/*  Inicializa variables  */
select	@w_max_dias  = 100,
	@w_cont_dias = 0,
	@w_fecha     = @i_fecha

/*  Calcula numero de dias posteriores  */
while	@w_max_dias != 0
begin
	/*  Suma dias  */
	select	@w_fecha = dateadd(dd, 1, @w_fecha)
	/*  Determina si @w_fecha es feriado  */
	if not exists (select	df_fecha
			 from	cobis..cl_dias_feriados
			where	df_fecha = @w_fecha)
	   select @w_cont_dias = @w_cont_dias + 1

	/*  Inserta el registro correspondiente  */
	insert into cl_dias_laborables (dl_fecha, dl_num_dias) 
		values	(@w_fecha, @w_cont_dias) 
	if @@error != 0
 	begin
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103051
		return  1
	end
	select @w_max_dias = @w_max_dias - 1
end
go
