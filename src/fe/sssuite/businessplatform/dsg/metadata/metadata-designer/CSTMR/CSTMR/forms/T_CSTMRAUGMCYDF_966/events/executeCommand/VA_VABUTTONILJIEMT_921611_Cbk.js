//Start signature to Callback event to VA_VABUTTONILJIEMT_921611
task.executeCommandCallback.VA_VABUTTONILJIEMT_921611 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    console.log('Ingresa a collback')
        if(entities.DocumentsUpload.uploads){
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Los documentos fueron completados', true);
        } else {
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Faltan documentos por subir', true);
        }
};