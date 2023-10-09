/************************************************************************/
/*	Archivo:		hpagen.sp				*/
/*	Stored procedure:	sp_hp_agencia				*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
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
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_hp_agencia')
   drop proc sp_hp_agencia
go
create proc sp_hp_agencia (
		@t_debug	char(1) = 'N',
		@t_file		varchar(10) = null,
		@t_from		varchar(32) = null,
		@i_tipo 	char(1),
		@i_filial	tinyint = null,
		@i_codigo	tinyint = null
)
as
declare @w_sp_name	varchar(32)
select @w_sp_name = 'sp_hp_agencia'


if @i_tipo = 'A'
begin
	 select   of_oficina, of_nombre
	   from	  cl_oficina
	   where  of_filial = @i_filial
	    and   of_subtipo = 'A'
	   order  by of_filial, of_oficina
	 if @@rowcount = 0
	 begin
	    exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101028
	  /* 'No existe agencia'*/
	    return 1
	 end
	 return 0
end
if @i_tipo = 'V'
begin
	 select  of_nombre
	   from  cl_oficina
	  where  of_filial = @i_filial
	    and  of_oficina = @i_codigo
	    and  of_subtipo = 'A'
	 if @@rowcount = 0
	 begin
	    exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101028
	  /* 'No existe agencia'*/
	    return 1
	 end

end
go
