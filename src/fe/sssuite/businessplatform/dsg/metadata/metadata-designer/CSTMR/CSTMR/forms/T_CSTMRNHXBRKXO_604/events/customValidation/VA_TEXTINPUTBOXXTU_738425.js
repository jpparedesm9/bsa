//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: CustomerSpouseForm
    
task.customValidation.VA_TEXTINPUTBOXXTU_738425 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 30);     
        
};