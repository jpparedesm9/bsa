/* variables locales de T_CSTMRPCOZHJII_971*/
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

    
        var task = designerEvents.api.authorizationtransfercommentary;
    

    //"TaskId": "T_CSTMRPCOZHJII_971"


    //Entity: Entity2
    //Entity2. (Button) View: AuthorizationTransferCommentary
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRKHSQNF_877316 = function(  entities, executeCommandEventArgs ) {
        
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal({
        resultArgs: {
            rejectionReason: entities.Entity2.attribute1
        }});
    };



}));