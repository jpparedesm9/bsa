/***********************************************************************/
/*    Archivo:            cr_up_tr_solicitud.sp                        */
/*    Stored procedure:   sp_up_tr_solicitud                           */
/*    Base de Datos:      cob_credito                                  */
/*    Producto:           Credito                                      */
/*    Disenado por:       VBR                                          */
/***********************************************************************/
/*            IMPORTANTE                                               */
/*    Este programa es parte de los paquetes bancarios propiedad de    */
/*    'MACOSA',representantes exclusivos para el Ecuador de la         */
/*    AT&T                                                             */
/*    Su uso no autorizado queda expresamente prohibido asi como       */
/*    cualquier autorizacion o agregado hecho por alguno de sus        */
/*    usuario sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante               */
/***********************************************************************/
/*            PROPOSITO                                                */
/*    Este stored procedure actualiza  el nro de tramite que se renova */
/*    en la solicitud de WF                                            */
/***********************************************************************/
/*                       MODIFICACIONES                                */
/*    FECHA       AUTOR                  RAZON                         */
/* 01/09/2017    VBR     Emision Inicial                               */
/* 15/11/2018    MTA     Agregar validacion para los grupos            */
/* 14/11/2019    POV     Correccion para filtrar toperacion            */
/* 19/08/2020    ACH     #144022-cambio del orden regla-upd            */
/***********************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_up_tr_solicitud')
   drop proc sp_up_tr_solicitud
go

create proc sp_up_tr_solicitud (
   @s_ssn                int           = null,
   @s_user               login         = null,
   @s_sesn               int           = null,
   @s_term               varchar(30)   = null,
   @s_date               datetime      = null,
   @s_srv                varchar(30)   = null,
   @s_lsrv               varchar(30)   = null,
   @s_ofi                smallint      = null,
   @s_rol                smallint      = null,
   @t_trn                smallint      = 21020,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(30)   = null,
   @i_id_inst_proc       int           = null,
   @o_porcentaje         varchar(255)  = null out  
)
as
declare
@w_today           datetime,     -- FECHA DEL DIA
@w_return          int,          -- VALOR QUE RETORNA
@w_sp_name         varchar(32),  -- NOMBRE STORED PROC
@w_tramite         int,
@w_grupo           int,
@w_grupal          char(1),
@w_tramite_ant     int,
@w_tramite_ant_sol int,
@w_error           int,
@w_est_novigente   int,
@w_est_anulado     int,
@w_est_credito     int,
@w_toperacion      varchar(255),
@w_msg             varchar(255)

select @w_sp_name = 'sp_up_tr_solicitud'

/* Estados */
exec cob_externos..sp_estados
@i_producto      = 7,
@o_est_novigente = @w_est_novigente out,
@o_est_anulado   = @w_est_anulado out,
@o_est_credito   = @w_est_credito out

select 
@w_est_novigente = isnull(@w_est_novigente, 0),
@w_est_anulado   = isnull(@w_est_anulado, 6),
@w_est_credito   = isnull(@w_est_credito, 99)

select 
@w_grupal      = io_campo_7,
@w_tramite     = io_campo_3,
@w_grupo       = io_campo_1,
@w_toperacion  = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_grupal  = 'S'
begin
   select @w_tramite_ant = max(tg_tramite)
   from cob_cartera..ca_operacion, 
        cob_credito..cr_tramite_grupal
   where tg_grupo = @w_grupo
   and op_estado not in (@w_est_novigente,@w_est_anulado,@w_est_credito)
   and op_banco = tg_prestamo
   and tg_prestamo <> tg_referencia_grupal
   and tg_tramite <> @w_tramite
end
else 
begin
   select @w_tramite_ant = max(tr_tramite)
   from cob_credito..cr_tramite, 
       cob_cartera..ca_operacion
   where tr_tramite = op_tramite
   and op_toperacion = @w_toperacion
   and op_estado not in (@w_est_novigente,@w_est_anulado,@w_est_credito)
   and op_cliente in (select de_cliente from cr_deudores where de_tramite = @w_tramite and de_rol = 'D')   
end

if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_3 = @w_tramite and io_estado <> 'TER')
begin 
   select @w_tramite_ant_sol = isnull(io_campo_5,0)
   from cob_workflow..wf_inst_proceso 
   where io_campo_3 = @w_tramite

   print 'Tramite: '+convert(varchar(25), @w_tramite_ant_sol)+ '---- w_tramite_ant:' + convert(varchar(25),@w_tramite_ant)
   
   if @w_tramite_ant_sol =  0 and @w_tramite_ant <> 0
   begin
      update cob_workflow..wf_inst_proceso
      set io_campo_5 = @w_tramite_ant        
      where io_campo_3 = @w_tramite
   end
end

if @w_grupal  = 'S'
begin 
      exec @w_error     = cob_cartera..sp_ejecutar_regla
   @s_ssn            = @s_ssn,
   @s_ofi            = @s_ofi,
   @s_user           = @s_user,
   @s_date           = @s_date,
   @s_srv            = @s_srv,
   @s_term           = @s_term,
   @s_rol            = @s_rol,
   @s_lsrv           = @s_lsrv,
   @s_sesn           = @s_sesn,
   @i_regla          = 'TASA_GRP', 	 
   @i_id_inst_proc   = @i_id_inst_proc,
   @o_resultado1     = @o_porcentaje out
   
   if @w_error <> 0 
   begin 
      select 
      @w_msg   = 'ERROR: AL EJECUTAR LA REGLA DE TASA GRUPAL' ,
      @w_error = 70005
      goto ERROR_FIN  
   end
   if @o_porcentaje is null
      select @o_porcentaje = -1
end

return 0

ERROR_FIN:

exec @w_error = cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_msg

return @w_error

go
