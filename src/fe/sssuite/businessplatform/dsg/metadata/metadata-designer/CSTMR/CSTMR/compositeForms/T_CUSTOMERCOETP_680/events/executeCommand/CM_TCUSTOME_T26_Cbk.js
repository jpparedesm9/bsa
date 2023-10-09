//Start signature to callBack event to CM_TCUSTOME_T26
task.executeCommandCallback.CM_TCUSTOME_T26 = function (entities, executeCommandCallbackEventArgs) {
    //here your code
    //var references = entities.References.data();
	 
	if(entities.EconomicInformation.businessYears == null){
        entities.EconomicInformation.businessYears = 0;
    }
	 
    if (executeCommandCallbackEventArgs.success) {
        //Set del campo HiddenInCompleted para poder continuar la tarea
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        if (executeCommandCallbackEventArgs.commons.api.parentVc != null && executeCommandCallbackEventArgs.commons.api.parentVc != undefined) {
            if (executeCommandCallbackEventArgs.commons.api.parentVc.model != null && executeCommandCallbackEventArgs.commons.api.parentVc.model != undefined && executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
                executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
            }
        }
        if (section != null) {
            var response = {
                operation: "U"
                , section: section
                , clientId: entities.NaturalPerson.personSecuential
            };
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.responseEvent(response);
        }
        
        if((entities.NaturalPerson.maritalStatusCode === casado)||(entities.NaturalPerson.maritalStatusCode === unionLibre)){
           // executeCommandCallbackEventArgs.commons.api.viewState.show('VC_GQKQIIYSWN_251604');
        } else {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
        }
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_2_9');
		executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TCUSTOME_T6S');
    }
    else {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
};