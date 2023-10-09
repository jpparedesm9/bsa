//Start signature to Callback event to VA_VABUTTONOKQWNLY_810576
task.executeCommandCallback.VA_VABUTTONOKQWNLY_810576 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    var references = entities.References.data();
    if (executeCommandCallbackEventArgs.success) {
        if (ban){
            if (showHeader) {
                if(entities.CustomerTmpReferences.customerType == 'P'){
                    LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpReferences.name, 0);
                }else{
                    LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpReferences.referencesName, 0);
                }
                LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmpReferences.documentNumber, 1);
                LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmpReferences.documentType, 1);
                LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmpReferences.code, 2);
                LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_REFERENESE_949576');
                executeCommandCallbackEventArgs.commons.api.viewState.show('G_REFERENESE_949576');
            } else {
                //Para VCC
                executeCommandCallbackEventArgs.commons.api.viewState.hide('G_REFERENESE_949576');
            }
        }
        /*if(references.length<2){
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError('El Cliente Debe Tener Al Menos Dos Referencias Personales',true); 
        }*/
    }
    
};