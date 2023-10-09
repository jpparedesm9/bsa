use cob_credito 
go 

if exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_mnemonico = 'SOLGRP')
begin
   update cob_credito..cr_imp_documento
   set id_estado='P'
   where id_mnemonico = 'SOLGRP'
end

if exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_mnemonico = 'CEASFU')
begin
   update cob_credito..cr_imp_documento
   set id_estado='P'
   where id_mnemonico = 'CEASFU'
end

if exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_mnemonico = 'SOLGRP')
begin
   update cob_credito..cr_imp_documento
   set id_estado='P'
   where id_mnemonico = 'SOLGRP'
end

if exists (select * from  cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_mnemonico = 'CEASFU')
begin
   update cob_credito..cr_imp_documento
   set id_estado='P'
   where id_mnemonico = 'CEASFU'
end

go
