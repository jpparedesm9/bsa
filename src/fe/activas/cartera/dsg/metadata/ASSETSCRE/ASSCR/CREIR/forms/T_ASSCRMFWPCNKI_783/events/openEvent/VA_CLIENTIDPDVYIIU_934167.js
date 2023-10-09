//Entity: PrefilledRequest
//PrefilledRequest.clientId (TextInputButton) View: prefilledRequest

task.textInputButtonEvent.VA_CLIENTIDPDVYIIU_934167 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_BSQUEDAIE_90412');
    nav.customAddress = {
        id: "findCustomer",
        url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ["/customer/services/find-customers-srv.js"
             , "/customer/controllers/find-customers-ctrl.js"]
      }];
    nav.customDialogParameters = {};
};