/************************************************************************/
/*	Archivo:		moneda.sp				*/
/*	Stored procedure:	sp_moneda				*/
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
/*      Busqueda general y especificas de moneda                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*      24/Feb/93       M. Davila       Stored Procedure independiente  */
/*                                      de catalogo                     */
/*      24/Nov/93       R. Minga V.     documentacion, param @s_        */
/*                                      Verificacion y validacion       */
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_moneda')
   drop proc sp_moneda
go

create proc sp_moneda (
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
        @i_modo			tinyint = null,
        @i_tipo			char(2) = null,
        @i_moneda		tinyint = null
)
as
declare @w_sp_name	varchar(32)

select @w_sp_name = 'sp_moneda'

/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 1555
begin
  set rowcount 20
  if @i_modo = 0
	select 'Codigo' = mo_moneda,
	       'Moneda' = convert(char(20),mo_descripcion),
	       'Simbolo'= mo_simbolo,
	       'Cod. Pais' =  mo_pais,
	       'Pais' =convert(char(20),pa_descripcion),
	       'Estado' = mo_estado,
               'Decimales' = mo_decimales
	from   cl_moneda, cl_pais
	where  pa_pais = mo_pais
	order  by mo_moneda
   else
   if @i_modo = 1
	select 'Codigo' = mo_moneda,
	       'Moneda' = convert(char(20),mo_descripcion),
	       'Simbolo'= mo_simbolo,
	       'Cod. Pais' =  mo_pais,
	       'Pais' =convert(char(20),pa_descripcion),
	       'Estado' = mo_estado,
               'Decimales' = mo_decimales
	from   cl_moneda, cl_pais
	where  pa_pais = mo_pais
          and  mo_moneda > @i_moneda
	order  by mo_moneda
        if @@rowcount = 0
        exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101000
          /*    'No existe dato en catalogo'*/
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

/** Query **/
/* consulta de paises y monedas de 20 en 20 */
if @i_operacion = 'Q'
begin
if @t_trn = 1554
begin
  set rowcount 20
  if @i_modo = 0
	select 'Codigo' = mo_moneda,
	       'Moneda' = convert(char(20), mo_descripcion),
	       'Simbolo'= mo_simbolo,
	       'Cod. Pais' =  mo_pais,
	       'Pais' = convert(char(20), pa_descripcion)
	from   cl_moneda, cl_pais
	where  pa_pais = mo_pais
	  and  mo_estado = 'V'
	order  by mo_moneda 
   if @i_modo = 1
	select 'Codigo' = mo_moneda,
	       'Moneda' = convert(char(20), mo_descripcion),
	       'Simbolo'= mo_simbolo,
	       'Cod. Pais' =  mo_pais,
	       'Pais' = convert(char(20), pa_descripcion)
	from   cl_moneda, cl_pais
	where  pa_pais = mo_pais
          and  mo_moneda > @i_moneda
	  and  mo_estado = 'V'
	order  by mo_moneda 
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

/* ** Help ** */
if @i_operacion = "H"
begin
if @t_trn = 1556
begin
        /* Consulta de monedas y codigos de 20 en 20 */
	if @i_tipo = "A"
	begin
	  set rowcount 20
	  if @i_modo = 0
		select 'Codigo'= mo_moneda,
	     	       'Moneda' = convert(char(20), mo_descripcion),
	               'Simbolo'= mo_simbolo
		  from cl_moneda
		 where mo_estado = 'V'
		 order by mo_moneda
	  if @i_modo = 1
		select 'Codigo'= mo_moneda,
	     	       'Moneda' = convert(char(20), mo_descripcion),
	               'Simbolo'= mo_simbolo
		  from cl_moneda
		 where mo_moneda > @i_moneda
		   and mo_estado = 'V'
		 order by mo_moneda
	   set rowcount 0
	   return 0
	 end
	if @i_tipo = "V"
	begin
		select mo_descripcion
		  from cl_moneda
		 where mo_moneda = @i_moneda
		   and mo_estado = 'V'
		 order by mo_moneda

		if @@rowcount = 0
	 	        /* No existe dato solicitado */ 
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101000
	end
	if @i_tipo = "VL"
	begin
		select mo_descripcion, mo_decimales
		  from cl_moneda
		 where mo_moneda = @i_moneda
		   and mo_estado = 'V'
		 order by mo_moneda

		if @@rowcount = 0
	 	        /* No existe dato solicitado */ 
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101000
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
