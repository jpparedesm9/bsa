use cob_fpm
go

delete from cob_fpm..fp_extractordata
delete from  fp_amountitemvalueshistory
delete from  fp_itemapplieswayhistory
delete from  fp_itemvalueshistory
delete from  fp_itemsbyproducthistory
delete from  fp_generalparametershistory
delete from  fp_itemstatushistory
delete from  fp_operationstatushistory
delete from  fp_accountingprofilehistory
delete from  fp_catalogsbyproducthistory

delete from  fp_processbyproducthistory
delete from  fp_productauthorizationhistory
delete from  fp_policiesbyproducthistory
delete from  fp_currencyproductshistory
delete from  fp_unitfunctionalityvalues

if exists (select 1 from syscolumns c, sysobjects o 
                 where  o.type = 'U' 
                 and    o.name = 'fp_unitfunctionalityvalueshist' 
) 
delete from  fp_unitfunctionalityvalueshist

delete from  fp_bankingproductshistory
delete from  fp_mappingtypegroup
delete from  fp_processbyoperation
delete from  fp_processbymodule

delete from  fp_amountitemvalues
delete from  fp_itemappliesway
delete from  fp_appliestowhenapply
delete from  fp_appliesto
delete from  fp_whenapplynodetype
delete from  fp_itemvalues
delete from  fp_itemstatus
delete from  fp_processbyproduct
delete from  fp_operationstatus
delete from  fp_productauthorization

delete from  fp_catalogsbyproduct
delete from  fp_itemsbyproduct
delete from  fp_items
delete from  fp_generalparametersvalues
delete from  fp_accountingprofile
delete from  fp_policiesbyproduct
delete from  fp_currencyproducts
delete from  fp_fieldsbyproduct
delete from  fp_bankingproducts
delete from  fp_fieldsmappings

delete from  fp_requiredfieldsbytable
delete from  fp_tablesbymodule
delete from  fp_fieldvalidators
delete from  fp_fieldvalues
delete from  fp_dictionaryfields
delete from  fp_dicfunctionalitygroup
delete from  fp_diccompanyproducttype
delete from  fp_companies
delete from  fp_nodecategoryfunctionalities
delete from  fp_nodetypecategory

delete from  fp_module
delete from  fp_modulegroup
delete from  fp_nodetypefunctionalities
delete from  fp_functionalities
delete from  fp_nodetypeproduct
if exists (select 1 from syscolumns c, sysobjects o 
                 where  o.type = 'U' 
                 and    o.name = 'fp_fieldsbyproductvalues' 
) 
delete from  fp_fieldsbyproductvalues
go