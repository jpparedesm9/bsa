//WarningRiskQuery Entity: 
    task.executeQuery.Q_WARNINGK_3983 = function(executeQueryEventArgs){
        
        		if((executeQueryEventArgs.parameters.listType=='') ||(executeQueryEventArgs.parameters.listType==' ' ))
		{
			executeQueryEventArgs.parameters.listType=null
		}
          if(executeQueryEventArgs.parameters.alertDate!=null && executeQueryEventArgs.parameters.consultDate!=null &&     executeQueryEventArgs.parameters.listType!=null )
        {
            executeQueryEventArgs.commons.messageHandler.showMessagesError('Se debe realizar la b\u00fasqueda por Fecha o por Tipo de Operaci\u00f3n',true);
            executeQueryEventArgs.commons.execServer = false;
        }
        else
        {
         executeQueryEventArgs.commons.execServer = true;
        }
        //executeQueryEventArgs.commons.serverParameters. = true;
        
    };