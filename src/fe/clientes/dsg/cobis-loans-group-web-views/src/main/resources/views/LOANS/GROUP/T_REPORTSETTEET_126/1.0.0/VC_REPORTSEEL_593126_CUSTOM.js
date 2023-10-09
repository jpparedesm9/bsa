/* variables locales de T_REPORTSETTEET_126*/
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

    
        var task = designerEvents.api.reportsettlementsheet;
    

    //"TaskId": "T_REPORTSETTEET_126"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReportSettlementSheet
    task.initData.VC_REPORTSEEL_593126 = function (entities, initDataEventArgs){
        entities.CreditHeader.creditCode= initDataEventArgs.commons.api.navigation.getCustomDialogParameters().IDRequested;
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        
    };



}));