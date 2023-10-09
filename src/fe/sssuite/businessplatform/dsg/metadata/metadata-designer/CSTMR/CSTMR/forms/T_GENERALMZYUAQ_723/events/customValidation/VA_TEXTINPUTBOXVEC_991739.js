//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXVEC_991739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 3, 30); //el 3 es con punto y espacio   
};