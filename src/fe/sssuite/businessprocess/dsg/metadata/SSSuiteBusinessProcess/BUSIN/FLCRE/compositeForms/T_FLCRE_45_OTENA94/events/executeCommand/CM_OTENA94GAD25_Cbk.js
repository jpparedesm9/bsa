// (Button) Guardar
    task.executeCommandCallback.CM_OTENA94GAD25 = function(entities, executeCommandEventArgs) {
        task.setSecurity(entities, executeCommandEventArgs , 'CM_OTENA94GAD25');
		//seteo de boton 
		if(entities.Punishment!=null){
			for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
				if(row.Recommended ===false){
					$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
				}
			}
		}
		if((task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') 
			|| (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES' 
				&& entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed)
		){
			BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);			
		}	
    };