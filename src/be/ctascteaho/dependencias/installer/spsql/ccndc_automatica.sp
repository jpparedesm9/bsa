use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_ccndc_automatica') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_ccndc_automatica
    IF OBJECT_ID('dbo.sp_ccndc_automatica') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_ccndc_automatica >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_ccndc_automatica >>>'
END
go
create proc sp_ccndc_automatica (
        @s_srv                  varchar(30),
        @s_ofi                  smallint,
        @s_ssn                  int,
	@s_ssn_branch		int = null,
        @s_user                 varchar(24) = 'CTE',
        @s_org                  char(1) = 'L',
        @s_lsrv                 varchar(30) = null,
        @s_term                 varchar(10) = 'consola',
        @s_date                 datetime = null, /*RQU Pers Branch II */ 
        @t_trn                  int,
        @t_ssn_corr             int = null,
	@t_ejec                 char(1) = null,
	@i_cta                  cuenta,
        @i_val                  money = null, --ACO ENE/05/2001
	@i_cau			varchar(3),
	@i_mon	        	tinyint,
	@i_dep                  tinyint = 1,
	@i_alt	        	int = 0,
        @i_fecha                datetime,
	@i_interes		money = null,
	@i_comision		money = 0,
	@i_solca		money = null,
        @i_mora                 money = 0,
	@i_tinteres		real = null,
	@i_tcomision		real = null,
	@i_tsolca		real = null,
	@i_tmora 		real = null,
	@i_reverso		char(1) = null,
	@i_changeofi		char(1)= 'N',
	@i_nchq                 int=null,
	@i_valch                money=null,
        @i_cobsus               char(1) = 'N',
	@i_inmovi		char(1) = 'N',
	@i_cobiva               char(1) = 'N', 
	@i_corr                 char(1) = 'N',
	@i_ind                  int     = 1,
	@i_canal		tinyint = null,
	@i_bloq_cta		char(1) = 'N',
	@i_afecta_minimo	char(1) = 'N', -- Vicente Mafla
	@i_accion		char(1) = 'E',
	@i_impues_trans		smallint = null,
        @i_modulo               smallint = null, 
	@i_enlinea		char(1)	= 'S',
	@i_bloq_no   		char(1) = null,
	@i_bloq_sob		char(1) = null,  -- EAA 07/16/2002
	@i_sin_cobro_imp        char(1) = 'N',
        @i_iva                  money = null,
        @i_concepto		varchar(64) = null,
        @i_pit                  char(1) = 'N',
        @i_origen		char(1) = null,  -- EAA 09/19/2005
        @i_trn_cenit            int = 0, 
	@o_clase_clte		char(1) = null out,
	@o_prod_banc		tinyint = null out,
	@o_valiva	        money = null out,
     -- II VMA 26-abr-2001
	@o_valnxmil		money = null out
     -- FI VMA 26-abr-2001

 )
as
select @o_clase_clte,
	   @o_prod_banc,
	   @o_valiva,
	   @o_valnxmil

return 0
go
IF OBJECT_ID('dbo.sp_ccndc_automatica') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_ccndc_automatica >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_ccndc_automatica >>>'
go

