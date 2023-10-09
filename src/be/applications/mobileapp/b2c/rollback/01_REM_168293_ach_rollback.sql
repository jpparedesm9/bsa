USE cobis
GO

SELECT fu_oficina, * FROM cl_funcionario
WHERE fu_login   = 'onboarding'

UPDATE cl_funcionario SET fu_oficina = 9001
WHERE fu_login   = 'onboarding'

SELECT fu_oficina, * FROM cl_funcionario
WHERE fu_login   = 'onboarding'
GO
