/* variables locales de T_ASSCRLLURZAUF_274*/

var codClienteReset = 0;
var nameCliente = "";
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

    
        var task = designerEvents.api.resetmessageimage;
    

    //"TaskId": "T_ASSCRLLURZAUF_274"


    //Entity: ResetImageMessage
//ResetImageMessage. (Button) View: ResetMessageImage
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONKOXRDID_200225 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;

    entities.ResetImageMessage.codResetClient = codClienteReset;


};

//Start signature to Callback event to VA_VABUTTONKOXRDID_200225
task.executeCommandCallback.VA_VABUTTONKOXRDID_200225 = function (entities, executeCommandCallbackEventArgs) {
    //here your code}

    console.log(codClienteReset);

    if (executeCommandCallbackEventArgs.success == true) {

        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESETEOAF_14457', '', 3000, false);
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONKOXRDID_200225');


    } else {
        console.log("ingreso si hay error")
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONKOXRDID_200225');
    }







};


//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ResetMessageImage
task.initData.VC_RESETMESME_339274 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    
    // Botones ocultos
    
    initDataEventArgs.commons.api.viewState.hide('VA_CODRESETCLIENTN_154225');
    initDataEventArgs.commons.api.viewState.hide('VA_NAMECLIENTFJHNP_973225');
    initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONKOXRDID_200225');
    
    

    var nav = initDataEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_VALIDARRU_71967');
    nav.address = {
        moduleId: 'ASSCR',
        subModuleId: 'CREIR',
        taskId: 'T_ASSCRDVFRQXGU_966',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CALLCENTRP_967966'
    };
    nav.queryParameters = {
        mode: 2
    };
    nav.modalProperties = {
        size: 'lg',
        callFromGrid: false
    };
    nav.customDialogParameters = {
        variable: 0
    };

    //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
    nav.openModalWindow(initDataEventArgs.commons.controlId, null);
    //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
    //nav.openModalWindow(id, args.modelRow);


};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ResetMessageImage
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;

    var response = onCloseModalEventArgs.result;
    codClienteReset = response.codigoCliente;
    nameCliente = response.nameClient;

    if (codClienteReset !== undefined || codClienteReset == 0) {

        // Se muestran los botones


        onCloseModalEventArgs.commons.api.viewState.show('VA_VABUTTONKOXRDID_200225');

        entities.ResetImageMessage.codResetClient = codClienteReset;
        entities.ResetImageMessage.nameClient = nameCliente;
    }

    onCloseModalEventArgs.commons.api.viewState.show('VA_CODRESETCLIENTN_154225');
    onCloseModalEventArgs.commons.api.viewState.show('VA_NAMECLIENTFJHNP_973225');



};



}));