use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_crea_ofibanco')
  drop proc sp_tr_crea_ofibanco
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_tr_crea_ofibanco
(
 @s_ssn           int,
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_user           varchar(30),
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_ofi            smallint,
    @s_rol            smallint    = 1,
    @s_org_err        char(1)     = null,
    @s_error          int         = null,
    @s_sev            tinyint     = null,
    @s_msg            varchar(240)     = null,
    @s_org            char(1),
    @t_debug          char(1)     = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1)     = 'N',
    @t_trn            smallint,
    @i_tran               char(1)     = null,
    @i_oficina            smallint    = null,
    @i_ciudad             int    = null,
    @i_desc           varchar(64) = null,
    @i_direccion          varchar(120)   = null,
    @i_telefono           varchar(12) = null
)
as 
  return 0

go

