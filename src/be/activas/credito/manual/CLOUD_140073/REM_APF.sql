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
/*  AGREGAR RUBRO IVA_ESPERA                  */
/**********************************************/

select @w_ntc_product_category_id = ntc_productcategory_id 
from fp_nodetypecategory 
where ntc_name = 'Cartera'

select @w_dfg_functionality_id = dfg_functionality_id
from fp_dicfunctionalitygroup
where dfg_name = 'Rubro Porcentaje'

PRINT @w_dfg_functionality_id 

---- IVA_ESPERA
select @w_item_id = ite_item_id
from fp_items
where ite_name = 'IVA_ESPERA' 

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
delete fp_items where ite_item_id = @w_item_id

   
select @w_item_id  = isnull(max(ite_item_id),0) + 1
FROM fp_items

select
@w_ite_code = isnull(max(@w_ite_code),0) + 1
FROM fp_items

insert into fp_items values(@w_item_id,@w_ntc_product_category_id,'IVA_ESPERA','Iva Interés de Espera','O',@w_ite_code,'Rubro Porcentaje')

select * from fp_items where ite_item_id = @w_item_id
   
select @w_iaw_itemappliesway_id = isnull(max(iaw_itemappliesway_id) ,0) + 1
from fp_itemappliesway

insert into fp_itemsbyproduct values('GRUPAL',@w_item_id,'O')
insert into fp_itemappliesway values(@w_iaw_itemappliesway_id,'GRUPAL',@w_item_id,'P',1,0,0,'','N')

select * from fp_itemsbyproduct where ite_item_idfk = @w_item_id
select * from fp_itemappliesway where ite_item_idfk = @w_item_id

select @w_item_id_aux = ite_item_id
from fp_items
where ite_name = 'IVA_INT' 

select @w_iaw_itemappliesway_id_aux = iaw_itemappliesway_id
from fp_itemappliesway
where ite_item_idfk                 = @w_item_id_aux 
and   bp_product_idfk               = 'GRUPAL'


select dc_fields_idfk AS dc_fields_idfk, 'GRUPAL' AS bp_product_idfk, @w_item_id AS ite_item_idfk, iv_value AS iv_value
INTO #fp_itemvalues
from fp_itemvalues
where bp_product_idfk = 'GRUPAL'
and   ite_item_idfk   in ( select ite_item_id from fp_items where ite_name = 'IVA_INT')

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
iv_value = '15'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Forma de pago'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = 'P'
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
iv_value = 'S'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Rubro asociado'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update #fp_itemvalues set 
iv_value = 'INT_ESPERA'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

insert into fp_itemvalues
select * from #fp_itemvalues

select * from fp_itemvalues where ite_item_idfk    = @w_item_id

insert into fp_amountitemvalues 
select 'GRUPAL', @w_iaw_itemappliesway_id, cp_currency_idfk,
aiv_userange, aiv_rangetype, aiv_currencycharge, aiv_businessrule,
'TIVA', aiv_ratereference, aiv_minimumsign, aiv_minimum,
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

select * from fp_amountitemvalues where iaw_itemappliesway_idfk = @w_iaw_itemappliesway_id

-----------------------------------------------------------
-------------------    INT_ESPERA   -----------------------
-----------------------------------------------------------

select @w_item_id = ite_item_id
from fp_items
where ite_name = 'INT_ESPERA' 

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Prioridad'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update fp_itemvalues set 
iv_value = '15'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Forma de pago'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update fp_itemvalues set 
iv_value = 'M'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'


select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Rubro fijo'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update fp_itemvalues set 
iv_value = 'N'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Causa'
and   dfg_functionality_idfk = @w_dfg_functionality_id

update fp_itemvalues set 
iv_value = 'S'
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_dc_fields_id       = dc_fields_id
from fp_dictionaryfields     
where dc_name                = 'Rubro asociado'
and   dfg_functionality_idfk = @w_dfg_functionality_id

delete fp_itemvalues 
where dc_fields_idfk   = @w_dc_fields_id
and   ite_item_idfk    = @w_item_id
and   bp_product_idfk  = 'GRUPAL'

select @w_iaw_itemappliesway_id     = iaw_itemappliesway_id
from fp_itemappliesway
where ite_item_idfk                 = @w_item_id 
and   bp_product_idfk               = 'GRUPAL'

update fp_amountitemvalues set
aiv_valuereference = null
where iaw_itemappliesway_idfk = @w_iaw_itemappliesway_id

select * from fp_itemvalues where ite_item_idfk    = @w_item_id

select @w_dfg_functionality_id = null

--Parámetro: Gracia
select @w_dfg_functionality_id = dfg_functionality_id
from fp_dicfunctionalitygroup
where dcp_name_idfk = 'Parámetros Generales'
and   dfg_name      = 'Tabla de Amortización'

if @w_dfg_functionality_id is not null begin

   delete fp_fieldsmappings where mp_physicalfield ='dt_desplazamiento'
   delete fp_generalparametersvalues where dc_fields_idfk in (select dc_fields_id from fp_dictionaryfields where dc_name = 'Gracia')
   delete fp_generalparametershistory where dc_fields_idfk in (select dc_fields_id from fp_dictionaryfields where dc_name = 'Gracia')
   
   delete fp_dictionaryfields where dc_name = 'Gracia'
   
   select @w_dc_fields_id = max(dc_fields_id) + 1
   from fp_dictionaryfields
   
   insert into fp_dictionaryfields (dc_fields_id, dfg_functionality_idfk, dc_name, dc_description, dc_valuetype, dc_enabled, dc_modifyinherited, dc_required, dc_evaluationproduct, dc_multivalue, dc_ishead)
   values (@w_dc_fields_id, @w_dfg_functionality_id, 'Gracia', 'Gracia', 'Integer', 'S', 'S', 'N', 'N', 'N', 'N')
   
   insert into fp_fieldsmappings (dc_fields_idfk, tm_table_idfk, mp_physicalfield, mp_datatype)
   values (@w_dc_fields_id, 1, 'dt_desplazamiento', 'smallint')
   
   insert into fp_generalparametersvalues (dc_fields_idfk, bp_product_idfk, gpv_value, gpv_inheritedfrom, gpv_ruleid, gpv_rulename, gpv_description)
   values (@w_dc_fields_id, 'GRUPAL', '0', 'GRUPAL', 0, NULL, '')
   
   print 'Gracia: '+ convert(varchar, @w_dc_fields_id)
   
   select @w_dc_fields_id = null
   select @w_dc_fields_id       = dc_fields_id
   from fp_dictionaryfields     
   where dc_name                = 'Plazo'--Plazo
   and   dfg_functionality_idfk = @w_dfg_functionality_id
   
   if @w_dc_fields_id is not null begin
   
      print 'Plazo: '+ convert(varchar, @w_dc_fields_id)
      
      update fp_generalparametersvalues set 
      gpv_value = '16'
      where dc_fields_idfk  = @w_dc_fields_id
      and   bp_product_idfk = 'GRUPAL'
   
   end
   
   select @w_dc_fields_id = null
   
   select @w_dc_fields_id       = dc_fields_id
   from fp_dictionaryfields     
   where dc_name                = 'Plazo mínimo'
   and   dfg_functionality_idfk = @w_dfg_functionality_id
   
   if @w_dc_fields_id is not null begin
   
      print 'Plazo mínimo: '+ convert(varchar, @w_dc_fields_id)
      
      update fp_generalparametersvalues set 
      gpv_value = '16'
      where dc_fields_idfk  = @w_dc_fields_id
      and   bp_product_idfk = 'GRUPAL'
      
   end
   
   select @w_dc_fields_id  = null
   
   select @w_dc_fields_id       = dc_fields_id
   from fp_dictionaryfields     
   where dc_name                = 'Plazo máximo'
   and   dfg_functionality_idfk = @w_dfg_functionality_id
   
   if @w_dc_fields_id is not null begin
   
      print 'Plazo máximo: '+ convert(varchar, @w_dc_fields_id)
      
      update fp_generalparametersvalues set 
      gpv_value = '24'
      where dc_fields_idfk  = @w_dc_fields_id
      and   bp_product_idfk = 'GRUPAL'
      
   end
   
end

update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_item_id + 1 where TABLA = 'fp_items'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_iaw_itemappliesway_id + 1 where TABLA = 'fp_itemappliesway'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_dc_fields_id + 1 where TABLA = 'fp_dictionaryfields'
update cobis..CL_SEQNOS_JAVA  set SIGUIENTE = @w_fv_value_id + 1 where TABLA = 'fp_fieldvalues'

DROP TABLE #fp_itemvalues
drop table #fp_fieldvalues


GO

