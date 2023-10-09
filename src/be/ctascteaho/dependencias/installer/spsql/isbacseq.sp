
use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_isba_cseqnos')
  drop proc sp_isba_cseqnos
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc [dbo].[sp_isba_cseqnos] 
  (   @i_tabla           varchar(30)     = NULL,      
      @o_siguiente       int             = NULL   out
         
)
as

declare @w_return    int

exec @w_return = cob_sbancarios..sp_cseqnos
@i_tabla     = @i_tabla,
@o_siguiente = @o_siguiente out

if @w_return <> 0 or @@error <> 0
begin
   --NO SE PUDO OBTENER EL SECUENCIAL DE LA OPERACION
   exec cobis..sp_cerror
   @i_num = 2902990
   return 2902990
end
   
if @o_siguiente is null
   select @o_siguiente = 1
   
return 0


GO

