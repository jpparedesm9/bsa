//Entity: TransferRequest
//TransferRequest.marketType (ComboBox) View: TransferRequestForm
task.customValidate.VA_MARKETTYPEMWHWP_950231 = function (entities, customValidateEventArgs) {
    customValidateEventArgs.commons.execServer = false;
    if (entities.TransferRequest.isAll == 'N' && (entities.TransferRequest.marketType == '' || entities.TransferRequest.marketType == null || entities.TransferRequest.marketType == undefined)) {
        var errorMessage = customValidateEventArgs.commons.api.viewState.translate('CSTMR.MSG_CSTMR_TIPODEMDD_28306');
        customValidateEventArgs.errorMessage = errorMessage;
        customValidateEventArgs.isValid = false;
    } else {
        customValidateEventArgs.isValid = true;
    }
};