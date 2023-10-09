//Entity: NaturalPerson
//NaturalPerson.bioReaderKey (TextInputBox) View: GeneralForm

task.customValidate.VA_BIOREADERKEYXPM_644739 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 18, 18, "A", "CSTMR.MSG_CSTMR_CAMPODENR_14381");
    }

};