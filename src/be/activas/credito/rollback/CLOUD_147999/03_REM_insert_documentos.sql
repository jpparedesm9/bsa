/*
*  Inserta documento solicitudCreditoIndividualRevolvente REQ#147999
*  Johan castro 08/01/2021
*/
use cob_credito
go 

delete cr_imp_documento where id_toperacion = 'RENOVACION'
delete cobis..cl_catalogo where tabla = 682 and codigo = 'CRRENGR'
delete cobis..cl_catalogo where tabla = 691 and codigo = 'RENOVACION'

-- Documento encontrado en pruebas de humo caso 147999

update cr_imp_documento
set    id_estado     = 'C'
where  id_toperacion = 'GRUPAL'
and    id_producto   = 'CRE'
and    id_mnemonico  = 'CERCON2'

go 