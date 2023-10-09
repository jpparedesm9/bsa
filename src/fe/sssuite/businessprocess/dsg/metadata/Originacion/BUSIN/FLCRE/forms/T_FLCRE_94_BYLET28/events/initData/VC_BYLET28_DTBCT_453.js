//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_BYLET28_DTBCT_453 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
        // initDataEventArgs.commons.serverParameters.entityName = true;
        var warrantyType=initDataEventArgs.commons.api.vc.customDialogParameters.warrantyType;
        var viewState = initDataEventArgs.commons.api.viewState;
        entities.WarrantyGeneral.currency = initDataEventArgs.commons.api.vc.customDialogParameters.warrantyGeneral.currency;
        if ("AHORRO" == warrantyType) {            
            viewState.hide("GR_IEDMBENTEW96_04");
            viewState.disable("GR_IEDMBENTEW96_04");
            viewState.show("G_FIXEDTEYTE_555W96");
            viewState.enable("G_FIXEDTEYTE_555W96");
        }
        if ("DPF" == warrantyType) {
           viewState.hide("G_FIXEDTEYTE_555W96");
            viewState.disable("G_FIXEDTEYTE_555W96");
            viewState.show("GR_IEDMBENTEW96_04");
            viewState.enable("GR_IEDMBENTEW96_04");            
        }
    };