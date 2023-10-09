/************************************************************************/
/*	Archivo:		suproofi.sp				*/
/*	Stored procedure:	sp_su_prooficina			*/
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

if exists (select * from sysobjects where name = 'sp_su_prooficina')
   drop proc sp_su_prooficina
go

create proc sp_su_prooficina (
	@t_debug      char(1) = 'N',
	@t_file	      varchar(10) = null,
	@t_from	      varchar(32) = null,
	@i_modo	      tinyint = null,
	@i_secuencial tinyint = null)
as
declare  @w_sp_name varchar(32)
select @w_sp_name = 'sp_su_prooficina'
set rowcount 20
if @i_modo = 0
     select 'Filial' = pl_filial,
	    'Localidad' = substring(of_nombre, 1, 15),
	    'Codigo' = pl_secuencial,
	    'Producto' = substring(pm_descripcion, 1, 15),
	    'Moneda' = substring(mo_descripcion, 1, 10)
     from   cl_pro_moneda, cl_pro_oficina, cl_oficina, cl_moneda
     where  of_oficina = pl_oficina
     and    pm_producto = pl_producto
     and    pm_moneda = pl_moneda
     and    mo_moneda = pl_moneda
     order  by pl_filial, pl_oficina,	pl_producto, pl_moneda
else
    select  'Filial' = pl_filial,
	    'Localidad' = substring(of_nombre, 1, 15),
	    'Codigo' = pl_secuencial,
	    'Producto' = substring(pm_descripcion, 1, 15),
	    'Moneda' = substring(mo_descripcion, 1, 10)
     from   cl_pro_moneda, cl_pro_oficina, cl_oficina, cl_moneda
     where  pl_secuencial > @i_secuencial
     and    of_oficina = pl_oficina
     and    pm_producto = pl_producto
     and    pm_moneda = pl_moneda
     and    mo_moneda = pl_moneda
     order  by pl_filial, pl_oficina,	pl_producto, pl_moneda
if @@rowcount = 0
begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101001
     /* 'No existe dato solicitado'*/
	return 1
end
set rowcount 0
go
