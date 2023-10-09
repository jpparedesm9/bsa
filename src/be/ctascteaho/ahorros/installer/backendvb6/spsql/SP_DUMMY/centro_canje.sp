use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_centro_canje')
  drop proc sp_centro_canje
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_centro_canje
(
   @s_srv          varchar(16) = null,
       @t_debug        char(1) = 'N', 
       @t_file         varchar(14) = null,
       @t_from         varchar(32) = null,
       @t_trn          smallint,
       @i_filial       tinyint = 1,
       @i_opcion       char(2),
       @i_sec          int = null,
       @i_oficina      int = null,
       @i_desc         varchar(255) = null,
       @i_ciudad       int = null,
       @i_tipo         char(2) = null,
       @i_modo         tinyint = 0,
       @i_ofi_canje    int = null
)
as 
  return 0

go

