use cobis
go

delete from cl_seqnos
 where bdatos = 'cob_cuentas'
   and tabla  = 'cc_cencanje' 

insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values('cob_cuentas','cc_cencanje',0,'NULL')
go

