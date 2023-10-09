//Entity: NaturalPerson
//NaturalPerson.firstName (TextInputBox) View: CustomerGeneralInfForm
    
task.customValidation.VA_FIRSTNAMEFPYKAF_649213 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 20); //3 es con punto y espacio cs: 150907
};