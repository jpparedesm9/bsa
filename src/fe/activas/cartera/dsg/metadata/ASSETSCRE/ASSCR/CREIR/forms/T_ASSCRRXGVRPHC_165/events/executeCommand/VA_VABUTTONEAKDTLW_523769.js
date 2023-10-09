//Entity: LoginCallCenter
    //LoginCallCenter. (Button) View: CallCenterQuestions
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONEAKDTLW_523769 = function(  entities, executeCommandEventArgs ) {
        if(entities.LoginCallCenter.idCliente==null || entities.LoginCallCenter.idCliente==='' ||        entities.LoginCallCenter.idCliente==undefined)
            {
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELCDIGOTO_45403', true)
                executeCommandEventArgs.commons.execServer = false;
                
            }
        else{
            executeCommandEventArgs.commons.execServer = true;
            }
        
    
        //executeCommandEventArgs.commons.serverParameters.LoginCallCenter = true;
    };