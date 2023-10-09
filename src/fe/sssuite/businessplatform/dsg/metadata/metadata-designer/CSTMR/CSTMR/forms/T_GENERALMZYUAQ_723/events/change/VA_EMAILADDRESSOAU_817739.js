//Entity: LegalPerson
    //LegalPerson.emailAddress (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_EMAILADDRESSOAU_817739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(entities.LegalPerson.emailAddress)){
            changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }
    };