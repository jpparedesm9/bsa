//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ModificationCURPRFCForm
    task.initData.VC_MODIFICAIC_908774 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.serverParameters.NaturalPerson = true;
    
        var nav = initDataEventArgs.commons.api.navigation;
        var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
        var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
        var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;       
        
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
		}

    };