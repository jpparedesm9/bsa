//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReportSettlementSheet
    task.initData.VC_REPORTSEEL_593126 = function (entities, initDataEventArgs){
        entities.CreditHeader.creditCode= initDataEventArgs.commons.api.navigation.getCustomDialogParameters().IDRequested;
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        
    };