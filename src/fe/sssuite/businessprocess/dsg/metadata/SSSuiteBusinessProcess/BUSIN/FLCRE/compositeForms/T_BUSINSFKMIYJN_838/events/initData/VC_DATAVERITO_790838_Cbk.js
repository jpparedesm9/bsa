//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestionsCompound
    task.initDataCallback.VC_DATAVERITO_790838 = function (entities, initDataCallbackEventArgs){
        initDataCallbackEventArgs.commons.execServer = true;      
        task.loadTaskHeader(entities, initDataCallbackEventArgs);
    };