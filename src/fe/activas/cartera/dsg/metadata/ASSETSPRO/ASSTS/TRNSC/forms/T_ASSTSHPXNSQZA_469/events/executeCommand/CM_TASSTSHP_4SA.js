// (Button) 
    task.executeCommand.CM_TASSTSHP_4SA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        if (entities.ProcessInstance.transactionNumber == null)
        {
          executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GRUPONOAO_46111", true);
        }else
        {
            var itemReporte = "GarantiaLiquida";
            var args = [['numTran', entities.ProcessInstance.transactionNumber]];
            var tittle = cobis.translate('ASSTS.LBL_ASSTS_FICHADEAN_46919');
	   	   ASSETS.Utils.generarReporte (itemReporte, args, tittle);
        }   
            
    };