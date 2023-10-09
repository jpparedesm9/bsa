//gridCommand (Button) QueryView: GridRefinancingOperations
//Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
task.gridCommand.CEQV_201_QV_ITRIC1523_63_978 = function (entities, gridExecuteCommandEventArgs) {
    // (Button)
    // QueryView:
    // Borrowers

    //Parametros Generales para evaluar la regla
    var task = gridExecuteCommandEventArgs.commons.api.parentVc.model.Task;
    entities.GeneralParameters = {
        acronymRule: "VALPORREN",
        idInstanceProcess: task.processInstanceIdentifier,
        idAsigActividad: task.cobisAssignAct,
        idClient: task.clientId
    };

    gridExecuteCommandEventArgs.commons.serverParameters.OriginalHeader = true;
    gridExecuteCommandEventArgs.commons.serverParameters.SelectedOperations = true;
    gridExecuteCommandEventArgs.commons.serverParameters.RefinancingOperations = true;
    gridExecuteCommandEventArgs.commons.serverParameters.GeneralParameters = true;
    gridExecuteCommandEventArgs.commons.serverParameters.DebtorGeneral = true;

    gridExecuteCommandEventArgs.commons.execServer = true;
};