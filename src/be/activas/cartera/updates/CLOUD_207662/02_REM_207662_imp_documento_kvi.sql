use cob_credito
go 

--Antes
select * from cob_credito..cr_imp_documento
order by id_toperacion


--Individual
update cob_credito..cr_imp_documento
set id_estado = 'C'
where id_toperacion = 'INDIVIDUAL'
and id_documento = 11

delete from cob_credito..cr_imp_documento where id_toperacion = 'INDIVIDUAL' and id_documento = 13
insert into cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
values (13, 'INDIVIDUAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCONIND', 'O', 'certificadoConsentimientoZurich-SecureConsentInd', 'P', null, null)


--Grupal
update cob_credito..cr_imp_documento
set id_estado = 'C'
where id_toperacion = 'GRUPAL'
and id_documento = 7

delete from cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_documento = 13
insert into cob_credito..cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
values (13, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsentGru', 'P', null, null)


--Renovacion
update cob_credito..cr_imp_documento
set id_estado = 'C'
where id_toperacion = 'RENOVACION'
and id_documento = 6

delete from cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_documento = 10
insert into cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
values (10, 'RENOVACION', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimientoZurich-SecureConsentRen', 'P', null, null)


--Despues
select * from cob_credito..cr_imp_documento
order by id_toperacion  

go
