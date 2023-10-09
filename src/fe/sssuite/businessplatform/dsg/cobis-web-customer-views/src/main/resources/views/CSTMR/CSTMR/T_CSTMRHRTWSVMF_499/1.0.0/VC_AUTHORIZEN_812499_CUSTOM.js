/* variables locales de T_CSTMRHRTWSVMF_499*/
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

    
        var task = designerEvents.api.authorizationtransferdetailform;
    

    //"TaskId": "T_CSTMRHRTWSVMF_499"


    //AuthorizationTransferDetailQuery Entity: 
    task.executeQuery.Q_AUTHORTD_2985 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
		var filtro = {
			idRequest: executeQueryEventArgs.commons.api.parentVc.customDialogParameters.idRequest
		}
        executeQueryEventArgs.commons.api.vc.parentVc = {};
        executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    };



}));