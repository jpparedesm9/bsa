// (Button) 
    task.executeCommand.CM_TLIBERAT_T16 = function(entities, executeCommandEventArgs) {
        //executeCommandEventArgs.commons.execServer = true;
       
       
			var msgConfirm = "WRRNT.LBL_WRRNT_ESTSEGUEN_20114";
			
			return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm(msgConfirm).then(function(resp){
				var response = false;
				switch(resp.buttonIndex){
					case 0 : //CANCEL
							executeCommandEventArgs.commons.execServer = false;
							break;
					case 1 : //ACCEPT													
				            executeCommandEventArgs.commons.execServer = true;
							response = true;
							break;
				}
				return response;
			});
        
        

    };