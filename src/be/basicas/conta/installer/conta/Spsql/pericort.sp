/************************************************************************/
/*	Archivo: 		pericort.sp				*/
/*	Stored procedure: 	sp_pericort				*/
/*	Base de datos:  	cob_conta					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  		Jorge Rivera Farino        		*/
/*	Fecha de documentacion:	21/Abr/95				*/
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
/*      Retornar el periodo y el corte al que pertenese una fecha dada  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_pericort')  
 drop proc sp_pericort  
 
go 

create proc sp_pericort (
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
        @i_empresa              tinyint=null,
        @i_fecha_tran           datetime=null,
	@o_corte 		int	=null out,
	@o_periodo 		tinyint	=null out,
	@o_estado 		char(1)	=null out
	)
as
declare 
	@w_return       int,
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_today 	datetime,  	/* fecha del dia */
	@w_corte	int,
	@w_estado	char(1),
	@w_periodo	int,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_pericort'

/*  Modo de debug  */
if @t_debug = 'S'
begin
        exec cobis..sp_begin_debug @t_file = @t_file
        select  '/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn			   = @s_ssn,
		s_user			   = @s_user,
		s_sesn			   = @s_sesn,
		s_term			   = @s_term,	
		s_date			   = @s_date,	
		s_srv			   = @s_srv,	
		s_lsrv			   = @s_lsrv,	
		s_rol			   = @s_rol,
		s_ofi			   = @s_ofi,
		s_org_err		   = @s_org_err,
		s_error			   = @s_error,
		s_sev			   = @s_sev,
		s_msg			   = @s_msg,
		s_org			   = @s_org,
		t_debug			   = @t_debug,	
		t_file			   = @t_file,
		t_from			   = @t_from,
		i_empresa		   = @i_empresa,
		i_fecha_tran 		   = @i_fecha_tran
        exec cobis..sp_end_debug
end

/***  DETERMINAR A QUE CORTE PERTENECE EL ASIENTO  ***/

select @w_corte = co_corte, @w_periodo = co_periodo, @w_estado = co_estado
from cob_conta..cb_corte
where co_empresa = @i_empresa and
      co_fecha_ini <= @i_fecha_tran and
      co_fecha_fin >= @i_fecha_tran 

if @@rowcount = 0
begin
	/* 'Periodo o corte no definido '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 603023
	return 1
end
else
begin
    select @o_corte   = @w_corte
    select @o_periodo = @w_periodo
    select @o_estado  = @w_estado
    return 0 
end
go
