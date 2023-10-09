//Entity: WarrantyGeneral
    //WarrantyGeneral.fixedTerm (TextInputButton) View: [object Object]
    //Campo Plazo Fijo
    task.textInputButtonEvent.VA_ARANSCATIO0709_IDER508 = function(textInputButtonEventArgs ) {
        var nav = FLCRE.API.getApiNavigation(textInputButtonEventArgs, 'T_FLCRE_94_BYLET28', 'VC_BYLET28_DTBCT_453');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_TERMKHLPJ_39636');
        nav.modalProperties = {
            size: 'lg'
        };
        nav.queryParameters = {
            mode: textInputButtonEventArgs.commons.constants.mode.Insert
        };
        nav.customDialogParameters = {
            customerSearch: textInputButtonEventArgs.commons.api.vc.model.CustomerSearch.data()
        };

        textInputButtonEventArgs.commons.execServer = false;
    };