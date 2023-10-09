//Entity: Aval
    //Aval. (Button) View: Aval
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONFUIXKXW_718576 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.Aval = true;
        if(entities.OriginalHeader.ProductType === "INDIVIDUAL"){
            if((entities.Aval.idCustomer === undefined) || (entities.Aval.idCustomer === null)){
                executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ELAVALEOB_47675');
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
        }
    };