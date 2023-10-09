//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Liberation
    task.initData.VC_LIBERATINO_737422 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var customParameters = initDataEventArgs.commons.api.vc.customDialogParameters;
        entities.Warranty.externalCode = customParameters.externalCode;
        entities.Warranty.custody = customParameters.custody;
        entities.Warranty.type = customParameters.custodyType;
        
    };