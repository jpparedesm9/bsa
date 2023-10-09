//Entity: SpousePerson
//SpousePerson.expirationDate (DateField) View: GeneralForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DATEFIELDKPKNOQ_427739 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (task.ValidaVencimiento(entities.SpousePerson.expirationDate) == false) {
        changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELDOCUMTO_49378', true);
    }
};