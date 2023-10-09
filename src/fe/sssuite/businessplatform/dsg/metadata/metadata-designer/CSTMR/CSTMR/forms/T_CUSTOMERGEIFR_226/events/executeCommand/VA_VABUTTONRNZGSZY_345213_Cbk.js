//Start signature to Callback event to VA_VABUTTONRNZGSZY_345213
    task.executeCommandCallback.VA_VABUTTONRNZGSZY_345213 = function(entities, executeCommandCallbackEventArgs) {
        if(executeCommandCallbackEventArgs.success){
			//Open Modal
			var nav = executeCommandCallbackEventArgs.commons.api.navigation;

			nav.address = {
				moduleId: 'CSTMR',
				subModuleId: 'CSTMR',
				taskId: 'T_CSTMRNJOIOJFD_116',
				taskVersion: '1.0.0',
				viewContainerId: 'VC_REPLACEAII_570116'
			};
			nav.queryParameters = {
				mode: 2
			};
			nav.modalProperties = {
				size: 'md',
				callFromGrid: false
			};
			nav.customDialogParameters = {
                personSecuential: entities.NaturalPerson.personSecuential,
				oldAccount: entities.Context.accountIndividual,
				newAccount: entities.NaturalPerson.accountIndividual
			};
			nav.openModalWindow(executeCommandCallbackEventArgs.commons.controlId, null);
		} else {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_OCURRIONR_93100');
        }
    };