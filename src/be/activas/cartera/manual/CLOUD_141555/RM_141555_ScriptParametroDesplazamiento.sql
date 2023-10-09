use cobis
go

select *
from cobis..ba_parametro
where pa_batch =7093


if not exists(select * from cobis..ba_parametro where pa_batch = 7093 and pa_parametro = 3 and pa_sarta = 99)
begin
   insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (99, 7093, 17, 3, 'ACEPTA SOLAPAMIENTO', 'C', 'S')
end

if not exists(select * from cobis..ba_parametro where pa_batch = 7093 and pa_parametro = 3 and pa_sarta = 0)
begin
   insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 7093, 0, 3, 'ACEPTA SOLAPAMIENTO', 'C', 'N')
end
go



select *
from cobis..ba_parametro
where pa_batch =7093