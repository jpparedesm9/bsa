
USE cobis
go

UPDATE cobis..cl_seqnos
SET siguiente = 90
WHERE tabla = 'si_dispositivo'

