//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: AddressForm
task.initData.VC_ADDRESSYWA_591769 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.serverParameters.CustomerTmp = true;
    initDataEventArgs.commons.serverParameters.VirtualAddress = true;
    initDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;

    //Se oculta la columna Direccion
    initDataEventArgs.commons.api.grid.hideColumn('QV_4851_97960', 'addressDescription');

    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
		initDataEventArgs.commons.execServer = false;
		initDataEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
		nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
			url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
			files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
        }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
        
    initDataEventArgs.commons.api.viewState.hide('CM_TADDRESS_C49', true);
        
    } else if (customDialogParameters != null && customDialogParameters != undefined && parentParameters.Task == undefined) {
        //si es desde la VCC
        showHeader = false;
        section = customDialogParameters.section;
        entities.CustomerTmp.code = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters.clientId;
    } else if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
        showHeader = false;
        var task = parentParameters.Task;
        if (task != null) {
            entities.CustomerTmp.code  = task.clientId;
        }
    }
};