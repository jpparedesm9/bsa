select  en_nomlar, p_fecha_nac, * from cobis..cl_ente
where en_ente in (34612,35203,35543) 

update cobis..cl_ente
set    p_fecha_nac = '10/20/1967' -- Correcta: 20/10/1967
where  en_ente = 34612

update cobis..cl_ente
set    p_fecha_nac = '10/17/1984' -- Correcta: 17 10 1984
where  en_ente = 35203

update cobis..cl_ente
set    p_fecha_nac = '05/21/1994'  -- Correcta 21/05/1994
where  en_ente = 35543


select  en_nomlar, p_fecha_nac, * from cobis..cl_ente
where en_ente in (34612,35203,35543) 
go