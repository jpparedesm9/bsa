--actualizacion de registros de sincronizacion

USE cob_sincroniza
go

UPDATE cob_sincroniza..si_sincroniza SET si_estado='P', si_fecha_sin=null
WHERE si_secuencial IN (2201,2202) AND si_usuario='herojas'

SELECT * FROM cob_sincroniza..si_sincroniza WHERE si_secuencial IN (2201,2202)

go