/******************************************************************************/
/*             GRUPO 59                                                       */
/******************************************************************************/

--mareyesgo    73	MIGUEL ANGEL REYES GONZALEZ
--davazquezsa  50	DANTE ALEJANDRO VAZQUEZ SAAVEDRA


USE cobis 
go
--1.-
--actualizacion en la cl_cliente_grupo de mareyesgo a davazquezsa 

update cobis..cl_cliente_grupo  
set cg_usuario = 'davazquezsa'
where cg_grupo = 59

--2.-
--actualizacion en la cl_ente de mareyesgo a davazquezsa 

UPDATE cobis..cl_ente 
SET en_oficial    = 50,
    c_funcionario = 'davazquezsa',
    en_oficina    = 3348
WHERE en_ente in (773 , 774 , 775, 777, 1409,
                  1410, 1411, 1413)
                  

--3.-
--actualizacion en la cl_grupo de mareyesgo a davazquezsa 
update cobis..cl_grupo
set gr_oficial = 50
where gr_grupo = 59

--4.-
--actualizacion en la cr_tramite de mareyesgo a davazquezsa 

UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'davazquezsa',
    tr_usuario_apr= 'davazquezsa',
    tr_oficial    = 50
WHERE tr_cliente in (773 , 774 , 775, 777, 1409,
                     1410, 1411, 1413)


--5.-
--actualizacion en la ca_operacion de mareyesgo a davazquezsa 
UPDATE cob_cartera..ca_operacion 
SET op_oficial = 50 
WHERE op_cliente in (773 , 774 , 775, 777, 1409,
                     1410, 1411, 1413)


--6.-
--actualizacion en la ca_operacion_his de mareyesgo a davazquezsa
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 50 
WHERE oph_cliente in (773 , 774 , 775, 777, 1409,
                      1410, 1411, 1413)

--7.-
--actualizacion en la cob_cartera_his..ca_operacion de mareyesgo a davazquezsa

update  cob_cartera_his..ca_operacion
set op_oficial   = 50
WHERE op_cliente in (773 , 774 , 775, 777, 1409,
                      1410, 1411, 1413)

--8.-
--actualizacion en la cob_cartera_his..ca_operacion_his de mareyesgo a davazquezsa

update cob_cartera_his..ca_operacion_his
set oph_oficial = 50
WHERE oph_cliente in (773 , 774 , 775, 777, 1409,
                      1410, 1411, 1413)




go



/******************************************************************************/
/*             GRUPO 93                                                       */
/******************************************************************************/
--zturincio        51	ZAIRA TURINCIO PASCUAL
--jcorona    43	JESSICA CORONA MARTINEZ

--1.-
--actualizacion en la cl_cliente_grupo de zturincio a jcorona 

update cobis..cl_cliente_grupo  
set cg_usuario = 'jcorona'
where cg_grupo = 93

--2.-
--actualizacion en la cl_ente de zturincio a jcorona 

UPDATE cobis..cl_ente 
SET en_oficial    = 43,
    c_funcionario = 'jcorona',
    en_oficina    = 3348
WHERE en_ente in (58  , 59  , 64  , 84  ,
                  111 , 2782, 2789, 2892,
                  2898, 2997)
                  

--3.-
--actualizacion en la cl_grupo de zturincio a jcorona 
update cobis..cl_grupo
set gr_oficial = 43
where gr_grupo = 93

--4.-
--actualizacion en la cr_tramite de zturincio a jcorona 

UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'jcorona',
    tr_usuario_apr= 'jcorona',
    tr_oficial    = 43
WHERE tr_cliente in (58  , 59  , 64  , 84  ,
                     111 , 2782, 2789, 2892,
                     2898, 2997)


--5.-
--actualizacion en la ca_operacion de mareyesgo a davazquezsa 
UPDATE cob_cartera..ca_operacion 
SET op_oficial = 43 
WHERE op_cliente in (58  , 59  , 64  , 84  ,
                     111 , 2782, 2789, 2892,
                     2898, 2997)

--6.-
--actualizacion en la ca_operacion_his de mareyesgo a davazquezsa
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 43 
WHERE oph_cliente in (58  , 59  , 64  , 84  ,
                      111 , 2782, 2789, 2892,
                      2898, 2997)

--7.-
--actualizacion en la cob_cartera_his..ca_operacion de mareyesgo a davazquezsa

update  cob_cartera_his..ca_operacion
set op_oficial   = 43
WHERE op_cliente in (58  , 59  , 64  , 84  ,
                     111 , 2782, 2789, 2892,
                     2898, 2997)
--8.-
--actualizacion en la cob_cartera_his..ca_operacion_his de mareyesgo a davazquezsa

update cob_cartera_his..ca_operacion_his
set oph_oficial = 43
WHERE oph_cliente in (58  , 59  , 64  , 84  ,
                     111 , 2782, 2789, 2892,
                     2898, 2997)


/******************************************************************************/
/*             GRUPO 389                                                       */
/******************************************************************************/
--jorocio    112	JOEL OROCIO LOPEZ
--aarcosfl   157	ARTURO ARCOS FLORES

--1.-
--actualizacion en la cl_cliente_grupo de jorocio a aarcosfl 

update cobis..cl_cliente_grupo  
set cg_usuario = 'aarcosfl'
where cg_grupo = 389

--2.-
--actualizacion en la cl_ente de jorocio a aarcosfl 

UPDATE cobis..cl_ente 
SET en_oficial    = 157,
    c_funcionario = 'aarcosfl',
    en_oficina    = 2403
WHERE en_ente in (10032, 10081, 10134,
                  10142, 10287, 10405,
                  10409, 10573)
                  

--3.-
--actualizacion en la cl_grupo de zturincio a jcorona 
update cobis..cl_grupo
set gr_oficial = 157
where gr_grupo = 389

--4.-
--actualizacion en la cr_tramite de zturincio a jcorona 

UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'aarcosfl',
    tr_usuario_apr= 'aarcosfl',
    tr_oficial    = 157
WHERE tr_cliente in (10032, 10081, 10134,
                     10142, 10287, 10405,
                     10409, 10573)


--5.-
--actualizacion en la ca_operacion de mareyesgo a davazquezsa 
UPDATE cob_cartera..ca_operacion 
SET op_oficial = 157 
WHERE op_cliente in (10032, 10081, 10134,
                     10142, 10287, 10405,
                     10409, 10573)

--6.-
--actualizacion en la ca_operacion_his de mareyesgo a davazquezsa
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 157 
WHERE oph_cliente in (10032, 10081, 10134,
                      10142, 10287, 10405,
                      10409, 10573)

--7.-
--actualizacion en la cob_cartera_his..ca_operacion de mareyesgo a davazquezsa

update  cob_cartera_his..ca_operacion
set op_oficial   = 157
WHERE op_cliente in (10032, 10081, 10134,
                      10142, 10287, 10405,
                      10409, 10573)
--8.-
--actualizacion en la cob_cartera_his..ca_operacion_his de mareyesgo a davazquezsa

update cob_cartera_his..ca_operacion_his
set oph_oficial = 157
WHERE oph_cliente in (10032, 10081, 10134,
                      10142, 10287, 10405,
                      10409, 10573)

