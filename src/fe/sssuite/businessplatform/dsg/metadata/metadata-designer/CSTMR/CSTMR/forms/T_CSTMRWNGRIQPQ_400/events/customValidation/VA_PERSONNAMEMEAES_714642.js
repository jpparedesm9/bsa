//Entity: ComplementaryRequestData
//ComplementaryRequestData.personNameMessages (TextInputBox) View: ComplementaryRequestDataForm
    
task.customValidation.VA_PERSONNAMEMEAES_714642 = function( customValidationEventArgs ) {
	return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 20);            
};