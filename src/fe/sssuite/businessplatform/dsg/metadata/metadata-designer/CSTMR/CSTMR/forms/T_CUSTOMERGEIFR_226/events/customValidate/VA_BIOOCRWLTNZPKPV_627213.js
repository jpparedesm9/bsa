//Entity: NaturalPerson
//NaturalPerson.bioOCR (TextInputBox) View: CustomerGeneralInfForm

task.customValidate.VA_BIOOCRWLTNZPKPV_627213 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;
    
    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 13, 13, "N", "CSTMR.MSG_CSTMR_CAMPODE1E_73658");
    }

};