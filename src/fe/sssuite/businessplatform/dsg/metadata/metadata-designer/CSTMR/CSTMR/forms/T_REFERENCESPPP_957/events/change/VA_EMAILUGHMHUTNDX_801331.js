//Entity: References
    //References.email (TextInputBox) View: ReferencesPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_EMAILUGHMHUTNDX_801331 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;
    
    if(!LATFO.UTILS.validarEmail(entities.References.email)){
         changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
    }
};