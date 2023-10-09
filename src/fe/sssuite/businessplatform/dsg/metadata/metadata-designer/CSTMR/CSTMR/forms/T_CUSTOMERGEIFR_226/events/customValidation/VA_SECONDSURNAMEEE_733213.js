//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SECONDSURNAMEEE_733213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto 
};