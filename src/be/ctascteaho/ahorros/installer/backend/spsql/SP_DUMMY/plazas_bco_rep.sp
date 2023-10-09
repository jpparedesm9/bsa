use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_plazas_bco_rep')
  drop proc sp_plazas_bco_rep
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_plazas_bco_rep
(
   @s_srv                   varchar(16) = null,
       @t_debug                 char(1) = 'N', 
       @t_file              varchar(14) = null,
       @t_from              varchar(32) = null,
       @t_trn               smallint,
       @i_operacion             char(1),
       @i_plaza         smallint = 0,
       @i_oficina       smallint = 0    
)
as 
  return 0

go

