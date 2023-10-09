



update cob_conta..cb_corte set co_estado = 'V' where co_corte = 190 and co_periodo = 2018
go 

update cob_cartera..ca_transaccion set tr_ofi_usu = tr_ofi_oper where tr_ofi_usu in (1101) and tr_estado  = 'ING'
go 


select 'DESPUES', * from cob_conta..cb_corte where co_corte = 190 and co_periodo = 2018
select 'DESPUES', * from cob_cartera..ca_transaccion where tr_ofi_usu in (1101) and tr_estado  = 'ING'

