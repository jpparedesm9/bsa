use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icus_valida_cuenta_gar')
  drop proc sp_icus_valida_cuenta_gar
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc sp_icus_valida_cuenta_gar(
@s_ssn		      int,
@s_ssn_branch	  int,
@s_srv		      varchar(30) = null,
@s_lsrv		      varchar(30) = null,
@s_user		      varchar(30) = null,
@s_sesn		      int = null,
@s_term		      varchar(10),
@s_date		      datetime,
@s_ofi		      smallint,  /* Localidad origen transaccion */
@s_rol		      smallint = 1,
@s_org_err	      char(1)  = null,	/* Origen de error: [A], [S] */
@s_error	      int      = null,
@s_sev		      tinyint  = null,
@s_msg		      mensaje  = null,
@s_org		      char(1),
@t_corr           char(1) = 'N',
@t_ssn_corr       int = null,
@t_debug	      char(1) = 'N',
@t_file		      varchar(14) = null,
@t_from		      varchar(32) = null,
@t_rty		      char(1) = 'N',
@t_trn		      smallint,
@t_ejec		      char(1) = 'N', --CCR BRANCH III
@i_cuenta         cuenta = null,
@i_producto       int = null,
@o_cuenta         int = null out
)as
 
declare @w_sp_name     descripcion,
        @w_return      int
 
select  @w_sp_name = "sp_icus_valida_cuenta_gar"
 
select @o_cuenta = 0
 
return 0


GO

