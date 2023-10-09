// (Button) 
task.executeCommandCallback.CM_TFLCRE_8_TCR = function (entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.execServer = false;
    //Se deshabilita la pantalla de ingresos si el móvil está usando
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var hideIngreso = ['VC_OIIRL51_SNNMB_699'] //grid vertical    
    BUSIN.API.disable(viewState, hideIngreso);
};