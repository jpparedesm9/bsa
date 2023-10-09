--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_credito 
go 

--Antes
select * from cob_credito..cr_plazo_ind

delete from cob_credito..cr_plazo_ind

insert into cr_plazo_ind values ('W', 12)
insert into cr_plazo_ind values ('W', 25)
insert into cr_plazo_ind values ('W', 38)
insert into cr_plazo_ind values ('W', 51)

insert into cr_plazo_ind values ('BW', 6)
insert into cr_plazo_ind values ('BW', 12)
insert into cr_plazo_ind values ('BW', 19)
insert into cr_plazo_ind values ('BW', 25)

insert into cr_plazo_ind values ('M', 3)
insert into cr_plazo_ind values ('M', 6)
insert into cr_plazo_ind values ('M', 9)
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

create table dbo.ca_plazo_asis_med
    (
    pm_producto    varchar(10),
    pm_plazo       int,
    pm_frecuencia  varchar(10),
	pm_valor       money,
    pm_seguro      varchar(16)
    )
go

insert into ca_plazo_asis_med values ('INDIVIDUAL', 3,  'M', 52.5, 'EXTENDIDO')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 6,  'M', 52.5, 'EXTENDIDO')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 9,  'M', 52.5, 'EXTENDIDO')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 12, 'M', 52.5, 'EXTENDIDO')

--Despues
select * from cob_cartera..ca_plazo_asis_med
--------->>>>>>>>>Fin REQ#203379 - OT plazos credito individual 2023


--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go 

--Antes 
select top 1 * from ca_seguro_externo

if not exists (select * from sys.columns 
               where Name = 'se_plazo_asis_med'
			   and Object_ID = Object_ID('ca_seguro_externo'))
begin
	alter table ca_seguro_externo add se_plazo_asis_med int null
end

--Despues 
select top 1 * from ca_seguro_externo

go 
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>