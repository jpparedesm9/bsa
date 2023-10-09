use cobis
go

delete from cl_parametro 
where pa_nemonico in ('RENAPO', 'VIGANI', 'VIGREI', 'VIGCOD', 'VIGSOC', 'RENAPO', 'RENBRN', 'RENCHN', 'RENTTP',
                      'RENTI1','RENTI2','RENLON','RENLAT') and pa_producto='CLI'

insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('BANDERA PARA HABILITAR RENAPO','RENAPO','C','N','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('BRANCH RENAPO','RENBRN','C','0000','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('CHANNEL RENAPO','RENCHN','C','002','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('TRANSACTION TYPE RENAPO','RENTTP','C','7001','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('TRANSACTION ID PT 1 RENAPO','RENTI1','C','12345123451234512','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('TRANSACTION ID PT 2 RENAPO','RENTI2','C','34512374','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('LONGITUDE RENAPO','RENLON','C','1','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('LATITUDE RENAPO','RENLAT','C','1','CLI')
INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char,  pa_producto)
VALUES ('RESPUESTA RENAPO OK002', 'RENOK2', 'C', 'OK0002','CLI')


insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto)
values ('VIGENCIA ANVERSO IDENTIFICACION','VIGANI','S',30,'CLI')
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto)
values ('VIGENCIA REVERSO IDENTIFICACION','VIGREI','S',30,'CLI')
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto)
values ('VIGENCIA COMPROBANTE DOMICILIO','VIGCOD','S',30,'CLI')
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto)
values ('VIGENCIA SOLICITUD CORTA','VIGSOC','S',90,'CLI')

if exists (select 1 from cl_parametro where pa_nemonico = 'ENVBIO')
begin
	delete from cl_parametro 
	where pa_nemonico = 'ENVBIO'
end
else
begin
	insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	values ('AMBIENTE SERVICIOS BIOMETRICOS', 'ENVBIO', 'C', 'pro', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
end

go
