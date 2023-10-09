use cob_credito
go


DECLARE @w_id_documento INT

SELECT @w_id_documento = isnull(max(id_documento) ,0) +1
FROM cob_credito..cr_imp_documento 
WHERE id_toperacion = 'GRUPAL'

DELETE cob_credito..cr_imp_documento 
WHERE id_toperacion = 'GRUPAL'
AND id_descripcion  = 'Certificado de Consentimiento 2'


INSERT INTO dbo.cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
VALUES (@w_id_documento , 'GRUPAL', 'CRE', 0, 'Certificado de Consentimiento 2', 'CERCON2', 'O', 'certificadoConsentimiento', 'P', NULL, NULL)

go


use cobis
go


if not exists (select 1  from cobis..cl_parametro where pa_nemonico='DIVLIM' and pa_producto='CCA')
begin
   insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   values ('DIVIDENDO LIMITE', 'DIVLIM', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')
end 
go

