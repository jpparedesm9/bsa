//Entity: Group
    //Group.titular1Name (TextInputButton) View: GroupForm
    
    task.textInputButtonEvent.VA_5634HKMSQGZFPUQ_212725 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        titular=1;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js",
                 //"/customer/services/find-program-srv.js",
                   "/customer/controllers/find-customers-ctrl.js"]
         }];
        
        nav.customDialogParameters = {
        
        };    
    };