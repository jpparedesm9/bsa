//Entity: Phone
    //Phone.phoneNumber (TextInputBox) View: AddressPopupForm
    
    task.customValidate.VA_TEXTINPUTBOXBZY_832436 = function(  entities, customValidateEventArgs ) {
        
        customValidateEventArgs.commons.execServer = false;
        LATFO.UTILS.validarTelefono(customValidateEventArgs);
    };