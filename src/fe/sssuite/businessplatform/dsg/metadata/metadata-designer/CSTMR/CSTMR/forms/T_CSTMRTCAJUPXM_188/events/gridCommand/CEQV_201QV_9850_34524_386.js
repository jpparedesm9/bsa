//gridCommand (Button) QueryView: QV_9850_34524
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9850_34524_386 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.CustomerTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };