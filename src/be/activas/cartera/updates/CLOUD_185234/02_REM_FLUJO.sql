use cobis
go
-->>>Se cambia de utf a ANsi

declare @w_co_id int, @w_mo_id int

delete an_component where co_name in ( 'Individual Aprobar Préstamo',  'Individual Aprobar Préstamo Regional')
and co_prod_name = 'WF'

select @w_co_id = max(co_id) from an_component
select @w_mo_id = mo_id from an_module where mo_name = 'IBX.InboxOficial'

select @w_co_id = isnull(@w_co_id, 0 ) + 1
insert into an_component(co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_co_id, @w_mo_id, 'Individual Aprobar Préstamo', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=AP', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')

select @w_co_id = isnull(@w_co_id, 0 ) + 1
insert into an_component(co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_co_id, @w_mo_id, 'Individual Aprobar Préstamo Regional', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=APR', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')

go