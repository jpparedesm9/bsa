use cob_bvirtual
go

delete from bv_b2c_tipo_msg where tm_tipo_msg = 'PAGO_VEN'
delete from bv_b2c_tipo_msg where tm_tipo_msg = 'VISITA'
delete from bv_b2c_tipo_msg where tm_tipo_msg = 'INCRE_LCR'
delete from bv_b2c_tipo_msg where tm_tipo_msg = 'RENO_LCR'
delete from bv_b2c_tipo_msg where tm_tipo_msg = 'ERROR_DES'

insert into bv_b2c_tipo_msg
values ('PAGO_VEN', 0, NULL, NULL,
'LE RECORDAMOS QUE EL DÍA DE HOY VENCE SU CUOTA', 
'OK', 'N', 'V', NULL,NULL,NULL,NULL)
go

insert into bv_b2c_tipo_msg
values ('VISITA', 0, NULL, NULL,
'LE GUSTARÍA QUE UN OFICIAL DE CRÉDITO LE VISITE EL DÍA DE MAÑANA', 
'SN', 'N', 'V', NULL,'SÍ','NO','N')
go


insert into cob_bvirtual..bv_b2c_tipo_msg
values ('INCRE_LCR', 0, 'cob_cartera', 'sp_lcr_incrementar_cupo',
'SE APROBÓ EL INCREMENTO A TU LÍNEA DE CRÉDITO POR $[VAR1] MXN. AUTORÍZALO DANDO CLIC EN "SÍ".', 
'SN', 'S', 'V', NULL,'SÍ','NO','S')
go

insert into bv_b2c_tipo_msg
values ('RENO_LCR', 0, 'cob_cartera',null,
'FELICIDADES, TIENES UNA RENOVACIÓN APROBADA', 
'SN', 'N', 'V', 'sp_ejecuta_msg_ren_b2c','Aceptar','Rechazar','N')
go

insert into bv_b2c_tipo_msg
values ('ERROR_DES', 2, NULL, NULL, 
'EL DEPÓSITO POR $[VAR1] MXN SOLICITADO EL [VAR2] A LAS [VAR3], NO SE PUDO REALIZAR EXITOSAMENTE. EL MOTIVO DEL ERROR EN EL FOLIO DE REFERENCIA: [VAR4] ES: [VAR5]. POR FAVOR COMUNÍQUESE CON EL SERVICIO DE ATENCIÓN DE TUIIO.',
'XX', 'N', 'V', NULL,NULL,NULL,NULL)
go

