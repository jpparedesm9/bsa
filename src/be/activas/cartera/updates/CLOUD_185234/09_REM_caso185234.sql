USE cob_cartera
GO

select TOP 10 * from cob_cartera..ca_corresponsal_limites where cl_corresponsal_id = '10' and cl_tipo_tran = 'GI'

INSERT INTO ca_corresponsal_limites (cl_corresponsal_id, cl_limite_min, cl_limite_max, cl_tipo_tran)
VALUES ('10', 75, 10000, 'GI')
GO

select TOP 10 * from cob_cartera..ca_corresponsal_limites where cl_corresponsal_id = '10' and cl_tipo_tran = 'GI'
GO
