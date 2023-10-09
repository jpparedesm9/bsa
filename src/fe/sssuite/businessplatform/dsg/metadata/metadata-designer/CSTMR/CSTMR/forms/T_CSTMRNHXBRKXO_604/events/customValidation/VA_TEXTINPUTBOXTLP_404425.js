//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXTLP_404425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 1, 20);    
};