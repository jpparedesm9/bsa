// (Button) 
task.executeCommand.CM_TBEFOREP_5TF = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    if (entities.PrintingPaymentInfo.data().length == 0){
        var dataGrid = {sequential: '0', beforeButton: false}    
    }
    else{
        var dataGrid = {sequential: secuentialIng, beforeButton: true}    
    }
    executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);        
};