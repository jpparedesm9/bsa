--==============================================================
-- Table: fp_nodetypeproduct
--==============================================================
create table fp_nodetypeproduct (
ntp_nodetype_id      numeric              not null,
ntp_nodetypeparent_idfk numeric,
ntp_name             varchar(64)          not null,
ntp_description      varchar(255),
ntp_keepdictionary   char(1),
ntp_finalproduct     char(1),
primary key (ntp_nodetype_id),
foreign key (ntp_nodetypeparent_idfk)
      references fp_nodetypeproduct (ntp_nodetype_id)
);

--==============================================================
-- Table: fp_modulegroup
--==============================================================
create table fp_modulegroup (
mog_modulegroup_id   numeric              not null,
mog_name             varchar(32),
primary key (mog_modulegroup_id)
);

--==============================================================
-- Table: fp_module
--==============================================================
create table fp_module (
mod_module_id        numeric              not null,
mog_modulegroup_idfk numeric              not null,
mod_name             varchar(64),
mod_mnemonic         varchar(10),
primary key (mod_module_id, mog_modulegroup_idfk),
foreign key (mog_modulegroup_idfk)
      references fp_modulegroup (mog_modulegroup_id)
);

--==============================================================
-- Table: fp_nodetypecategory
--==============================================================
create table fp_nodetypecategory (
ntc_productcategory_id numeric              not null,
ntp_nodetype_idfk    numeric              not null,
mod_module_fk        numeric,
mog_modulegroup_fk   numeric,
ntc_name             varchar(64)          not null,
ntc_description      varchar(255),
ntc_mnemonic         varchar(64),
primary key (ntc_productcategory_id),
foreign key (ntp_nodetype_idfk)
      references fp_nodetypeproduct (ntp_nodetype_id),
foreign key (mod_module_fk, mog_modulegroup_fk)
      references fp_module (mod_module_id, mog_modulegroup_idfk),
foreign key (mog_modulegroup_fk)
      references fp_modulegroup (mog_modulegroup_id)
);

--==============================================================
-- Table: fp_companies
--==============================================================
create table fp_companies (
com_company_id       numeric              not null,
com_parentnode       numeric,
com_name             varchar(64)          not null,
com_description      varchar(255),
primary key (com_company_id),
foreign key (com_parentnode)
      references fp_companies (com_company_id)
);

--==============================================================
-- Table: fp_bankingproducts
--==============================================================
create table fp_bankingproducts (
bp_product_id        varchar(10)          not null,
ntc_productcategory  numeric,
com_company_fk       numeric,
bp_name              varchar(40)          not null,
bp_description       varchar(255),
bp_parentnode        varchar(10),
bp_available         char(1),
bp_sector            numeric,
bp_delete            char(1),
bp_startdate         date,
bp_expirationdate    date,
bp_substantiation    varchar(255),
primary key (bp_product_id),
foreign key (ntc_productcategory)
      references fp_nodetypecategory (ntc_productcategory_id),
foreign key (com_company_fk)
      references fp_companies (com_company_id),
foreign key (bp_parentnode)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_accountingprofile
--==============================================================
create table fp_accountingprofile (
bp_product_idfk      varchar(10)          not null,
ap_transactiontype_id varchar(10)          not null,
ap_profile_id        varchar(10),
ap_filial_id         smallint             not null,
primary key (ap_transactiontype_id, bp_product_idfk, ap_filial_id),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_bankingproductshistory
--==============================================================
create table fp_bankingproductshistory (
bph_codsequential    numeric              not null,
bph_systemdate_id    date                 not null,
bph_product_id       varchar(10)          not null,
bph_processdate      date                 not null,
bph_name             varchar(40),
bph_description      varchar(255),
bph_available        char(1),
bph_startdate         date,
bph_expirationdate    date,
bph_substantiation    varchar(255),
primary key (bph_codsequential)
);

--==============================================================
-- Table: fp_accountingprofilehistory
--==============================================================
create table fp_accountingprofilehistory (
bph_codsequentialfk  numeric              not null,
aph_transactiontype_id varchar(10)          not null,
aph_profile_id       varchar(10),
aph_filial_id        smallint             not null,
aph_processdate      date,
primary key (aph_transactiontype_id, aph_filial_id, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);

--==============================================================
-- Table: fp_currencyproducts
--==============================================================
create table fp_currencyproducts (
cp_currency_id       varchar(10)          not null,
bp_product_idfk      varchar(10)          not null,
cp_status            char(1)              not null,
cp_inheritedfrom     varchar(10),
primary key (bp_product_idfk, cp_currency_id)
);

--==============================================================
-- Table: fp_items
--==============================================================
create table fp_items (
ite_item_id          numeric              not null,
ntc_productcategory_idfk numeric,
ite_name             varchar(64)          not null,
ite_description      varchar(64),
ite_valuetype        varchar(10),
ite_code             integer,
ite_dicassociate     varchar(64),
primary key (ite_item_id),
foreign key (ntc_productcategory_idfk)
      references fp_nodetypecategory (ntc_productcategory_id)
);

--==============================================================
-- Table: fp_itemsbyproduct
--==============================================================
create table fp_itemsbyproduct (
bp_product_idfk      varchar(10)          not null,
ite_item_idfk        numeric              not null,
ibp_itemtype         varchar(10),
primary key (bp_product_idfk, ite_item_idfk),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id),
foreign key (ite_item_idfk)
      references fp_items (ite_item_id)
);

--==============================================================
-- Table: fp_whenapplynodetype
--==============================================================
create table fp_whenapplynodetype (
want_applynodetype_id char(3)              not null,
want_description     varchar(20),
primary key (want_applynodetype_id)
);

--==============================================================
-- Table: fp_appliesto
--==============================================================
create table fp_appliesto (
at_appliesto_id      numeric              not null,
at_category          char(1)              not null,
at_description       char(20)             not null,
primary key (at_appliesto_id)
);

--==============================================================
-- Table: fp_appliestowhenapply
--==============================================================
create table fp_appliestowhenapply (
want_applynodetype_idfk char(3)              not null,
at_appliesto_idfk    numeric              not null,
primary key (want_applynodetype_idfk, at_appliesto_idfk),
foreign key (want_applynodetype_idfk)
      references fp_whenapplynodetype (want_applynodetype_id),
foreign key (at_appliesto_idfk)
      references fp_appliesto (at_appliesto_id)
);

--==============================================================
-- Table: fp_itemappliesway
--==============================================================
create table fp_itemappliesway (
iaw_itemappliesway_id numeric              not null,
bp_product_idfk      varchar(10)          not null,
ite_item_idfk        numeric              not null,
want_applynodetype_idfk char(3),
at_appliesto_idfk    numeric,
iaw_onwhatperiod     numeric,
iaw_onwhatperiodtype numeric,
iaw_itemreference    varchar(10),
iaw_itemincluded     char(1),
primary key (iaw_itemappliesway_id),
foreign key (bp_product_idfk, ite_item_idfk)
      references fp_itemsbyproduct (bp_product_idfk, ite_item_idfk),
foreign key (want_applynodetype_idfk, at_appliesto_idfk)
      references fp_appliestowhenapply (want_applynodetype_idfk, at_appliesto_idfk)
);

--==============================================================
-- Table: fp_amountitemvalues
--==============================================================
create table fp_amountitemvalues (
bp_product_idfk      varchar(10)          not null,
iaw_itemappliesway_idfk numeric              not null,
cp_currency_idfk     varchar(10)          not null,
aiv_userange         varchar(1),
aiv_rangetype        varchar(1),
aiv_currencycharge   varchar(10),
aiv_businessrule     varchar(50),
aiv_valuereference   varchar(10),
aiv_ratereference    varchar(10),
aiv_minimumsign      varchar(1),
aiv_minimum          numeric,
aiv_basesign         varchar(1),
aiv_base             numeric,
aiv_maximumsign      varchar(1),
aiv_maximum          numeric,
aiv_businessrulelimits varchar(50),
aiv_minimumlimittype varchar(1),
aiv_maximumlimittype varchar(1),
aiv_minimumlimit     numeric,
aiv_maximumlimit     numeric,
aiv_minimumlimitvar  varchar(10),
aiv_maximumlimitvar  varchar(10),
aiv_ratechangerate   varchar(10),
aiv_typechangerate   varchar(1),
aiv_periodchangerate numeric,
aiv_periodtypechangerate varchar(1),
aiv_formchangerate   varchar(1),
aiv_allowchangerate  varchar(1),
aiv_referenceratechangerate varchar(10),
aiv_minimumsignchangerate varchar(1),
aiv_minimumchangerate numeric,
aiv_basesignchangerate varchar(1),
aiv_basechangerate   numeric,
aiv_maximumsignchangerate varchar(1),
aiv_maximumchangerate numeric,
aiv_policy_id        integer,
aiv_policyname       varchar(40),
aiv_storedprocedure  varchar(64),
primary key (bp_product_idfk, iaw_itemappliesway_idfk, cp_currency_idfk),
foreign key (bp_product_idfk, cp_currency_idfk)
      references fp_currencyproducts (bp_product_idfk, cp_currency_id),
foreign key (iaw_itemappliesway_idfk)
      references fp_itemappliesway (iaw_itemappliesway_id)
);

--==============================================================
-- Table: fp_itemsbyproducthistory
--==============================================================
create table fp_itemsbyproducthistory (
bph_codsequentialfk  numeric              not null,
ite_item_idfk        numeric              not null,
ibph_processdate     date,
ibph_itemtype        varchar(10),
primary key (ite_item_idfk, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential),
foreign key (ite_item_idfk)
      references fp_items (ite_item_id)
);

--==============================================================
-- Table: fp_itemapplieswayhistory
--==============================================================
create table fp_itemapplieswayhistory (
bph_codsequentialfk  numeric              not null,
ite_item_idfk        numeric              not null,
iawh_itemappliesway_id numeric              not null,
iawh_processdate     date                 not null,
want_applynodetype_idfk char(3),
at_appliesto_idfk    numeric,
iawh_onwhatperiod    numeric,
iawh_onwhatperiodtype numeric,
iawh_itemreference   varchar(10),
iawh_itemincluded    char(1),
primary key (iawh_itemappliesway_id, ite_item_idfk, bph_codsequentialfk),
foreign key (ite_item_idfk, bph_codsequentialfk)
      references fp_itemsbyproducthistory (ite_item_idfk, bph_codsequentialfk)
);


--==============================================================
-- Table: fp_amountitemvalueshistory
--==============================================================
create table fp_amountitemvalueshistory (
bph_codsequentialfk   numeric              not null,
ite_item_idfk        numeric              not null,
iawh_itemappliesway_idfk numeric              not null,
cp_currency_idfk     varchar(10)          not null,
aivh_processdate     date                 not null,
aivh_userange        varchar(1),
aivh_rangetype       varchar(1),
aivh_currencycharge  varchar(10),
aivh_businessrule    varchar(50),
aivh_valuereference  varchar(10),
aivh_ratereference   varchar(10),
aivh_minimumsign     varchar(1),
aivh_minimum         numeric,
aivh_basesign        varchar(1),
aivh_base            numeric,
aivh_maximumsign     varchar(1),
aivh_maximum         numeric,
aivh_businessrulelimits varchar(50),
aivh_minimumlimittype varchar(1),
aivh_maximumlimittype varchar(1),
aivh_minimumlimit    numeric,
aivh_maximumlimit    numeric,
aivh_minimumlimitvar varchar(10),
aivh_maximumlimitvar varchar(10),
aivh_ratechangerate  varchar(10),
aivh_typechangerate  varchar(1),
aivh_periodchangerate numeric,
aivh_periodtypechangerate varchar(1),
aivh_formchangerate  varchar(1),
aivh_allowchangerate varchar(1),
aivh_referenceratechangerate varchar(10),
aivh_minimumsignchangerate varchar(1),
aivh_minimumchangerate numeric,
aivh_basesignchangerate varchar(1),
aivh_basechangerate  numeric,
aivh_maximumsignchangerate varchar(1),
aivh_maximumchangerate numeric,
aivh_policy_id       integer,
aivh_storedprocedure varchar(64),
aivh_policyname      varchar(40),
primary key (cp_currency_idfk, iawh_itemappliesway_idfk, ite_item_idfk, bph_codsequentialfk),
foreign key (iawh_itemappliesway_idfk, ite_item_idfk, bph_codsequentialfk)
      references fp_itemapplieswayhistory (iawh_itemappliesway_id, ite_item_idfk, bph_codsequentialfk)
);



--==============================================================
-- Table: fp_currencyproductshistory
--==============================================================
create table fp_currencyproductshistory (
bph_codsequentialfk  numeric              not null,
cph_currency_id      varchar(10)          not null,
cph_processdate      date                 not null,
cph_status           char(1),
cph_inheritedfrom    varchar(10),
primary key (cph_currency_id, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);

--==============================================================
-- Table: fp_productstemplates
--==============================================================
create table fp_productstemplates (
pt_template_id       char(10)             not null,
ntc_productcategory_fk numeric              not null,
pt_name              char(40)             not null,
pt_mnemonico         char(10),
primary key (pt_template_id),
foreign key (ntc_productcategory_fk)
      references fp_nodetypecategory (ntc_productcategory_id)
);

--==============================================================
-- Table: fp_currencytemplates
--==============================================================
create table fp_currencytemplates (
ct_currency_id       numeric              not null,
pt_template_idfk     char(10)             not null,
primary key (pt_template_idfk, ct_currency_id),
foreign key (pt_template_idfk)
      references fp_productstemplates (pt_template_id)
);

--==============================================================
-- Table: fp_diccompanyproducttype
--==============================================================
create table fp_diccompanyproducttype (
com_company_idfk     numeric              not null,
ntc_productcategory_idfk numeric              not null,
dcp_type_id          char(2)              not null,
dcp_name_id          varchar(64)          not null,
dcp_description      varchar(255),
dcp_itemtype         char(1),
primary key (com_company_idfk, ntc_productcategory_idfk, dcp_type_id, dcp_name_id),
foreign key (com_company_idfk)
      references fp_companies (com_company_id),
foreign key (ntc_productcategory_idfk)
      references fp_nodetypecategory (ntc_productcategory_id)
);

--==============================================================
-- Table: fp_dicfunctionalitygroup
--==============================================================
create table fp_dicfunctionalitygroup (
dfg_functionality_id numeric              not null,
com_company_idfk     numeric              not null,
ntc_productcategory_idfk numeric              not null,
dcp_type_idfk        char(2)              not null,
dcp_name_idfk        varchar(64)          not null,
dfg_name             varchar(64)          not null,
dfg_description      varchar(255)         not null,
dfg_enabled          char(1),
primary key (dfg_functionality_id),
foreign key (com_company_idfk, ntc_productcategory_idfk, dcp_type_idfk, dcp_name_idfk)
      references fp_diccompanyproducttype (com_company_idfk, ntc_productcategory_idfk, dcp_type_id, dcp_name_id)
);

--==============================================================
-- Table: fp_dictionaryfields
--==============================================================
create table fp_dictionaryfields (
dc_fields_id         numeric              not null,
dfg_functionality_idfk numeric              not null,
dc_name              varchar(64)          not null,
dc_description       varchar(255)         not null,
dc_valuetype         varchar(10)          not null,
dc_enabled           char(1),
dc_modifyinherited   char(1),
dc_required          char(1),
dc_multivalue	CHAR(1) NULL,
dc_evaluationproduct CHAR(1) DEFAULT 'N',
dc_ishead	CHAR(1) NULL,
primary key (dc_fields_id),
foreign key (dfg_functionality_idfk)
      references fp_dicfunctionalitygroup (dfg_functionality_id)
);

--==============================================================
-- Table: fp_tablesbymodule
--==============================================================
create table fp_tablesbymodule (
tm_table_id          numeric              not null,
mod_module_fk        numeric,
mog_modulegroup_fk   numeric,
tm_table             varchar(128),
tm_database          varchar(64),
tm_description       varchar(255),
tm_type              varchar(10),
primary key (tm_table_id),
foreign key (mod_module_fk, mog_modulegroup_fk)
      references fp_module (mod_module_id, mog_modulegroup_idfk)
);

--==============================================================
-- Table: fp_fieldsmappings
--==============================================================
create table fp_fieldsmappings (
dc_fields_idfk       numeric              not null,
tm_table_idfk        numeric              not null,
mp_physicalfield     varchar(32),
mp_datatype          varchar(32),
primary key (dc_fields_idfk, tm_table_idfk),
foreign key (dc_fields_idfk)
      references fp_dictionaryfields (dc_fields_id),
foreign key (tm_table_idfk)
      references fp_tablesbymodule (tm_table_id)
);

--==============================================================
-- Table: fp_fieldvalidators
--==============================================================
create table fp_fieldvalidators (
fva_validator_id     numeric              not null,
--dc_fields_fk         numeric              not null,
fva_fields_id         numeric              not null,
fva_validatortype    varchar(10)          not null,
fva_value            varchar(10),
fva_field            numeric,
fva_type			 varchar(3),
fva_apply_type       char(2) null,
primary key (fva_validator_id)
);

--==============================================================
-- Table: fp_fieldvalues
--==============================================================
create table fp_fieldvalues (
fv_value_id          numeric              not null,
--fv_fields_idfk       numeric              not null,
fv_fields_id         numeric              not null,
fv_valuesource_id    char(1)              not null,
fv_value             varchar(10)          not null,
fv_description       varchar(255)         not null,
fv_defaultvalue      char(1),
fv_type				 varchar(3)           not null, 
fv_database			 varchar(30)           not null, 
primary key (fv_value_id)
--foreign key (dc_fields_idfk)
--      references fp_dictionaryfields (dc_fields_id)
);

--==============================================================
-- Table: fp_functionalities
--==============================================================
create table fp_functionalities (
fun_functionality_id varchar(10)          not null,
fun_name             varchar(64),
fun_description      varchar(255),
fun_check            varchar(1)           not null,
primary key (fun_functionality_id)
);


--==============================================================
-- Table: fp_generalparametershistory
--==============================================================
create table fp_generalparametershistory (
bph_codsequentialfk  numeric              not null,
dc_fields_idfk       numeric              not null,
gph_processdate      date                 not null,
gph_value            varchar(10)          not null,
gph_inheritedfrom    varchar(10),
gph_ruleid           integer,
gph_rulename         varchar(40),
gph_description		 varchar(100),
primary key (bph_codsequentialfk, dc_fields_idfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential),
foreign key (dc_fields_idfk)
      references fp_dictionaryfields (dc_fields_id)
);


--==============================================================
-- Table: fp_generalparametersvalues
--==============================================================
create table fp_generalparametersvalues (
dc_fields_idfk       numeric              not null,
bp_product_idfk      varchar(10)          not null,
gpv_value            varchar(10)          not null,
gpv_inheritedfrom    varchar(10),
gpv_ruleid           integer,
gpv_rulename         varchar(40),
gpv_description VARCHAR (100) NULL,
primary key (dc_fields_idfk, bp_product_idfk, gpv_value),
foreign key (dc_fields_idfk)
      references fp_dictionaryfields (dc_fields_id),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_servicestransactions
--==============================================================
create table fp_servicestransactions (
st_servicetransaction_id char(10)             not null,
ntc_productcategory_idfk numeric              not null,
st_name                  char(30)		 not null,	
st_description       char(80)             not null,
st_type              char(1)              not null,
st_status              char(1)              not null,

primary key (st_servicetransaction_id, ntc_productcategory_idfk),
foreign key (ntc_productcategory_idfk)
      references fp_nodetypecategory (ntc_productcategory_id)
);


--==============================================================*/
-- Table: fp_servtranbankingproduct                             */
--==============================================================*/
create table fp_servtranbankingproduct (
   sbp_id               numeric                        not null,
   st_servicetransaction_idfk char(10)                       not null,
   ntc_productcategory_idfk numeric                        not null,
   bp_product_idfk      varchar(10)                    not null,
   sbp_available        char(1)                        null,
   primary key (sbp_id),
   foreign key (st_servicetransaction_idfk, ntc_productcategory_idfk)
      references fp_servicestransactions (st_servicetransaction_id, ntc_productcategory_idfk),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================*/
-- Table: fp_itemproducttransaction                             */
--==============================================================*/
create table fp_itemproducttransaction (
   ipt_name_id          varchar(64)                    not null,
   sbp_id               numeric                        not null,
   ite_item_idfk        numeric                        not null,
   bp_product_idfk      varchar(10)                    not null,
   ipt_calculates       char(1)                        not null,
primary key (ipt_name_id),   
foreign key (sbp_id)
      references fp_servtranbankingproduct (sbp_id),   
 foreign key (bp_product_idfk, ite_item_idfk)
      references fp_itemsbyproduct (bp_product_idfk, ite_item_idfk)  
);

--==============================================================
-- Table: fp_itemscategory
--==============================================================
create table fp_itemscategory (
ic_itemscategory_id  numeric              not null,
ic_description       varchar(20),
primary key (ic_itemscategory_id)
);

--==============================================================
-- Table: fp_itemstatus
--==============================================================
create table fp_itemstatus (
bp_product_idfk      varchar(10)          not null,
ite_item_idfk        numeric              not null,
is_status_id         smallint             not null,
is_startdays         integer,
is_finishdays        integer,
primary key (bp_product_idfk, ite_item_idfk, is_status_id),
foreign key (bp_product_idfk, ite_item_idfk)
      references fp_itemsbyproduct (bp_product_idfk, ite_item_idfk)
);

--==============================================================
-- Table: fp_itemstatushistory
--==============================================================
create table fp_itemstatushistory (
bph_codsequentialfk  numeric              not null,
ite_item_id          numeric              not null,
ish_status_id        smallint             not null,
ish_startdays        integer,
ish_finishday        integer,
ish_processdate      date,
primary key (ite_item_id, ish_status_id, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);


--==============================================================
-- Table: fp_itemvalues
--==============================================================
create table fp_itemvalues (
dc_fields_idfk       numeric              not null,
bp_product_idfk      varchar(10)          not null,
ite_item_idfk        numeric              not null,
iv_value             varchar(10)          not null,
primary key (dc_fields_idfk, bp_product_idfk, ite_item_idfk),
foreign key (dc_fields_idfk)
      references fp_dictionaryfields (dc_fields_id),
foreign key (bp_product_idfk, ite_item_idfk)
      references fp_itemsbyproduct (bp_product_idfk, ite_item_idfk)
);

--==============================================================
-- Table: fp_itemvalueshistory
--==============================================================
create table fp_itemvalueshistory (
bph_codsequentialfk  numeric              not null,
ite_item_idfk        numeric              not null,
dc_fields_idfk       numeric              not null,
ivh_processdate      date                 not null,
ivh_value            varchar(10)          not null,
primary key (bph_codsequentialfk, dc_fields_idfk, ite_item_idfk),
foreign key (ite_item_idfk, bph_codsequentialfk)
      references fp_itemsbyproducthistory (ite_item_idfk, bph_codsequentialfk)
);

--==============================================================
-- Table: fp_mappingtypegroup
--==============================================================
create table fp_mappingtypegroup (
mtg_group_id         varchar(10)          not null,
mtg_type_id          varchar(10)          not null,
mod_module_idfk      numeric              not null,
mog_modulegroup_idfk numeric              not null,
primary key (mtg_group_id, mtg_type_id, mod_module_idfk, mog_modulegroup_idfk),
foreign key (mod_module_idfk, mog_modulegroup_idfk)
      references fp_module (mod_module_id, mog_modulegroup_idfk)
);

--==============================================================
-- Table: fp_nodecategoryfunctionalities
--==============================================================
create table fp_nodecategoryfunctionalities (
ncf_order_id         smallint,
ntc_productcategory_idfk numeric              not null,
fun_functionality_idfk varchar(10)          not null,
primary key (ntc_productcategory_idfk, fun_functionality_idfk),
foreign key (ntc_productcategory_idfk)
      references fp_nodetypecategory (ntc_productcategory_id),
foreign key (fun_functionality_idfk)
      references fp_functionalities (fun_functionality_id)
);

--==============================================================
-- Table: fp_nodetypefunctionalities
--==============================================================
create table fp_nodetypefunctionalities (
ntf_order_id         smallint             not null,
fun_functionality_idfk varchar(10)          not null,
ntp_nodetype_idfk    numeric              not null,
primary key (fun_functionality_idfk, ntp_nodetype_idfk),
foreign key (fun_functionality_idfk)
      references fp_functionalities (fun_functionality_id),
foreign key (ntp_nodetype_idfk)
      references fp_nodetypeproduct (ntp_nodetype_id)
);

--==============================================================
-- Table: fp_operationstatus
--==============================================================
create table fp_operationstatus (
bp_product_idfk      varchar(10)          not null,
os_changetype        char(1)              not null,
os_initialstatus_id  smallint             not null,
os_finalstatus_id    smallint             not null,
os_startdays         integer,
os_finishdays        integer,
primary key (bp_product_idfk, os_changetype, os_initialstatus_id, os_finalstatus_id),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_operationstatushistory
--==============================================================
create table fp_operationstatushistory (
bph_codsequentialfk  numeric              not null,
osh_changetype       char(1)              not null,
osh_initialstatus_id smallint             not null,
osh_finalstatus_id   smallint             not null,
osh_startdays        integer,
osh_finishdays       integer,
osh_processdate      date,
primary key (osh_changetype, osh_initialstatus_id, osh_finalstatus_id, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);


--==============================================================
-- Table: fp_policiesbyproduct
--==============================================================
create table fp_policiesbyproduct (
pp_policy_id         integer              not null,
bp_product_idfk      varchar(10)          not null,
cp_currency_idfk     varchar(10)          not null,
pp_policyname        varchar(64),
pp_inheritedfrom     varchar(10),
primary key (pp_policy_id, bp_product_idfk, cp_currency_idfk),
foreign key (bp_product_idfk, cp_currency_idfk)
      references fp_currencyproducts (bp_product_idfk, cp_currency_id)
);

--==============================================================
-- Table: fp_policiesbyproducthistory
--==============================================================
create table fp_policiesbyproducthistory (
pph_policy_id        integer              not null,
cph_currency_idfk    varchar(10)          not null,
bph_codsequentialfk  numeric              not null,
pph_processdate      date,
pph_inheritedfrom    varchar(10),
pph_policyname       varchar(64),
primary key (pph_policy_id, cph_currency_idfk, bph_codsequentialfk),
foreign key (cph_currency_idfk, bph_codsequentialfk)
      references fp_currencyproductshistory (cph_currency_id, bph_codsequentialfk)
);

--==============================================================
-- Table: fp_processbymodule
--==============================================================
create table fp_processbymodule (
mod_module_idfk      numeric              not null,
mog_modulegroup_idfk numeric              not null,
pm_process_id        varchar(10)          not null,
primary key (mod_module_idfk, mog_modulegroup_idfk, pm_process_id),
foreign key (mod_module_idfk, mog_modulegroup_idfk)
      references fp_module (mod_module_id, mog_modulegroup_idfk)
);

--==============================================================
-- Table: fp_processbyproduct
--==============================================================
create table fp_processbyproduct (
bp_product_idfk      varchar(10)          not null,
pp_flow_id           varchar(32)          not null,
pp_processbyproduct_id numeric              not null,
pp_process_id        varchar(10),
pp_generic           char(1),
pp_processname       varchar(64),
pp_notgeneric        char(1),
pp_creditline        char(1),
primary key (bp_product_idfk, pp_flow_id, pp_processbyproduct_id),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_rulesbyproduct                                     
--==============================================================
create table fp_rulesbyproduct (
bp_product_idfk      varchar(10)                    not null,
rp_rule_id           int                            not null,
rp_rulesbyproduct_id numeric                        not null,
rp_rule_name         varchar(40)                    null,
primary key (bp_product_idfk, rp_rule_id, rp_rulesbyproduct_id),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_processbyproducthistory
--==============================================================
create table fp_processbyproducthistory (
pph_flow_id          varchar(32)          not null,
pph_process_id       varchar(10)          not null,
pp_processbyproduct_id numeric              not null,
bph_codsequentialfk  numeric              not null,
pph_generic          char(1),
pph_processdate      date                 not null,
pph_processname      varchar(64),
pph_notgeneric       char(1),
pph_creditline       char(1),
primary key (pph_flow_id, pp_processbyproduct_id, bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);

--==============================================================
--Table: fp_rulesbyproducthistory                              
--==============================================================
create table fp_rulesbyproducthistory (
bph_codsequentialfk  numeric                        not null,
rph_rule_id          int                            not null,
rp_rulesbyproduct_id numeric                        not null,
rph_rule_name        varchar(40)                    null,
rph_processdate      datetime                       not null,
primary key (bph_codsequentialfk, rph_rule_id, rp_rulesbyproduct_id),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);

--==============================================================
-- Table: fp_productauthorization
--==============================================================
create table fp_productauthorization (
bp_product_idfk      varchar(10)          not null,
pa_processid         varchar(32),
pa_status            char(1),
pa_username          varchar(32),
pa_terminal        varchar(32),
primary key (bp_product_idfk),
foreign key (bp_product_idfk)
      references fp_bankingproducts (bp_product_id)
);

--==============================================================
-- Table: fp_productauthorizationhistory
--==============================================================
create table fp_productauthorizationhistory (
bph_codsequentialfk  numeric              not null,
pah_processid        varchar(32),
pah_status           char(1),
pah_requestusername  varchar(32),
pah_requestterminal varchar(32),
pah_authorizationusername varchar(32),
pah_authorizationterminal varchar(32),
primary key (bph_codsequentialfk),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);


--==============================================================
-- Table: fp_servtrantemplates
--==============================================================
create table fp_servtrantemplates (
pt_template_idfk     char(10)             not null,
st_servicetransaction_idfk char(10)             not null,
ntc_productcategory_idfk numeric              not null,
primary key (pt_template_idfk, st_servicetransaction_idfk, ntc_productcategory_idfk),
foreign key (pt_template_idfk)
      references fp_productstemplates (pt_template_id),
foreign key (st_servicetransaction_idfk, ntc_productcategory_idfk)
      references fp_servicestransactions (st_servicetransaction_id, ntc_productcategory_idfk)
);

--==============================================================
-- Table: fp_whenapplyitemscategory
--==============================================================
create table fp_whenapplyitemscategory (
ic_itemscategory_idfk numeric              not null,
want_applynodetype_idfk char(3)              not null,
primary key (ic_itemscategory_idfk, want_applynodetype_idfk),
foreign key (want_applynodetype_idfk)
      references fp_whenapplynodetype (want_applynodetype_id),
foreign key (ic_itemscategory_idfk)
      references fp_itemscategory (ic_itemscategory_id)
);

--==============================================================*/
-- Table: fp_catalogsbyproduct                                  */
--==============================================================*/
create table fp_catalogsbyproduct (
   cp_catalogproduct_id numeric                        not null,
   bp_product_fk        varchar(10)                    not null,
   cp_code              varchar(10)                    not null,
   cp_type              char(1)                        not null,
   primary key (cp_catalogproduct_id),
   foreign key (bp_product_fk)
      references fp_bankingproducts (bp_product_id)   
);

--==============================================================
-- Table: fp_catalogsbyproducthistory
--==============================================================
create table fp_catalogsbyproducthistory (
   bph_codsequentialfk  numeric              not null,
   cph_code_id          varchar(10)                    not null,
   cph_type_id          char(1)                        not null,
cph_processdate      date,
primary key (bph_codsequentialfk, cph_code_id, cph_type_id),
foreign key (bph_codsequentialfk)
      references fp_bankingproductshistory (bph_codsequential)
);

--==============================================================
-- Table: fp_servicestransactionfield
--==============================================================
create table fp_servicestransactionfield (
	stf_fields_id numeric not null,
	dfg_functionality_idfk numeric not null,
	stf_name varchar(64) not null,
	stf_description varchar(255) not null,
	stf_valuetype varchar(10) not null,
	stf_enabled char(1) null,
	stf_modifyinherited char(1) null,
	stf_required char(1) null,
	primary key (stf_fields_id),
	foreign key (dfg_functionality_idfk)
		references fp_dicfunctionalitygroup (dfg_functionality_id)
);

--==============================================================
-- Table: fp_transactionfieldvalues
--==============================================================
create table fp_transactionfieldvalues (
	tfv_value_id numeric not null,
	stf_fields_idfk numeric not null,
	st_servicetransaction_idfk char(10)  	not null,
	ntc_productcategory_idfk numeric    not null,
	tfv_valuesource_id char(1) not null,
	tfv_value varchar(32) not null,
	tfv_description varchar(255) null,
	tfv_defaultvalue char(1) null,
	primary key (tfv_value_id),
	foreign key (stf_fields_idfk)
		references fp_servicestransactionfield (stf_fields_id),
	foreign key (st_servicetransaction_idfk, ntc_productcategory_idfk)
      references fp_servicestransactions (st_servicetransaction_id, ntc_productcategory_idfk)
);

--==============================================================*/
-- Table: fp_paymenttypefields                                  */
--==============================================================*/
/*==============================================================*/
/* Table: fp_paymenttypefields                                  */
/*==============================================================*/
create table fp_paymenttypefields (
   pt_fields_id         numeric                        not null,
   dfg_functionality_idfk numeric                      not null,
   pt_name              varchar(64)                    null,
   pt_description       varchar(255)                   null,
   pt_valuetype         varchar(10)                    null,
   pt_enabled           char(1)                        null,
   pt_modifyinherited   char(1)                        null,
   pt_required          char(1)                        null,
   primary key (pt_fields_id),
   foreign key (dfg_functionality_idfk)
      references fp_dicfunctionalitygroup (dfg_functionality_id)
);

--==============================================================*/
-- Table: fp_collectionpaymenttype                              */
--==============================================================*/
create table fp_collectionpaymenttype (
   cpt_mnemonic         varchar(10)                    not null,
   cpt_name             varchar(64)                    not null,
   cpt_description      varchar(255)                   not null,
   cpt_type             char(1)                        null,
   primary key (cpt_mnemonic)
);

--==============================================================*/
-- Table: fp_paymenttypefieldsvalues                            */
--==============================================================*/
create table fp_paymenttypefieldsvalues (
   ptv_value_id         numeric                        not null,
   pt_fields_idfk       numeric                        not null,
   cpt_mnemonic_fk      varchar(10)                    not null,
   ptv_valuesource_id   char(1)                        not null,
   ptv_value            varchar(32)                    not null,
   ptv_description      varchar(255)                   null,
   ptv_defaultvalue     char(1)                        null,
   primary key (ptv_value_id),
   foreign key (cpt_mnemonic_fk)
       references fp_collectionpaymenttype (cpt_mnemonic),
   foreign key (pt_fields_idfk)
       references fp_paymenttypefields (pt_fields_id)   
);



--==============================================================*/
-- Table: fp_transactionchannels                                */
--==============================================================*/
create table fp_transactionchannels (
   tc_id                numeric                        not null,
   sbp_idfk             numeric                        not null,
   tc_channel           varchar(10)                 null,
   
   primary key (tc_id),
   foreign key (sbp_idfk)
       references fp_servtranbankingproduct (sbp_id)       
);

--==============================================================*/
-- Table: fp_channelpayments                                    */
--==============================================================*/
create table fp_channelpayments (
   cp_id                numeric                        not null,
   tc_idfk              numeric                        not null,
   cpt_mnemonicfk       varchar(10)                    not null,
   
   primary key (cp_id),
   foreign key (tc_idfk)
       references fp_transactionchannels (tc_id),
   foreign key (cpt_mnemonicfk)
       references fp_collectionpaymenttype (cpt_mnemonic)
);
--==============================================================*/
-- Table: fp_transactionchannelsbase                            */
--==============================================================*/
create table fp_transactionchannelsbase (
   tcb_id               numeric                        not null,
   st_servicetransaction_idfk char(10)                       null,
   ntc_productcategory_idfk numeric                        null,
   tcb_channel          varchar(10)                    null,
   primary key (tcb_id),
   foreign key (st_servicetransaction_idfk, ntc_productcategory_idfk) references fp_servicestransactions (st_servicetransaction_id, ntc_productcategory_idfk)
);
--==============================================================*/
-- Table: fp_channelpaymentsbase                                */
--==============================================================*/
create table fp_channelpaymentsbase (
   cpb_id               numeric                        not null,
   tcb_idfk             numeric                        not null,
   cpt_mnemonicfk       varchar(10)                    not null,
   primary key (cpb_id),
   foreign key (cpt_mnemonicfk) references fp_collectionpaymenttype (cpt_mnemonic),
   foreign key (tcb_idfk) references fp_transactionchannelsbase (tcb_id)
);

--create table fp_grlparametersmultivalues (
--	gpmv_dc_fields_idfk    NUMERIC not NULL,
--	gpmv_bp_product_idfk   varchar(10) not NULL,
--	gpmv_value         varchar(100) not NULL,
--	primary key (gpmv_dc_fields_idfk, gpmv_bp_product_idfk),
--	foreign key (gpmv_dc_fields_idfk, gpmv_bp_product_idfk) references fp_generalparametersvalues (dc_fields_idfk, bp_product_idfk)
--);


/*==============================================================*/
/* Table: fp_fieldsbyproduct                                    */
/*==============================================================*/
create table fp_fieldsbyproduct (
   bp_product_idfk      varchar(10)                    not null,
   dc_fields_idfk       numeric                        not null,
   fp_mandatory         bit                            not null,
   fp_order             numeric                        null,
   constraint pk_fp_fieldsbyproduct primary key (bp_product_idfk, dc_fields_idfk)
)

/*==============================================================*/
/* Table: fp_unitfunctionalityvalues                            */
/*==============================================================*/
create table fp_unitfunctionalityvalues (
   registryid           numeric                        not null,
   dc_fields_id_fk      numeric                        not null,
   bp_product_id_fk     varchar(10)                    not null,
   uf_value             varchar(10)                    not null,
   uf_description		varchar(100)				   null,
   constraint pk_fp_unitfunctionalityvalues primary key (registryid, dc_fields_id_fk, bp_product_id_fk)
);

/*==============================================================*/
/* Table: fp_fieldsbyproductvalues                              */
/*==============================================================*/
create table fp_fieldsbyproductvalues (
   fpv_request          varchar(50)                    not null,
   bp_product_idfk      varchar(10)                    not null,
   dc_fields_idfk       numeric                        not null,
   fpv_value            varchar(64)                    not null,
   constraint pk_fp_fieldsbyproductvalues primary key (fpv_request, bp_product_idfk, dc_fields_idfk)
);
CREATE SCHEMA cobis AUTHORIZATION DBA;
--Sequential table
create table cobis.CL_SEQNOS_JAVA (
	BDATOS                          varchar(30)                          null,
	TABLA                           varchar(30)                      not null,
	SIGUIENTE                       int                                  null,
	PKEY                            varchar(30)                          null,
	primary key (TABLA)
);


CREATE TABLE fp_unitfunctionalityvalueshist
	(
	bph_codsequentialfk NUMERIC (18) NOT NULL,
	gph_processdate     DATETIME NOT NULL,
	h_registryid        NUMERIC (18) NOT NULL,
	dch_fields_id_fk    NUMERIC (18) NOT NULL,
	bph_product_id_fk   VARCHAR (10) NOT NULL,
	ufh_value           VARCHAR (50) NOT NULL,
	CONSTRAINT pk_fp_ufunctionalityvalhistory PRIMARY KEY (bph_codsequentialfk,h_registryid,dch_fields_id_fk,bph_product_id_fk),
	CONSTRAINT fk_fp_ufvreference_fp_bankhist FOREIGN KEY (bph_product_id_fk) REFERENCES fp_bankingproducts (bp_product_id),
	CONSTRAINT fk_fp_ufvreference_fp_dicthist FOREIGN KEY (dch_fields_id_fk) REFERENCES fp_dictionaryfields (dc_fields_id),
	CONSTRAINT fk_fp_ufvreference_fp_sechist FOREIGN KEY (bph_codsequentialfk) REFERENCES fp_bankingproductshistory (bph_codsequential)
	)





