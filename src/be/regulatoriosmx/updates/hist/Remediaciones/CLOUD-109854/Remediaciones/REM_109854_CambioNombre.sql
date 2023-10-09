--SOLICITAMOS DE SU APOYO PARA MODIFICAR EL APELLIDO DEL CLIENTE 27678 - ANABEL HERN�NDEZ CASTA��N EL CUAL ESTA MAL CAPTURADO EN SISTEMA:
--
--DATOS INCORRECTOS: 
--CLIENTE: ANABEL HERN�DEZ CASTA��N 
--CODIGO DE CLIENTE: 27678
--
--DATOS CORRECTOS: 
--CLIENTE: ANABEL HERN�NDEZ CASTA��N --  ANABEL HERNANDEZ CASTA�ON 
--CODIGO DE CLIENTE: 27678
--
--GRACIAS Y SALUDOS
--

USE cobis
GO

declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 27678
select @w_nombre_op = 'HERN�NDEZ CASTA��N ANABEL'

update cobis..cl_ente
set    en_nomlar = 'ANABEL HERN�NDEZ CASTA��N',
       p_p_apellido = 'HERN�NDEZ'
where  en_ente = @w_ente

SELECT ope = op_operacion
INTO #operaciones_109854
FROM cob_cartera..ca_operacion 
WHERE op_cliente = @w_ente

update cob_cartera..ca_operacion
set    op_nombre = @w_nombre_op
where  op_operacion in (SELECT ope FROM #operaciones_109854)

update cob_cartera..ca_operacion_his
set    oph_nombre = @w_nombre_op
where  oph_operacion in (SELECT ope FROM #operaciones_109854)

update cob_cartera_his..ca_operacion_his
set    oph_nombre = @w_nombre_op
where  oph_operacion in (SELECT ope FROM #operaciones_109854)

update cob_cartera_his..ca_operacion
set    op_nombre = @w_nombre_op
where  op_operacion in (SELECT ope FROM #operaciones_109854)

go
