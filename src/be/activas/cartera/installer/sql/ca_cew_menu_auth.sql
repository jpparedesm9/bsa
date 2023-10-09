use cobis
go

declare @w_me_id		int,
		@w_moneda 		int,
		@w_producto		int,
		@w_resource     int,
		@w_rol			int


select @w_moneda = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'
   
select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'CARTERA'

  
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'
  
 ---Creación Recursos Contenedor 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/ASSTS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/ASSTS/.*')
 end
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views//ASSTS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views//ASSTS/.*')
 end
 
if not exists (select 1 from cew_resource where re_pattern = '/resources/ASSTS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/resources/ASSTS/.*')
 end
 
 
if not exists (select 1 from cew_resource where re_pattern = '/resources/ASSTS/CMMNS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/resources/ASSTS/CMMNS/.*')
 end
 

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/ASSTS/CMMNS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/ASSTS/CMMNS/.*')
 end
 

 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/ASSTS/assets/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/ASSTS/assets/.*')
 end
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/customer/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/customer/.*')
 end 
 
if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views//ASSTS/CMMNS/UPLOADFILE/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views//ASSTS/CMMNS/UPLOADFILE/.*')
 end
 
--Autorización recursos al rol Menú por procesos
if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views//ASSTS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views//ASSTS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/resources/ASSTS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/resources/ASSTS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern = '/resources/ASSTS/CMMNS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/resources/ASSTS/CMMNS/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/CMMNS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/CMMNS/.*'
end


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/ASSTS/assets/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/ASSTS/assets/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/customer/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/customer/.*'
end


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views//ASSTS/CMMNS/UPLOADFILE/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views//ASSTS/CMMNS/UPLOADFILE/.*'
END




-- ************************************************** AUTORIZACIÓN DE FUNIONALIDADES CARTERA **************************************************

--Impresión de Documentos
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_IMPDOC'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	 
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryLiquidation', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryPaymentTableHead', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryPromissoryNote', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QuerySwornStatement', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryCreditAgreement', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryDebtorInformation', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryOffice', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryProcessingDate', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryPaymentTableDetail', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.QueryCreditStudy', @w_producto, 'R', @w_moneda)

    delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7055, @w_producto, 'R', @w_moneda)
end


--Proyección Cuota
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_PROYCUOTA'

if @w_me_id is not null
BEGIN

    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda

	insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Loan.LoanTransaction.LoanProyectionQuota', @w_producto, 'R', @w_moneda)
	
end

--Reajuste del Préstamo
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_READJUSTMENT'

if @w_me_id is not null
begin	

    delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
    and mt_producto 	= @w_producto
    and mt_moneda 	= @w_moneda

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7078, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7300, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7033, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7034, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7079, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7077, @w_producto, 'R', @w_moneda)	
end

--Pago Solidario 
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_SLDRT_PYMNT'

if @w_me_id is not null
begin
    delete cew_menu_service 
     where ms_id_menu 	= @w_me_id
       and ms_producto 	= @w_producto
       and ms_moneda 	= @w_moneda
   
    --insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    --values (@w_me_id, 'Loan.SolidarityPayment.ReadSolidarity', @w_producto, 'R', @w_moneda)
    
    --insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    --values (@w_me_id, 'Loan.SolidarityPayment.SearchSolidarityDetail', @w_producto, 'R', @w_moneda)
end


--Fecha Valor

select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_VALDATE'

if @w_me_id is not null
begin
	
    delete cew_menu_transaccion
     where mt_id_menu 	= @w_me_id
       and mt_producto 	= @w_producto
       and mt_moneda 	= @w_moneda
    
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id, 7130, @w_producto, 'R', @w_moneda)
    
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id, 7204, @w_producto, 'R', @w_moneda)
    
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id, 7049, @w_producto, 'R', @w_moneda)
end

--Pagos de Prestamo

select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_PAYMENTS'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu 	= @w_me_id
    and ms_producto 	= @w_producto
    and ms_moneda 	= @w_moneda
   	
	insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    values (@w_me_id, 'Collateral.SearchDeposit.SearchDeposit', @w_producto, 'R', @w_moneda)
	
	insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    values (@w_me_id, 'Collateral.SearchDeposit.SearchAccount', @w_producto, 'R', @w_moneda)
	
	
	delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
    and mt_producto 	= @w_producto
    and mt_moneda 	= @w_moneda

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7144, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1209, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7276, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7306, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7003, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7059, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7149, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7277, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,7058, @w_producto, 'R', @w_moneda)
end



--Renovación de Préstamo

select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_RENOVACIONES'

if @w_me_id is not null
begin
    delete cew_menu_service 
     where ms_id_menu 	= @w_me_id
       and ms_producto 	= @w_producto
       and ms_moneda 	= @w_moneda
    
    insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    values (@w_me_id, 'Loan.LoanTransaction.LoanRepayment', @w_producto, 'R', @w_moneda)
	
    delete cew_menu_transaccion
     where mt_id_menu 	= @w_me_id
       and mt_producto 	= @w_producto
       and mt_moneda 	= @w_moneda

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id,1556, @w_producto, 'R', @w_moneda)

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id,7076, @w_producto, 'R', @w_moneda)

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id,7027, @w_producto, 'R', @w_moneda)

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
    values (@w_me_id,7274, @w_producto, 'R', @w_moneda)
end

--Cambio de Estado

select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_CAMBIOEST' 


if @w_me_id is not null
begin
    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 
    
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7203, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7135, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7132, @w_producto, 'R', @w_moneda)
end

--Clausula aceleratoria

select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_CLAUSE' 

if @w_me_id is not null
begin

    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 
       
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7179, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7203, @w_producto, 'R', @w_moneda)
end
--Consulta General de Operaciones
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_QUERYSGENERALINFORMATION' 

if @w_me_id is not null
begin
    delete cew_menu_service 
     where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda
    
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.OperationDataQuery.SearchRefinanceLoan', @w_producto, 'R', @w_moneda)

    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 
   
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 714500, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7020, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7203, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7015, @w_producto, 'R', @w_moneda)
	
end

--Detalle de Cuenta de Ahorro
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_DETAILSAHO' 

if @w_me_id is not null
begin
    delete cew_menu_service 
     where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda
    
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.SearchLoanItems.SearchDetailsAho', @w_producto, 'R', @w_moneda)

    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 
    
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 731002, @w_producto, 'R', @w_moneda)
end
--Mentenimiento de Formas de pago
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_MANTENIMIENTO_PAG' 

if @w_me_id is not null
begin	
    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7084, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7076, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7222, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7086, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7085, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7087, @w_producto, 'R', @w_moneda)

end
--Prórroga de Cuota
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_EXTENDSQUONTA' 

if @w_me_id is not null
begin

    delete cew_menu_transaccion
     where mt_id_menu       = @w_me_id 
       and mt_producto      = @w_producto 
       and mt_moneda        = @w_moneda 
   
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7235, @w_producto, 'R', @w_moneda)
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7232, @w_producto, 'R', @w_moneda)
end

--Desembolso de Préstamo
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_DESEMBOLSO' 

if @w_me_id is not null
begin
    delete cew_menu_service 
     where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda

	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ApplyLiquidationLoan',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.InsertDetailPaymentForm',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadAccountSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadAccountsSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadGlobalVariablesSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadPaymentFormSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.RemoveDetailPaymentForm', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ValidateAccountOtherBanks', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Remittance.RemittanceService.GroupRemittanceByClient', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Remittance.RemittanceService.QueryRemittanceByClient', @w_producto, 'R', @w_moneda)
	
	delete cew_menu_transaccion
	where mt_id_menu       = @w_me_id 
	and mt_producto      = @w_producto 
	and mt_moneda        = @w_moneda 
	
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7050, @w_producto, 'R', @w_moneda)
end


--Ingreso de otros cargos

select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_INGREOTROCARGO' 

if @w_me_id is not null
begin
	delete cew_menu_service 
	 where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda

	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ApplyLiquidationLoan',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.InsertDetailPaymentForm',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadAccountSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadAccountsSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadGlobalVariablesSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ReadPaymentFormSearch', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.RemoveDetailPaymentForm', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ReadDisbursementForm.ValidateAccountOtherBanks', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Remittance.RemittanceService.GroupRemittanceByClient', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Remittance.RemittanceService.QueryRemittanceByClient', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.TransactionOtherChargesGrid', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.LoanTransaction.TransactionOtherChargesItems', @w_producto, 'R', @w_moneda)
    
	delete cew_menu_transaccion
	 where mt_id_menu       = @w_me_id 
	   and mt_producto      = @w_producto 
	   and mt_moneda        = @w_moneda 
	
	
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7065 , @w_producto, 'R', @w_moneda)
	
end


--Valores/Tasas Aplicar

select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_VALUES_RATES' 

if @w_me_id is not null
begin
	delete cew_menu_service 
	 where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda

	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.RatesManagement.SearchRates', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.RatesManagement.CreateTypeRate', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.RatesManagement.ReferenceValueList', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.RatesManagement.SearchValuesRate', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.RatesManagement.DeleteValuesRate', @w_producto, 'R', @w_moneda)
	
end

--Reportes de Desembolso


select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_IMPDISBURS' 

if @w_me_id is not null
begin
	delete cew_menu_service 
	 where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda

	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.SettlementSheetHeader', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.SettlementSheetDetail', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.GroupAccountSummary', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.DisbursementOrderDetail', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.AmortizationTableHeader', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.GroupAccount', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.GroupAccountHeader', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.AmortizationTableDetail', @w_producto, 'R', @w_moneda)
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.DisbursementOrderHeader', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.ReportMaintenance.AmortizationTableOperationHeader', @w_producto, 'R', @w_moneda)
	
end

--Manejo de fondos
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_FUND' 

if @w_me_id is not null
begin
	delete cew_menu_service 
	 where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda

	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.FundManagement.CreateFundResource', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.FundManagement.SearchFundResource', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.FundManagement.UpdateFundResource', @w_producto, 'R', @w_moneda)
end

--Conciliación
select @w_me_id = isnull(me_id, 0)
from cew_menu 
where me_name = 'MNU_ASSETS_CONCILIATION' 

if @w_me_id is not null
begin
	delete cew_menu_service 
	 where ms_id_menu       = @w_me_id 
       and ms_producto      = @w_producto 
       and ms_moneda        = @w_moneda
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.InsertFileInTemp', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.SearchAllConciliations',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.DeleteTemporary',@w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.UploadFile', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.SearchPaymentByFilter', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.GeneralInfo.GetCatalog', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id,'Loan.ConciliationManagement.ManualConciliation', @w_producto, 'R', @w_moneda)
end

--Log de procesamiento de órdenes de débito

select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_LOG_PROC_ORD_DEBITOS'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	 
    insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.DebitOrderProcessingLog.SearchDebitOrderProcessingLog', @w_producto, 'R', @w_moneda)

    delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 
    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7301, @w_producto, 'R', @w_moneda)
end


-- ************************************************** AUTORIZACIÓN DE FUNCIONALIDADES GENÉRICAS **************************************************
--(ESTA SECCIÓN DEBE IR AL FINAL PARA QUE LAS AUTORIZACIONES NO SE BORREN EN LA SECCIÓN DE AUTORIZACIÓN DE FUNCIONALIDADES)

--1. ADMIN-CONTENEDOR
delete from cew_menu_service
where ms_producto = @w_producto
and ms_servicio in ('CEW.Official.GetOfficialInfo', 'CEW.Menu.getMenuByRole', 'CEW.Preferences.getUserPreferences', 'Designer.LoadCatalog.Ext', 'CEW.Favorites.getUserFavorites', 'CustomerService.checkColumnExist',
                     'CustomerService.getGroupsByParameters','CEW.ContainerInfo.getContainerInfo')

insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CEW.Official.GetOfficialInfo', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CEW.Menu.getMenuByRole', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CEW.Preferences.getUserPreferences', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'Designer.LoadCatalog.Ext', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CEW.Favorites.getUserFavorites', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CustomerService.checkColumnExist', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CustomerService.getGroupsByParameters', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null
insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) select me_id, 'CEW.ContainerInfo.getContainerInfo', @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url is not null


--2. BUSQUEDA DE OPERACIONES
delete from cew_menu_transaccion 
where mt_producto = @w_producto
and mt_transaccion IN (7130, 7204, 7142, 7131)

insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) 
select me_id, 7130, @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url LIKE '%LOANSEARHC%'

insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
select me_id, 7204, @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url LIKE '%LOANSEARHC%'

insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) 
select me_id, 7142, @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url LIKE '%LOANSEARHC%'

insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
select me_id, 7131, @w_producto, 'R', @w_moneda from cew_menu where me_id_cobis_product = @w_producto and me_url LIKE '%LOANSEARHC%'

--3. RECURSOS DE CARTERA Y CLIENTES
delete cew_menu_resource from cew_menu
where mr_id_menu 	= me_id
and me_id_cobis_product = @w_producto

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/cobis/web/views/ASSTS/.*'
	
insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/resources/ASSTS/.*'


insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/resources/ASSTS/CMMNS/.*'
	
insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/cobis/web/views/ASSTS/CMMNS/.*'
	
insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/cobis/web/views/ASSTS/assets/.*'
	
insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

select @w_resource = null
select @w_resource = re_id
from cew_resource
where re_pattern = '/cobis/web/views/customer/.*'
	
insert into cew_menu_resource (mr_id_menu, mr_id_resource)
select me_id, @w_resource from cew_menu where me_id_cobis_product = @w_producto and me_url is not NULL

go

/*Asigancion de rol a las vistas*/
USE cobis
go

declare @w_id_resource int, @w_rol int,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CALL CENTER'
select 'Id_Role' = @w_rol

select @w_cod=isnull(max(re_id),0)  from cobis..cew_resource where re_pattern= '/cobis/web/views/ASSCR/.*'

 
IF not exists(select 1  FROM cobis..cew_resource where re_pattern= '/cobis/web/views/ASSCR/.*')
begin
  insert into dbo.cew_resource (re_id, re_pattern)
  values (@w_cod+1, '/cobis/web/views/ASSCR/.*')

end

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/ASSCR/.*'
select 'Id_Resource' = @w_id_resource

IF not exists(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
begin
insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
end

go

--------------------
-- CONCILIACION MANUAL DE PAGOS CASO #107888
--------------------
use cobis
go

declare 
@w_me_id       int, -- Codigo del menu a eliminar
@w_pd_producto int  -- Codigo del producto

select @w_me_id = me_id from cew_menu where me_name IN ('MNU_ASSETS_CONCILIATION_MANUAL') -- Obtiene el codigo del menu a eliminar
select @w_pd_producto = pd_producto from cobis..cl_producto where pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA' -- Obtiene el id del producto 'Cartera'

delete from cew_menu_transaccion where mt_id_menu IN (@w_me_id) -- Elimina el menu transacción
delete from cew_menu_service where ms_id_menu IN (@w_me_id) -- Elimina el menu servicio

if @w_me_id is not null
begin

	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ConciliationManagement.SearchConciliationByFilters', @w_pd_producto, 'R', 0)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ConciliationManagement.SearchMinorDateNotConciled', @w_pd_producto, 'R', 0)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'Loan.ConciliationManagement.ApplyOperationManualConciliation', @w_pd_producto, 'R', 0)
	
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7316, @w_pd_producto, 'R', 0)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id, 7317, @w_pd_producto, 'R', 0)
	
end

go

USE cobis
go

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CALL CENTER'


select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource

 
IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/ASSCR/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/ASSCR/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/ASSCR/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END


select @w_id_resource = re_id
from cobis..cew_resource
where re_pattern = '/cobis/web/views/customer/.*'

if not exists(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
   insert into cobis..cew_resource_rol values(@w_id_resource,@w_rol)
go

/* Menu Operaciones*/

USE cobis
go

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES'
select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource

 
IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/ASSCR/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/ASSCR/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/ASSCR/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END

go

--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare @w_resource     int,
		@w_rol			int

   
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MESA DE OPERACIONES'


if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views//PAOBJ/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views//PAOBJ/.*')
end

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/PAOBJ/PAOBJ/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/PAOBJ/PAOBJ/.*')
end

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/PAOBJ/assets/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/PAOBJ/assets/.*')
end


if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views//PAOBJ/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views//PAOBJ/.*'
END


if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views/PAOBJ/PAOBJ/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/PAOBJ/PAOBJ/.*'
END



if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views/PAOBJ/assets/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/PAOBJ/assets/.*'
END

go



use cobis
go

declare @w_codigo_resource int 

if not exists(select 1 from cew_resource where re_pattern = '/resources/CSTMR/.*')
begin
      select @w_codigo_resource= max(isnull(re_id,0)) + 1 from cew_resource
      insert into cew_resource (re_id, re_pattern) values (@w_codigo_resource, '/resources/CSTMR/.*')

end  
else 
      select @w_codigo_resource = re_id from cew_resource where re_pattern = '/resources/CSTMR/.*'


insert into cew_resource_rol (rro_id_resource, rro_id_rol)
select @w_codigo_resource, ro_rol
from cobis..ad_rol 
where not exists (select 1 from cew_resource_rol where rro_id_resource = @w_codigo_resource and rro_id_rol =ro_rol )

-- ==========================================================================
if not exists(select 1 from cew_resource where re_pattern = '/cobis/web/views/CSTMR/.*')
begin
      select @w_codigo_resource= max(isnull(re_id,0)) + 1 from cew_resource
      insert into cew_resource (re_id, re_pattern) values (@w_codigo_resource, '/cobis/web/views/CSTMR/.*')

end  
else 
      select @w_codigo_resource = re_id from cew_resource where re_pattern = '/cobis/web/views/CSTMR/.*'

insert into cew_resource_rol (rro_id_resource, rro_id_rol)
select @w_codigo_resource, ro_rol from cobis..ad_rol 
where not exists (select 1 from cew_resource_rol where rro_id_resource = @w_codigo_resource and rro_id_rol =ro_rol )

go
