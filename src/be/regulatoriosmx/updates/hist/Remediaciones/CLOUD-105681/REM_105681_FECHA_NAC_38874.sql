
--ACTUALIZACION DE LA FECHA DE NACIMIENTO DEL PROSPECTO 38874 MARY ANN SABCHEZ CONDE.

--FECHA INCORRECTA
--26/04/1989
--
--FECHA CORRECTA
--27/04/1989

update cobis..cl_ente
set p_fecha_nac = '1989/04/27'
where en_ente = 38874

go
