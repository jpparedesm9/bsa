//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: AmortizationTable
    task.initData.VC_AMORTIZAAT_297336 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
		entities.Amount.oldOperation=initDataEventArgs.commons.api.navigation.getCustomDialogParameters().operation;
        initDataEventArgs.commons.api.vc.model.Item = {};
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };