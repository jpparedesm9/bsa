//gridCommand (Button) QueryView: QV_9492_89518
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_9492_89518_895 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        task.checker(entities,gridExecuteCommandEventArgs);
    };