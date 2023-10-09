--BUEN DÍA FAVOR DE APOYARNOS CON LA CORRECCIÓN DE NOMBRE:
--ID:1119 NOMBRE CORRECTO: MA. ELENA ANGUIANO ORTIZ 
--Y EN SISTEMA COBIS SE ENCUENTRA MA ELENA ANGUIANO ORTIZ


USE cobis
GO
print 'Cambio Nombre - 1119'
declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 1119
select @w_nombre_op = 'ANGUIANO ORTIZ MA.'--Antes: TODO UNA MEZCLA...

update cobis..cl_ente
set    en_nombre = 'MA.', -- Antes MA
       en_nomlar = 'MA. ELENA ANGUIANO ORTIZ' -- Antes: MA ELENA ANGUIANO ORTIZ
where  en_ente = @w_ente

SELECT ope = op_operacion
INTO #operaciones
FROM cob_cartera..ca_operacion
WHERE op_cliente = @w_ente

update cob_cartera..ca_operacion
set    op_nombre = @w_nombre_op
where  op_operacion in (SELECT ope FROM #operaciones)

update cob_cartera..ca_operacion_his
set    oph_nombre = @w_nombre_op
where  oph_operacion in (SELECT ope FROM #operaciones)

update cob_cartera_his..ca_operacion_his
set    oph_nombre = @w_nombre_op
where  oph_operacion in (SELECT ope FROM #operaciones)

update cob_cartera_his..ca_operacion
set    op_nombre = @w_nombre_op
where  op_operacion in (SELECT ope FROM #operaciones)

go

--Y DEL CLIENTE EN MENCIÓN FAVOR DE APOYARNOS CON LA CORRECCIÓN DE ENTIDAD DE NACIMIENTO:
--ID:654 CLIENTE: DOLORES VILCHIS LARA
--Entidad de nacimiento correcta: Distrito Federal
--Entidad de nacimiento incorrecta: Edo de México
print 'Cambio Entidad'
select * from cobis..cl_ente where en_ente = 654

use cobis
go

update cobis..cl_ente 
set    p_depa_nac =  9 -- Antes 15
where  en_ente = 654
