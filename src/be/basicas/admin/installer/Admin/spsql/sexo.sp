/************************************************************************/
/*	Archivo:		sexo.sp					*/
/*	Stored procedure:	sp_sexo 				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Clientes				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 06-Nov-1992					*/
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
/*	Query de empleo 						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	06/Nov/92	M. Davila	Emision Inicial			*/
/*	15/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Seccion de Debug		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_sexo')
   drop proc sp_sexo
go

create proc sp_sexo (
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
	@t_trn			smallint = null,
       	@i_operacion		char(2),
       	@i_codigo		char(10) = null,
       	@i_modo			tinyint = null,
       	@i_valor 		varchar(32) = null

)
as
declare  @w_sp_name varchar(32)
select @w_sp_name = 'sp_sexo'





/* Search */
if @i_operacion = 'S' OR @i_operacion = 'Q'
begin
If @t_trn =15050 or @t_trn = 15051
begin
     set rowcount 20
     if @i_modo = 0
	select 'Codigo' = codigo,
	       'Sexo' = valor
	from   cl_catalogo
	where  tabla = 7
	order  by codigo
     else
	if @i_modo = 1
	   select 'Codigo' = codigo,
		  'Sexo' = valor
	   from   cl_catalogo
	   where  tabla = 7
	   and	  codigo > @i_codigo
	   order  by codigo
     if @@rowcount = 0
     begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101000
	   /* 'No existe dato en catalogo'*/
	return 1
     end
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

go
