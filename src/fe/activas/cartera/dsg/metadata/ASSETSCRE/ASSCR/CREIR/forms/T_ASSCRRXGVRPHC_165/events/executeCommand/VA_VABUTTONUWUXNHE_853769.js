// (Button) 
    task.executeCommand.VA_VABUTTONUWUXNHE_853769 = function(  entities, executeCommandEventArgs ) {
        entities.Amount.operation=entities.LoginCallCenter.opration
        
        if(entities.Amount.amountApproved==undefined ||entities.Amount.amountApproved==null || entities.Amount.amountApproved==='')
            {
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELMONTOTR_31505', true)
            }
        else{
            executeCommandEventArgs.commons.execServer = true;
        }
    
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };