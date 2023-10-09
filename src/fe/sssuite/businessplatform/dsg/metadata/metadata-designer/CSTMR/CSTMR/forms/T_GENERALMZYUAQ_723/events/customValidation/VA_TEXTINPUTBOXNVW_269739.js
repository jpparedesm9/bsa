//Entity: SpousePerson
//SpousePerson.secondName (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXNVW_269739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 30); //el 0 es sin punto
};