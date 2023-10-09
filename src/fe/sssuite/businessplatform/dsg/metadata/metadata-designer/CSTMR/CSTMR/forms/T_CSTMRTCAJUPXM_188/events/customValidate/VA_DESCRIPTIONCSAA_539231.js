//Entity: TransferRequest
    //TransferRequest.descriptionCause (TextInputBox) View: TransferRequestForm
    
    task.customValidate.VA_DESCRIPTIONCSAA_539231 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        if (entities.TransferRequest.idCause === "7" && entities.TransferRequest.descriptionCause ==""){
            var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_ESNECESPM_76519');
            customValidateEventArgs.errorMessage = errorMessage;
            customValidateEventArgs.isValid = false;
        }
        else {
            customValidateEventArgs.isValid = true;
        }
        
    };