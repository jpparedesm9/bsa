use cob_cartera
go

if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'ctr_convenio'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal_tipo_ref')) begin
   alter table ca_corresponsal_tipo_ref
   add ctr_convenio   varchar(255) null
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'co_convenio'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal')) begin
			   
   alter table ca_corresponsal
   drop column co_convenio
			   
end

go