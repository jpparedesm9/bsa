

use cob_cartera 
go 



select 'ANTES',* from ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2
select 'ANTES',* from ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2
select 'ANTES',* from ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2



---DELETE ESTADOS ANTERIORES 
delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2 
delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2
delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 2



delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 1  and em_estado_fin = 12 
delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 2 
delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 1 
delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 2  and em_estado_fin = 1
delete ca_estados_man where em_toperacion = 'GRUPAL' and em_tipo_cambio = 'A' and em_estado_ini = 2  and em_estado_fin = 12

delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 12 
delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 2 
delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 1
delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 2  and em_estado_fin = 1
delete ca_estados_man where em_toperacion = 'INDIVIDUAL' and em_tipo_cambio = 'A' and em_estado_ini = 2  and em_estado_fin = 12

delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 1 and em_estado_fin = 12 
delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 2 
delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 12 and em_estado_fin = 1
delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 2 and em_estado_fin = 1
delete ca_estados_man where em_toperacion = 'REVOLVENTE' and em_tipo_cambio = 'A' and em_estado_ini = 2  and em_estado_fin = 12


 
---INSERT NUEVOS ESTADOS 

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('GRUPAL', 'A', 1, 12, 31, 89)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('GRUPAL', 'A', 12, 2, 90, 179)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('GRUPAL', 'A', 12, 1, 0, 30)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('GRUPAL', 'A', 2, 1, 0, 30)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('GRUPAL', 'A', 2, 12, 31, 89)
go

-----
insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('INDIVIDUAL', 'A', 1, 12, 31, 89)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('INDIVIDUAL', 'A', 12, 2, 90, 179)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('INDIVIDUAL', 'A', 12, 1, 0, 30)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('INDIVIDUAL', 'A', 2, 1, 0, 30)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('INDIVIDUAL', 'A', 2, 12, 31, 89)
go

----

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('REVOLVENTE', 'A', 1, 12, 31, 89)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('REVOLVENTE', 'A', 12, 2, 90, 179)
go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('REVOLVENTE', 'A', 12, 1, 0, 30)

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('REVOLVENTE', 'A', 2, 1, 0, 30)

go

insert into dbo.ca_estados_man (em_toperacion, em_tipo_cambio, em_estado_ini, em_estado_fin, em_dias_cont, em_dias_fin)
values ('REVOLVENTE', 'A', 2, 12, 31, 89)
go
----


---INSERT TABLA CA_ESTADO 
select 'ANTES', * from ca_estado



delete from dbo.ca_estado where es_codigo = 1 
delete from dbo.ca_estado where es_codigo = 12
delete from dbo.ca_estado where es_codigo = 2 



insert into dbo.ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago)
values (1, 'VIGENTE', 'S', 'S')
go

insert into dbo.ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago)
values (12, 'VIGENTE', 'S', 'S')
go

insert into dbo.ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago)
values (2, 'VENCIDO', 'S', 'S')
go


select 'DESPUES', * from ca_estado