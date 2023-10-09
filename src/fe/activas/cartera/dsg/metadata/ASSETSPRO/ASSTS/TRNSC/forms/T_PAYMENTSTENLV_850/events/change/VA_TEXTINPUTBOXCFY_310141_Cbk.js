//Start signature to callBack event to VA_TEXTINPUTBOXCFY_310141
  task.changeCallback.VA_TEXTINPUTBOXCFY_310141 = function(entities, changeEventArgs) {
       entities.Payment.retention = entities.PaymentMethod.retention;
        entities.Payment.reference = ""
        entities.Payment.note = ""; 
        
        if(entities.PaymentMethod.category.substring(0,2) == "CH") {
            changeEventArgs.commons.api.viewState.show("VA_NUMCHECKQLTBIOX_669141");
            changeEventArgs.commons.api.viewState.show("VA_TEXTINPUTBOXSJQ_831141");
        }
        else
        {
            changeEventArgs.commons.api.viewState.hide("VA_NUMCHECKQLTBIOX_669141");
            changeEventArgs.commons.api.viewState.hide("VA_TEXTINPUTBOXSJQ_831141");
        }
    };