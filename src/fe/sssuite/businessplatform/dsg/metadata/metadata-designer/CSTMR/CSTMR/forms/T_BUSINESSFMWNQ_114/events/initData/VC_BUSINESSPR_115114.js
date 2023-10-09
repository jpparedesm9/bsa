//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BusinessForm
task.initData.VC_BUSINESSPR_115114 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.serverParameters.Business = true;
    initDataEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;


    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
		
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
                
    }
};