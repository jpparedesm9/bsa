use cob_workflow
go

delete wf_tipo_documento where td_nombre_tipo_doc = 'SOLICITUD COMPLEMENTARIA LCR'
insert into wf_tipo_documento values (30, 'SOLICITUD COMPLEMENTARIA LCR', 'D', 'V', 'P')

go

use cobis
go

declare
@w_co_id             int,
@w_mo_id             int

update an_component set 
co_class= 'VC_BIOVALIDSA_412339_TASK.html?SOLICITUD=GRUPAL' 
where co_name = 'VALIDACION BIOMETRICO'
and co_prod_name = 'WF'

select @w_co_id = isnull(max(co_id), 0) + 1
from an_component

select @w_mo_id = mo_id
from an_module
where mo_name = 'IBX.InboxOficial'

delete an_component where co_name = 'VALIDACION BIOMETRICO LCR'
insert an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_co_id, @w_mo_id,  'VALIDACION BIOMETRICO LCR', 'VC_BIOVALIDSA_412339_TASK.html?SOLICITUD=LCR', 'views/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339/1.0.0/','I', NULL, 'WF')

go