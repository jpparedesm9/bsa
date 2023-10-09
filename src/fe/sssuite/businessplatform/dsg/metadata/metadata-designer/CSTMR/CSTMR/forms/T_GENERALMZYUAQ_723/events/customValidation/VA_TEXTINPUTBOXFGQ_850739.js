//Entity: NaturalPerson
//NaturalPerson.secondSurname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXFGQ_850739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto
    
};