//undefined Entity: 
task.executeQuery.Q_RESULTTO_3724 = function(executeQueryEventArgs){
    executeQueryEventArgs.commons.execServer = true;

    if (angular.isUndefined(executeQueryEventArgs.commons.api.vc.parentVc)) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }
    
    console.log(executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.esGrupo);
    console.log(executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.criterioBusqueda);

    executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = {
        parameters: {
            esGrupo: executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.esGrupo,
            criterioBusqueda: executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.criterioBusqueda
        }
    };
};