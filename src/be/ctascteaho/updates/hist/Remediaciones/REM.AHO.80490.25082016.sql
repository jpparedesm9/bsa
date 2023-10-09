/***********************************************************************************************************/

---Fecha					: 25/08/2016 
--Descripción               : script para la Historia 80490 
--Descripción de la Solución: Remediacion para la Historia 80490
--Autor						: Jorge Baque
/***********************************************************************************************************/
--$/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql/cc_tran.sql
use cobis
go

delete from cl_ttransaccion
 where tn_trn_code in (2502)
 
go

insert into cl_ttransaccion values (2502,'ND POR CHQ DEVUELTO CAMARA','NDCD','ND POR CHEQUE DEVUELTO CAMARA')

go