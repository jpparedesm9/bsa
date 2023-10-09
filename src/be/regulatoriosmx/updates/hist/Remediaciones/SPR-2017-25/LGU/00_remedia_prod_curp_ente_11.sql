/*  ACTUALIZAR  RFC Y CURP
*/
USE cobis
GO
SELECT en_ced_ruc, en_rfc, en_nit
FROM cl_ente
where en_ente = 11


UPDATE cl_ente SET
	en_ced_ruc = 'GIRC430705MMCLSR04',
	en_rfc =  'GIRC430705PTA',
	en_nit  =  'GIRC430705PTA'
where en_ente = 11


SELECT en_ced_ruc, en_rfc, en_nit
FROM cl_ente
where en_ente = 11




SELECT ea_ced_ruc, ea_nit
FROM cl_ente_aux
where ea_ente = 11

UPDATE cl_ente_aux SET
	ea_ced_ruc  = 'GIRC430705MMCLSR04',
	ea_nit = 'GIRC430705PTA'
where ea_ente = 11

SELECT ea_ced_ruc, ea_nit
FROM cl_ente_aux
where ea_ente = 11

PRINT 'Actualizacion terminada...'

GO




