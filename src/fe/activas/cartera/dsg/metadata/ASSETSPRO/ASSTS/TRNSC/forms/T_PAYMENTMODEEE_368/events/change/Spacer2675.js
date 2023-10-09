//Entity: PaymentForm
    //PaymentForm.payFormId (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer2675 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        var api = changeEventArgs.commons.api;
        if(changeEventArgs.newValue=="CHOTBCOS"){
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = true;
        }else{
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
        }
        entities.PaymentForm.accountNumber = "";
    };