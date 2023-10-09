use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_rechazo_moncc')
  drop proc sp_rechazo_moncc
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_rechazo_moncc
(
  @i_fecha        datetime,
@i_producto     smallint,
@i_tipo         char(1) = 'M',
@o_procesadas   int out
)
as 
  return 0

go

