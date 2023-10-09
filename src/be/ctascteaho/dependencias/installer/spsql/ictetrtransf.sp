
use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icte_tr_transferencias')
  drop proc sp_icte_tr_transferencias
go

/****** Object:  StoredProcedure [sp_icte_tr_transferencias]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc sp_icte_tr_transferencias
@s_ssn		      int,
@s_ssn_branch	      int,
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
@t_corr               char(1) = 'N',
@t_ssn_corr           int = null,
@t_debug	      char(1) = 'N',
@t_file		      varchar(14) = null,
@t_from		      varchar(32) = null,
@t_rty		      char(1) = 'N',
@t_trn		      smallint,
@t_ejec		      char(1) = 'N', --CCR BRANCH III
@i_prodeb             char(3),
@i_ctadb              cuenta,
@i_prodep             char(3),
@i_cta_dep            cuenta,
@i_mon		      tinyint,
@i_val                money,
@i_sec		      tinyint = 0,
@i_oficina            smallint = null,
@i_nocaja             char(1) = 'N',
@i_inforcuenta        char(1) = 'N',
@i_atm_server	      char(1) = 'N',
@i_canal              smallint = null,
@i_srvorg	      varchar(8) = null,
@i_num_trans	      int = 0,
@i_cliente            int = null,
@i_comision           money = 0,
@i_monto_maximo	      char(1) = 'S',
@i_sobregirar         char(1) = 'N',
@i_referencia         varchar(40) = null,
@i_verifica_blq       char(1)  = 'S',
@i_turno	      smallint = null,
@i_por_traslado	      char(1) = null,
@i_sld_caja	      money = 0,   
@i_idcierre	      int = 0,     
@i_filial	      smallint = 1,
@i_idcaja	      int = 0,
@i_fecha_valor_a	datetime = null, 
@i_cau_comi	      varchar(3) = null,
@i_serial		varchar(20) = null,
@i_subcuenta_deb varchar(19) = null, 
@i_subcuenta_cre varchar(19) = null, 
@o_nomdb	      varchar(30) = null out,
@o_nomcr	      varchar(30) = null out,
@o_ssn                int = null out	

as declare
@w_sp_name            descripcion,
@w_return             int


select  @w_sp_name = "sp_icte_tr_transferencias"


return 0


GO

