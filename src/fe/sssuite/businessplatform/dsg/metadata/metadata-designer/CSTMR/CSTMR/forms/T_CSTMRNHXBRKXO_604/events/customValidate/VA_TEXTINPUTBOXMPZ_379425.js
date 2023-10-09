//Entity: SpousePerson
    //SpousePerson.phone (TextInputBox) View: CustomerSpouseForm
    
    task.customValidate.VA_TEXTINPUTBOXMPZ_379425 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        LATFO.UTILS.validarTelefono(customValidateEventArgs);
    
        
    };