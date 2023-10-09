//Entity: SpousePerson
//SpousePerson.secondSurname (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXPLP_556425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16);
    
};