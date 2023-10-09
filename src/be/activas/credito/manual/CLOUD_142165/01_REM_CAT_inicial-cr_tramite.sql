use cob_credito
go
if not exists (SELECT 1 FROM sys.columns WHERE Name = 'tr_cat_caratula'
               AND Object_ID = Object_ID('cob_credito..cr_tramite')) begin
   alter table cr_tramite
   add tr_cat_caratula FLOAT null
end


go

