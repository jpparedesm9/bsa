//Entity: WarrantieComext
    //WarrantieComext. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    //Siguiente
    task.executeCommand.VA_WRRNTSEACH8507_0000435 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        entities.GuaranteeSearchCriteria.CorrelativeEnd =2;
    };