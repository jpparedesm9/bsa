//Entity: Group
    //Group. (Button) View: GroupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPDPCKGB_382725 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
		executeCommandEventArgs.commons.serverParameters.Credit = true;
		//executeCommandEventArgs.commons.serverParameters.GroupMember = true;
		executeCommandEventArgs.commons.serverParameters.Amount = true;		
		executeCommandEventArgs.commons.serverParameters.Context = true;  //caso203112 para pantalla de grupos flujo
		executeCommandEventArgs.commons.execServer = true;

    };