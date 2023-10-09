use cobis
go

--Parametro para indicar si el sistema tiene cuentas migradas
DELETE cobis..cl_parametro WHERE pa_producto = 'AHO' AND pa_nemonico = 'CTAMIG'
go

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('EL SISTEMA TIENE CUENTAS MIGRADAS (S=SI,N=NO)', 'CTAMIG', 'C', 'S', 'AHO')
go

