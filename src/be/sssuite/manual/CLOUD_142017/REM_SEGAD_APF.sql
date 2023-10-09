
use cobis
go

declare
@w_codigo                       int

select @w_codigo = codigo 
from cobis..cl_tabla 
where tabla = 'fp_tipo_rubro'

delete cl_catalogo where tabla = @w_codigo and codigo = 'S'
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code,type )
values (@w_codigo, 'S', 'SEGURO', 'V', NULL, NULL, NULL)

go

use cob_fpm
go


declare 
@w_item_id                       int,
@w_item_id_aux                   int,
@w_ite_code                      int,
@w_ntc_product_category_id       int,
@w_iaw_itemappliesway_id         int,
@w_iaw_itemappliesway_id_aux     int,
@w_table_id                      int,
@w_dc_fields_id                  int,
@w_dc_fields_id_tmp              INT = 0,
@w_dfg_functionality_id          INT = 1000,
@w_dc_name                       VARCHAR(64),
@w_dc_description                VARCHAR(255),
@w_dc_valuetype                  VARCHAR(10),
@w_dc_enabled                    CHAR(1),
@w_dc_modifyinherited            CHAR(1),
@w_dc_required                   CHAR(1),
@w_dc_evaluationproduct          CHAR(1),
@w_dc_multivalue                 CHAR(1),
@w_dc_ishead                     CHAR(1),
@w_fv_value_id                   int

create table #fp_fieldvalues (
    fv_value_id       NUMERIC (18) NOT NULL identity,
	fv_fields_id      NUMERIC (18) DEFAULT ((0)) NOT NULL,
	fv_valuesource_id CHAR (1) NOT NULL,
	fv_value          VARCHAR (32) NOT NULL,
	fv_description    VARCHAR (255) NULL,
	fv_defaultvalue   CHAR (1) NULL,
	fv_type           CHAR (3) NULL,
	fv_database       VARCHAR (32) NULL
)

/**********************************************/
/*  AGREGAR RUBRO SEGAD                       */
/**********************************************/

select @w_ntc_product_category_id = ntc_productcategory_id 
from fp_nodetypecategory 
where ntc_name = 'Cartera'

select @w_dfg_functionality_id = max(dfg_functionality_id) + 100
from fp_dicfunctionalitygroup

PRINT @w_dfg_functionality_id 

---- SEGAD
select @w_item_id = ite_item_id
from fp_items
where ite_name = 'SEGAD' 

PRINT @w_item_id

select @w_iaw_itemappliesway_id     = iaw_itemappliesway_id
from fp_itemappliesway
where ite_item_idfk                 = @w_item_id 
and   bp_product_idfk               = 'GRUPAL'

PRINT @w_iaw_itemappliesway_id

delete fp_amountitemvalues where iaw_itemappliesway_idfk =  @w_iaw_itemappliesway_id and bp_product_idfk = 'GRUPAL'
delete fp_itemappliesway where ite_item_idfk = @w_item_id and bp_product_idfk = 'GRUPAL'  
delete fp_itemvalues where ite_item_idfk = @w_item_id and bp_product_idfk = 'GRUPAL' 
delete fp_itemsbyproduct where ite_item_idfk = @w_item_id and bp_product_idfk = 'GRUPAL' 
delete fp_fieldsmappings where dc_fields_idfk in (select dc_fields_id from fp_dictionaryfields 
                                                  where dfg_functionality_idfk = (select dfg_functionality_id from fp_dicfunctionalitygroup 
												                                  where dfg_name = 'Rubro Seguro' ))
delete fp_fieldvalues where fv_fields_id in (select dc_fields_id from fp_dictionaryfields 
                                             where dfg_functionality_idfk = (select dfg_functionality_id from fp_dicfunctionalitygroup 
												                             where dfg_name = 'Rubro Seguro' ))
delete fp_dictionaryfields where dfg_functionality_idfk = (select dfg_functionality_id from fp_dicfunctionalitygroup where dfg_name = 'Rubro Seguro' )
delete fp_dicfunctionalitygroup where dfg_name = 'Rubro Seguro'  
DELETE fp_diccompanyproducttype WHERE dcp_name_id = 'Rubro Seguro' 
delete fp_items where ite_item_id = @w_item_id

   
INSERT INTO fp_diccompanyproducttype (com_company_idfk, ntc_productcategory_idfk, dcp_type_id, dcp_name_id, dcp_description, dcp_itemtype)
VALUES (1, 100, 'R', 'Rubro Seguro', 'Rubro Seguro', 'S')  


insert into fp_dicfunctionalitygroup (dfg_functionality_id, com_company_idfk, ntc_productcategory_idfk, dcp_type_idfk, dcp_name_idfk, dfg_name, dfg_description, dfg_enabled)
values (@w_dfg_functionality_id, 1, 100, 'R', 'Rubro Seguro', 'Rubro Seguro', 'Rubro Seguro', 'S')


select @w_dc_fields_id = max(dc_fields_id) + 1
from cob_fpm..fp_dictionaryfields

select @w_fv_value_id = max(fv_value_id) + 1
from cob_fpm..fp_fieldvalues

SELECT @w_dc_fields_id_tmp = 0

WHILE 1 = 1 BEGIN

   SELECT TOP 1
   @w_dc_fields_id_tmp     = dc_fields_id,
   @w_dc_name              = dc_name,
   @w_dc_description       = dc_description,
   @w_dc_valuetype         = dc_valuetype,
   @w_dc_enabled           = dc_enabled,
   @w_dc_modifyinherited   = dc_modifyinherited,
   @w_dc_required          = dc_required,
   @w_dc_evaluationproduct = dc_evaluationproduct,
   @w_dc_multivalue        = dc_multivalue,
   @w_dc_ishead            = dc_ishead       
   from cob_fpm..fp_dictionaryfields
   where dfg_functionality_idfk = 900
   AND   dc_fields_id > @w_dc_fields_id_tmp
   ORDER BY dc_fields_id asc

   IF @@ROWCOUNT = 0 BREAK 
   
   INSERT INTO fp_dictionaryfields VALUES (
   @w_dc_fields_id , @w_dfg_functionality_id, @w_dc_name, @w_dc_description,
   @w_dc_valuetype, @w_dc_enabled, @w_dc_modifyinherited, @w_dc_required,
   @w_dc_evaluationproduct, @w_dc_multivalue, @w_dc_ishead)   
   
   insert into fp_fieldsmappings 
   select 
   @w_dc_fields_id, 2, mp_physicalfield, mp_datatype
   from fp_dictionaryfields,fp_fieldsmappings
   where dc_fields_id = dc_fields_idfk
   AND dc_fields_id = @w_dc_fields_id_tmp
   
   insert into #fp_fieldvalues
   select @w_dc_fields_id, fv_valuesource_id, fv_value, fv_description, fv_defaultvalue, fv_type,fv_database
   from fp_dictionaryfields,fp_fieldvalues
   where dc_fields_id = fv_fields_id
   and dc_fields_id   = @w_dc_fields_id_tmp  

      
   SELECT @w_dc_fields_id = @w_dc_fields_id + 1
   
END



insert into fp_fieldvalues
select 
fv_value_id  +@w_fv_value_id,  
fv_fields_id     ,
fv_valuesource_id,
fv_value         ,
fv_description   ,
fv_defaultvalue  ,
fv_type          ,
fv_database      
from #fp_fieldvalues

SELECT * FROM fp_dictionaryfields  WHERE dfg_functionality_idfk = @w_dfg_functionality_id
   
SELECT 
@w_item_id  = isnull(max(ite_item_id),0) + 1
FROM fp_items

select
@w_ite_code = isnull(max(@w_ite_code),0) + 1
FROM fp_items

insert into fp_items values(@w_item_id,@w_ntc_product_category_id,'SEGAD','Seguro Adicional','O',@w_ite_code,'Rubro Seguro')

   
select @w_iaw_itemappliesway_id = isnull(max(iaw_itemappliesway_id) ,0) + 1
from fp_itemappliesway

insert into fp_itemsbyproduct values('GRUPAL',@w_item_id,'O')
insert into fp_itemappliesway values(@w_iaw_itemappliesway_id,'GRUPAL',@w_item_id,'P',1,0,0,'','N')


select @w_item_id_aux = ite_item_id
from fp_items
where ite_name = 'INT_ESPERA' 

select @w_iaw_itemappliesway_id_aux = iaw_itemappliesway_id
from fp_itemappliesway
where ite_item_idfk                 = @w_item_id_aux 
and   bp_product_idfk               = 'GRUPAL'


select dc_fields_idfk AS dc_fields_idfk, 'GRUPAL' AS bp_product_idfk, @w_item_id AS ite_item_idfk, iv_value AS iv_value
INTO #fp_itemvalues
from fp_itemvalues
where bp_product_idfk = 'GRUPAL'
and   ite_item_idfk   = ( select ite_item_id from fp_items where ite_name = 'INT')

update #fp_itemvalues set 
dc_fields_idfk  = b.dc_fields_id
from fp_dictionaryfields a, fp_dictionaryfields b
where a.dc_name = b.dc_name
AND   a.dc_fields_id = dc_fields_idfk
and   b.dfg_functionality_idfk = @w_dfg_functionality_id

select * from #fp_itemvalues

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Prioridad'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = '12'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Forma de pago'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = 'M'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'


select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Rubro fijo'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = 'N'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Causa'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = 'N'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

insert into fp_itemvalues
select * from #fp_itemvalues

insert into fp_amountitemvalues 
select 'GRUPAL', @w_iaw_itemappliesway_id, cp_currency_idfk,
aiv_userange, aiv_rangetype, aiv_currencycharge, aiv_businessrule,
NULL, aiv_ratereference, aiv_minimumsign, aiv_minimum,
aiv_basesign, aiv_base, aiv_maximumsign, aiv_maximum, aiv_businessrulelimits,
aiv_minimumlimittype, aiv_maximumlimittype, aiv_minimumlimit, aiv_maximumlimit,
aiv_minimumlimitvar, aiv_maximumlimitvar, aiv_ratechangerate, aiv_typechangerate,
aiv_periodchangerate, aiv_periodtypechangerate, aiv_formchangerate, aiv_allowchangerate,
aiv_referenceratechangerate, aiv_minimumsignchangerate, aiv_minimumchangerate,aiv_basesignchangerate,
aiv_basechangerate, aiv_maximumsignchangerate, aiv_maximumchangerate, aiv_policy_id,
aiv_policyname, aiv_storedprocedure
from fp_amountitemvalues
where iaw_itemappliesway_idfk   = @w_iaw_itemappliesway_id_aux
and   bp_product_idfk           = 'GRUPAL'


select @w_dc_fields_id = dc_fields_idfk 
from cob_fpm..fp_fieldsmappings 
where mp_physicalfield ='dt_dias_gracia'

update  fp_generalparametersvalues set 
gpv_value = '0'
where dc_fields_idfk = @w_dc_fields_id
and   bp_product_idfk = 'GRUPAL'

update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_item_id + 1 where TABLA = 'fp_items'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_iaw_itemappliesway_id + 1 where TABLA = 'fp_itemappliesway'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_dc_fields_id + 1 where TABLA = 'fp_dictionaryfields'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_fv_value_id + 1 where TABLA = 'fp_fieldvalues'

DROP TABLE #fp_itemvalues
drop table #fp_fieldvalues


GO

