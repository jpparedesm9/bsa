use cobis
go 

declare @w_id_menu int

select @w_id_menu = me_id from cew_menu where me_name='MNU_ASSETS_PAYMENTS'

delete from cew_menu_role where mro_id_menu=@w_id_menu
delete from cew_menu where me_id=@w_id_menu

select @w_id_menu = me_id from cew_menu where me_name='MNU_ASSETS_REVERSE'

delete from cew_menu_role where mro_id_menu=@w_id_menu
delete from cew_menu where me_id=@w_id_menu

go

declare @num integer, @num1 integer, @w_back integer, @w_ass integer, @w_mant_pago int, @w_man integer, @w_clau integer, @w_cambioest integer, @w_old_menu integer, @w_menu_desc varchar(50),@w_proycuota int,@w_prorroga int, @w_pago int,
        @w_mant_consulta integer, @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT, @w_orden int, @w_producto int, @w_moneda int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_orden = 10

select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'CARTERA'
 
 select @w_moneda = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'
--MENU PAGOS

select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'

select @w_pago = null
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_GROUP'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAYMENTS_GROUP'

select @w_pago = null
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAYMENTS_MNU'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,'MNU_ASSETS_PAYMENTS_MNU',7, 1, @w_orden, 0, 'Pago de Préstamos')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = @w_orden + 1

--PAGOS INDIVIDUALES
select @w_pago = null
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,'MNU_ASSETS_INDIVIDUAL_PAYMENTS','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=8&category=4&type=I',7, 1, @w_orden, 0, 'Pago Individual')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)


select @num = me_id 
from cew_menu 
where me_name = 'MNU_ASSETS_PAYMENTS'

if @num is not null
begin
    delete cew_menu_service 
    where ms_id_menu 	= @num
    and ms_producto 	= @w_producto
    and ms_moneda 	= @w_moneda
   	
	insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    values (@num, 'Collateral.SearchDeposit.SearchDeposit', @w_producto, 'R', @w_moneda)
	
	insert into dbo.cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
    values (@num, 'Collateral.SearchDeposit.SearchAccount', @w_producto, 'R', @w_moneda)
	
	
	delete cew_menu_transaccion
    where mt_id_menu 	= @num
    and mt_producto 	= @w_producto
    and mt_moneda 	= @w_moneda

    insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7144, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,1209, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7276, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7306, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7003, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7059, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7149, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7277, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@num,7058, @w_producto, 'R', @w_moneda)
end

select @w_orden = @w_orden + 1

--PAGOS GRUPALES
select @w_pago = null
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_GROUP'
delete from cobis..cew_menu_service where ms_id_menu = @w_pago and ms_servicio = 'Loan.ProductListCredit.QueryPendingPayment' and ms_producto = 7
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAYMENTS_GROUP'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,'MNU_ASSETS_PAYMENTS_GROUP','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=8&category=4&type=G',7, 1, @w_orden, 0, 'Pago Grupal')


insert into cobis..cew_menu_service (ms_id_menu,ms_servicio,ms_producto,ms_tipo,ms_moneda) 
values (@num,'Loan.ProductListCredit.QueryPendingPayment',@w_producto,'R',@w_moneda)


insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = 6

--MENU REVERSAS

select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_INDIVIDUAL'
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_old_menu = null
select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_GROUP'
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_REVERSE_MNU'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option,me_description)
values(@num,@w_man,@w_menu_desc,7, 1, @w_orden, 0,'Reverso')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = @w_orden + 1

--REVERSA INDIVIDUAL
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_REVERSE_INDIVIDUAL'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,me_description)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2&category=3&type=I',7, 1, @w_orden, 0,'Reversos Transacciones Individuales')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = @w_orden + 1

--REVERSA GRUPAL
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_REVERSE_GROUP'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,me_description)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2&category=3&type=G',7, 1, @w_orden, 0,'Reverso Pagos Grupales')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

go

