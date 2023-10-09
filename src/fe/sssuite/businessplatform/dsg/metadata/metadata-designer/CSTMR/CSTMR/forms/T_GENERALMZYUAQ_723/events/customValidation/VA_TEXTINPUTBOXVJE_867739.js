//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXVJE_867739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 1, 20); //el 1 es con punto
};