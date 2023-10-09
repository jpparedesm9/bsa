/*
*  Inserta documento solicitudCreditoIndividualRevolvente REQ#140485
*  Johan castro 08/11/2020
*/
use cob_credito
go 

delete cr_imp_documento where id_toperacion = 'REVOLVENTE' and id_mnemonico = 'SICREV'

select * from cr_imp_documento where id_toperacion = 'REVOLVENTE'

go 