USE cob_cartera
GO

select TOP 10 * from cob_cartera..ca_corresponsal_limites where cl_corresponsal_id = '10' and cl_tipo_tran = 'GI'

delete cob_cartera..ca_corresponsal_limites where cl_corresponsal_id = '10' and cl_tipo_tran = 'GI'

select TOP 10 * from cob_cartera..ca_corresponsal_limites where cl_corresponsal_id = '10' and cl_tipo_tran = 'GI'
GO
