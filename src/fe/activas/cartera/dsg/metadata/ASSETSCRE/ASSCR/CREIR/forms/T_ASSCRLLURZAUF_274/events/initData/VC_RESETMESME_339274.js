//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ResetMessageImage
task.initData.VC_RESETMESME_339274 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    
    // Botones ocultos
    
    initDataEventArgs.commons.api.viewState.hide('VA_CODRESETCLIENTN_154225');
    initDataEventArgs.commons.api.viewState.hide('VA_NAMECLIENTFJHNP_973225');
    initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONKOXRDID_200225');
    
    

    var nav = initDataEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_VALIDARRU_71967');
    nav.address = {
        moduleId: 'ASSCR',
        subModuleId: 'CREIR',
        taskId: 'T_ASSCRDVFRQXGU_966',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CALLCENTRP_967966'
    };
    nav.queryParameters = {
        mode: 2
    };
    nav.modalProperties = {
        size: 'lg',
        callFromGrid: false
    };
    nav.customDialogParameters = {
        variable: 0
    };

    //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
    nav.openModalWindow(initDataEventArgs.commons.controlId, null);
    //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
    //nav.openModalWindow(id, args.modelRow);


};