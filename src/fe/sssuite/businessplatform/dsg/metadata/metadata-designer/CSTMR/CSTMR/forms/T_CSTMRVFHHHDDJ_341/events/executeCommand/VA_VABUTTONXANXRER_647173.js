//Entity: WarningRisk
    //WarningRisk. (Button) View: ViewAlertsEditForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXANXRER_647173 = function(  entities, executeCommandEventArgs ) {
        
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("CSTMR.LBL_CSTMR_ESTSEGUUC_16115").then(function(resp){
        switch(resp.buttonIndex){
            case 0 : //cancel
                    console.log('No se hace Nada');                        
                    executeCommandEventArgs.commons.execServer = false;
                    return false;
                    break;
            case 1 : //accept
                    console.log('Se manda a consumir servicio'); 
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.api.vc.closeModal({});
                 
                    return true;
                    break;
            }
        });      
    };