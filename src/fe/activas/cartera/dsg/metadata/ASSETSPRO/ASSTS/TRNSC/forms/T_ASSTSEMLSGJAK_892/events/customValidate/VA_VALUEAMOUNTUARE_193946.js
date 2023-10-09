//Entity: GroupPaymenInfo
//GroupPaymenInfo.valueAmountUseGuarantee (TextInputBox) View: GroupPayment

task.customValidate.VA_VALUEAMOUNTUARE_193946 = function (entities, customValidateEventArgs) {
    if (customValidateEventArgs.currentValue > getMaxValueAmountAllowed(entities)) {
        customValidateEventArgs.errorMessage = customValidateEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_ELVALORGO_54922') + " $" + getMaxValueAmountAllowed(entities);
        customValidateEventArgs.isValid = false;
    } else {
        customValidateEventArgs.isValid = true;
    }
};