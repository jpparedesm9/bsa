/* variables locales de T_BANKACCOUNTOA_777*/
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

    
        var task = designerEvents.api.bankaccountsmodal;
    

    //"TaskId": "T_BANKACCOUNTOA_777"

    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BankAccountsModal
    task.initData.VC_BANKACCOMU_224777 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to callBack event to VC_BANKACCOMU_224777
    task.initDataCallback.VC_BANKACCOMU_224777 = function(entities, initDataEventArgs) {
        //here your code
        initDataEventArgs.commons.api.vc.viewState.VA_VASIMPLELABELLL_811523.label = entities.Entity1.Attribute2;
    };

//gridRowSelecting QueryView: QV_1987_24851
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1987_24851 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        var selectedAccount = gridRowSelectingEventArgs.rowData;
        gridRowSelectingEventArgs.commons.api.vc.closeModal(selectedAccount);
    };



}));