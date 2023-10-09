//Entity: Entity2
    //Entity2.attribute1 (TextInputButton) View: FRegularizarPagosObjetados
    
    task.textInputButtonEvent.VA_1WFWHEAZGTYHGIU_390505 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
            var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = cobis.translate('PAOBJ.LBL_PAOBJ_BU00FASDE_39896');
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
            //if (textInputButtonEventArgs.model.LoanInstancia.idOptionMenu == 14 && textInputButtonEventArgs.model.LoanSearchFilter.isGroup == true) {
            //nav.label = cobis.translate('Busqueda de Operaciones Grupales');
            nav.customDialogParameters = {
                client: 0
                , type: 3
                , mode: "findGroup"
            };
        
        nav.customDialogParameters = {};        
    };