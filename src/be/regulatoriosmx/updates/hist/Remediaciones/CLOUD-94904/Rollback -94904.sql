USE cobis
GO

SELECT en_nombre, en_nomlar,* FROM cobis..cl_ente WHERE en_ente = 1292

UPDATE cl_ente
SET en_nombre = 'LILIANA',
    en_nomlar = 'LILIANA SOLEDAD ESTRADA SOLIS'
WHERE en_ente = 1292

SELECT en_nombre, en_nomlar,* FROM cobis..cl_ente WHERE en_ente = 1292

go