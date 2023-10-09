//Entity: DemographicData
//DemographicData.whichProfession (TextInputBox) View: DemographicForm

task.customValidation.VA_WHICHPROFESSINI_582794 = function( customValidationEventArgs ) {
    return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 4, 30); 
};