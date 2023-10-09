/* variables locales de T_STATUSLISTSPE_405*/
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

    
        var task = designerEvents.api.statuslistform;
    

    //"TaskId": "T_STATUSLISTSPE_405"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: StatusListForm
    task.initData.VC_STATUSLIST_332405 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var model=initDataEventArgs.commons.api.vc.model;
        model.Loan=initDataEventArgs.commons.api.parentVc.model.Loan;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//gridRowSelecting QueryView: QV_5541_56326
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5541_56326 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        var parentModel=gridRowSelectingEventArgs.commons.api.parentVc.model;
        var Status=gridRowSelectingEventArgs.rowData;        
        parentModel.Loan.newStatus=Status.newStatus;            
        
        gridRowSelectingEventArgs.commons.api.vc.closeModal(Status);
        //gridRowSelectingEventArgs.commons.serverParameters.LoanStatusChange = true;
    };



}));