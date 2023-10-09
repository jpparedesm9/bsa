//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: LegalPersonComposite
task.initData.VC_LEGALPERIP_319665 = function (entities, initDataEventArgs) {
   initDataEventArgs.commons.execServer = false;
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
	var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;
	
    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined){
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
            mode: "findCompany"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
    }else if(customDialogParameters !=null && customDialogParameters!=undefined && parentParameters.Task == undefined){
        showHeader = false;
        entities.LegalPerson.personSecuential = customDialogParameters.clientId;
        section = customDialogParameters.section;
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
	}else if( (customDialogParameters !=null || customDialogParameters != undefined) && parentParameters.Task != undefined){
        showHeader = false;
        var task = parentParameters.Task;
		if (task != null){
            entities.LegalPerson.personSecuential = task.clientId;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
        }
    }
};