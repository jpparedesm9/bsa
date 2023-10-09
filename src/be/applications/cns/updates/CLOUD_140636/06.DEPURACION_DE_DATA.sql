use cob_cartera
go

select 'ca_ns_sms_cobranzas'     = count(1) from cob_cartera..ca_ns_sms_cobranzas
select 'ca_ns_sms_recordatorios' = count(1) from cob_cartera..ca_ns_sms_recordatorios

truncate table cob_cartera..ca_ns_sms_cobranzas
truncate table cob_cartera..ca_ns_sms_recordatorios

select 'ca_ns_sms_cobranzas'     = count(1) from cob_cartera..ca_ns_sms_cobranzas
select 'ca_ns_sms_recordatorios' = count(1) from cob_cartera..ca_ns_sms_recordatorios
go

use cob_cartera_his
go

select 'ca_ns_sms_cobranzas_his'     = count(1) from cob_cartera_his..ca_ns_sms_cobranzas_his
select 'ca_ns_sms_recordatorios_his' = count(1) from cob_cartera_his..ca_ns_sms_recordatorios_his

truncate table cob_cartera_his..ca_ns_sms_cobranzas_his
truncate table cob_cartera_his..ca_ns_sms_recordatorios_his

select 'ca_ns_sms_cobranzas_his'     = count(1) from cob_cartera_his..ca_ns_sms_cobranzas_his
select 'ca_ns_sms_recordatorios_his' = count(1) from cob_cartera_his..ca_ns_sms_recordatorios_his

go