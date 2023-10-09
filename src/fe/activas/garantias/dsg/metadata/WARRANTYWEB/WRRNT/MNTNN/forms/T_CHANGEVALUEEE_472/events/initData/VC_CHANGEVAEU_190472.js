//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ChangeValue
    task.initData.VC_CHANGEVAEU_190472 = function (entities, initDataEventArgs){
        var warranty = initDataEventArgs.commons.api.vc.customDialogParameters.warranty;
        entities.Warranty.externalCode = warranty.externalCode;
        entities.Warranty.custody = warranty.custody;
        entities.Warranty.type = warranty.type;
        entities.Warranty.office = warranty.subsidiary;
         initDataEventArgs.commons.execServer = true;
        
    };