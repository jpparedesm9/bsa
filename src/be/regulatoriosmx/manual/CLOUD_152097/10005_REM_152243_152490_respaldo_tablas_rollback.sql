use cob_conta_super
go

print 'Inicio respalda:' + convert(VARCHAR(30),getdate())

select '#cr_resultado_xml' = count(*) from cob_credito..cr_resultado_xml
select '#sb_ns_estado_cuenta' = count(*) from cob_conta_super..sb_ns_estado_cuenta
select '#cr_rfc_int_error' = count(*) from cob_credito..cr_rfc_int_error

truncate table cob_credito..cr_resultado_xml
truncate table cob_conta_super..sb_ns_estado_cuenta
truncate table cob_credito..cr_rfc_int_error

INSERT INTO cob_credito..cr_resultado_xml
select * 
from cr_resultado_xml_152243

INSERT INTO cob_conta_super..sb_ns_estado_cuenta
select *  
FROM sb_ns_estado_cuenta_152243

INSERT into cob_credito..cr_rfc_int_error
select * 
from cr_rfc_int_error_152243


print 'Fin respalda:' + convert(VARCHAR(30),getdate())
go
