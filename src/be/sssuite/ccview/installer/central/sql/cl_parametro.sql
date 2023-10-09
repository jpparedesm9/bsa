use cobis
go

if not exists ( select * from cl_parametro where pa_nemonico= 'PTI')
begin
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MONTO CAPITAL AJUSTADO', 'PTI', 'M', NULL, NULL, NULL, NULL, 5000000, NULL, NULL, 'CRE')
end

if not exists ( select * from cl_parametro where pa_nemonico= 'LIMICE')
begin
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('LIMITE GRUPO ICE',	'LIMICE',	'T',	NULL,	30	,NULL,	NULL,	NULL,	NULL, NULL,	'CRE')
end

if not exists ( select * from cl_parametro where pa_nemonico= 'LPTMAX')
begin
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('LIMITE DE CREDITO / CAPITAL AJUSTADO','LPTMAX','F',NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	20,	'CRE')
end


if not exists ( select * from cl_parametro where pa_parametro= 'CONYUGE')
begin
	declare @w_id_relacion int
	
	select @w_id_relacion = 2
	SELECT @w_id_relacion = re_relacion from cl_relacion where re_descripcion = 'CONYUGE' or re_descripcion = 'CÓNYUGE O UNION LIBRE'
	
	INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	VALUES('CONYUGE','COU','T',NULL, @w_id_relacion, NULL,	NULL,	NULL,	NULL, NULL,	'CRE')
end
go
