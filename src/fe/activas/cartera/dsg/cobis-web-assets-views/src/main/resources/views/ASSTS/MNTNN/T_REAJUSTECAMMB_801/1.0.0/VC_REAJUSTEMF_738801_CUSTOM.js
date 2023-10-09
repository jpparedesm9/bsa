/* variables locales de T_REAJUSTECAMMB_801*/
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

    
        var task = designerEvents.api.readjustmentloancabform;
    

    /*"TaskId": "T_REAJUSTECAMMB_801",*/
    //Your code here

    //showGridRowDetailIcon QueryView: QV_5831_17646
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_5831_17646 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

//gridInitDetailTemplate QueryView: QV_5831_17646
//
task.gridInitDetailTemplate.QV_5831_17646 = function (entities, gridInitDetailTemplateEventArgs) {
gridInitDetailTemplateEventArgs.commons.execServer = false;
// gridInitDetailTemplateEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
};

//gridRowDeleting QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_5831_17646 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };

//gridRowUpdating QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_5831_17646 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;
        //gridRowUpdatingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };



}));