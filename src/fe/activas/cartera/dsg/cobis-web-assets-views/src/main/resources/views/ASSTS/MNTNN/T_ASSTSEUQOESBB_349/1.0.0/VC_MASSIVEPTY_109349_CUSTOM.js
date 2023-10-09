/* variables locales de T_ASSTSEUQOESBB_349*/
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

    
        var task = designerEvents.api.massivepayment;
    

    //"TaskId": "T_ASSTSEUQOESBB_349"


    //Entity: Entity18
    //Entity18.attribute1 (FileUpload) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_1OTMQVYBJOEHUHZ_818263 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = false;
       
        
    };

//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONDGDOXOG_649263 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
        }
        
    };

//Start signature to Callback event to VA_VABUTTONDGDOXOG_649263
task.executeCommandCallback.VA_VABUTTONDGDOXOG_649263 = function(entities, executeCommandCallbackEventArgs) {
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
      if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
            viewState.disable('VA_VABUTTONMYCSNRW_701263');
        }
    else{

        if(executeCommandCallbackEventArgs.success){
            if(entities.MassivePaymentFile.fileObservations == 0){
                viewState.enable('VA_VABUTTONMYCSNRW_701263');
            }
        }else{
            viewState.disable('VA_VABUTTONMYCSNRW_701263');
            entities.MassivePaymentFile.fileObservations=0
            entities.MassivePaymentFile.processedRecords = 0
            entities.MassivePaymentFile.processedAmount = 0
        }
    }
};

//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONGTRMBBC_889263 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    /*    var buttons = ['BUTTON N', 'BUTTON 2', 'BUTTON 1'],
        promise = cobis.showMessageWindow.confirm('CONTENT: CONFIRM TEST', 'CONFIRM TITLE', buttons);
        promise.then(function (response) {
            console.info("Boton:", response.buttonIndex);
             executeCommandEventArgs.commons.execServer = true;
        });*/
    };

//Start signature to Callback event to VA_VABUTTONGTRMBBC_889263
task.executeCommandCallback.VA_VABUTTONGTRMBBC_889263 = function(entities, executeCommandCallbackEventArgs) {
//here your code
     var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
         viewState.disable('VA_VABUTTONMYCSNRW_701263');
};

//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONMYCSNRW_701263 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var buttons = ['SI', 'NO']
            
              
        if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
              
             executeCommandEventArgs.commons.api.vc.executeCommand('VA_VABUTTONVBEQBSD_442263','Compute', undefined, true, false, 'VC_MASSIVEPTY_109349', false);
            
        }else{
            var promise = cobis.showMessageWindow.confirm('\u00BFConfirma el proceso de Pagos Masivos\u003F', 'Pagos Masivos',  buttons);
            promise.then(function (response) {
                if(response.buttonIndex == 0){
            	   executeCommandEventArgs.commons.api.vc.executeCommand('VA_VABUTTONGTRMBBC_889263','Compute', undefined, true, false, 'VC_MASSIVEPTY_109349', false);
                }
        
        
            });
        }
    };

//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONVBEQBSD_442263 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
      
            var viewState = executeCommandEventArgs.commons.api.viewState;
         viewState.disable('VA_VABUTTONMYCSNRW_701263');
        entities.MassivePaymentFile.fileObservations = 0;
        entities.MassivePaymentFile.processedRecords = 0;
        entities.MassivePaymentFile.processedAmount = 0;
        
        //entities.MassivePaymentRecord={}
       // entities.MassivePaymentRecord=[];
    };

//Start signature to Callback event to VA_VABUTTONVBEQBSD_442263
task.executeCommandCallback.VA_VABUTTONVBEQBSD_442263 = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.vc.removeFile('VA_1OTMQVYBJOEHUHZ_818263')
       
};

//undefined Entity: 
    task.executeQuery.Q_MASSIVEE_3035 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    //   return {}
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MassivePayment
    task.initData.VC_MASSIVEPTY_109349 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.MassivePaymentFile.fileObservations=0
        entities.MassivePaymentFile.processedRecords = 0
        entities.MassivePaymentFile.processedAmount = 0
        
    };



}));