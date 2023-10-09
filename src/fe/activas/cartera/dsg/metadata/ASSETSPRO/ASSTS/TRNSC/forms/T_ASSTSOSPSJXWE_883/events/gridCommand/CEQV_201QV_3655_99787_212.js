//gridCommand (Button) QueryView: QV_3655_99787
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_3655_99787_212 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DetailRejectedDispersions = true;
        ASSETS.API.checker(entities,gridExecuteCommandEventArgs);
    };