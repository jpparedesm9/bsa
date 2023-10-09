// (Button) 
    task.executeCommand.CM_TASSTSCX_S1_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
        if (entities.Loan.clientID == null)
        {
          executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ESNECESNI_47620", true);
        }else
        {
            var itemReporte = "PreCancellation";
            var args = [['clientID', entities.Loan.clientID],  ['amountPRE', entities.PreCancellation.amountPRE]]
            var tittle = cobis.translate('ASSTS.LBL_ASSTS_REFERENIN_30495');
	   	   ASSETS.Utils.generarReporte (itemReporte, args, tittle);
        }
    };