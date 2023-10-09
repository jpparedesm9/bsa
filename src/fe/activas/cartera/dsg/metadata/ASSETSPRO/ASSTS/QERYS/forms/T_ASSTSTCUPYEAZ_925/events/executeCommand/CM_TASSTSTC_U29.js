// (Button) 
    task.executeCommand.CM_TASSTSTC_U29 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var filtro = {
            action: "P"
        };
        executeCommandEventArgs.commons.api.vc.parentVc = {}
        executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        
        var verifica = false;
        if(entities.CreditCandidates.data().length != 0){
            for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
                if(entities.CreditCandidates.data()[i].isChecked === true){
                    verifica = true;
					// Por caso#161681
                    //if((entities.CreditCandidates.data()[i].description != null) && (entities.CreditCandidates.data()[i].description != '')){
                    //    //executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('ASSTS.MSG_ASSTS_ALPOSPODI_25615');
                    //    break;
                    //}
                }
            }
        }
        if(!verifica){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBESELTC_84593');
            executeCommandEventArgs.commons.execServer = false;
        }
    };