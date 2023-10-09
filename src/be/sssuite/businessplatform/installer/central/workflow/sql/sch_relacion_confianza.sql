/* RELACION DE CONFIANZA */
use cobis
go

declare @w_ap_id int,
        @w_rc_id int,
        @w_sec   int,
        @w_rol   int

/* Escogemos rol */
select @w_rol = inst_rol from cobis..platform_installer

/* Verificamos existencia de la aplicacion */
select @w_ap_id = ap_id_aplicacion
from cts_aplicacion
where ap_nombre = 'Scheduler'

/* Si existe borramos referencias */
if (@w_ap_id != null)
begin
   select @w_rc_id = ue_id_relacion
   from cts_usuario_externo
   where ue_id_aplicacion = @w_ap_id
   
   if (@w_rc_id != null)
   begin
      delete cts_relacion_confianza
      where rc_id_relacion = @w_rc_id

      delete cts_usuario_externo
      where ue_id_aplicacion = @w_ap_id
        and ue_id_relacion = @w_rc_id

      delete cts_aplicacion
      where ap_id_aplicacion = @w_ap_id
   end
end

/* Si existió aplicación usamos el mismo código para inserción */
/* caso contrario obtenemos secuencial                        */
if (@w_ap_id = null)
   select @w_ap_id = isnull(max(ap_id_aplicacion),0) +1
   from cts_aplicacion

insert into cts_aplicacion(ap_id_aplicacion, ap_nombre,   ap_terminal, ap_estado )
                    values(@w_ap_id,         'Scheduler', 'TERM-SCHED', 'V')

if (@w_rc_id = null)
   select @w_rc_id = isnull(max(rc_id_relacion),0) + 1
   from cts_relacion_confianza

insert into cts_usuario_externo(ue_id_aplicacion, ue_usuario, ue_rol, ue_id_relacion, ue_estado )
                         values(@w_ap_id,         'admuser',  @w_rol, @w_rc_id,       'V')

select @w_sec = isnull(max(rc_secuencial),0) + 1
from cts_relacion_confianza

insert into cts_relacion_confianza(rc_secuencial, rc_id_relacion, rc_usuario, 
                                   rc_rol,        rc_oficina,     rc_terminal, 
                                   rc_servidor,   rc_id_sesion,   rc_id_sesion_cts,
                                   rc_estado)
                            values(@w_sec,        @w_rc_id,       'admuser',
                                   @w_rol ,       1,              'TERM-SCHED',
                                   'CTSSRV',      null,           'ID:414d5120514d2e42524f4b455230312037b7be482000d502',
                                   'V')                                                                                          
go
