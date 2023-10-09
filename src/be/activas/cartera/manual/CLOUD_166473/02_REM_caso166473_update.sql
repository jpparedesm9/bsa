select
cliente = dc_cliente,
operacion = dc_operacion,
registro = (select count(1)
            from cob_cartera..ca_det_ciclo d
            where d.dc_cliente = a.dc_cliente
            and d.dc_operacion < a.dc_operacion) + 1
into #operaciones_num_ciclo            
from cob_cartera..ca_det_ciclo a
order by dc_cliente, dc_operacion

UPDATE cob_cartera..ca_det_ciclo
SET dc_ciclo = registro
FROM #operaciones_num_ciclo 
WHERE dc_cliente = cliente
AND dc_operacion = operacion

DROP TABLE #operaciones_num_ciclo
GO

/*
select *
from #operaciones_num_ciclo
where dc_cliente = 359814


select *
from #operaciones_num_ciclo
where dc_cliente = 161481


select *
from #operaciones_num_ciclo
where dc_cliente = 3
*/