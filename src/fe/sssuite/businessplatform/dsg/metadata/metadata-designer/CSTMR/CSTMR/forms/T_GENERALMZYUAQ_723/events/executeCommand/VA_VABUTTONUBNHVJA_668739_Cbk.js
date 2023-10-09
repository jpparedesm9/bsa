//Start signature to callBack event to VA_VABUTTONUBNHVJA_668739
task.executeCommandCallback.VA_VABUTTONUBNHVJA_668739 = function (entities, executeCommandCallbackEventArgs) {
    var controls = [];
    if (executeCommandCallbackEventArgs.success) {
        if (entities.Person.operation == 'I') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSRXH_631566', true);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSLJO_139566', true);
        } else if (entities.Person.operation == 'U') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818', '', 2000, false);
        }

        if (entities.NaturalPerson.bioRenapo == 'S') {
            executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_SSC');
        }

        /*Se comenta por Biométricos, se activan los campos*/
        /*controls =  [
                'VA_TEXTINPUTBOXBFT_518739','VA_TEXTINPUTBOXWXT_116739','VA_TEXTINPUTBOXVEC_991739','VA_TEXTINPUTBOXBXR_146739',                      
                'VA_TEXTINPUTBOXFGQ_850739','VA_DOCUMENTTYPEFZR_461739','VA_TEXTINPUTBOXNJK_823739','VA_DATEFIELDEXOTID_585739',
                'VA_EMAILVIWJAKIOCI_922739','VA_TEXTINPUTBOXGXM_696739','VA_DATEFIELDKWUZZN_303739','VA_TEXTINPUTBOXJOG_550739',
                'VA_TEXTINPUTBOXECU_912739','VA_TEXTINPUTBOXHWM_415739','VA_TEXTINPUTBOXVJE_867739','VA_TEXTINPUTBOXNVW_269739',
                'VA_TEXTINPUTBOXDTF_989739','VA_TEXTINPUTBOXDFU_862739','VA_TEXTINPUTBOXDYK_693739','VA_TEXTINPUTBOXXGF_770739',
                'VA_DATEFIELDKPKNOQ_427739','VA_BIRTHDATEHFEDFC_460739','VA_TEXTINPUTBOXTMT_413739','VA_TEXTINPUTBOXBNS_113739',
                'VA_TEXTINPUTBOXKUG_213739','VA_TEXTINPUTBOXNLL_783739','VA_TEXTINPUTBOXDXR_200739',
                'VA_TEXTINPUTBOXXTK_742739','VA_EMAILADDRESSOAU_817739','VA_GENDERCODEVBBDG_772739', 'VA_9419JJQLECKWUON_319739',
                'VA_COUNTYOFBIRTHHH_490739','VA_COUNTRYOFBIRHTH_170739'];*/
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4', true);
        //task.disableFields (executeCommandCallbackEventArgs, controls, true);

        if (entities.LegalPerson.personSecuential != null) {
            entities.CustomerTmp.code = entities.LegalPerson.personSecuential;
        } else if (entities.NaturalPerson.personSecuential != null) {
            entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;
        }
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VC_OHGJMSCFAL_971769');

        if (entities.Context.renapoByCurp == 'S') {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MR6', true);
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXNJK_823739');
        }
    } else {
        if (entities.Context.renapoByCurp == 'S') {
            executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MR6', true);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXNJK_823739');
        }
    }
};
