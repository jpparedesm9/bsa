-------Rollback Req.185234 - Seguros Individual 
use cob_credito
go

delete cr_imp_documento where id_mnemonico in ('CERCONIND','CEASFUIND') and id_toperacion ='INDIVIDUAL' 
go

