use cob_credito
go

select *
from cob_credito..cr_imp_documento
where id_mnemonico =  'CERCON'


if not exists (select 1 from cr_imp_documento where id_documento = 7)
begin
   insert into cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
   values (7, 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento', 'CERCON', 'O', 'certificadoConsentimiento', 'P', NULL, NULL)
end


select *
from cob_credito..cr_imp_documento
where id_mnemonico =  'CERCON'
