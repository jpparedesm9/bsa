//Start signature to callBack event to CM_TPAYMENT_TM7
    task.executeCommandCallback.CM_TPAYMENT_TM7 = function(entities, executeCommandEventArgs) {
        //here your code
         executeCommandEventArgs.commons.execServer = false;
		var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };