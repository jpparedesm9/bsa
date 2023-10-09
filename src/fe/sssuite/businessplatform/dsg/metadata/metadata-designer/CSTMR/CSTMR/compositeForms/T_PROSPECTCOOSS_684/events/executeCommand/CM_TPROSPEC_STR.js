// (Button) 
    task.executeCommand.CM_TPROSPEC_STR = function(entities, executeCommandEventArgs) {      
        executeCommandEventArgs.commons.execServer = true;
        var physicalAddresses = entities.PhysicalAddress.data();
        var virtualAddresses = entities.VirtualAddress.data();
        var hasMainPhisicalAddress = false;
        entities.Context.channel = channel; // caso203112
		
        for(var i = 0; i < physicalAddresses.length; i++){
             if(physicalAddresses[i].isMainAddress)
             {
               hasMainPhisicalAddress = true;
             }
         }
         executeCommandEventArgs.commons.serverParameters.Context=true;
         if(hasMainPhisicalAddress && virtualAddresses.length > 0){
             executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
         }else {
             executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243',false);
             executeCommandEventArgs.commons.execServer = false;          
         }
    };