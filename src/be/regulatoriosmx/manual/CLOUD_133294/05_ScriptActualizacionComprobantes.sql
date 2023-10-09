
SELECT * FROM cob_conta..cb_comprobante
WHERE co_empresa    = 1
AND co_fecha_tran   = '01/01/2020'
AND co_automatico   = 6079
and co_descripcion like '%Cierre de Periodo%'

update cob_conta..cb_comprobante set
co_reversado = 'S'
WHERE co_empresa    = 1
AND co_fecha_tran   = '01/01/2020'
AND co_automatico   = 6079
and co_descripcion like '%Cierre de Periodo%'

SELECT * FROM cob_conta..cb_comprobante
WHERE co_empresa    = 1
AND co_fecha_tran   = '01/01/2020'
AND co_automatico   = 6079
and co_descripcion like '%Cierre de Periodo%'


