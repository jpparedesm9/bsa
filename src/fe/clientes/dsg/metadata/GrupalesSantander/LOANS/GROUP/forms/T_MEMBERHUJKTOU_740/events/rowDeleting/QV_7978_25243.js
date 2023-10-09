//gridRowDeleting QueryView: QV_7978_25243
//Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_7978_25243 = function (entities, gridRowDeletingEventArgs) {
    if (typeOrigin === LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        gridRowDeletingEventArgs.rowData.creditCode =  entities.Credit.creditCode; //gridRowDeletingEventArgs.commons.api.vc.parentVc.model.Task.bussinessInformationIntegerTwo; //se comenta xq se pierde el codigo del credito
    }
    gridRowDeletingEventArgs.rowData.groupId = entities.Group.code;
    gridRowDeletingEventArgs.commons.serverParameters.Member = true;
    gridRowDeletingEventArgs.commons.execServer = true;
};