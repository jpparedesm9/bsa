//Entity: NaturalPerson
//NaturalPerson.bioOCR (TextInputBox) View: GeneralForm

task.customValidate.VA_BIOOCRPFNDHELMR_160739 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 13, 13, "N", "CSTMR.MSG_CSTMR_CAMPODE1E_73658");
    }

};