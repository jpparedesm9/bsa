//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments. (Button) View: QueryDocuments
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRLGUJMS_186273 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = false;
        /*var filtro = {
		loan:entities.HeaderQueryDocuments.loan,//prestamo
		procedure:entities.HeaderQueryDocuments.procedure,//tramite
		groupId:entities.HeaderQueryDocuments.groupId,//grupo
		clientId:entities.HeaderQueryDocuments.clientId//cliente
	   }
		executeCommandEventArgs.commons.api.grid.refresh("QV_9888_36569",filtro);*/
    };