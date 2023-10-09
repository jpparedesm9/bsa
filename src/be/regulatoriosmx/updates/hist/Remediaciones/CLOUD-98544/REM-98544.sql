--'herojas' 67
--'bdelacruz' 117
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=67,
c_funcionario='herojas' WHERE en_ente 
IN (6781,6783,6785,6789,6791,6796,6804,6845,6874,
 6879,6883,6893,6894,7006,7013,7227)


UPDATE cobis..cl_grupo SET gr_oficial=67
WHERE gr_grupo IN (257,261)

UPDATE cobis..cl_cliente_grupo SET cg_usuario='herojas'
WHERE cg_grupo IN (257,261)

SELECT * FROM cobis..cl_ente WHERE en_ente 
   IN (6781,6783,6785,6789,6791,6796,6804,6845,6874,
       6879,6883,6893,6894,7006,7013,7227)
 
SELECT * FROM cobis..cl_grupo WHERE gr_grupo IN (257,261)
 
SELECT * FROM cobis..cl_cliente_grupo WHERE cg_grupo IN (257,261)

go