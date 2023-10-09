use cobis
go

/************/
/*  SEQNOS  */
/************/

print 'Insercion:  cl_seqnos'

delete cl_seqnos
where bdatos = 'cob_remesas' and tabla in (
    'pe_cambio_costo', 'pe_cambio_val_contr', 
    'pe_costo', 'pe_mercado', 'pe_pro_bancario', 
    'pe_pro_final', 'pe_servicio_dis', 
    'pe_servicio_per', 'pe_tipo_rango', 
    'pe_val_contratado','pe_pro_rango_edad')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_cambio_costo', 0, 'cc_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_cambio_val_contr', 0, 'vv_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_costo', 0, 'co_secuencial')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_mercado', 0, 'me_mercado')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_pro_bancario', 0, 'pb_pro_bancario')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_pro_final', 0, 'pf_pro_final')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_servicio_dis', 0, 'sd_servicio_dis')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_servicio_per', 0, 'sp_servicio_per')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_tipo_rango', 0, 'tr_tipo_rango')
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_remesas', 'pe_val_contratado', 0, 'vc_secuencial')
go

insert into cobis..cl_seqnos   (bdatos, tabla, siguiente, pkey) 
values  ('cob_remesas', 'pe_pro_rango_edad',0,'re_codigo')  
go

