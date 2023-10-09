//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: MobilePopUpForm
task.initData.VC_MOBILEPOPP_688549 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    if ((entities.Mobile.deviceStatus === null) || (entities.Mobile.deviceStatus === '')) {
        entities.Mobile.deviceStatus = 'P';
    }

    if (initDataEventArgs.commons.api.vc.mode === initDataEventArgs.commons.constants.mode.Insert) {
        initDataEventArgs.commons.api.viewState.disable('VA_DEVICESTATUSGNK_898864');              
        entities.Mobile.imei = null;
        entities.Mobile.official = null;
        entities.Mobile.allowUpdate = true;
    } else if (initDataEventArgs.commons.api.vc.mode === initDataEventArgs.commons.constants.mode.Update) {
        initDataEventArgs.commons.api.viewState.enable('VA_DEVICESTATUSGNK_898864');
    }
    
    if(entities.Mobile.deviceStatus == 'P'){
        initDataEventArgs.commons.api.viewState.disable('VA_ALLOWUPDATETLLJ_672864');
    }
};