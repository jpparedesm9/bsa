
use cobis 
go 

--of origen 90	JESSYCA LOZADA CERVANTES
--od destino 159	SOCORRO PEREZ TELLES


select 'antes', * from cobis..cl_ente       where en_ente = 21409


update cobis..cl_ente set  en_oficial = 159 where en_ente = 21409



select 'despues', * from cobis..cl_ente      where en_ente = 21409