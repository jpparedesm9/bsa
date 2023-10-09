use cobis
go

delete cl_parametro where pa_nemonico in ('PTRREN','PCAREN', 'ATMREN','ATAREN','CICREN', 'RDTGRP','PORREN','MNPRTG')
delete cl_errores where numero in (2108080, 2108081, 2108082, 2108083, 2108084, 2108085, 2108086)
go