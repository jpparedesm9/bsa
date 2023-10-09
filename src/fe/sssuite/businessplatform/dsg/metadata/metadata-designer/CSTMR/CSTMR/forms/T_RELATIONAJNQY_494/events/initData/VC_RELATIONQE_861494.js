//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RelationForm
    task.initData.VC_RELATIONQE_861494 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        if(entities.RelationContext.secuential==null && initDataEventArgs.commons.api.parentVc==undefined)
		{
        var nav = initDataEventArgs.commons.api.navigation;        
        nav.label='B\u00FAsqueda de Clientes';
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
        else{
             numsecuential=initDataEventArgs.commons.api.parentVc.customDialogParameters.codigoCli;
            entities.RelationContext.secuential=numsecuential;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','Relation', undefined, true, false, 'VC_RELATIONQE_861494', false); 
        }
    };