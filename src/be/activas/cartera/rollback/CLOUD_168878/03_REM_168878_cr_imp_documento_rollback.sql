use cob_credito 
go 

delete from  cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_mnemonico = 'SOPREREFI'
delete from  cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_mnemonico = 'SOLPREGRU'

go
