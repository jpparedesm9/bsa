//Entity: ReferenceReq
    //ReferenceReq.purchaseAmount (TextInputBox) View: ValidateReferenceForm
    
    task.customValidate.VA_3427XJKLLNQAQYE_228945 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        if(entities.ReferenceReq.purchaseAmount <= 0 || 
           entities.ReferenceReq.purchaseAmount > MAX_AMOUNT){//Monto debe ser mayor a 0 y menor a 10 000 000 000
            customValidateEventArgs.errorMessage = 'CSTMR.MSG_CSTMR_MONTODERR_29310';
            customValidateEventArgs.isValid = false;
            $("#VA_3427XJKLLNQAQYE_228945").val("0");
        } else{
            customValidateEventArgs.isValid = true;
        }
    };