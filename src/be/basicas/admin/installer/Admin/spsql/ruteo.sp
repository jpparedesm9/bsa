/************************************************************************/
/*	Archivo:		ruteo.sp				*/
/*	Stored procedure:	sp_ruteo				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 08-Nov-1992					*/
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
/*	Query de ruteo							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Seccion de Debug	 	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_ruteo')
   drop proc sp_ruteo
go

create procedure sp_ruteo (
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
	@i_filial_d		tinyint,
	@i_oficina_d		smallint,
	@i_nodo_d		tinyint,
	@i_filial_h		tinyint,
	@i_oficina_h		smallint,
	@i_nodo_h		tinyint,
	@i_max_nivel 		int = 5
)
as
set nocount on
declare
	@w_nivel	int,
	@w_origen 	varchar(20),
	@w_destino	varchar(20),
	@w_nombre	varchar(20),
	@w_pasos	tinyint,
	@w_resultado	varchar(80),
	@w_sp_name      varchar(32)


select @w_sp_name = 'sp_ruteo'



If @t_trn = 15045
begin

	select  @w_origen = substring(X.di_nombre_n_d, 1, 20),
		@w_destino = substring(Y.di_nombre_n_h, 1, 20)
	from	ad_directa X, ad_directa Y
	where	X.di_filial_d = @i_filial_d
	and	X.di_oficina_d = @i_oficina_d
	and	X.di_nodo_d = @i_nodo_d
	and	Y.di_filial_h = @i_filial_h
	and	Y.di_oficina_h = @i_oficina_h
	and	Y.di_nodo_h = @i_nodo_h
if @@rowcount = 0
begin
	exec sp_cerror
		@i_num = 151018
		/* no existe ruta directa */
	return 1
end

create table #stack (nombre char(20), nivel int)
create table #list (nombre char(20),
		    nivel int,
		    li_estado char(1))
create table #ad_resultado (ruta varchar(70), pasos tinyint)

insert #stack values (@w_origen, 1)
select @w_nivel = 1

while @w_nivel > 0
 begin

	if exists (select * 
		     from #stack 
		    where nivel = @w_nivel)
	begin
		select @w_origen = nombre
		  from #stack
		 where nivel = @w_nivel

		delete from #stack
		 where nivel = @w_nivel
		   and   nombre = @w_origen

		delete from #list
		 where nivel >= @w_nivel

		if exists (select * 
			     from #list
			    where nombre = @w_origen)
		   continue

		insert #list values(@w_origen, @w_nivel, 'V')

		/* impresion de resultados */
		if (@w_origen = @w_destino)
		begin
			select @w_pasos = count(*)
			from #list

			/* listado horizontal */
			select @w_resultado = ''
			while 1>0
			begin
			  select @w_nombre = nombre
			  from	#list
			  where	li_estado = 'V'
			  order by nivel
			  if @@rowcount = 0
			     break

			  select @w_resultado = @w_nombre + ' - ' + @w_resultado
			  update #list
			  set	li_estado = 'C'
			  where	nombre = @w_nombre
			end
			insert into #ad_resultado values(@w_resultado, @w_pasos)
			update #list
			   set li_estado = 'V'
			continue
		end

		insert #stack
		select di_nombre_n_h, @w_nivel+1
	 	  from ad_directa
     		 where di_nombre_n_d = @w_origen
	   	    and @w_nivel < @i_max_nivel
		if @@rowcount > 0
			select @w_nivel = @w_nivel + 1
	end
	else
		select @w_nivel = @w_nivel - 1
end
select	'Ruta' = ruta, 'Pasos' = pasos
  from	#ad_resultado
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
go
				
	
