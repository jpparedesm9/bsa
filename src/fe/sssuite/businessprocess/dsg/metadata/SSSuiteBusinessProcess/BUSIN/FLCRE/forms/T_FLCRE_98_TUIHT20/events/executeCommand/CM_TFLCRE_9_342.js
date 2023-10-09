// (Button) 
    task.executeCommand.CM_TFLCRE_9_342 = function(entities, executeCommandEventArgs) {
        //executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
     var api = executeCommandEventArgs.commons.api;
     var msgResourceID = "Esta seguro de Consolidar?";
     return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm(msgResourceID).then(function(resp){
    switch(resp.buttonIndex){
       case 0 : //cancel      
         executeCommandEventArgs.commons.execServer = false;
         return false;
         break;
       case 1 : //accept             
         executeCommandEventArgs.commons.execServer = true;
         return true;
         break;
      }
     });
    };