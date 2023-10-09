USE cobis
GO
DELETE cobis..cl_errores WHERE numero =  701191
GO



UPDATE cob_conta..cb_det_perfil  SET dp_cuenta = '11020203' 
WHERE dp_perfil = 'CCA_PAG'
AND dp_codval = 136 -----SOBRANTE

GO

