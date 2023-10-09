//Entity: NaturalPerson
//NaturalPerson.bioCIC (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOCICLKEOYOTBY_860213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 9, 9, "N", "CSTMR.MSG_CSTMR_CAMPODETR_21780");
    }

};