//Entity: UnusualOperations
    //UnusualOperations.customerSecondSurname (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSECONNN_410527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };