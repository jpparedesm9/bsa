use cob_cartera
go
if not exists (select 1 from syscolumns where id = object_id('ca_corresponsal_trn') and name = 'co_login')
begin
	alter table ca_corresponsal_trn
	add co_login login
end

if not exists (select 1 from syscolumns where id = object_id('ca_corresponsal_trn') and name = 'co_terminal')
begin
	alter table ca_corresponsal_trn
	add co_terminal varchar(30)
end

if not exists (select 1 from syscolumns where id = object_id('ca_corresponsal_trn') and name = 'co_fecha_real')
begin
	alter table ca_corresponsal_trn
	add co_fecha_real datetime
end
go