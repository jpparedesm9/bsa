//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONGTRMBBC_889263 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    /*    var buttons = ['BUTTON N', 'BUTTON 2', 'BUTTON 1'],
        promise = cobis.showMessageWindow.confirm('CONTENT: CONFIRM TEST', 'CONFIRM TITLE', buttons);
        promise.then(function (response) {
            console.info("Boton:", response.buttonIndex);
             executeCommandEventArgs.commons.execServer = true;
        });*/
    };