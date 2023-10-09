
--amgutierrez    130	ANYULI MICHELLE GUTIERREZ GOMEZ
--uconchillos    156	URBANO CONCHILLOS RAMIREZ


USE cobis 
go
--1.-
--actualizacion en la cl_ente de amgutierrez a uconchillos 
UPDATE cobis..cl_ente 
SET en_oficial    = 156,
    c_funcionario = 'uconchillos',
    en_oficina    = 2403
WHERE en_ente in (10249, 10248, 10243,10234,
                  10239, 10531, 10361,10380)
                  
update cobis..cl_grupo
set gr_oficial = 156
where gr_grupo = 395

update cobis..cl_cliente_grupo  
set cg_usuario = 'uconchillos'
where cg_grupo = 395

go

--2.-
--actualizacion en la ca_operacion de slovera a rhernandezg 

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 156 
WHERE op_cliente in (10249, 10248, 10243,10234,
                     10239, 10531, 10361,10380)

go

--3.-
--actualizacion en la cr_tramite de slovera a rhernandezg 
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'uconchillos',
    tr_usuario_apr= 'uconchillos',
    tr_oficial    = 156
WHERE tr_cliente in (10249, 10248, 10243,10234,
                     10239, 10531, 10361,10380)

go
--3.-
--actualizacion en la ca_operacion_his de slovera a rhernandezg 

UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 156 
WHERE oph_cliente in (10249, 10248, 10243,10234,
                      10239, 10531, 10361,10380)

/******************************************************************************/
/*             GRUPO 223                                                      */
/******************************************************************************/
--jorocio        112	JOEL OROCIO LOPEZ
--uconchillos    156	URBANO CONCHILLOS RAMIREZ

UPDATE cobis..cl_ente 
SET en_oficial    = 156,
    c_funcionario = 'uconchillos',
    en_oficina    = 2403
WHERE en_ente in (5378, 5381, 5389, 5674, 5679,
                  6050, 5918, 5901)

update cobis..cl_grupo
set gr_oficial = 156
where gr_grupo = 223

update cobis..cl_cliente_grupo  
set cg_usuario = 'uconchillos'
where cg_grupo = 223
go
--2.-
--actualizacion en la ca_operacion de slovera a rhernandezg 

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 156 
WHERE op_cliente in (5378, 5381, 5389, 5674, 5679,
                     6050, 5918, 5901)

go
--3.-
--actualizacion en la cr_tramite de slovera a rhernandezg 
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'uconchillos',
    tr_usuario_apr= 'uconchillos',
    tr_oficial    = 156
WHERE tr_cliente in (5378, 5381, 5389, 5674, 5679,
                     6050, 5918, 5901)
                     
go
--3.-
--actualizacion en la ca_operacion_his de slovera a rhernandezg 
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 156 
WHERE oph_cliente in (5378, 5381, 5389, 5674, 5679,
                      6050, 5918, 5901)                    





