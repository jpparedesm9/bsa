/************************************************************************/
/*	Archivo: 		domingos.sp				*/
/*	Stored procedure: 	sp_gen_domingos				*/
/*	Base de datos:  	cobis					*/
/*	Producto: 		Administracion				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 10-Feb-1993					*/
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
/*	Este programa genera los registros correspondientes a los	*/
/*	sabados y domingos del anio dado como parametro			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10-Feb-1993	S Ortiz		Emision inicial			*/
/*      11/Nov/93       R. Minga V.     Documentacion, parametros de    */
/*                                      debug                           */
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/
use cobis
go

if exists (select name from sysobjects where name = 'sp_gen_domingos')
	drop proc sp_gen_domingos
go

create proc sp_gen_domingos (
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
	@i_anio			tinyint
)
as
declare	@w_inicio	char(8),
	@w_contador	smallint,
	@w_dia_actual	datetime,
	@w_sabado	datetime,
	@w_domingo	datetime,
	@w_bandera	bit,
	@w_semanas	tinyint,
	@w_sp_name	varchar(30)

/*  Inicializar variables  */
select	@w_sp_name = 'sp_catalogo'

/*  Inicializar variables  */
select	@w_inicio = '01/01/' + convert(char(2), @i_anio),
	@w_bandera = 0,
	@w_semanas = 0,
	@w_contador = 0


/*  Encontrar los sabados y domingos del anio  */
begin tran
   /* Encontrar el primer sabado */
   while @w_bandera = 0
      begin
	select	@w_dia_actual = dateadd(dd, @w_contador, @w_inicio)

	/*  Encuentra el primer sabado del anio  */
	if datepart(dw, @w_dia_actual) = 7
	begin
		select	@w_sabado = @w_dia_actual,
			@w_domingo = dateadd(dd, 1, @w_dia_actual),
			@w_bandera = 1
	end
	select	@w_contador = @w_contador + 1
     end

/* insertar el primer sabado en dias feriados */
insert  into cl_dias_feriados (df_fecha) values (@w_sabado)

/* si no se puede insertar, error */
if @@error != 0
begin
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 103052
	return  1
end

/* insertar el primer domingo */
insert  into cl_dias_feriados (df_fecha) values (@w_domingo)
if @@error != 0
begin
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 103053
	return  1
end

/*  Encuentra los sabados y domingos siguientes  */
while @w_semanas <= 50 
begin
	select	@w_sabado  = dateadd(dd, 7, @w_sabado),
		@w_domingo = dateadd(dd, 7, @w_domingo),
		@w_semanas = @w_semanas + 1

        /* insertar los sabados */
	insert  into cl_dias_feriados (df_fecha) values (@w_sabado)
	if @@error != 0
	begin
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103052
		return  1
	end

        /* insertar los domingos */
	insert  into cl_dias_feriados (df_fecha) values (@w_domingo)
	if @@error != 0
	begin
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103053
		return  1
	end
end
commit tran
go
