use cobis
go

delete from cl_ttransaccion
 where tn_trn_code in (1610)
go

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1610, 'TRANSACCION CONSULTA HOMINI VALIDA', 'TRCHV', 'TRANSACCION CONSULTA HOMINI VALIDA')

go

