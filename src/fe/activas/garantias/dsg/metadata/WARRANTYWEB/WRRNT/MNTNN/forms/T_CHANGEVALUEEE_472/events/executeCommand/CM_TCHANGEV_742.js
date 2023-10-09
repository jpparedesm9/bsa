// (Button) 
    task.executeCommand.CM_TCHANGEV_742 = function(entities, executeCommandEventArgs) {
        //var msgConfirm = "WRRNT.LBL_WRRNT_ESTSEGUCM_38694";
        var newValue = 0.0;
        
        if (entities.Warranty.percent==0)
            newValue = entities.GenericTransaction.newValue;
        else
            newValue = entities.GenericTransaction.newValue*entities.Warranty.percent/100;
            
        var msgConfirmPercent = cobis.translate("WRRNT.LBL_WRRNT_ESTSEGUCM_38694");
        var msgConfirmNewValue = cobis.translate("WRRNT.LBL_WRRNT_ESTSEGUGL_81455");
        
        var msgConfirm= msgConfirmPercent +" " + entities.Warranty.percent +" "+ msgConfirmNewValue +" "+ newValue;

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