USE cobis
GO
DELETE cobis..cl_errores WHERE numero =  701191

INSERT INTO cobis..cl_errores VALUES (701191, 0, 'No puede reversar esta transaccion')

SELECT * FROM cobis..cl_errores WHERE numero =  701191
GO





UPDATE cob_conta..cb_det_perfil  SET dp_cuenta = 'F_PAGO' 
WHERE dp_perfil = 'CCA_PAG'
AND dp_codval = 136 -----SOBRANTE

GO

