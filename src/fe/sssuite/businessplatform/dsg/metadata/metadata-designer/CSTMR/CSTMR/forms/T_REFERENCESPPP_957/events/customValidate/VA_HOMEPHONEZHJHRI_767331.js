//Entity: References
    //References.homePhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_HOMEPHONEZHJHRI_767331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != '')){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };