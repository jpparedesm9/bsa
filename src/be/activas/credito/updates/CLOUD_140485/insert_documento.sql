/*
*  Inserta documento solicitudCreditoIndividualRevolvente REQ#140485
*  Johan castro 08/11/2020
*/
use cob_credito
go 

declare @w_max int  
delete cr_imp_documento where id_toperacion = 'REVOLVENTE' and id_mnemonico = 'SICREV'
select @w_max = max(id_documento) from cr_imp_documento where id_toperacion = 'REVOLVENTE'
select @w_max = @w_max + 1 

INSERT INTO cr_imp_documento (id_documento,id_toperacion,id_producto,id_moneda,id_descripcion,id_mnemonico,id_tipo_tramite,id_template,id_estado,id_dato,id_medio) 
VALUES (@w_max ,'REVOLVENTE','CRE',0,'Solicitud Individual Complementaria','SICREV','O   ','solicitudCreditoIndividualRevolvente','P   ',NULL,NULL)

select * from cr_imp_documento where id_toperacion = 'REVOLVENTE'

go 