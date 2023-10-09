/* variables locales de T_CSTMRVFHHHDDJ_341*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.viewalertseditform;
    

    //"TaskId": "T_CSTMRVFHHHDDJ_341"


    //Entity: WarningRisk
    //WarningRisk.statusAlert (ComboBox) View: ViewAlertsEditForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6316JFVGVVCUOPG_835173 = function(  entities, changedEventArgs ) {

     changedEventArgs.commons.execServer = false;
               
        
        if((changedEventArgs.newValue === 'NR') || (changedEventArgs.newValue === 'SR')){
            changedEventArgs.commons.api.viewState.show('VA_3831FTIGRDFHULJ_171173');
            
        } else {
            changedEventArgs.commons.api.viewState.hide('VA_3831FTIGRDFHULJ_171173');
            
        }
        changedEventArgs.commons.api.ext.timeout(function() { //Aplicar el estilo en toda el area de todas las celdas marcadas
                $('.Disable_CTR').closest('td').addClass('Disable_CTR');
            },1000);
    
        
    };

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

//Entity: WarningRisk
    //WarningRisk. (Button) View: ViewAlertsEditForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXWSXRPU_614173 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.WarningRisk = true;
    };

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

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ViewAlertsEditForm
    task.initData.VC_VIEWALERES_934341 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.viewState.hide('VA_3831FTIGRDFHULJ_171173');
        
    };



}));