-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_cat') IS NOT NULL
	DROP table dbo.ca_cat
go

create table dbo.ca_cat
	(
	ct_tipo_tabla      varchar(10),
	ct_tasa_interes    float,
	ct_tasa_comision   float,
	ct_periodicidad    int,
	ct_cat             float
	)
go

insert into ca_cat values ('ROTATIVA',70,3,7,245.94)
insert into ca_cat values ('ROTATIVA',70,3,14,161.58)
go
