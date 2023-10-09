// (Button) 
    task.executeCommand.CM_TASSTSOS_ASN = function(entities, executeCommandEventArgs) {
        var selection = 0;
        if (entities.DetailRejectedDispersions.data().length == 0){
             executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_NOEXISTSG_21670'),true);
            executeCommandEventArgs.commons.execServer = false;
            }
        for (var i=0; i < entities.DetailRejectedDispersions.data().length; i++){
                                
               if (entities.DetailRejectedDispersions.data()[i].selection != undefined || entities.DetailRejectedDispersions.data()[i].selection != false){
                
                   selection = selection + 1
                   
            }
            }
        if (selection == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_SELECCINT_52125'),true);
                   executeCommandEventArgs.commons.execServer = false;
               }else {
                   executeCommandEventArgs.commons.execServer = true; 
               }
        //executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };