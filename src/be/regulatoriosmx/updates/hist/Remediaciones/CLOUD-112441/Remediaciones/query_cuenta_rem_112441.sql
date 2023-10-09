print 'Soporte #112441 - CAMBIO DE DATOS INCORRECTOS'
--ID:40757 CLIENTE: LOURDES YANETH MACIAS GONZALEZ
--ESTADO DE NACIMIENTO CORRECTA: EDO DE MÉXICO
--ESTADO DE NACIMIENTO INCORRECTA: CIUDAD DE MÉXICO.
--
--ID:788 CLIENTE: Maria de Los Angeles Martinez Barrios
--ESTADO DE NACIMIENTO CORRECTA: CHIAPAS
--ESTADO DE NACIMIENTO INCORRECTA: CIUDAD DE MÉXICO.


select p_depa_nac, * from cobis..cl_ente where en_ente = 40757

update cobis..cl_ente 
set p_depa_nac = 15 --9
where en_ente = 40757

select p_depa_nac, * from cobis..cl_ente where en_ente = 40757
go


select p_depa_nac, * from cobis..cl_ente where en_ente = 788

update cobis..cl_ente 
set p_depa_nac = 7 --9
where en_ente = 788

select p_depa_nac, * from cobis..cl_ente where en_ente = 788
go