//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: TransferRequestForm
task.initData.VC_TRANSFERUR_363188 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
    initDataEventArgs.commons.api.viewState.disable('VA_ISALLNMRJFGEEEH_511231');
};