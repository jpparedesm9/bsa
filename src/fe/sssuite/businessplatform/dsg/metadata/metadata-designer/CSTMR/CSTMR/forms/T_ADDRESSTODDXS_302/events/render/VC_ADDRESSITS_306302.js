//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: AddressPopupForm
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }


    if (renderEventArgs.commons.api.vc.mode === renderEventArgs.commons.constants.mode.Update) {
        renderEventArgs.commons.api.viewState.enable('G_ADDRESSJWN_806436');
    } else {
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSJWN_806436');
    }

    if (entities.PhysicalAddress.directionNumberInternal === -1) {
        entities.PhysicalAddress.directionNumberInternal = null;
    }

    if (parameters != null && parameters.modo != null && parameters.modo != undefined && parameters.modo == 'Q') {
        var controls = ['VC_ADDRESSITS_306302', 'G_ADDRESSJWN_806436'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);
    }

    var scannedDocumentsDetailList = renderEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = renderEventArgs.commons.api.vc.parentVc.model.Context;

    if (parameters != null && parameters.modo != 'Q' && renderEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && posDataModRequest != null && entities.PhysicalAddress.addressType == 'RE' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {

        if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || context.roleEnabledDataModRequest != 'S' || context.addressState != 'N') {
            var controls = ['VC_ADDRESSITS_306302'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);
            var controls2 = ['VA_REFERENCEDKFTKI_970436', 'VA_VABUTTONCRFQENP_394436'];
            LATFO.UTILS.disableFields(renderEventArgs, controls2, false);

        } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && context.addressState == 'N') {
            var controls = ['VC_ADDRESSITS_306302'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, false);
    }
    }

};