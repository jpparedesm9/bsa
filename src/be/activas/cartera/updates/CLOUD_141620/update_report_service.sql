/*
 *   Actualiza el nombre del servicio a invocar
 *   Johan Castro
 *   14/10/2020 
 */
use cob_credito
go 

select * 
from   cr_imp_documento 
where  id_toperacion = 'GRUPAL' 
and    id_mnemonico = 'CERCON'

update cr_imp_documento 
set    id_template = 'certificadoConsentimientoZurich-SecureConsent' 
where  id_toperacion = 'GRUPAL' and id_mnemonico = 'CERCON'

select * 
from   cr_imp_documento 
where  id_toperacion = 'GRUPAL' 
and    id_mnemonico = 'CERCON'

go 