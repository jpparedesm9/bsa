//Entity: UnusualOperations
    //UnusualOperations.customerSecondName (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSECOMEE_535527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };