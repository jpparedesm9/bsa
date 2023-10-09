//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: DocumentGrid
task.initData.VC_DOCUMENTDD_249541 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;

    var filtro = {
        customerId: initDataEventArgs.commons.api.parentVc.customDialogParameters.customerId
    }
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMENN_7504', filtro);
};