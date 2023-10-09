--BUEN DÍA FAVOR DE APOYARNOS CON EL CAMBIO DE POSICIONES DEL SEGUNDO NOMBRE DE LA CLIENTA EN MENCIÓN:
--CLIENTE: MARÍA ANA HERNANDEZ ESTRADA ID: 42430

USE cobis
GO
print 'Cambio Nombre - 42430'
declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 42430
select @w_nombre_op = 'HERNANDEZ ESTRADA MARIA'--Antes: HERNANDEZ ESTRADA MARIA ANA

update cobis..cl_ente
set    en_nombre = 'MARIA', -- Antes MARIA ANA
       en_nomlar = 'MARIA ANA HERNANDEZ ESTRADA', -- Antes: MARIA ANA  HERNANDEZ ESTRADA
	   p_s_nombre = 'ANA'
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

