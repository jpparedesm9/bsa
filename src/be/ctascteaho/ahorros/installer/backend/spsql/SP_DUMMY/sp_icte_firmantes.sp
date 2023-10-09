use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icte_firmantes')
  drop proc sp_icte_firmantes
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_icte_firmantes
(
  @s_ssn        int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user     varchar(30),
    @s_sesn         int=null,
    @s_term     varchar(10),
    @s_date     datetime,
    @s_ofi      smallint,   /* Localidad origen transaccion */
    @s_rol      smallint,
    @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
    @s_error    int = null,
    @s_sev          tinyint = null,
    @s_msg      varchar(240)    = null,
    @s_org      char(1),
    @t_corr     char(1) = 'N',
    @t_ssn_corr int = null, /* Trans a ser reversada */
    @t_debug    char(1) = 'N',
    @t_file     varchar(14) = null,
    @t_from     varchar(32) = null,
    @t_rty      char(1) = 'N',
    @t_trn      smallint,
    @i_operacion varchar(1),
    @i_producto  varchar(3),     --Nemonico del producto cobis ('AHO', 'CTE')
    @i_cuenta    varchar(25),    --string de la cuenta
    @i_moneda    tinyint,    --codigo moneda
    @i_ente      int    --cod_ente

)
as 
  return 0

go

