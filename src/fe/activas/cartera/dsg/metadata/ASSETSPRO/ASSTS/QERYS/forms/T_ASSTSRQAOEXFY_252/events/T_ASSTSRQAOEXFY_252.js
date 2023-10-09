//"TaskId": "T_ASSTSRQAOEXFY_252"
function loadFindCustomer(nav,textInputName){
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
        mode: "findCustomer",
        controlName: textInputName
    };
    nav.modalProperties = {
        size: 'lg'
    };
};