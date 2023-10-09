/************************************************************************/
/*  Archivo:              distcolres.sp                                 */
/*  Stored procedure:     sp_dist_colectivo_responsable                 */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         Sonia Rojas                                   */
/*  Fecha de escritura:   18/Noviembre/2019                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
 
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_dist_colectivo_responsable')
   drop proc sp_dist_colectivo_responsable
go


create proc sp_dist_colectivo_responsable(
@i_colectivo              varchar(255),
@o_oficial_resp           int         out,
@o_oficial_resp_login     varchar(50) out
)
as
declare
@w_error                  int,
@w_msg                    varchar(255),
@w_sp_name                varchar(64),
@w_oficial                int,
@w_numero                 int,
@w_funcionario            int


select @w_sp_name = 'sp_dist_colectivo_responsable'
select @w_oficial = 0, @w_numero = 0

select funcionario = cc_funcionario, numero = 0
into #funcionario 
from  ca_colectivo_cargo
where cc_colectivo = @i_colectivo
and   cc_rol       = 'ASESOR'

if @@rowcount = 0 begin
   select 
   @w_error = 70400,
   @w_msg = 'ERROR: NO ESTA PARAMETRIZADO UN ASESOR PARA EL COLECTIVO INGRESADO'
   goto ERROR_FIN
end
   
while 1 = 1 begin

   select top 1 @w_funcionario = funcionario 
   from #funcionario
   where funcionario > @w_oficial
   order by funcionario asc
   
   if @@rowcount = 0 break
   
   select @w_oficial    = oc_oficial
   from cobis..cl_funcionario, cobis..cc_oficial
   where fu_funcionario = oc_funcionario
   and   fu_funcionario = @w_funcionario
   
   if @@rowcount = 0 or @w_oficial is null begin
      select 
      @w_error = 151091,
      @w_msg = 'ERROR: NO EXISTE OFICIAL'
      goto ERROR_FIN
   end 
   
   select @w_numero = count(tr_tramite)
   from cob_credito..cr_tramite, cob_workflow..wf_inst_proceso
   where tr_tramite = io_campo_3
   and   io_estado  = 'EJE'
   and   tr_oficial = @w_oficial
   
   update #funcionario set 
   numero           = @w_numero
   where funcionario = @w_funcionario


end

select top 1 
@o_oficial_resp =  funcionario
from #funcionario
order by numero asc

select @o_oficial_resp_login = fu_login 
from cobis..cl_funcionario
where fu_funcionario         = @o_oficial_resp

return 0

ERROR_FIN:

exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
return @w_error
go
