//Entity: Group
    //Group.titular2Name (TextInputButton) View: GroupForm
    
    task.textInputButtonEvent.VA_4103IWRALHJMDZX_523725 = function( textInputButtonEventArgs ) {

     textInputButtonEventArgs.commons.execServer = false;
        titular=2;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",//idCustomer
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