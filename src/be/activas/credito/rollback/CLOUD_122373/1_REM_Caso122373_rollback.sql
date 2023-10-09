-------------------->>UPDATE DE ESTADO
use cob_credito
go

update cr_imp_documento
set    id_estado = 'P'
where  id_mnemonico = 'AUTPARE'

-------------------->>INSERT PARAMETRO ACTIVAR
use cobis
go

if exists(select 1 from cobis..cl_parametro 
    where  pa_producto = 'CRE'
    and    pa_nemonico = 'ADODOM')
begin
    print 'Ya existe'
end
else
begin
    insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	values ('ACTIVAR FUNCIONALIDAD DOCUMENTO DOMICILIACION S/N', 'ADODOM', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
end
	
go
