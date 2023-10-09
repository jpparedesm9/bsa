//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ManualConciliation
task.initData.VC_MANUALCOLT_571678 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;

    var commons = initDataEventArgs.commons;
    var api = initDataEventArgs.commons.api;
    var parameters = api.navigation.getCustomDialogParameters();
    var conciliationDate = cobis.containerScope.preferences.processDate;

    entities.ConciliationSearch = parameters.conciliationSearch;
    if (conciliationDate != null && conciliationDate != undefined) {
        var parts = conciliationDate.split("/");
        var d1 = new Date(Number(parts[2]), Number(parts[0]) - 1, Number(parts[1]));
        entities.ConciliationSearch.conciliationDate = d1;
    }
    entities.ConciliationSearch.conciliationUser= cobis.userContext.getValue(cobis.constant.USER_NAME);

    switch (entities.ConciliationSearch.type) {
    case 'I':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REVERSAPA_99657');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_APLICAROA_80830');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    case 'G':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_ANULARGTA_91633');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REGISTRAA_30892');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    case 'P':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REVERSAPA_99657');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_APLICAROA_80830');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    default:
        break;
    }

};