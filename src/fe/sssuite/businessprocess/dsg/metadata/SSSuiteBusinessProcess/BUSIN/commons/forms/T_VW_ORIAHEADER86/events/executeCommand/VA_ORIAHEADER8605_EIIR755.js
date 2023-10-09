//Entity: EntidadInfo
    //EntidadInfo. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_ORIAHEADER8605_EIIR755 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
		 task.openFindProgram(executeCommandEventArgs);
    };