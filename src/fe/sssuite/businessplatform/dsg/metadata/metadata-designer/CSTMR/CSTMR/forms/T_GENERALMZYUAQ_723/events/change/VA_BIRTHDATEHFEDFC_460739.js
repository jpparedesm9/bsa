//Entity: SpousePerson
//SpousePerson.birthDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_BIRTHDATEHFEDFC_460739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.FechaNacimiento(entities.SpousePerson.birthDate,edadMin, edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }
};