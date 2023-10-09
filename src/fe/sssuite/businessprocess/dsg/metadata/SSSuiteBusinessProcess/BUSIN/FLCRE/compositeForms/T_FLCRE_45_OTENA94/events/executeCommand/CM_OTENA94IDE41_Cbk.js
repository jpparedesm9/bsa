// (Button) Eliminar
    task.executeCommandCallback.CM_OTENA94IDE41 = function(entities, executeCommandEventArgs) {
        task.setSecurity(entities, executeCommandCallbackEventArgs , 'CM_OTENA94IDE41');
		if(task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES') {
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
		if(entities.HeaderPunishment.Status===FLCRE.CONSTANTS.StatusPenalization.Processed && task.Type === FLCRE.CONSTANTS.OfficerType.CreditAnalyst){
			var menu = cobis.translate('BUSIN.DLB_BUSIN_OECIEAATA_43936');
			BUSIN.INBOX.STATUS.openNewTab(task.ApplicationNumber,menu);
		}
    };