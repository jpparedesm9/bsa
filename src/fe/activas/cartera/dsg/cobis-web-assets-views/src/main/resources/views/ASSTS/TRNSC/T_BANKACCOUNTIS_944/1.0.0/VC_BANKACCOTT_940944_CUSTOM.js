/* variables locales de T_BANKACCOUNTIS_944*/
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

    
        var task = designerEvents.api.bankaccountslistform;
    

    //"TaskId": "T_BANKACCOUNTIS_944"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BankAccountsListForm
    task.initData.VC_BANKACCOTT_940944 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.Payment.customerID = dialogParameters.customerID;
        entities.Payment.paymentType = dialogParameters.paymentType;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//gridRowSelecting QueryView: QV_1987_42894
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1987_42894 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
        var selectedAccount = gridRowSelectingEventArgs.rowData;
        gridRowSelectingEventArgs.commons.api.vc.closeModal(selectedAccount);
        
    };



}));