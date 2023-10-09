// (Button) 
    task.executeCommand.CM_TASSTSTC_95A = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var filtro = {
            action: "A"
        };
        executeCommandEventArgs.commons.api.vc.parentVc = {}
        executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        var verifica = false;
        if(entities.CreditCandidates.data().length != 0){
            for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
                if(entities.CreditCandidates.data()[i].isChecked === true){
                    verifica = true;
                    if((entities.CreditCandidates.data()[i].periodicity === null) || (entities.CreditCandidates.data()[i].periodicity === '') || (entities.CreditCandidates.data()[i].periodicity === undefined)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBEDEFAE_12359');
                        executeCommandEventArgs.commons.execServer = false;
                        break;
                    } else if((entities.CreditCandidates.data()[i].description === null) || (entities.CreditCandidates.data()[i].description === '') || (entities.CreditCandidates.data()[i].description === undefined)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBEDEFRC_94935');
                        executeCommandEventArgs.commons.execServer = false;
                        break;
                    }
                }
            }
        }
        if(!verifica){
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSTS.MSG_ASSTS_DEBESELTC_84593');
            executeCommandEventArgs.commons.execServer = false;
        }
    };