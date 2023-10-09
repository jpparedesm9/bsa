--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_credito 
go 

--Antes
select * from cob_credito..cr_plazo_ind

delete from cob_credito..cr_plazo_ind

insert into cr_plazo_ind values ('W', 16)
insert into cr_plazo_ind values ('W', 20)
insert into cr_plazo_ind values ('W', 24)

insert into cr_plazo_ind values ('BW', 12)
insert into cr_plazo_ind values ('BW', 24)

insert into cr_plazo_ind values ('M', 6)
insert into cr_plazo_ind values ('M', 12)

--Despues
select * from cob_credito..cr_plazo_ind

go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>


--------->>>>>>>>>REQ#203379 - OT plazos credito individual 2023
use cob_cartera
go

if object_id ('dbo.ca_plazo_asis_med') is not null
    drop table dbo.ca_plazo_asis_med
go
--------->>>>>>>>>Fin REQ#203379 - OT plazos credito individual 2023


--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go 

--Antes 
select top 1 * from ca_seguro_externo

if exists (select * from sys.columns 
           where Name = 'se_plazo_asis_med'
		   and Object_ID = Object_ID('ca_seguro_externo'))
begin
	alter table ca_seguro_externo drop column se_plazo_asis_med
end

--Despues 
select top 1 * from ca_seguro_externo

go 
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
