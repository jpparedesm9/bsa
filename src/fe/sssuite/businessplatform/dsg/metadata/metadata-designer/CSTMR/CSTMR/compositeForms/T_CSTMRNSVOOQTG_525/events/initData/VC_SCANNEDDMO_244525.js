//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ScannedDocuments
task.initData.VC_SCANNEDDMO_244525 = function (entities, initDataEventArgs) {
    var parentParameters = initDataEventArgs.commons.api.parentVc.model;
    entities.OriginalHeader.applicationNumber = parentParameters.Task.processInstanceIdentifier;
    entities.OriginalHeader.productType = parentParameters.Task.bussinessInformationStringTwo;
    entities.GeneralData.clientId = parentParameters.Task.clientId
    var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;

    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
    mode = customDialogParameters.Task.urlParams.MODE;

    //initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    initDataEventArgs.commons.serverParameters.GeneralData = true;
    initDataEventArgs.commons.serverParameters.OriginalHeader = true;
    initDataEventArgs.commons.serverParameters.Context = true;
    initDataEventArgs.commons.api.viewState.hide('G_SCANNEDDSD_789611');

};