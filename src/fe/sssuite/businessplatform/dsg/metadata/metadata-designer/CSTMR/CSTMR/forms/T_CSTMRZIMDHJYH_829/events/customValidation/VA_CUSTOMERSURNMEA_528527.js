//Entity: UnusualOperations
    //UnusualOperations.customerSurname (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSURNMEA_528527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };