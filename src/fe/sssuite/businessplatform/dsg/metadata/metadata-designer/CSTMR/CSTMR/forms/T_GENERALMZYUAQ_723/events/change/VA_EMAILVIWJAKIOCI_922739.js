//Entity: NaturalPerson
    //NaturalPerson.email (TextInputBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_EMAILVIWJAKIOCI_922739 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(entities.NaturalPerson.email)){
            changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }
    };