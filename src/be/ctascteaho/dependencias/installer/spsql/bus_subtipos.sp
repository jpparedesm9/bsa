use cob_sbancarios
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_bus_subtipos')
  drop proc sp_bus_subtipos
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_bus_subtipos
(
  
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_trn              smallint    = null,
    @s_ofi              smallint    = null,
    @i_modo             char(1)     = null,
    @i_cod_subtipo      int         = 0,
    @i_estado           char(1)     = null,
    @i_cod_prod         tinyint     = null,
    @i_cod_ins          smallint    = null,
    @i_valor_unitario   money       = null,
    @i_comercial        char(1)     = 'N',
    @i_oficina          smallint    = null,
    @i_secuencial       int         = 0,
    @i_bco              smallint    = null,
    @i_cuenta           varchar(15) = null
)
as 
  return 0

go

