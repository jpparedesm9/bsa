



if not exists(select 1 from cobis..cl_parametro where pa_nemonico = 'CBMMC')
begin
  insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
  values ('CODIGO BATCH MENSUAL MOV. CONT', 'CBMMC', 'I', NULL, NULL, NULL, 36429, NULL, NULL, NULL, 'CON')
end