use 
cobis
go

if exists (SELECT * FROM cl_parametro WHERE pa_nemonico = 'COU' AND pa_producto = 'CRE')
begin
    UPDATE cl_parametro 
    SET pa_tinyint = 209
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'COU'
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('CONYUGE', 'COU', 'T', NULL, 209, NULL, NULL, NULL, NULL, NULL, 'CRE')
end
GO