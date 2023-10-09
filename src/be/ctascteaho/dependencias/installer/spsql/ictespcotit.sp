use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icte_sp_cotitulares')
  drop proc sp_icte_sp_cotitulares
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc [dbo].[sp_icte_sp_cotitulares]
@i_cta		cuenta,
@i_mon		tinyint,
@i_producto          tinyint,
@o_nombre1           varchar(64) out,
@o_nombre2           varchar(64) out


as declare
@w_sp_name            descripcion


select  @w_sp_name = "sp_icte_sp_cotitulares"

   --  BUSCA COTITULARES

	 
return 0


GO

