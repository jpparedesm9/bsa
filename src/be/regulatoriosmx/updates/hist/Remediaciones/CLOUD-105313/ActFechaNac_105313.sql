use cobis 
go
--NOMBRE: Dorotea Araiza González 36782
--FECHA DE NACIMIENTO CORRECTA: 1950/03/28
--FECHA DE NACIMIENTO INCORRECTA EN COBIS: 1950/03/27.


update cl_ente set    p_fecha_nac = '03/28/1950' where  en_ente = 36782 go  


--NOMBRE:MARTHA IVONNE GARCIA CRUZ 36680
--FECHA DE NACIMIENTO CORRECTA: 05/05/1980
--FECHA DE NACIMIENTO INCORRECTA EN COBIS: 04/05/1980

update cl_ente set    p_fecha_nac = '05/05/1980' where  en_ente = 36680 go  