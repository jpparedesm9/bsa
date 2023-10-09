//Entity: References
    //References.officePhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_OFFICEPHONEGMFI_991331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != "")){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };