//Entity: NaturalPerson
//NaturalPerson.bioEmissionNumber (TextInputBox) View: GeneralForm

task.customValidate.VA_BIOEMISSIONNUUU_579739 = function (entities, customValidateEventArgs) {

    customValidateEventArgs.commons.execServer = false;

    if (customValidateEventArgs.currentValue == null || customValidateEventArgs.currentValue == "") {
        customValidateEventArgs.isValid = true;
    } else {
        LATFO.UTILS.validarMinMax(customValidateEventArgs, 2, 2, "A", "CSTMR.MSG_CSTMR_CAMPODEBT_21506");
    }

};