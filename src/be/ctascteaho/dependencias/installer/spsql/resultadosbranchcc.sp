use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_resultados_branch_cc')
  drop proc sp_resultados_branch_cc
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_resultados_branch_cc
(
   @t_debug         char(1)     = 'N',
    @t_file          varchar(14) = null,
    @t_from          varchar(30) = null,
    @s_ssn_host      int         = null,
    @i_cuenta        int,
    @i_tipo_cuenta   char(1),    -- Posibles valores (O)rigen ,(D)estino
    @i_fecha         datetime,
    @i_ofi           smallint
)
as 
  return 0

go

