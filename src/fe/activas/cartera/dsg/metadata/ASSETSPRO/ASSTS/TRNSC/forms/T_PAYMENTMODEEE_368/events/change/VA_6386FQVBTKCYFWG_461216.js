//Entity: PaymentForm
    //PaymentForm.clientFullName (TextInputButton) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6386FQVBTKCYFWG_461216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var disClientId = changeEventArgs.commons.api.navigation.getCustomDialogParameters().loan.clientID;
        var newClientId = entities.PaymentForm.clientId;
        if(newClientId != disClientId && changeEventArgs.oldValue != null){
            changeEventArgs.commons.execServer = false;
        }
    };