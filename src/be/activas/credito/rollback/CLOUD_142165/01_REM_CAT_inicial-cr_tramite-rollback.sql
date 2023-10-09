use cob_credito
go
if exists (SELECT 1 FROM sys.columns WHERE Name = 'tr_cat_caratula'
               AND Object_ID = Object_ID('cob_credito..cr_tramite')) begin
   alter table cr_tramite
   drop column tr_cat_caratula
end


go