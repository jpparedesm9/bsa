//Entity: TransferRequest
    //TransferRequest.officialDestinationId (ComboBox) View: TransferRequestForm
    
    task.customValidate.VA_OFFICIALDESTDNN_244231 = function(  entities, customValidateEventArgs ) {

        customValidateEventArgs.commons.execServer = false;
        if (entities.TransferRequest.officialDestinationId == entities.TransferRequest.officialOriginId){
            var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_ELOFICIEA_76583');
            customValidateEventArgs.errorMessage = errorMessage;
            customValidateEventArgs.isValid = false;
        }
        else {
            customValidateEventArgs.isValid = true;
        }
    };