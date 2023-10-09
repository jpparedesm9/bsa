//Entity: Business
    //Business.whichResource (TextInputBox) View: BusinessPopupForm
    
    task.customValidation.VA_WHICHRESOURCEEE_338246 = function( customValidationEventArgs ) {
      return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 4, 30); 
    };