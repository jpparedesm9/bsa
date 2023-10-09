use cobis
go

select * from cl_seqnos where bdatos = 'cob_bvirtual'

print 'Insercion de entradas en cl_seqnos para B2C'

declare @w_sig int
select @w_sig = max(en_ente) from cob_bvirtual..bv_ente
if exists (select 1 from cl_seqnos where tabla = 'bv_ente')
    update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = @w_sig + 1, pkey = 'en_ente' where tabla = 'bv_ente'
else
	insert into cl_seqnos values ('cob_bvirtual','bv_ente',@w_sig + 1,'en_ente')

-- -----
if exists (select 1 from cl_seqnos where tabla = 'bv_log')
    update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = 1, pkey = 'bv_log' where tabla = 'lo_secuencial'
else
    insert into cl_seqnos values ('cob_bvirtual','bv_log',1,'lo_secuencial')

select * from cl_seqnos where bdatos = 'cob_bvirtual'

go