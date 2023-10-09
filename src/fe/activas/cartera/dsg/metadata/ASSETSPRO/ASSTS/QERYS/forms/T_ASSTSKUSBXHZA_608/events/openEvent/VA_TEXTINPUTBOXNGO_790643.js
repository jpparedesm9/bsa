//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.clientId (TextInputButton) View: DebitOrderProcessingLog

    task.textInputButtonEvent.VA_TEXTINPUTBOXNGO_790643 = function (textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
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
    };