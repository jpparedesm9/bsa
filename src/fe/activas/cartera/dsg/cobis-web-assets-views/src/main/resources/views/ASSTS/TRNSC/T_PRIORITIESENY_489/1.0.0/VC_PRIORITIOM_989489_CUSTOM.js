/* variables locales de T_PRIORITIESENY_489*/
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

    
        var task = designerEvents.api.prioritiespaymentsmodal;
    

    //"TaskId": "T_PRIORITIESENY_489"

    // (Button) 
    task.executeCommand.CM_TPRIORIT_I8N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelPriority = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelPriority);
    };

// (Button) 
    task.executeCommand.CM_TPRIORIT_TTT = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var dataGrid = {
            data: entities.Priorities
            }
        executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PrioritiesPaymentsModal
    task.initData.VC_PRIORITIOM_989489 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.Priorities = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().priorities;
        //initDataEventArgs.commons.api.grid.addAllRows("Priorities", initDataEventArgs.commons.api.navigation.getCustomDialogParameters().priorities, false);
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: PrioritiesPaymentsModal
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };



}));