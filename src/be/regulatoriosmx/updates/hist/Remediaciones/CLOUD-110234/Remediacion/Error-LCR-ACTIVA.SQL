use cobis 
go 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (70067, 0, 'ERROR: EL CLIENTE TIENE UNA LCR EN CURSO')



update cobis..ba_batch set 
ba_arch_fuente = 'cob_cartera..sp_lcr_generar_candidatos'
where ba_batch =7088


use cob_cartera 
go 

if object_id ('dbo.ca_lcr_candidatos') is not null
	drop table dbo.ca_lcr_candidatos
go

create table dbo.ca_lcr_candidatos (
	cc_fecha_ing       datetime      not null,   
	cc_fecha_liq       datetime      not null,
	cc_grupo           int           not null,
	cc_nom_grupo       varchar (64)      null,
    cc_oficina         int               null,       
	cc_cliente         int          not  null,
	cc_nombre          varchar (255)     null,
    cc_gerente         login             null,
	cc_asesor          login             null,
	cc_user            login             null,
	cc_date            datetime          null,
	cc_respuesta       catalogo          null,
	cc_periodicidad    catalogo          null,
	cc_asesor_asig     login             null)
go

create index idx1 on ca_lcr_candidatos(cc_cliente)
create index idx2 on ca_lcr_candidatos(cc_gerente)

go 



if object_id ('dbo.lcr_reporte_candidatos') is not null
	drop table dbo.lcr_reporte_candidatos
go

create table dbo.lcr_reporte_candidatos (   
	fecha_liq          varchar (255)       not null,
	grupo              varchar (255)   not null,
    oficina            int                 null,       
	cliente            int             not null,
	nombre             varchar (255)       null,
	asesor             varchar (255)       null,
	gerente            varchar (255)       null)

go
