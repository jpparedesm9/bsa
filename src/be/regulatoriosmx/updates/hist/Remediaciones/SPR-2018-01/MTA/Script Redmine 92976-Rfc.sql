------------------------------------------------------
--Caso Redmine 92976, Se corrige RFC de cliente
------------------------------------------------------

use cobis
go

update cl_ente 
set en_rfc = 'GAFE750213IKA'
where en_ente = 247
and en_ced_ruc = 'GAFE750213MMCLLG01'

go

