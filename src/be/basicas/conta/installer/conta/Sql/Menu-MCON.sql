/********************************************************************/	
/*    Archivo:       Menu-AdminRed.sql	                            */
/*    Base de datos: cobis         		 	            		    */
/*    Producto:      Menu-MCON					  			 	    */
/*    Disenado por:  Roger Orejuela                                 */
/*    Fecha:	     04/Ago/2012		 	 	    				*/
/********************************************************************/
/*		     IMPORTANTE	                                    */
/*    Este programa es parte de los paquetes bancarios propiedad de */
/*    "MACOSA", representantes exclusivos para el Ecuador de "NCR". */
/*    Su uso no autorizado queda expresamente prohibido asi como    */
/*    cualquier alteracion o agregado hecho por alguno de sus	    */
/*    usuarios sin el debido consentimiento por escrito de la 	    */
/*    Presidencia Ejecutiva de MACOSA o su representante.	    */
/********************************************************************/
/*		     PROPOSITO		                            */
/*    Este script permite crear las opciones de menu para la        */
/*    administracion de seguridades                                 */
/********************************************************************/
/*	             MODIFICACIONES		                    */
/*    FECHA          AUTOR          RAZON	                    */
/*    01/Nov/2012    J. Mite        Autorizacion de Funcionalidades */
/*    21-04-2016     BBO            Migracion Sybase-SQL FAL        */
/********************************************************************/



/********************************************************************/
/*                REPORTES ENTIDADES DE CONTROL REC                 */
/********************************************************************/

--====================================================
-- PRODNAME 
--====================================================
use cobis
go
 
declare @w_codigo int 
select @w_codigo=codigo from cl_tabla where tabla='an_product'
if not exists( select 1 from  cl_catalogo  where tabla=@w_codigo and codigo ='M-CON')
   insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-CON','CONTABILIDAD','V')  

declare @w_nemonic varchar(10)
	
--ID del componente actual
select @w_nemonic = 'M-CON'


-- BASE PROD-NAME
if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571,@w_nemonic)    --FILIAL

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1574,@w_nemonic)    --OFICINA

--if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic)
--   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic
--insert into an_transaction_component values (0, 15015,@w_nemonic)   --NODO

--if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic)
--   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic
--insert into an_transaction_component values (0, 15062,@w_nemonic)   --BUSCA TERMINALES

--if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic)
--   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic
--insert into an_transaction_component values (0, 1581,@w_nemonic)    --BASE DATOS

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =568  and tc_oc_nemonic =@w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =568  and tc_oc_nemonic =@w_nemonic
insert into an_transaction_component values (0, 568,@w_nemonic) ----------------Usuario

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUNAME DE CON'
go


--====================================================
-- FBcoDefinicion
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoDefinicion'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6036 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6036 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6036,null)	


--====================================================
-- FBcoOrganizacion
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoOrganizacion'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6055 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6055 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6055,null)	




--====================================================
-- FBcoOficinas
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoOficinas'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6055 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6055 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6055,null)	



--====================================================
-- FBcoNivelDepto
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoNivelDepto'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6505 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6505 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6505,null)	



--====================================================
-- FBcoAreas
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoAreas'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6515 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6515 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6515,null)	




--====================================================
-- FBcoPeriodos
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBcoPeriodos'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6095 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6095 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6095,null)	



--====================================================
-- FRelacion
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FRelacion'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6849 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6849 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6849,null)	



--====================================================
-- FTPNiveles
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTPNiveles'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6025 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6025 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6025,null)	



--====================================================
-- FModificaPlan
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FModificaPlan'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6238 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6238 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6238,null)	


--====================================================
-- FTPDinamica
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTPDinamica'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6205 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6205 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6205,null)	


--====================================================
-- FPGCuentas
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FPGCuentas'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6075 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6075 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6075,null)	


--====================================================
-- FCtaProceso
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FCtaProceso'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =8004 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =8004 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,8004,null)	


--====================================================
-- FCtaTerceros--------------------------------------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FTPBuscaCuenta
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTPBuscaCuenta'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6017 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6017 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6017,null)	



--====================================================
-- FPGBuscarCuentas
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FPGBuscarCuentas'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6337 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6337 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6337,null)	


--====================================================
-- FModctaTercer
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FModctaTercer'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6212 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6212 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6212,null)	


--====================================================
-- FConsolidacion
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FConsolidacion'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6799 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6799 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6799,null)	


--====================================================
-- FRetenIndCom
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FRetenIndCom'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6015 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6015 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6015,null)	

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6040 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6040 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6040,null)	

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6045 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6045 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6045,null)	

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6044 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6044 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6044,null)	



--====================================================
-- FAsoofidepart
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FAsoofidepart'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6216 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6216 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6216,null)	


--====================================================
-- FREGFISC
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FREGFISC'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6532 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6532 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6532,null)	


--====================================================
-- FParametro
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FParametro'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6925 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6925 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6925,null)	



--====================================================
-- FPerfilRelacion
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FPerfilRelacion'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6935 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6935 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6935,null)	


--====================================================
-- FCodVal
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FCodVal'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6945 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6945 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6945,null)	

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6946 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6946 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6946,null)	


--====================================================
-- FTipArea
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTipArea'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6895 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6895 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6895,null)	


--====================================================
-- FPerfil
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FPerfil'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6906 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6906 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6906,null)	



--====================================================
-- FconsultaInterfaz
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FconsultaInterfaz'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6909 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6909 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6909,null)	



--====================================================
-- FParamGrupo-------------------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FModifiPerfil
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FModifiPerfil'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6214 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6214 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6214,null)	



--====================================================
-- FCbProducto
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FCbProducto'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6099 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6099 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6099,null)	



--====================================================
-- FCotizaciones
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FCotizaciones'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6145 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6145 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6145,null)	



--====================================================
-- FSeguridad
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FSeguridad'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6735 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6735 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6735,null)	



--====================================================
-- FComprobanteTipo
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FComprobanteTipo'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6126 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6126 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6126,null)	



--====================================================
-- FComprobante
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FComprobante'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6106 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6106 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6106,null)	


--====================================================
-- FConsultaComprobt
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FConsultaComprobt'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6114 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6114 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6114,null)	


--====================================================
-- FNitpadec -----------------------------------------------------------------------------------------------------------------------------
--====================================================



--====================================================
-- FCtrlcpd-------------------------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FSaldosContables2
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FSaldosContables2'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6325 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6325 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6325,null)	



--====================================================
-- FSaldosContables3
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FSaldosContables3'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6402 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6402 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6402,null)	



--====================================================
-- FSaldosContables4
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FSaldosContables4'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6976 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6976 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6976,null)	



--====================================================
-- FSaldosContables
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FSaldosContables'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6578 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6578 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6578,null)	


if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6579 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6579 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6579,null)	


--====================================================
-- FTranCuenta
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTranCuenta'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6335 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6335 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6335,null)	



--====================================================
-- FTranCuentaH --------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FCompBusca
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FCompBusca'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6128 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6128 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6128,null)	



--====================================================
-- FConsultaPuentes -----------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FEstadoFinanc
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FEstadoFinanc'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6215 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6215 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6215,null)	



--====================================================
-- FReadFile
--====================================================
/*
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FReadFile'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =8073 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =8073 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,8073,null)	
*/


--====================================================
-- FExcelDeclaraciones
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FExcelDeclaraciones'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6163 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6163 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6163,null)	



--====================================================
-- FExcelAnexos
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FExcelAnexos'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6163 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6163 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6163,null)	


--====================================================
-- FProvisiones----------------------------------------
--====================================================




--====================================================
-- FBusquedaAuxiliares
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FBusquedaAuxiliares'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6346 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6346 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6346,null)	



--====================================================
-- FEstadoCuenta --------------------------------------------------------------------------------------------------
--====================================================



--====================================================
-- FBusquedaAuxiliaresH ------------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FConsultaCuenta
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FConsultaCuenta'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6029 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6029 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6029,null)	



--====================================================
-- FConsultaCuentaH
--====================================================



--====================================================
-- FConsultaTercero
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FConsultaTercero'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6278 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6278 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6278,null)	




--====================================================
-- FConsultaTerceroH---------------------------------------------------------------------------------------------
--====================================================


--====================================================
-- FTerceroBusca
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'CON.FTerceroBusca'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6278 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =6278 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,6278,null)	




--====================================================
-- FLibMayor -------------------------------------------------------------------------------------------------------
--====================================================




--====================================================
-- FLibDia -------------------------------------------------------------------------------------------------------
--====================================================
