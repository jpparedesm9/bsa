//Entity: SpousePerson
//SpousePerson.surname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXDTF_989739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto    
 };