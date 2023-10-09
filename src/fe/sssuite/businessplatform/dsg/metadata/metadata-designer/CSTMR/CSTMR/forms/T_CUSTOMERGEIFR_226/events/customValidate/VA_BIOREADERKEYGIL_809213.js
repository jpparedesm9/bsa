//Entity: NaturalPerson
//NaturalPerson.bioReaderKey (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOREADERKEYGIL_809213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 18, 18, "A", "CSTMR.MSG_CSTMR_CAMPODENR_14381");
    }

};