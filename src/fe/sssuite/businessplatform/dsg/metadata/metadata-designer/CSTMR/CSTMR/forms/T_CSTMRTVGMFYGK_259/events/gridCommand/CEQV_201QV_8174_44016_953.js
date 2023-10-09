//gridCommand (Button) QueryView: QV_8174_44016
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_8174_44016_953 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.AuthorizationTransferRequest = true;
        task.checker(entities,gridExecuteCommandEventArgs);
    };