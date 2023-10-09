---------------
--CASO 109621
---------------
use cobis
go

--CLIENTE 125
update cobis..cl_ente 
set en_ced_ruc='CAZV670711MDFHVR03'
where en_ente = 125


update cobis..cl_ente_aux
set ea_ced_ruc= 'CAZV670711MDFHVR03'
where ea_ente = 125


--CLIENTE 137 
update cobis..cl_ente 
set en_ced_ruc='FORC850604MMCLDR05'
where en_ente = 137 


update cobis..cl_ente_aux
set ea_ced_ruc='FORC850604MMCLDR05'
where ea_ente = 137 


--CLIENTE 326  
update cobis..cl_ente 
set en_ced_ruc='DESA550927HMCGND04',
    p_sexo = 'M'
where en_ente = 326  


update cobis..cl_ente_aux
set ea_ced_ruc='DESA550927HMCGND04'
where ea_ente = 326  


go
