update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(com_company_id),0) + 1 from cob_fpm..fp_companies) where TABLA = "fp_companies"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(ntp_nodetype_id),0) + 1 from cob_fpm..fp_nodetypeproduct) where TABLA = "fp_nodetypeproduct"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(ntc_productcategory_id),0) + 1 from cob_fpm..fp_nodetypecategory) where TABLA = "fp_nodetypecategory"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(dfg_functionality_id),0) + 1 from cob_fpm..fp_dicfunctionalitygroup) where TABLA = "fp_dicfunctionalitygroup"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(dc_fields_id),0) + 1 from cob_fpm..fp_dictionaryfields) where TABLA = "fp_dictionaryfields"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(fv_value_id),0) + 1 from cob_fpm..fp_fieldvalues) where TABLA = "fp_fieldvalues"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(iaw_itemappliesway_id),0) + 1 from cob_fpm..fp_itemappliesway) where TABLA = "fp_itemappliesway"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(ite_item_id),0) + 1 from cob_fpm..fp_items) where TABLA = "fp_items"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(pp_processbyproduct_id),0) + 1 from cob_fpm..fp_processbyproduct) where TABLA = "fp_processbyproduct"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(bph_codsequential),0) + 1 from cob_fpm..fp_bankingproductshistory) where TABLA = "fp_bankingproductshistory"
update cobis..CL_SEQNOS_JAVA set SIGUIENTE = (select isnull(max(cp_catalogproduct_id),0) + 1 from cob_fpm..fp_catalogsbyproduct) where TABLA = "fp_catalogsbyproduct"

go
