//Entity: LegalRepresentative
    //LegalRepresentative. (ImageButton) View: LegalRepresentative
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VAIMAGEBUTTONNN_454183 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
        //nav.label = cobis.translate('LATFO.DLB_LATFO_LIENTLAIM_54829');
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
            mode:"findRepresentative"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
        
    };