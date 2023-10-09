//Entity: WarrantieComext
    //WarrantieComext. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    //Buscar Garantías
    task.executeCommand.VA_WRRNTSEACH8507_0000044 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        entities.GuaranteeSearchCriteria.CorrelativeEnd =1;
		if(entities.GuaranteeSearchCriteria.Office==undefined){
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesInformation('Criterio de Oficina es Obligatorio');
		 }else{
		      executeCommandEventArgs.commons.execServer = true;
		 }
    };