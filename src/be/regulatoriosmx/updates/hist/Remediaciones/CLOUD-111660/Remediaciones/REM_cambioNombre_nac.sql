--BUEN DÍA FAVOR DE APOYARNOS CON EL CAMBIO DE POSICIONES DEL SEGUNDO NOMBRE DE LA CLIENTA EN MENCIÓN:
--CLIENTE: MARÍA ANA HERNANDEZ ESTRADA ID: 42430

USE cobis
GO
print 'Cambio Nombre - 42430'
declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 42430
select @w_nombre_op = 'HERNANDEZ ESTRADA ANA MARIA'--Antes: HERNANDEZ ESTRADA MARIA ANA

update cobis..cl_ente
set    en_nombre = 'ANA MARIA', -- Antes MARIA ANA
       en_nomlar = 'ANA MARIA HERNANDEZ ESTRADA' -- Antes: MARIA ANA  HERNANDEZ ESTRADA
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

--CORRECCIÓN DE ENTIDAD DE NACIMIENTO DEL CLIENTE EN MENCIÓN:
--CLIENTE: ROCIÓ HERRERA VELAZQUEZ ID: 33622 DEBE DE SER ESTADO DE MEXICO Y ACTUALMENTE TIENE CIUDAD DE MEXICO.
print 'Cambio Entidad'
select * from cobis..cl_ente where en_ente = 33622

use cobis
go

update cobis..cl_ente 
set    p_depa_nac = 15 -- Antes 9
where  en_ente = 33622
