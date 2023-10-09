//Entity: LoanSearchFilter
    //LoanSearchFilter.numIdentification (TextInputButton) View: LoanSearchForm
    
    task.textInputButtonEvent.VA_CODCLIENTCIXLEY_866508 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
    nav.customAddress = {
        id: "findCustomer"
        , url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER
        , files: ["/customer/services/find-customers-srv.js"
                                           , "/customer/controllers/find-customers-ctrl.js"]
        }];
    //Validacion para busqueda de operaciones grupales
        if (textInputButtonEventArgs.model.LoanInstancia.idOptionMenu == 14 && textInputButtonEventArgs.model.LoanSearchFilter.isGroup == true) {
        nav.label = cobis.translate('Busqueda de Operaciones Grupales');
        nav.customDialogParameters = {
            client: 0
            , type: 3
			, mode: "findGroup"
        };
    }
    else {
        nav.customDialogParameters = {};
    }
    };