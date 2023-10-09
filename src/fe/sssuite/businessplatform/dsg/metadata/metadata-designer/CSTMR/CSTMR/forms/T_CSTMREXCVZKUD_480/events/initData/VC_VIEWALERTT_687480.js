//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ViewAlertsForm
    task.initData.VC_VIEWALERTT_687480 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
        
    };