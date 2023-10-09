//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: CustomerSpouseFor//SpousePerson.surname (TextInputBox) View: CustomerSpouseFor     
task.customValidation.VA_TEXTINPUTBOXJTN_514425 = function( customValidationEventArgs ) {    
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16);
 } ;