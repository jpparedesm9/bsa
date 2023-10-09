//gridCommand (Button) QueryView: GridDocumentProduct
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_QDMNT8051_16_659 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DocumentProduct = true;
        BUSIN.API.checker(entities, gridExecuteCommandEventArgs);
    };