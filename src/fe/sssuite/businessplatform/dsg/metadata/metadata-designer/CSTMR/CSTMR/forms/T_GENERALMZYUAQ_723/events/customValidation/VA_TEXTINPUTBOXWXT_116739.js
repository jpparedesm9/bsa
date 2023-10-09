//Entity: NaturalPerson
//NaturalPerson.firstName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXWXT_116739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 20); //el 3 es con punto y espacio
        
};