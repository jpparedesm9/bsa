//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_SECONDNAMESJJYD_721213 = function( customValidationEventArgs ) {
     return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 30); //el 3 es con punto y espacio
};