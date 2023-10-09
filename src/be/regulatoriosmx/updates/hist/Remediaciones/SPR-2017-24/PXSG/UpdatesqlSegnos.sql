
USE cobis
go

update cobis..cl_seqnos
		set siguiente = 87
		where tabla = 'si_dispositivo'
go