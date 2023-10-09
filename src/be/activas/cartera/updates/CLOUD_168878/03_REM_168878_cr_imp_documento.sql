use cob_credito 
go 

declare @w_maximo_renovacion int = 0, @w_maximo_grupal int = 0

select @w_maximo_renovacion = max(id_documento)+1 from cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION'
select @w_maximo_grupal = max(id_documento)+1 from cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL'

if not exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_mnemonico = 'SOPREREFI')
begin
   insert into cr_imp_documento (id_documento, id_toperacion, id_producto, id_moneda, id_descripcion, id_mnemonico, id_tipo_tramite, id_template, id_estado, id_dato, id_medio)
   values (@w_maximo_renovacion, 'RENOVACION', 'CRE', 0, 'Solicitud Prellenada Renovación Financiada', 'SOPREREFI', 'O', 'solicitudCreditoRenovFinanPrellenada', 'P', null, null)
end

if not exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_mnemonico = 'SOLPREGRU')
begin
   insert cob_credito..cr_imp_documento(id_documento,id_toperacion,id_producto, id_moneda, id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio)
   values(@w_maximo_grupal,'GRUPAL','CRE', 0, 'Solicitud Prellenada Grupal','SOLPREGRU', 'O', 'solicitudCreditoGrupalPrellenada', 'P', null, null)
end

go
