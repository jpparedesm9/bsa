//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: SimulationCreditRenovations
    task.initData.VC_SIMULATIEE_163810 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        initDataEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        initDataEventArgs.commons.api.viewState.disable('CM_TLOANSYB_148');
        
    };