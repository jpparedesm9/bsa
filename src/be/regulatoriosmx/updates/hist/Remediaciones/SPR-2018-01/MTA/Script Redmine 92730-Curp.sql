------------------------------------------------------
--Caso Redmine 92730, Se corrige los numeros de CURP
------------------------------------------------------

use cobis
go

update cl_ente 
set en_ced_ruc = 'MEMR591002MDFJNC07'
where en_ente = 304
and en_rfc = 'MEMM591002MDFJNR09'

go

