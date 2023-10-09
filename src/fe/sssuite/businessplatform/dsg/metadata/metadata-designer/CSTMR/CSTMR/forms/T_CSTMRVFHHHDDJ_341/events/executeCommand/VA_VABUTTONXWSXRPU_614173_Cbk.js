//Entity: WarningRisk
    //WarningRisk. (Button) View: ViewAlertsEditForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONXWSXRPU_614173 = function(  entities, executeCommandCallbackEventArgs ) {

    executeCommandCallbackEventArgs.commons.execServer = false;
    if(executeCommandCallbackEventArgs.success){
             
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3983_71432');
         /*var criteria = { field: "alertCode", operator:"eq" ,value: entities.WarningRisk.alertCode} ;
         executeCommandCallbackEventArgs.commons.api.grid.selectRow("QV_3983_71432",criteria);*/
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({});
        
         }

    
        
    };