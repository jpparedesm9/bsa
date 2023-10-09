//Start signature to callBack event to CM_EJTDI03AVE03
    task.executeCommandCallback.CM_EJTDI03AVE03 = function(entities, executeCommandCallbackEventArgs) {
        //here your code
		
		//Habilito el boton de acciones del contenedor inbox
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		
		executeCommandCallbackEventArgs.commons.execServer = false;     
    };