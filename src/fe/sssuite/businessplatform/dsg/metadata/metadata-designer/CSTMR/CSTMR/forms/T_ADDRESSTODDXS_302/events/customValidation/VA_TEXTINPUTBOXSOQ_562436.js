//Entity: PhysicalAddress
    //PhysicalAddress.street (TextInputBox) View: AddressPopupForm
    
    task.customValidation.VA_TEXTINPUTBOXSOQ_562436 = function( customValidationEventArgs ) {
      var regularExp = /[A-Za-z0-9\s]+$/g;
      return regularExp.test(customValidationEventArgs.character);
    };