/* variables locales de T_ASSTSWUUUFOXQ_983*/
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

    
        var task = designerEvents.api.paymentapplication;
    

    //"TaskId": "T_ASSTSWUUUFOXQ_983"

    // (Button) 
    task.executeCommand.CM_TASSTSWU_SAS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Entity: Entity17
//Entity17.attribute1 (FileUpload) View: PaymentApplication
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_1RKSKKIACKZKFJR_539131 = function (entities, executeCommandEventArgs) {    
    var fileUpload = executeCommandEventArgs.commons.api.fileUpload;    
    //fileUpload.setParameters(10, true, 'fileRepo');
    //entities.PaymentApplication;
    executeCommandEventArgs.commons.execServer = false;
};

//Entity: Entity17
    //Entity17. (Button) View: PaymentApplication
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONUHRKEOM_688131 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.Entity17 = true;
    };

//PaymentApplicationQuery Entity: 
    task.executeQuery.Q_PAYMENII_8495 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };



}));