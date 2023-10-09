USE cobis
GO

declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 86161
select @w_nombre_op = 'LOPEZ MILLAN MA.'

update cobis..cl_ente
set    en_nombre = 'MA.',
       en_nomlar = 'MA. ERIKA LOPEZ MILLAN'
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
