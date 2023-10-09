use cobis
go

if not exists (select 1 from cl_parametro where pa_nemonico = 'APERN4' and pa_producto='REC')
begin
	insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	values ('RPT - APERTURA N4', 'APERN4', 'C', 'Aperturas', null, null, null, null, null, null,  'REC')
end
go