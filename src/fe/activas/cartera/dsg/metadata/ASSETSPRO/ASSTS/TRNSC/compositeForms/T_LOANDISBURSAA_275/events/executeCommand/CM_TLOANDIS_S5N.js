// (Button) 
    task.executeCommand.CM_TLOANDIS_S5N = function(entities, executeCommandEventArgs) {
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
      if(entities.LiquidateResult.sumTotal > entities.DisbursementResult.sumTotal){
         executeCommandEventArgs.commons.execServer = false;
         executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_ERRORELDR_83907'),true);
      }else{
      	executeCommandEventArgs.commons.execServer = true;	
      }
    };