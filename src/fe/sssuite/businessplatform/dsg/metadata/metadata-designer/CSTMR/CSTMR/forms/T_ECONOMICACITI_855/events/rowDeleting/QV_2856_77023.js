//gridRowDeleting QueryView: QV_2856_77023
//Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_2856_77023 = function (entities, gridRowDeletingEventArgs) {
    gridRowDeletingEventArgs.commons.execServer = true;
    gridRow = -1;
    //gridRowDeletingEventArgs.commons.serverParameters.EconomicActivity = true;
};