//Start signature to callBack event to VC_EYWRY63_FMRRT_302
    task.initDataCallback.VC_EYWRY63_FMRRT_302 = function(entities, initDataEventArgs) {
        if(entities.OriginalHeader.TypeRequest != FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
			BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
		}		
		task.loadTaskHeader(entities,initDataEventArgs);
   
    };