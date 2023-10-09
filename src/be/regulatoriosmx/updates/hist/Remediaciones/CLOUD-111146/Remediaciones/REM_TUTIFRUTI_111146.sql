update cob_cartera..ca_garantia_liquida
set gl_dev_estado = NULL,
    gl_dev_fecha = NULL, 
	gl_dev_valor = NULL
where gl_grupo = 1506
and   gl_id in (16789,16790,16791,16792,16793,
                16794,16795,16796,16797,16798)
go
