USE cob_cartera
go

select * from   ca_estados_man where em_tipo_cambio ='A'

insert into ca_estados_man values('GRUPAL','A',1,4,180,99999)

insert into ca_estados_man values('GRUPAL','A',2,4,180,99999)

insert into ca_estados_man values('INDIVIDUAL','A',1,4,180,99999)

insert into ca_estados_man values('INDIVIDUAL','A',2,4,180,99999)

insert into ca_estados_man values('REVOLVENTE','A',1,4,180,99999)

insert into ca_estados_man values('REVOLVENTE','A',2,4,180,99999)