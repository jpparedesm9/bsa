// (Button) 
    task.executeCommand.CM_TTESTWKH_NN5 = function(entities, executeCommandEventArgs) {
        var mode = executeCommandEventArgs.commons.api.vc.mode;
        var concept = entities.OtherCharges.concept;
        var iniDiv = entities.OtherCharges.iniDiv;
        var divUp = entities.OtherCharges.divUp;
        var commentary = entities.OtherCharges.commentary;
        var value = entities.OtherCharges.value;
        var reference = entities.OtherCharges.reference;
    var valueMax = entities.OtherCharges.valueMax;
    var valueMin = entities.OtherCharges.valueMin;
        executeCommandEventArgs.commons.execServer = false;
        if ((iniDiv < 0) || iniDiv > 32767){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11968",true); 
           return;
        }
        if ((divUp < 0) || divUp > 32767){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11968",true); 
           return;
        }
        if (iniDiv > divUp){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
        if (iniDiv > divUp){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
        if (value < 0){
           executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11978",true); 
           return;
        }
        if (reference != null){
            if (value > valueMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11973",true);
            return;
            }
            if (value < valueMin) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11974",true);
                return;
            }            
        }       
        if (mode === 1){
            //if (concept.trim() === ''){
            //   executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11970",true); 
            //   return;
            //}            
            //if (commentary.trim() === ''){
            //   executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11971",true); 
            //   return;
            //}           
            //executeCommandEventArgs.commons.messageHandler.showMessagesInformation("ASSTS.MSG_ASSTS_SEDEBERZE_11979", true);
        }       
        
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
      
    };