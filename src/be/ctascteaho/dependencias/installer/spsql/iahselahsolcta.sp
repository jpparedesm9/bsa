use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_iaho_select_ah_sol_cuenta')
  drop proc sp_iaho_select_ah_sol_cuenta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc [dbo].[sp_iaho_select_ah_sol_cuenta]
@i_numsol	      int ,
@o_estado_sol   char(2) = null out

as declare
@w_sp_name            descripcion

select  @w_sp_name = 'sp_iaho_select_ah_sol_cuenta'

select @o_estado_sol = sc_estado
	from cob_ahorros..ah_solicitud_cuenta
	where sc_numsol = @i_numsol
	and  sc_estado in ('AP')
	

return 0


GO

