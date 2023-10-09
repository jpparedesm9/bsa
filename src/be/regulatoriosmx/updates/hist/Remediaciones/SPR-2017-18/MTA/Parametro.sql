use cobis
go

IF NOT EXISTS (SELECT 1 FROM  cobis..cl_parametro WHERE pa_nemonico = 'PMMGR')
BEGIN
   INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('PORCENTAJE DE MONTO GRUPAL', 'PMMGR', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 30, 'CRE')
END

GO
