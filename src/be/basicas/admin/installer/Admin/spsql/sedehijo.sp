/************************************************************************/
/*	Archivo:		sedehijo2.sp				*/
/*	Stored procedure:	sp_se_dehijo2				*/
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
/*	06/Nov/92	L. Carvajal	Emision Inicial			*/
/*	15/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*      24/Feb/93       M. Davila       Eliminacion del retorno del     */
/*                                      campo nivel                     */
/*                                                                      */
/*      17/Ene/94       F.Espinosa      Cambio en el envio del parametro*/
/*                                      filial en lugar de la oficina   */
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*                                      Seccion de Debug   		*/
/*	08/Sep/94	C.Rodriguez	Considerar la oficina para la	*/
/*					jerarquia			*/
/*	02/Feb/01	C.Navas		Considerar la oficina para la	*/
/*					jerarquia inicial		*/
/*	26/Jul/01	A.Duque		Correcciòn jerarquico de dep.	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_se_dehijo2')
   drop proc sp_se_dehijo2
go

create proc sp_se_dehijo2 (
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
	@i_modo 	   	tinyint = null,
	@i_filial	   	tinyint = null,
	@i_departamento    	smallint = null,
	@i_oficina		smallint = null
)
as
declare @w_sp_name  varchar(32),
	@w_minimo_nivel   tinyint
select @w_sp_name = 'sp_se_dehijo2'


If @t_trn = 15046
begin
if @i_modo = 0
begin
--ADU: 2001-07-27
     select @w_minimo_nivel=min(de_nivel)
     from    cl_departamento
     where   de_filial = @i_filial
       and   de_oficina = @i_oficina
       and   de_departamento <>0
--FIN ADU


/*    select  str(de_oficina,3), 
	    str(de_departamento,3),*/
    select  de_oficina,
	    de_departamento,
	    substring(de_descripcion, 1, 40)
     from   cl_departamento
    where   de_filial = @i_filial
      and   de_oficina = @i_oficina 
      and   de_nivel=@w_minimo_nivel	--ADU: 2001-07-27
    order   by de_oficina, de_departamento
end
else
    -- CNA 05-02-2001
    /*select  str(de_oficina,3),
	    str(de_departamento,3),*/
    select  de_oficina,
	    de_departamento,
	    substring(de_descripcion,1,40)
      from  cl_departamento
     where  de_filial = @i_filial
       and  de_o_oficina = @i_oficina
       and  de_o_departamento = @i_departamento
     order  by de_oficina, de_departamento
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
