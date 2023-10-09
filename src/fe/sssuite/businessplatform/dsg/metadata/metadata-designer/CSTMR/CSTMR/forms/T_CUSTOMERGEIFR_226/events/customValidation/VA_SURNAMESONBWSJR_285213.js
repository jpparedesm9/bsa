//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SURNAMESONBWSJR_285213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto     
        
};