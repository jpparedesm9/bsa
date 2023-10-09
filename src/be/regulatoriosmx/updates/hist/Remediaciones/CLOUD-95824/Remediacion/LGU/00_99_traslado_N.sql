
SELECT co_traslado, * FROM cob_conta..cb_comprobante  
where co_empresa = 1
and   co_mayorizado  = 'S'
and   co_autorizado  = 'S'
AND   co_fecha_tran = '01/01/2018'
AND   co_comprobante IN (509,
510,
511
)




UPDATE cob_conta..cb_comprobante  SET co_traslado = 'N'
where co_empresa = 1
and   co_mayorizado  = 'S'
and   co_autorizado  = 'S'
and   co_traslado    = 'S'
AND   co_fecha_tran  = '01/01/2018'
AND   co_comprobante IN (509,
510,
511
)



SELECT co_traslado,* FROM cob_conta..cb_comprobante  
where co_empresa = 1
and   co_mayorizado  = 'S'
and   co_autorizado  = 'S'
AND   co_fecha_tran = '01/01/2018'
AND   co_comprobante IN (509,
510,
511
)

SELECT * FROM cob_conta..cb_corte WHERE co_empresa = 1
AND co_periodo = 2018
AND co_corte = 1

UPDATE cob_conta..cb_corte  SET co_estado = 'V'
WHERE co_empresa = 1
AND co_periodo = 2018
AND co_corte = 1
SELECT * FROM cob_conta..cb_corte WHERE co_empresa = 1
AND co_periodo = 2018
AND co_corte = 1

