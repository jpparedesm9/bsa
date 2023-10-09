use cobis
go

if not exists (select 1 from cl_parametro where pa_nemonico='S_APP' and pa_producto = 'ADM')
begin
    insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    values ('PATH S_APP EN SERVIDOR', 'S_APP', 'C', 'C:\cobisHostMS\kernel\bin\', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')
end
go


