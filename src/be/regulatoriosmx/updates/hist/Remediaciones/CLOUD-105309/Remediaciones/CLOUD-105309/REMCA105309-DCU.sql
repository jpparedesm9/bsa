use cobis
go

delete from cobis..cl_parametro WHERE pa_nemonico in ('POPAGP')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
     VALUES ('PORCENTAJE DE PAGO GRUPO PROMO', 'POPAGP'   , 'T'    , NULL   , 40        , NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

