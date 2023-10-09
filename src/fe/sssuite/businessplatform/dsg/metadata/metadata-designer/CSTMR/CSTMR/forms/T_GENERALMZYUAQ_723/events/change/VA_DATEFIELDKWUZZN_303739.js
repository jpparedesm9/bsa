//Entity: NaturalPerson
//NaturalPerson.birthDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DATEFIELDKWUZZN_303739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.FechaNacimiento(entities.NaturalPerson.birthDate,edadMin, edadMax) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
    }
};