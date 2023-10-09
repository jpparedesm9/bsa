--Remediacion caso 108976
--Cliente 4554 

USE cobis
GO

declare @w_ente        INT

select @w_ente = 4554

update cobis..cl_ente
set p_p_apellido = 'GARDUÑO',
en_nomlar = 'JANETH DANIELA GARDUÑO DELGADO'
where en_ente = @w_ente


SELECT ope = op_operacion
INTO #operaciones_4554
FROM cob_cartera..ca_operacion 
WHERE op_cliente = @w_ente

update cob_cartera..ca_operacion
set op_nombre = 'GARDUÑO DELGADO JANETH'
where op_operacion in (SELECT ope FROM #operaciones_4554)


update cob_cartera..ca_operacion_his
set oph_nombre = 'GARDUÑO DELGADO JANETH'
where oph_operacion in (SELECT ope FROM #operaciones_4554)


update cob_cartera_his..ca_operacion_his
set oph_nombre = 'GARDUÑO DELGADO JANETH'
where oph_operacion in (SELECT ope FROM #operaciones_4554)


update cob_cartera_his..ca_operacion
set op_nombre = 'GARDUÑO DELGADO JANETH'
where op_operacion in (SELECT ope FROM #operaciones_4554)

go
