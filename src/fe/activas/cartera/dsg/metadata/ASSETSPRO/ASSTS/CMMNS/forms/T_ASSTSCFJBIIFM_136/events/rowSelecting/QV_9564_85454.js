//gridRowSelecting QueryView: QV_9564_85454
//Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelecting.QV_9564_85454 = function (entities, gridRowSelectingEventArgs) {
    gridRowSelectingEventArgs.commons.execServer = false;

    var conciliationSearch = gridRowSelectingEventArgs.rowData;

    if (conciliationSearch != null && conciliationSearch.conciliate == 'N' && (conciliationSearch.notConciliationReason == 'NE' || conciliationSearch.notConciliationReason == 'NR')) {
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        nav.address = {
            moduleId: "ASSTS",
            subModuleId: "TRNSC",
            taskId: "T_ASSTSODKKUGLX_678",
            viewContainerId: "VC_MANUALCOLT_571678",
            taskVersion: "1.0.0"
        };


        nav.label = cobis.translate('ASSTS.LBL_ASSTS_CONCILINA_99171');
        nav.modalProperties = {
            size: 'md'
        };
        nav.customDialogParameters = {
            conciliationSearch: conciliationSearch,
        };
        nav.openModalWindow(gridRowSelectingEventArgs.commons.controlId);
    }


};