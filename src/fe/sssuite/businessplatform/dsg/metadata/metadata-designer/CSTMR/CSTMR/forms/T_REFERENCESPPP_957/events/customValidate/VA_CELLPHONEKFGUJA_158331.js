//Entity: References
    //References.cellPhone (TextInputBox) View: ReferencesPopupForm
    
    task.customValidate.VA_CELLPHONEKFGUJA_158331 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if((customValidateEventArgs.currentValue != null) && (customValidateEventArgs.currentValue != '')){
            LATFO.UTILS.validarTelefono(customValidateEventArgs);
        }
    };