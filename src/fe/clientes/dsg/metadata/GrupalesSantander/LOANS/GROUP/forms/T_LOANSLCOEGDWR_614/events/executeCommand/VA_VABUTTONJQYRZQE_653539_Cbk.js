//Entity: UploadedDocuments
    //UploadedDocuments. (Button) View: ScannedDocuments
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONJQYRZQE_653539 = function(  entities, executeCommandCallbackEventArgs ) {

        executeCommandCallbackEventArgs.commons.execServer = false;
        
        if(entities.UploadedDocuments.uploads){
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Los documentos fueron completados', true);
        } else {
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Faltan documentos por subir', true);
        }
        
    };