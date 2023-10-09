use cob_conta_super
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_errorlog')
  drop proc sp_errorlog
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_errorlog
(
     @i_operacion         char(1)     = 'A',
   @i_fecha_fin         datetime    = null,
   @i_fuente            varchar(64) ,
   @i_origen_error      varchar(255)= null,
   @i_descrp_error      varchar(255)= null   
)
as 
  return 0

go

