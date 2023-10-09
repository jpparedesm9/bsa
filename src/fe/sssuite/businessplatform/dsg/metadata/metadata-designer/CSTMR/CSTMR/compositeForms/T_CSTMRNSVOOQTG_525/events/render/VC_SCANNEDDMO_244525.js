//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ScannedDocuments
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    var parentParameters = renderEventArgs.commons.api.parentVc.model;
    var customerId = (parentParameters.Task.clientId != null) ? parseInt(parentParameters.Task.clientId) : 0;

    var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters;
    var typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;

    if (typeRequest == 'COLECTIVOS') {
        parentParameters.InboxContainerPage.HiddenInCompleted = "YES";
    }

    //Filtro para llenado de executeQuery
    var filtro = {
        customerId: customerId,
        processInstance: parentParameters.Task.processInstanceIdentifier,
        typeRequest: typeRequest
    }
    renderEventArgs.commons.api.grid.refresh('QV_7463_28553', filtro);
};