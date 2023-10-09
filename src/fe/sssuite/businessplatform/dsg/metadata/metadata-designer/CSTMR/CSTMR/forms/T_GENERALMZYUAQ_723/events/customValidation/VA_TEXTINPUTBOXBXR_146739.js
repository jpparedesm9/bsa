//Entity: NaturalPerson
//NaturalPerson.surname (TextInputBox) View: GeneralForm
    
task.customValidation.VA_TEXTINPUTBOXBXR_146739 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 16); //el 0 es sin punto    
        
};