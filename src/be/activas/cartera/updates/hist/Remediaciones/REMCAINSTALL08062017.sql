/**********************************************************************************************************************/
--No Bug                                : NA
--Título de la Historia           : CGS-S110828 Pantalla para reportes Desembolso
--Fecha                                      : 08/06/2017
--Descripción del Problema :  No se muestra el menu de reportes.
--Descripción de la Solución : Agregado de autorizaciones a cew_menu y cew_menu_rol
--Autor                                        : Paúl Ortiz Vera
--Instalador                 : ca_cew_menu.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
/**********************************************************************************************************************/



USE cobis
GO


declare @num integer, @num1 integer, @w_back integer, @w_ass integer, @w_mant_pago int, @w_man integer, @w_clau integer, @w_cambioest integer, @w_old_menu integer, @w_menu_desc varchar(50),@w_proycuota int,@w_prorroga int, @w_pago int,
        @w_mant_consulta integer, @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT

select @w_rol = 3
select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_BACK_OFFICE'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product)
values(@num,@w_id_parent,'MNU_ASSETS',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)


----------------------------------
--ENU REPORTES DE DESEMBOLSO
----------------------------------
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_IMPDISBURS'
select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu
----Selecciona 'MNU_QUERY'
select @w_mant_consulta = me_id from cobis..cew_menu where me_name = 'MNU_QUERY'
--Selecciona 'MNU_QUERYMNU_QUERY'
select @w_mant_cartera = me_id from cobis..cew_menu where me_id_parent = @w_mant_consulta AND me_name = 'MNU_QUERYMNU_QUERY'
--Inserta
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_mant_cartera,'MNU_ASSETS_IMPDISBURS','views/ASSTS/MNTNN/T_DISBURSEMESRT_822/1.0.0/VC_DISBURSERM_822822_TASK.html',7)
--Inserta para el rol
insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) 
values (@num,@w_rol)

----------------------------------
--Pago Solidario
----------------------------------
select @w_old_menu = null
select @w_menu_desc = 'MNU_ASSETS_SLDRT_PYMNT'
select @w_old_menu=me_id from cobis..cew_menu where me_name= @w_menu_desc
delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu
----Selecciona 'MNU_OPER'
select @w_mant_opera = me_id from cobis..cew_menu where me_name = 'MNU_OPER'
--Selecciona 'MNU_ASSETS'
select @w_mant_cartera = me_id from cobis..cew_menu where me_id_parent = @w_mant_opera AND me_name = 'MNU_ASSETS'
--Inserta
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_mant_cartera,'MNU_ASSETS_SLDRT_PYMNT','views/ASSTS/MNTNN/T_SOLIDARITYYPN_463/1.0.0/VC_SOLIDARIEN_259463_TASK.html',7)
--Inserta para el rol
insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) 
values (@num,@w_rol)
