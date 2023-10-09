//Entity: PaymentForm
    //PaymentForm.accountNumber (TextInputButton) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_2481BBVZTGCBDCR_830216 = function( entities, changeEventArgs ) {
        //changeEventArgs.commons.execServer = true;
        if(changeEventArgs.newValue != ""){      
        changeEventArgs.commons.execServer = true;
     }else{
         changeEventArgs.commons.execServer = false;
        }
    };