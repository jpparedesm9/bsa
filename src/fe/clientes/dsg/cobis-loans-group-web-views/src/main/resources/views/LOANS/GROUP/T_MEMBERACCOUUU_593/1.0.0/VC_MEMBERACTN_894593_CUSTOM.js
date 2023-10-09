/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.memberaccountform;

//"TaskId": "T_MEMBERACCOUUU_593"

//Entity: PaymentSelection
    //PaymentSelection.selectedType (ComboBox) View: MemberAccountForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_1604DQVPVZOCATA_609750 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    
        //changedEventArgs.commons.serverParameters.PaymentSelection = true;
    };

//Entity: PaymentSelection
    //PaymentSelection. (Button) View: MemberAccountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONINEGDLY_123750 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.PaymentSelection = true;
    };

//AmountQuery Entity: 
    task.executeQuery.Q_AMOUNTKL_6248 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };


}());