--rollback errores
USE cobis
go

delete cobis..cl_errores where numero IN (70200,70201)