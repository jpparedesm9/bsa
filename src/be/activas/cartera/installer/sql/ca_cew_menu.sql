	use cobis
go 

declare @num integer, @num1 integer, @w_back integer, @w_ass integer, @w_mant_pago int, @w_man integer, @w_clau integer, @w_cambioest integer, @w_old_menu integer, @w_menu_desc varchar(50),@w_proycuota int,@w_prorroga int, @w_pago int,
        @w_mant_consulta integer, @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT, @w_orden int, @w_producto int

select @w_rol = 3, @w_orden = 1

select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'CARTERA'

select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_BACK_OFFICE'

if exists(select 1 from cobis..cew_menu where me_name = 'MNU_ASSETS')
begin
	select @num = me_id from cobis..cew_menu where me_name = 'MNU_ASSETS'
end
else
begin
	select @num= (max(me_id)+1) from cobis..cew_menu
	insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option)
	values(@num,@w_id_parent,'MNU_ASSETS',7, 1, @w_orden, 0)
end

if not exists(select 1 from cobis..cew_menu_role where mro_id_menu = @num and mro_id_role = 3)
begin
	insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
	values(@num, 3)
end



select @w_orden = @w_orden + 1

--------------------
-- MANTENIMIENTO
--------------------
select @w_old_menu=null, @w_id_parent = null
select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_MANTN'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_MANTN',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

select @w_clau=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_CLAUSE'
delete from cobis..cew_menu_role where mro_id_menu = @w_clau
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_CLAUSE'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_CLAUSE','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=3',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--FECHA VALOR
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_VALDATE'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=1',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

---MANTENIMIENTO DE FORMAS DE PAGO
select @w_mant_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTENIMIENTO_PAG'
delete from cobis..cew_menu_role where mro_id_menu = @w_mant_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_MANTENIMIENTO_PAG'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTENIMIENTO_PAG'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_MANTENIMIENTO_PAG','views/ASSTS/MNTNN/T_PAYMENTMAIETA_586/1.0.0/VC_PAYMENTMNE_706586_TASK.html',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

-- --REVERSAS
-- select @w_old_menu = null
-- select @w_menu_desc = 'MNU_ASSETS_REVERSE'

-- select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
-- delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
-- delete from cobis..cew_menu where me_id = @w_old_menu

-- select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
-- select @num= (max(me_id)+1) from cobis..cew_menu
-- insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
-- values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2',7, 1, @w_orden, 0)

-- insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
-- values(@num,3)

-- select @w_orden = @w_orden + 1

--MENU REVERSAS
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
values(@num,3)

select @w_orden = @w_orden + 1

--REVERSA INDIVIDUAL
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_REVERSE_INDIVIDUAL'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2&category=3&type=I',7, 1, @w_orden, 0, 'Reversos Transacciones Individuales')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--REVERSA GRUPAL
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_REVERSE_GROUP'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_REVERSE_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2&category=3&type=G',7, 1, @w_orden, 0,'Reverso Pagos Grupales')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--Consulta General
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_QUERYSGENERALINFORMATION'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=4',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--Impresión de Documentos
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_IMPDOC'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_IMPDOC','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=11',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--REAJUSTES
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_READJUSTMENT'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=5',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--Cambio de estado
select @w_cambioest=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_CAMBIOEST'
delete from cobis..cew_menu_role where mro_id_menu = @w_cambioest
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_CAMBIOEST'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_CAMBIOEST','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=6',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--PROYECCION CUOTA

select @w_proycuota=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PROYCUOTA'
delete from cobis..cew_menu_role where mro_id_menu = @w_proycuota
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PROYCUOTA'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_PROYCUOTA','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=7',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--PRORROGA CUOTA

select @w_prorroga=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_EXTENDSQUONTA'
delete from cobis..cew_menu_role where mro_id_menu = @w_prorroga
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_EXTENDSQUONTA'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_EXTENDSQUONTA'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_EXTENDSQUONTA','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=12',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--INGRESO OTROS CARGOS
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_INGREOTROCARGO'

select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=10',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--------------------
-- OPERACIONES
--------------------

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'
delete from cobis..cew_menu_role where mro_id_menu = @w_man
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_TRNSC'

select @w_ass=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num1= (max(me_id)+1) from cobis..cew_menu
insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option)
values(@num1,@w_ass,'MNU_ASSETS_TRNSC',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num1,3)

select @w_orden = @w_orden + 1

--MENU PAGOS

select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAYMENTS_MNU'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product, me_visible, me_order, me_option,me_description)
values(@num,@w_man,'MNU_ASSETS_PAYMENTS_MNU',7, 1, @w_orden, 0, 'Pago de Préstamos')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--PAGOS INDIVIDUALES
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_INDIVIDUAL_PAYMENTS'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,'MNU_ASSETS_INDIVIDUAL_PAYMENTS','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=8&category=4&type=I',7, 1, @w_orden, 0, 'Pago Individual')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--PAGOS GRUPALES
select @w_pago=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_GROUP'
delete from cobis..cew_menu_service where ms_id_menu = @w_pago and ms_servicio = 'Loan.ProductListCredit.QueryPendingPayment' and ms_producto = 7
delete from cobis..cew_menu_role where mro_id_menu = @w_pago
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAYMENTS_GROUP'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAYMENTS_MNU'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_man,'MNU_ASSETS_PAYMENTS_GROUP','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=8&category=4&type=G',7, 1, @w_orden, 0,'Pago Grupal')

insert into cobis..cew_menu_service (ms_id_menu,ms_servicio,ms_producto,ms_tipo,ms_moneda) 
values (@num,'Loan.ProductListCredit.QueryPendingPayment',7,'R',0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--RENOVACIONES

select @w_proycuota=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_RENOVACIONES'
delete from cobis..cew_menu_role where mro_id_menu = @w_proycuota
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_RENOVACIONES'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_RENOVACIONES','views/ASSTS/TRNSC/T_REFINANCELISS_781/1.0.0/VC_REFINANCSL_902781_TASK.html?menu=9',7, 1, @w_orden, 0)
--values(@num,@w_man,'MNU_ASSETS_RENOVACIONES','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=9',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--DESEMBOLSO
select @w_proycuota=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_DESEMBOLSO'
delete from cobis..cew_menu_role where mro_id_menu = @w_proycuota
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_DESEMBOLSO'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_man,'MNU_ASSETS_DESEMBOLSO','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=13',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

select @w_orden = @w_orden + 1

--CONSULTA DE OPERACIONES GRUPALES
/*select @w_codigo = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_GROUP'
delete from cobis..cew_menu_role where mro_id_menu = @w_codigo
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_GROUP'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_man,'MNU_ASSETS_GROUP','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=14',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)*/


--CONSULTA AHORRO INDIVIDUAL
select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_id_parent = me_id from cew_menu
where me_name = 'MNU_ASSETS_MANTN'

select @w_old_menu = me_id from cew_menu
where me_name = 'MNU_ASSETS_DETAILSAHO'

delete from cew_menu_role
where mro_id_menu = @w_old_menu

delete from cew_menu
where me_id = @w_old_menu

select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_DETAILSAHO','views/ASSTS/MNTNN/T_DETAILSAHOANJ_635/1.0.0/VC_DETAILSAOH_471635_TASK.html',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = @w_orden + 1

----------------------------------
--ENU REPORTES DE DESEMBOLSO
----------------------------------
select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_menu_desc = 'MNU_ASSETS_IMPDISBURS'
select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent = me_id from cew_menu
where me_name = 'MNU_ASSETS_MANTN'

--Inserta
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_IMPDISBURS','views/ASSTS/MNTNN/T_DISBURSEMESRT_822/1.0.0/VC_DISBURSERM_822822_TASK.html',7, 1, @w_orden, 0)

--Inserta para el rol
insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) 
values (@num,@w_rol)

select @w_orden = @w_orden + 1

----------------------------------
--Pago Solidario
----------------------------------
select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_menu_desc = 'MNU_ASSETS_SLDRT_PYMNT'
select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent = me_id from cew_menu
where me_name = 'MNU_ASSETS_MANTN'

--Inserta
--select @num= (max(me_id)+1) from cobis..cew_menu
--insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
--values(@num,@w_id_parent,'MNU_ASSETS_SLDRT_PYMNT','views/ASSTS/MNTNN/T_SOLIDARITYYPN_463/1.0.0/VC_SOLIDARIEN_259463_TASK.html',7, 1, @w_orden, 0)

----Inserta para el rol
--insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) 
--values (@num,@w_rol)

--select @w_orden = @w_orden + 1


--Fecha Valor
select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_VALUES_RATES'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_VALUES_RATES'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_VALUES_RATES','views/ASSTS/MNTNN/T_VALUERATESFBO_932/1.0.0/VC_VALUERATEE_334932_TASK.html',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

select @w_orden = @w_orden + 1

--Mantenimiento de Fondos
select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_FUND'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_FUND'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_FUND','views/ASSTS/MNTNN/T_ASSTSUFGAMLTW_237/1.0.0/VC_FUNDWJCLLL_877237_TASK.html',7, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)


--Pagos grupales con uso de garantía
select @w_orden = @w_orden + 1

select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_PAGO_GRUPALES_GRANTIA'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_PAGO_GRUPALES_GRANTIA'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_PAGO_GRUPALES_GRANTIA','views/ASSTS/TRNSC/T_ASSTSEMLSGJAK_892/1.0.0/VC_GROUPPAYTT_620892_TASK.html',@w_producto, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

--Log de procesamiento de órdenes de débitos

select @w_orden = @w_orden + 1

select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_LOG_PROC_ORD_DEBITOS'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_LOG_PROC_ORD_DEBITOS'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_LOG_PROC_ORD_DEBITOS','views/ASSTS/QERYS/T_ASSTSKUSBXHZA_608/1.0.0/VC_DEBITORDOC_486608_TASK.html',@w_producto, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)


--Conciliación
select @w_orden = @w_orden + 1

select @w_old_menu = null, @w_id_parent = null, @num = null

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_CONCILIATION'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_CONCILIATION'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_TRNSC'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,'MNU_ASSETS_CONCILIATION','views/ASSTS/CMMNS/T_ASSTSCFJBIIFM_136/1.0.0/VC_CONCILIAHN_488136_TASK.html',@w_producto, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

--Reenvío de correo
select @w_orden = @w_orden + 1

select @w_old_menu = null, @w_id_parent = null, @num = null, @w_menu_desc = 'MNU_ASSETS_VOUCHER_MAIL'

select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_menu_desc

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option)
values(@num,@w_id_parent,@w_menu_desc,'views/ASSTS/TRNSC/T_ASSTSHPXNSQZA_469/1.0.0/VC_VOUCHERPTM_945469_TASK.html',@w_producto, 1, @w_orden, 0)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

--Referencia Precancelacion
select @w_orden = @w_orden + 1

select @w_old_menu = null, 
       @w_id_parent = null, 
       @num = null, 
       @w_menu_desc = 'MNU_PRECANCELLATION_MANT'

select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_menu_desc

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_menu_desc,'views/ASSTS/TRNSC/T_ASSTSCXBWUFVI_696/1.0.0/VC_PRECANCETA_713696_TASK.html',@w_producto, 1, @w_orden, 0, 'Referencia Liquidación Anticipada de Préstamos')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)


--Referencia Precancelacion
select @w_orden = @w_orden + 1

select @w_old_menu = null, 
       @w_id_parent = null, 
       @num = null, 
       @w_menu_desc = 'MNU_ACCOUNT_STATUS'

select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_menu_desc

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_menu_desc,'views/ASSTS/TRNSC/T_ASSTSFIQJZFID_726/1.0.0/VC_ACCOUNTSSA_935726_TASK.html',@w_producto, 1, @w_orden, 0, 'Estado de Cuenta')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

--Bloqueo LCR
select @w_orden = @w_orden + 1


select @w_old_menu = null, 
       @w_id_parent = null, 
       @num = null, 
       @w_menu_desc = 'MNU_LCR_BLOCK'
	   
select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_menu_desc

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_menu_desc,'views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=14&category=6',@w_producto, 1, @w_orden, 0, 'Bloqueo de Línea de Crédito')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

go

--Regularizar Dispersiones Rechazadas
declare @num integer, @w_old_menu integer, @w_menu_desc varchar(50), @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT, @w_orden int, @w_producto int, @w_option_menu varchar(100)

select @w_option_menu = 'MNU_REGULARIZE_REJECTED_DISPERSIONS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'


select @w_orden = max(me_order) from cobis..cew_menu
where me_id_cobis_product = 7
and me_id_parent = 27

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_orden = @w_orden + 1
select @w_old_menu = null, @w_id_parent = null, @num = null
select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_option_menu

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = @w_option_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_option_menu,'views/ASSTS/TRNSC/T_ASSTSOSPSJXWE_883/1.0.0/VC_REGULARIOE_732883_TASK',@w_producto, 1, @w_orden, 0, 'Regularizar Dispersiones Rechazadas')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

go

--Carga masiva de archivos
declare @num integer, @w_old_menu integer, @w_menu_desc varchar(50), @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT, @w_orden int, @w_producto int, @w_option_menu varchar(100)

select @w_option_menu = 'MNU_CARGA_MASIVA'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
select @w_id_parent = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @w_orden = max(me_order) from cobis..cew_menu
where me_id_cobis_product = @w_producto
and me_id_parent = @w_id_parent

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' 
select @w_orden = @w_orden + 1
select @w_old_menu = null, @w_id_parent = null, @num = null
select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_option_menu

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = @w_option_menu

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_option_menu,'views/ASSTS/MNTNN/T_ASSTSEUQOESBB_349/1.0.0/VC_MASSIVEPTY_109349_TASK.html',@w_producto, 1, @w_orden, 0, 'Carga Masiva de Pagos')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)



/*Menu para Pantalla de Call Center*/
use cobis
go
declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_menu_id_1 INT,
        @w_producto int,
        @w_rol int,
        @w_rol_1 int,
        @w_menu_order INT
        
    /*Inserto el Rol si no existe */  
    
    if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'CALL CENTER')
    begin
        select @w_rol_1 =  max(ro_rol)+1 from cobis..ad_rol
        insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
        values (@w_rol_1, 1, 'CALL CENTER', getdate(), 1, 'V', getdate(), 9000)
    END
    
   /*Creacion de menu*/

    select @w_menu_parent_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
    select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
    SELECT @w_rol=ro_rol FROM cobis..ad_rol WHERE ro_descripcion ='CALL CENTER'
    
     /*Creacion de menu MNU_CALL_CENTER*/

    if not exists (select 1 from cew_menu where me_name = 'MNU_CALL_CENTER')
    begin
    	select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
    	insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
    	values (@w_menu_id, @w_menu_parent_id, 'MNU_CALL_CENTER', 1,null, @w_menu_order, 
    	@w_producto, 0, 'Call Center')
    END
    
    /*Creacion de cew_menu_role MNU_CALL_CENTER*/
    
    select @w_menu_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_id_1 = me_id from cew_menu where me_name = 'MNU_CALL_CENTER' 
   
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id, @w_rol)
    end 
       
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id_1 and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id_1, @w_rol)
    end 
	
	/*Creacion de cew_menu_role MNU_QUESTION_CENTER*/
use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CALL CENTER'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CALL_CENTER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'CALL CENTER')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_QUESTION_CENTER')
	    begin
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_QUESTION_CENTER', 1,'views/ASSCR/CREIR/T_ASSCRRXGVRPHC_165/1.0.0/VC_CALLCENTRS_338165_TASK.html?mode=1', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_QUESTION_CENTER'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_QUESTION_CENTER')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_QUESTION_CENTER', 1,'views/ASSCR/CREIR/T_ASSCRRXGVRPHC_165/1.0.0/VC_CALLCENTRS_338165_TASK.html?mode=1', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_QUESTION_CENTER'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go


/* INSERTAR MENU DE CR?ITO INDIVIDUAL */

use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'FUNCIONARIO OFICINA', getdate(), 1, 'V', getdate(), 9000)
end

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'COORDINADOR', getdate(), 1, 'V', getdate(), 9000)
end

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

-- COORDINADOR
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_OPER'
if not exists(select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol)
begin
	insert into cew_menu_role values (@w_menu_parent_id, @w_rol)
end
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ASSETS'
if not exists(select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol)
begin
	insert into cew_menu_role values (@w_menu_parent_id, @w_rol)
end

-- FUNCIONARIO OFICINA
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_OPER'
if not exists(select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol)
begin
	insert into cew_menu_role values (@w_menu_parent_id, @w_rol)
end
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ASSETS'
if not exists(select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol)
begin
	insert into cew_menu_role values (@w_menu_parent_id, @w_rol)
end

if @w_menu_parent_id is not null
begin
    --MENU CREDITO INDIVIDUAL - FUNCIONARIO OFICINA
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_CREDIT_IND')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_CREDIT_IND', 1, null, @w_menu_order, @w_producto, 0, 'Cr?to Individual')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_CREDIT_IND'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	
	--MENU CANDIDATOS A CREDITO - FUNCIONARIO OFICINA
	select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CREDIT_IND'
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_CREDIT_CANDIDATES')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_CREDIT_CANDIDATES', 1, 'views/ASSTS/QERYS/T_ASSTSTCUPYEAZ_925/1.0.0/VC_CREDITCAAD_894925_TASK.html', @w_menu_order, @w_producto, 0, 'Candidatos a Creditos LCR')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_CREDIT_CANDIDATES'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	
	--MENU CREDITO INDIVIDUAL - COORDINADOR
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
	if exists(select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
	begin 
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_CREDIT_IND'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	--MENU CANDIDATOS A CREDITO - COORDINADOR
	if exists(select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
	begin 
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_CREDIT_CANDIDATES'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	
end
else
begin
    print 'No existe el menu padre: MNU_OPER'
end

go
--------------------
-- CONCILIACION MANUAL DE PAGOS CASO #107888
--------------------
use cobis
go

declare 
@w_me_id_old int -- Codigo del menu a eliminar

select @w_me_id_old = me_id from cew_menu where me_name IN ('MNU_ASSETS_CONCILIATION_MANUAL') -- Obtiene el codigo del menu a eliminar

delete from cew_menu_role where mro_id_menu IN (@w_me_id_old) -- Elimina el menu rol
delete from cew_menu where me_name IN ('MNU_ASSETS_CONCILIATION_MANUAL') -- Elimina el menu
go

declare 
@w_me_id  int, -- Codigo del menu
@w_me_id_parent int, -- Codigo del menu padre
@w_ro_rol int, -- Codigo del rol
@w_pd_producto int -- Codigo del producto

select @w_me_id = isnull(max(me_id), 0) +1 from cew_menu -- Obtiene el nuevo id para el menu
select @w_me_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_ASSETS' -- Obtiene el id del menu para el modulo de Cartera
select @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA' -- Obtiene el id del producto 'Cartera'
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES' -- Obtiene el id del rol de operaciones

insert into cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	values (@w_me_id, @w_me_id_parent, 'MNU_ASSETS_CONCILIATION_MANUAL', 1, 'views/ASSTS/CMMNS/T_ASSTSNZKCUGDD_542/1.0.0/VC_CONCILIALA_363542_TASK.html', 181,  @w_pd_producto,  0, 'Conciliación Manual')

insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id, @w_ro_rol) 

if exists (select 1 from cew_menu_role where mro_id_menu = @w_me_id_parent and mro_id_role = @w_ro_rol)
begin
	print 'YA EXISTE MENU CON EL ROL DE OPERACIONES'
end
else
begin
	print 'SE CREA LA RELACION MENU-ROL CON EL ROL DE OPERACIONES'
	insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id_parent, @w_ro_rol)
end

go

use cobis
go
declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_menu_id_1 INT,
        @w_producto int,
        @w_rol int,
        @w_rol_1 int,
        @w_menu_order INT
        
    /*Inserto el Rol si no existe */  
    
    if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'CALL CENTER')
    begin
        select @w_rol_1 =  max(ro_rol)+1 from cobis..ad_rol
        insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
        values (@w_rol_1, 1, 'CALL CENTER', getdate(), 1, 'V', getdate(), 9000)
    END
    
   /*Creacion de menu*/

    select @w_menu_parent_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
    select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
    SELECT @w_rol=ro_rol FROM cobis..ad_rol WHERE ro_descripcion ='CALL CENTER'
    
     /*Creacion de menu MNU_CALL_CENTER*/

    if not exists (select 1 from cew_menu where me_name = 'MNU_CALL_CENTER')
    begin
    	select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
    	insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
    	values (@w_menu_id, @w_menu_parent_id, 'MNU_CALL_CENTER', 1,null, @w_menu_order, 
    	@w_producto, 0, 'Call Center')
    END
    
    /*Creacion de cew_menu_role MNU_CALL_CENTER*/
    
    select @w_menu_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_id_1 = me_id from cew_menu where me_name = 'MNU_CALL_CENTER' 
   
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id, @w_rol)
    end 
       
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id_1 and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id_1, @w_rol)
    end 
	
	/*Creacion de cew_menu_role MNU_RESET_IMAGE_MESSAGE*/
use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CALL CENTER'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CALL_CENTER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'CALL CENTER')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE')
	    begin
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_RESET_IMAGE_MESSAGE', 1,'views/ASSCR/CREIR/T_ASSCRLLURZAUF_274/1.0.0/VC_RESETMESME_339274_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_RESET_IMAGE_MESSAGE', 1,'views/ASSCR/CREIR/T_ASSCRLLURZAUF_274/1.0.0/VC_RESETMESME_339274_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go

--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare 
@w_me_id_old int -- Codigo del menu a eliminar

select @w_me_id_old = me_id from cew_menu where me_name IN ('MNU_ASSETS_PAGO_OBJETADO') -- Obtiene el codigo del menu a eliminar

delete from cew_menu_role where mro_id_menu IN (@w_me_id_old) -- Elimina el menu rol
delete from cew_menu where me_name IN ('MNU_ASSETS_PAGO_OBJETADO') -- Elimina el menu
go

declare 
@w_me_id  int, -- Codigo del menu
@w_me_id_parent int, -- Codigo del menu padre
@w_ro_rol int, -- Codigo del rol
@w_pd_producto int -- Codigo del producto

select @w_me_id = isnull(max(me_id), 0) +1 from cew_menu -- Obtiene el nuevo id para el menu
select @w_me_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_ASSETS' -- Obtiene el id del menu para el modulo de Cartera
select @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA' -- Obtiene el id del producto 'Cartera'
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el id del rol de operaciones

insert into cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	values (@w_me_id, @w_me_id_parent, 'MNU_ASSETS_PAGO_OBJETADO', 1, 'views/PAOBJ/PAOBJ/T_PAOBJXPZXAKUO_168/1.0.0/VC_FREGULARPJ_493168_TASK.html', 182,  @w_pd_producto,  0, 'Regularizar Pago Objetado')

insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id, @w_ro_rol) 

if exists (select 1 from cew_menu_role where mro_id_menu = @w_me_id_parent and mro_id_role = @w_ro_rol)
begin
	print 'YA EXISTE MENU CON EL ROL MESA DE OPERACIONES'
end
else
begin
	print 'SE CREA LA RELACION MENU-ROL CON EL ROL MESA DE OPERACIONES'
	insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id_parent, @w_ro_rol)
end

go

-------------------------------------
-- SOLICITUD PRELLENADA Req.168878
-------------------------------------
use cobis
go

declare 
@w_me_id            int,
@w_me_parent        int,
@w_producto         int,
@w_menu_order       int

declare @w_roles table(
   role         int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_me_id = isnull(max(me_id) ,0) +1 from cobis..cew_menu
select @w_me_parent = me_id from cobis..cew_menu where me_name = 'MNU_OPER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_me_parent

insert into @w_roles
select ro_rol
from ad_rol
where ro_estado = 'V'

select * from @w_roles

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST')

delete cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST'


if @w_me_parent is not null begin

   insert into cobis..cew_menu values (@w_me_id, @w_me_parent, 'MNU_ASSETSCRE_PREFILLED_REQUEST', 1, 'views/ASSCR/CREIR/T_ASSCRMFWPCNKI_783/1.0.0/VC_PREFILLESE_234783_TASK.html', @w_menu_order, @w_producto, 0, 'Solicitud Prellenada', null, 'CWC')
         
   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
end


delete cobis..cew_resource_rol 
where rro_id_resource in ( select  re_id 
                           from cew_resource where re_pattern in (
						   '/cobis/web/views/ASSCR/.*'))
and rro_id_rol in (select role from @w_roles)

insert into cobis..cew_resource_rol
select  re_id, role
from cew_resource, @w_roles
where re_pattern in (
'/cobis/web/views/ASSCR/.*')

go

