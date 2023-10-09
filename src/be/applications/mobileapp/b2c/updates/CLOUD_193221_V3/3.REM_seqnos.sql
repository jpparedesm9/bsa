
-- CLOUD_191122_707383_vulnerabilidades\src\be\applications\mobileapp\b2c\installer\sql\b2c_seqno.sql

use cobis
go

delete from cl_seqnos
where bdatos = 'cob_bvirtual'
go

print 'Insercion de entradas en cl_seqnos para B2C'
go
declare @w_sig int

select @w_sig = max(tp_id) from cob_bvirtual..bv_trans_procesos
if exists (SELECT 1 from cobis..cl_seqnos where tabla = 'bv_trans_procesos')
	update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = @w_sig + 1, pkey = 'tp_id' where tabla = 'bv_trans_procesos'
else
	insert into cobis..cl_seqnos values ('cob_bvirtual','bv_trans_procesos',1,'tp_id')
go

