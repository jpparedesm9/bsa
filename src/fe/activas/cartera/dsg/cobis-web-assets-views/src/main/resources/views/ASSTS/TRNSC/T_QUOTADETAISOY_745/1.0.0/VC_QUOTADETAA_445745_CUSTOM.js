/* variables locales de T_QUOTADETAISOY_745*/
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

    
        var task = designerEvents.api.quotadetailpaymentsmodal;
    

    //"TaskId": "T_QUOTADETAISOY_745"


    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QuotaDetailPaymentsModal
    task.initData.VC_QUOTADETAA_445745 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        entities.Loan = initDataEventArgs.commons.api.parentVc.model.Loan;
     entities.Payment = initDataEventArgs.commons.api.parentVc.model.Payment;
    };



}));