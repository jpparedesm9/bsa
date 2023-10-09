use cob_cartera
go

if not exists (select 1 from syscolumns where id = object_id('ca_precancela_refer') and name = 'pr_referencia') 
begin
	alter table ca_precancela_refer add pr_referencia varchar(64)
end
go

use cobis
go

DELETE cobis..cl_errores WHERE numero =  701192
INSERT INTO cobis..cl_errores VALUES (701192, 1, 'La Fecha valor es mayor a la fecha proceso')
go
