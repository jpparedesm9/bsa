--PRORROGA CUOTA
use cobis
go 

declare @num integer,  @w_back integer, @w_ass integer, @w_man integer, @w_clau integer,  @w_prorroga int

select @w_ass=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
delete from cobis..cew_menu_role where mro_id_menu = @w_ass
delete from cobis..cew_menu where me_name = 'MNU_ASSETS'

select @w_back=me_id from cobis..cew_menu where me_name= 'MNU_BACK_OFFICE'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product)
values(@num,@w_back,'MNU_ASSETS',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)

--------------------
-- MANTENIMIENTO
--------------------
select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
delete from cobis..cew_menu_role where mro_id_menu = @w_man
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_MANTN'

select @w_ass=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cobis..cew_menu(me_id,me_id_parent,me_name,me_id_cobis_product)
values(@num,@w_ass,'MNU_ASSETS_MANTN',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)


select @w_clau=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_CLAUSE'
delete from cobis..cew_menu_role where mro_id_menu = @w_clau
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_CLAUSE'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_MANTN'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_man,'MNU_ASSETS_CLAUSE','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=3',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)


select @w_prorroga=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_EXTENDSQUONTA'
delete from cobis..cew_menu_role where mro_id_menu = @w_prorroga
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_EXTENDSQUONTA'

select @w_man=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_EXTENDSQUONTA'
select @num= (max(me_id)+1) from cobis..cew_menu
insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_man,'MNU_ASSETS_EXTENDSQUONTA','views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=12',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)


  -- Registro de los servicios LoanExtendsQuota y QueryLoanExtendsQuota
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.LoanExtendsQuota')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', csc_method_name = 'queryLoanQuota', csc_description = '', csc_trn = 7235 WHERE csc_service_id = 'Loan.LoanMaintenance.LoanExtendsQuota'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.LoanExtendsQuota', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'queryLoanQuota', '', 7235)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.QueryLoanExtendsQuota')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', csc_method_name = 'queryLoanExtendsQuota', csc_description = '', csc_trn = 7232 WHERE csc_service_id = 'Loan.LoanMaintenance.QueryLoanExtendsQuota'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.QueryLoanExtendsQuota', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'queryLoanExtendsQuota', '', 7232)
      GO
	  -- fin servicios LoanExtendsQuota y QueryLoanExtendsQuota