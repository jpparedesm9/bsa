
USE cob_conta
go
select *
from cob_conta..cb_corte
where co_fecha_ini = '11/21/2018'

update cob_conta..cb_corte
set co_estado = 'V' 
where co_fecha_ini = '11/21/2018'

select *
from cob_conta..cb_corte
where co_fecha_ini = '11/21/2018'

GO 
--Grupo 2192
USE cob_cartera
go
UPDATE cob_cartera..ca_transaccion SET tr_ofi_usu=tr_ofi_oper
WHERE tr_secuencial =1 
AND tr_operacion IN (134804,134807,134810,134813,134816,134819,134822,134825)
AND tr_estado='ING'  
go

USE cob_conta
go
select *
from cob_conta..cb_corte
where co_fecha_ini = '11/26/2018'

update cob_conta..cb_corte
set co_estado = 'V' 
where co_fecha_ini = '11/26/2018'

select *
from cob_conta..cb_corte
where co_fecha_ini = '11/26/2018'

GO 
--Grupo 2251
USE cob_cartera
go
UPDATE cob_cartera..ca_transaccion SET tr_ofi_usu=tr_ofi_oper
WHERE tr_secuencial =1 
AND tr_operacion IN (139673,139676,139679,139682,139685,139688,139691,139694)
AND tr_estado='ING'  
go

--Grupo 2227
USE cob_cartera
go
UPDATE cob_cartera..ca_transaccion SET tr_ofi_usu=tr_ofi_oper
WHERE tr_secuencial =1 
AND tr_operacion IN (139459,139462,139465,139468,139471,139474,139477,139480)
AND tr_estado='ING'  
go