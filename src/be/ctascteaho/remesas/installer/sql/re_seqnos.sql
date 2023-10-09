use cobis
go

/************/
/*  SEQNOS  */
/************/

print 'Insercion:  cl_seqnos'

delete cl_seqnos
where bdatos = 'cob_remesas' and tabla in ('pd_titulos', 'pd_transferidos', 
   're_cab_cheques', 
    're_cab_dataentry', 're_camara', 
    're_carta', 're_cheque_rec', 
    're_cheque_rem', 're_clase_impuesto', 
    're_consecutivo', 're_definicion_caja', 
    're_enca_transfer_automatica', 're_excepciones', 
    're_limites', 're_movimientos_caja', 
    're_ndc_auto_cabecera', 're_ndc_automatica', 
    're_orden_caja', 're_parametro_extracto', 
    're_peticiones_efectivo', 're_planilla', 
    're_rembolso_corresponsal', 're_seciss_ind', 
    're_tran_contable', 're_transferencia', 
    're_trn_perfil', 're_valida_datos_offline')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pd_titulos', 0, 'ti_contador')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pd_transferidos', 0, 'tf_contador')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_cab_cheques', 0, 'cc_sec')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_cab_dataentry', 0, 'ce_comprobante')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_camara', 0, 'ca_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_carta', 0, 'ct_carta')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_cheque_rec', 0, 'cr_cheque_rec')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_cheque_rem', 0, 'cr_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_clase_impuesto', 0, null)
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_consecutivo', 0, null)
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_definicion_caja', 0, 'dc_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_enca_transfer_automatica', 0, 'ta_codigo')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_excepciones', 0, 'ex_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_limites', 0, 'li_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_movimientos_caja', 0, 'mc_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_ndc_auto_cabecera', 0, 'na_sec')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_ndc_automatica', 0, 'na_sec')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_orden_caja', 0, 'oc_idorden')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_parametro_extracto', 0, 'pe_codigo')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_peticiones_efectivo', 0, 'pe_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_planilla', 0, null)
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_rembolso_corresponsal', 0, 're_sec')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_seciss_ind', 0, null)
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_tran_contable', 0, 'tc_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_transferencia', 0, 'tr_id')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_trn_perfil', 0, 'tp_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 're_valida_datos_offline', 0, 'vd_idvalidacion')
go 
