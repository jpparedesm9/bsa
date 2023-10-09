//Entity: UnusualOperations
    //UnusualOperations.customerName (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_TEXTINPUTBOXTVB_163527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };