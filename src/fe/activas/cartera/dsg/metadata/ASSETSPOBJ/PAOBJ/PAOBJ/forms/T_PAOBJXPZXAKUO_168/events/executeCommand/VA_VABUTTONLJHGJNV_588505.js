//Entity: DatosBusquedaPagoObjetado
    //DatosBusquedaPagoObjetado. (Button) View: FRegularizarPagosObjetados
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONLJHGJNV_588505 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        // entities.ResultadoPagosObjetados = [];
        executeCommandEventArgs.commons.api.grid.refresh('QV_3724_71065');
    };