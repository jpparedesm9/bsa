//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReportGroupAccountStatement
    task.initData.VC_REPORTGRTT_453266 = function (entities, initDataEventArgs){
        entities.CreditHeader.creditCode= initDataEventArgs.commons.api.navigation.getCustomDialogParameters().IDRequested;
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        
    };