-- CORRECCION DE NOMBRE CLIENTE 42832 - MARIA DEL ROSARIO LUGO LOZA
-- SOLICITAMOS DE SU APOYO PARA LA CORRECCION DEL NOMBRE DEL CLENTE
-- INCORRECTA MA DEL ROSARIO LUGO LOZA
-- CORRECTA MARIA DEL ROSARIO LUGO LOZA

USE cobis
GO
print 'Cambio Nombre - 42832'
declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 42832
select @w_nombre_op = 'LUGO LOZA MARIA'--Antes: LUGO LOZA MA

update cobis..cl_ente
set    en_nombre = 'MARIA', -- Antes MA
       en_nomlar = 'MARIA DEL ROSARIO LUGO LOZA' -- Antes: MA DEL ROSARIO LUGO LOZA
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
