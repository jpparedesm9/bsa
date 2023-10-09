@echo off
if '%1'=='' goto ayuda
if '%2'=='' goto ayuda
if '%3'=='' goto ayuda

echo Inicio de ejecucion de creartablaextractor.sql
sqlcmd -U%1 -P%2 -S%3  -i defaults/creartablaextractor.sql -o output/creartablaextractor.txt
echo Inicio de ejecucion de tabla deleteTables.sql
sqlcmd -U%1 -P%2 -S%3  -i defaults/deleteTables.sql -o output/deleteTables.txt
echo Inicio de ejecucion de tabla fp_functionalities
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_functionalities.sql -o output/fp_functionalities.txt
echo Inicio de ejecucion de tabla fp_nodetypeproduct
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_nodetypeproduct.sql -o output/fp_nodetypeproduct.txt
echo Inicio de ejecucion de tabla fp_nodetypefunctionalities
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_nodetypefunctionalities.sql -o output/fp_nodetypefunctionalities.txt
echo Inicio de ejecucion de tabla fp_modulegroup
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_modulegroup.sql -o output/fp_modulegroup.txt
echo Inicio de ejecucion de tabla fp_module
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_module.sql -o output/fp_module.txt
echo Inicio de ejecucion de tabla fp_nodetypecategory
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_nodetypecategory.sql -o output/fp_nodetypecategory.txt
echo Inicio de ejecucion de tabla fp_nodecategoryfunctionalities
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_nodecategoryfunctionalities.sql -o output/fp_nodecategoryfunctionalities.txt
echo Inicio de ejecucion de tabla fp_companies
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_companies.sql -o output/fp_companies.txt
echo Inicio de ejecucion de tabla fp_diccompanyproducttype
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_diccompanyproducttype.sql -o output/fp_diccompanyproducttype.txt
echo Inicio de ejecucion de tabla fp_dicfunctionalitygroup
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_dicfunctionalitygroup.sql -o output/fp_dicfunctionalitygroup.txt
echo Inicio de ejecucion de tabla fp_dictionaryfields
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_dictionaryfields.sql -o output/fp_dictionaryfields.txt
echo Inicio de ejecucion de tabla fp_fieldvalues
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_fieldvalues.sql -o output/fp_fieldvalues.txt
echo Inicio de ejecucion de tabla fp_fieldvalidators
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_fieldvalidators.sql -o output/fp_fieldvalidators.txt
echo Inicio de ejecucion de tabla fp_tablesbymodule
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_tablesbymodule.sql -o output/fp_tablesbymodule.txt
echo Inicio de ejecucion de tabla fp_fieldsmappings
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_fieldsmappings.sql -o output/fp_fieldsmappings.txt
echo Inicio de ejecucion de tabla fp_bankingproducts
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_bankingproducts.sql -o output/fp_bankingproducts.txt
echo Inicio de ejecucion de tabla fp_currencyproducts
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_currencyproducts.sql -o output/fp_currencyproducts.txt
echo Inicio de ejecucion de tabla fp_policiesbyproduct
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_policiesbyproduct.sql -o output/fp_policiesbyproduct.txt
echo Inicio de ejecucion de tabla fp_accountingprofile
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_accountingprofile.sql -o output/fp_accountingprofile.txt
echo Inicio de ejecucion de tabla fp_generalparametersvalues
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_generalparametersvalues.sql -o output/fp_generalparametersvalues.txt
echo Inicio de ejecucion de tabla fp_items
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_items.sql -o output/fp_items.txt
echo Inicio de ejecucion de tabla fp_itemsbyproduct
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_itemsbyproduct.sql -o output/fp_itemsbyproduct.txt
echo Inicio de ejecucion de tabla fp_catalogsbyproduct
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_catalogsbyproduct.sql -o output/fp_catalogsbyproduct.txt
echo Inicio de ejecucion de tabla fp_productauthorization
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_productauthorization.sql -o output/fp_productauthorization.txt
echo Inicio de ejecucion de tabla fp_operationstatus
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_operationstatus.sql -o output/fp_operationstatus.txt
echo Inicio de ejecucion de tabla fp_processbyproduct
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_processbyproduct.sql -o output/fp_processbyproduct.txt
echo Inicio de ejecucion de tabla fp_itemstatus
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_itemstatus.sql -o output/fp_itemstatus.txt
echo Inicio de ejecucion de tabla fp_itemvalues
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_itemvalues.sql -o output/fp_itemvalues.txt
echo Inicio de ejecucion de tabla fp_whenapplynodetype
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_whenapplynodetype.sql -o output/fp_whenapplynodetype.txt
echo Inicio de ejecucion de tabla fp_appliesto
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_appliesto.sql -o output/fp_appliesto.txt
echo Inicio de ejecucion de tabla fp_appliestowhenapply
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_appliestowhenapply.sql -o output/fp_appliestowhenapply.txt
echo Inicio de ejecucion de tabla fp_itemappliesway
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_itemappliesway.sql -o output/fp_itemappliesway.txt
echo Inicio de ejecucion de tabla fp_amountitemvalues
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_amountitemvalues.sql -o output/fp_amountitemvalues.txt
echo Inicio de ejecucion de tabla fp_processbymodule
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_processbymodule.sql -o output/fp_processbymodule.txt
echo Inicio de ejecucion de tabla fp_processbyoperation
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_processbyoperation.sql -o output/fp_processbyoperation.txt
echo Inicio de ejecucion de tabla fp_mappingtypegroup
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_mappingtypegroup.sql -o output/fp_mappingtypegroup.txt
echo Inicio de ejecucion de tabla fp_requiredfieldsbytable
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_requiredfieldsbytable.sql -o output/fp_requiredfieldsbytable.txt
echo Inicio de ejecucion de tabla fp_unitfunctionalityvalues.sql
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_unitfunctionalityvalues.sql -o output/fp_unitfunctionalityvalues.txt
echo Inicio de ejecucion de tabla fp_fieldsbyproduct.sql
sqlcmd -U%1 -P%2 -S%3  -i archivos/fp_fieldsbyproduct.sql -o output/fp_fieldsbyproduct.txt


rem echo Inicio de ejecucion de deleteCartera.sql
rem sqlcmd -U%1 -P%2 -S%3  -i defaults/deleteCartera.sql -o output/deleteCartera.sql.txt
echo Inicio de ejecucion de APFUpdateSeqnos.sql
sqlcmd -U%1 -P%2 -S%3  -i defaults/APFUpdateSeqnos.sql -o output/APFUpdateSeqnos.sql.txt
echo Inicio de ejecucion de UpdateFlujosAPF.sql
sqlcmd -U%1 -P%2 -S%3  -i defaults/UpdateFlujosAPF.sql -o output/UpdateFlujosAPF.sql.txt












goto fin
:ayuda
echo bd_crear.bat [parametro 1] [parametro 2] [parametro 3] 
echo parametro 1: Usuario de Base de Datos
echo parametro 2: Clave Usuario de Base de Datos
echo parametro 3: Servidor de SQL (ip:puerto)
pause
goto fin
:fin
