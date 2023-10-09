/************************************************************************/
/*	Archivo:		sefuhijo.sp				*/
/*	Stored procedure:	sp_se_fuhijo				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
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
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_se_fuhijo')
   drop proc sp_se_fuhijo
go
create proc sp_se_fuhijo (
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
	@i_modo 	   	smallint = null,
	@i_funcionario	  	smallint = null
)
as
declare @w_sp_name  varchar(32)
select @w_sp_name = 'sp_se_fuhijo'




If @t_trn = 15047
begin

if @i_modo = 0
    select  fu_funcionario,
	    substring(fu_nombre, 1, 40),
	    de_filial,
	    de_oficina
    from    cl_funcionario, cl_departamento
   where    fu_nivel = 0
     and    de_departamento = fu_departamento
     and    de_oficina = fu_oficina
    order   by fu_funcionario
else
    select  fu_funcionario,
	    substring(fu_nombre, 1, 40),
	    de_filial,
	    de_oficina
      from  cl_funcionario, cl_departamento
     where  fu_jefe = @i_funcionario
       and  de_departamento = fu_departamento
       and  de_oficina = fu_oficina
     order  by fu_funcionario
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
