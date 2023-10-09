//Start signature to Callback event to VA_VABUTTONTOSIJNF_422769
task.executeCommandCallback.VA_VABUTTONTOSIJNF_422769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    console.log('Ingresa a callback boton VA_VABUTTONTOSIJNF_422769')
    if(entities.QuestionValidation.corretValidation==='S')
        {
            executeCommandCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONUWUXNHE_853769');
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESPUESTT_28632', '', 3000, false);
        }
    else
        {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
        }
    
     if(entities.QuestionValidation.msmValidation!='--')
        {
            var msnValidation=entities.QuestionValidation.msmValidation;
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnValidation+'', true);
            //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnValidation, '', 20000, false);
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692');
        }
    
};