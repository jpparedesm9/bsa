//Start signature to Callback event to VA_VABUTTONJPSJYQV_906304
task.executeCommandCallback.VA_VABUTTONJPSJYQV_906304 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if (executeCommandCallbackEventArgs.success) {
        if (ban){
        if (showHeader) {
            if(entities.CustomerTmpBusiness.customerType == 'P'){
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.name, 0);
            }else{
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.businessName, 0);
            }
            LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentNumber, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentType, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmpBusiness.code, 2);
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_BUSINESSSS_428304');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_BUSINESSSS_428304');
        } else {
            //Para VCC
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_BUSINESSSS_428304');
        }
      }
        
    }
    
    
};