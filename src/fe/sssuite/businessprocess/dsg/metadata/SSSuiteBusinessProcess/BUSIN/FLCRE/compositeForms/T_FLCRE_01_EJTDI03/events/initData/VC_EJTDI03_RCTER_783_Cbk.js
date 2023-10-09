//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RejectedApplication
    task.initDataCallback.VC_EJTDI03_RCTER_783 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;   		
		task.loadTaskHeader(entities,initDataEventArgs);
    };