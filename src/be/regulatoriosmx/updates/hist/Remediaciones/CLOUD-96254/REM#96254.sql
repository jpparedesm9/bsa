use cobis 
go

-- Respaldo de Datos
select * from cobis..cl_ente where en_ente in (711,713,837,836)

-- Actualizacion de Datos
update cobis..cl_ente 
set en_oficial = 35,
    c_funcionario = 'scruzgo' 
where en_ente in (711,713,837,836)

update cobis..cl_ente 
set en_oficial = 72,
    c_funcionario = 'malopezva' 
where en_ente in (2070)

update cobis..cl_ente 
set en_oficial = 85,
    c_funcionario = 'presensizhe' 
where en_ente in (1338)

-- Despues de Actualizacion de Datos
select * from cobis..cl_ente where en_ente in (711,713,837,836)

go