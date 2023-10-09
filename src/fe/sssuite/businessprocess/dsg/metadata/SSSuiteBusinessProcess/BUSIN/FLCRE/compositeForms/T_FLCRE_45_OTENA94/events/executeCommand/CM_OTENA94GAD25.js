// (Button) Guardar
    task.executeCommand.CM_OTENA94GAD25 = function(entities, executeCommandEventArgs) {
        if(!task.validateStatus(entities, executeCommandEventArgs,true)){
			executeCommandEventArgs.commons.execServer = false;//JRU false
			return;
		}
		
		for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
			if (row.Recommended === false && ( row.Observation === null ||  row.Observation.trim() === '' ) && row.Status=='R'){
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('DSGNR.SYS_DSGNR_LBLERRCNS_00025',null,6000);
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
		}
		BUSIN.API.disable(executeCommandEventArgs.commons.api.viewState,['CM_OTENA94COM63']);
    };