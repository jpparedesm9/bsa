use cob_ccontable
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_errorcconta')
  drop proc sp_errorcconta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_errorcconta
(
    @t_debug        char(1) = 'N',
    @t_trn          int = null,
    @t_file         varchar(14) = null,
    @i_operacion        char(1)  = null,
    @i_empresa      tinyint = null,
    @i_fecha        datetime = null,
    @i_producto     tinyint = null,
    @i_tran_modulo      varchar(20) = null,
    @i_asiento      smallint = null,
    @i_fecha_conta      datetime = null,
    @i_numerror     int = null,
    @i_mensaje      varchar(100) = null,
    @i_perfil       varchar(20) = null,
    @i_modo         tinyint = null,
    @i_secuencial       int = null,
    @i_oficina      smallint = null,
    @i_valor        money = null,
    @i_comprobante      int = null
)
As
  return 0

go

