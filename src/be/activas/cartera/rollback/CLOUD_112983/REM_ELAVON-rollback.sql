use cobis
go

--Buscar operaciones
delete cts_serv_catalog where csc_service_id in ( 'BusinessToBusiness.OperationManagement.SearchOperations',  'BusinessToBusiness.PaymentManagement.ApplyPayment', 'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName')
delete ad_servicio_autorizado where ts_servicio in ( 'BusinessToBusiness.OperationManagement.SearchOperations',  'BusinessToBusiness.PaymentManagement.ApplyPayment', 'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName')

delete cl_errores where numero in (103200,103201,103202,103203, 70320,70321,70322,70323,70324)
delete cl_parametro where pa_nemonico in ('ELACOM','ELABRN', 'ELACON', 'ELAUSR','ELAPWD', 'ELAURL', 'ELAEMA')

GO


use cob_cartera
go

declare
@w_co_id                 int,
@w_ctr_id                int

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'co_tiempo_aplicacion_pag_rev'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal')) begin
   ALTER TABLE ca_corresponsal
   drop column co_tiempo_aplicacion_pag_rev  
end


select @w_co_id = co_id from ca_corresponsal where co_nombre = 'ELAVON'
if @w_co_id  is not null begin
   delete ca_corresponsal_tipo_ref WHERE ctr_co_id = @w_co_id
   delete ca_corresponsal where co_id = @w_co_id
end

go
