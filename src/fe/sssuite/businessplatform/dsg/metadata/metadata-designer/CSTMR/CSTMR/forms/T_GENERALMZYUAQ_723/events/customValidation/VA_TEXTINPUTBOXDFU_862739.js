//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXDFU_862739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto  
};