--NOMBRE: ARACELI RODRIGUEZ AGUIRRE
--ID: 42210
--FECHA DE NACIMIENTO CORRECTA: 19/06/1984
--FECHA DE NACIMIENTO INCORRECTA: 18/06/1984
--
--NOMBRE: TERESA CATALINA LOPEZ CRUZ
--ID: 42188
--FECHA DE NACIMIENTO CORRECTA: 06/04/1971
--FECHA DE NACIMIENTO INCORRECTA: 05/04/1971

update cobis..cl_ente
set p_fecha_nac = '06/19/1984'
where en_ente = 42210

update cobis..cl_ente
set p_fecha_nac = '04/06/1971'
where en_ente = 42188

go

